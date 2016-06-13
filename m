Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A7D1C105646D
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jun 2016 16:09:22 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 13 Jun 2016 16:08:59 +0200
Message-Id: <1465826958-19398-12-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1465826958-19398-1-git-send-email-philipp.reisner@linbit.com>
References: <1465826958-19398-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/30] drbd: when receiving P_TRIM,
	zero-out partial unaligned chunks
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

We can avoid spurious data divergence caused by partially-ignored
discards on certain backends with discard_zeroes_data=0, if we
translate partial unaligned discard requests into explicit zero-out.

The relevant use case is LVM/DM thin.

If on different nodes, DRBD is backed by devices with differing
discard characteristics, discards may lead to data divergence
(old data or garbage left over on one backend, zeroes due to
unmapped areas on the other backend). Online verify would now
potentially report tons of spurious differences.

While probably harmless for most use cases (fstrim on a file system),
DRBD cannot have that, it would violate our promise to upper layers
that our data instances on the nodes are identical.

To be correct and play safe (make sure data is identical on both copies),
we would have to disable discard support, if our local backend (on a
Primary) does not support "discard_zeroes_data=true".

We'd also have to translate discards to explicit zero-out on the
receiving (typically: Secondary) side, unless the receiving side
supports "discard_zeroes_data=true".

Which both would allocate those blocks, instead of unmapping them,
in contrast with expectations.

LVM/DM thin does set discard_zeroes_data=0,
because it silently ignores discards to partial chunks.

We can work around this by checking the alignment first.
For unaligned (wrt. alignment and granularity) or too small discards,
we zero-out the initial (and/or) trailing unaligned partial chunks,
but discard all the aligned full chunks.

At least for LVM/DM thin, the result is effectively "discard_zeroes_data=1".

Arguably it should behave this way internally, by default,
and we'll try to make that happen.

But our workaround is still valid for already deployed setups,
and for other devices that may behave this way.

Setting discard-zeroes-if-aligned=yes will allow DRBD to use
discards, and to announce discard_zeroes_data=true, even on
backends that announce discard_zeroes_data=false.

Setting discard-zeroes-if-aligned=no will cause DRBD to always
fall-back to zero-out on the receiving side, and to not even
announce discard capabilities on the Primary, if the respective
backend announces discard_zeroes_data=false.

We used to ignore the discard_zeroes_data setting completely.
To not break established and expected behaviour, and suddenly
cause fstrim on thin-provisioned LVs to run out-of-space,
instead of freeing up space, the default value is "yes".

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h      |   2 +-
 drivers/block/drbd/drbd_nl.c       |  15 ++--
 drivers/block/drbd/drbd_receiver.c | 140 ++++++++++++++++++++++++++++++-------
 include/linux/drbd_genl.h          |   1 +
 include/linux/drbd_limits.h        |   6 ++
 5 files changed, 134 insertions(+), 30 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 1a93f4f..8cc2955 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1488,7 +1488,7 @@ enum determine_dev_size {
 extern enum determine_dev_size
 drbd_determine_dev_size(struct drbd_device *, enum dds_flags, struct resize_parms *) __must_hold(local);
 extern void resync_after_online_grow(struct drbd_device *);
-extern void drbd_reconsider_max_bio_size(struct drbd_device *device, struct drbd_backing_dev *bdev);
+extern void drbd_reconsider_queue_parameters(struct drbd_device *device, struct drbd_backing_dev *bdev);
 extern enum drbd_state_rv drbd_set_role(struct drbd_device *device,
 					enum drbd_role new_role,
 					int force);
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 3643f9c..8d757d6 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1161,13 +1161,17 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 	unsigned int max_hw_sectors = max_bio_size >> 9;
 	unsigned int max_segments = 0;
 	struct request_queue *b = NULL;
+	struct disk_conf *dc;
+	bool discard_zeroes_if_aligned = true;
 
 	if (bdev) {
 		b = bdev->backing_bdev->bd_disk->queue;
 
 		max_hw_sectors = min(queue_max_hw_sectors(b), max_bio_size >> 9);
 		rcu_read_lock();
-		max_segments = rcu_dereference(device->ldev->disk_conf)->max_bio_bvecs;
+		dc = rcu_dereference(device->ldev->disk_conf);
+		max_segments = dc->max_bio_bvecs;
+		discard_zeroes_if_aligned = dc->discard_zeroes_if_aligned;
 		rcu_read_unlock();
 
 		blk_set_stacking_limits(&q->limits);
@@ -1185,7 +1189,7 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 
 		blk_queue_max_discard_sectors(q, DRBD_MAX_DISCARD_SECTORS);
 
-		if (blk_queue_discard(b) &&
+		if (blk_queue_discard(b) && (b->limits.discard_zeroes_data || discard_zeroes_if_aligned) &&
 		    (connection->cstate < C_CONNECTED || connection->agreed_features & FF_TRIM)) {
 			/* We don't care, stacking below should fix it for the local device.
 			 * Whether or not it is a suitable granularity on the remote device
@@ -1216,7 +1220,7 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 	}
 }
 
-void drbd_reconsider_max_bio_size(struct drbd_device *device, struct drbd_backing_dev *bdev)
+void drbd_reconsider_queue_parameters(struct drbd_device *device, struct drbd_backing_dev *bdev)
 {
 	unsigned int now, new, local, peer;
 
@@ -1488,6 +1492,9 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 	if (write_ordering_changed(old_disk_conf, new_disk_conf))
 		drbd_bump_write_ordering(device->resource, NULL, WO_BDEV_FLUSH);
 
+	if (old_disk_conf->discard_zeroes_if_aligned != new_disk_conf->discard_zeroes_if_aligned)
+		drbd_reconsider_queue_parameters(device, device->ldev);
+
 	drbd_md_sync(device);
 
 	if (device->state.conn >= C_CONNECTED) {
@@ -1866,7 +1873,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	device->read_cnt = 0;
 	device->writ_cnt = 0;
 
-	drbd_reconsider_max_bio_size(device, device->ldev);
+	drbd_reconsider_queue_parameters(device, device->ldev);
 
 	/* If I am currently not R_PRIMARY,
 	 * but meta data primary indicator is set,
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index a2e7ba9..078c4d98 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1442,6 +1442,108 @@ void drbd_bump_write_ordering(struct drbd_resource *resource, struct drbd_backin
 		drbd_info(resource, "Method to ensure write ordering: %s\n", write_ordering_str[resource->write_ordering]);
 }
 
+/*
+ * We *may* ignore the discard-zeroes-data setting, if so configured.
+ *
+ * Assumption is that it "discard_zeroes_data=0" is only because the backend
+ * may ignore partial unaligned discards.
+ *
+ * LVM/DM thin as of at least
+ *   LVM version:     2.02.115(2)-RHEL7 (2015-01-28)
+ *   Library version: 1.02.93-RHEL7 (2015-01-28)
+ *   Driver version:  4.29.0
+ * still behaves this way.
+ *
+ * For unaligned (wrt. alignment and granularity) or too small discards,
+ * we zero-out the initial (and/or) trailing unaligned partial chunks,
+ * but discard all the aligned full chunks.
+ *
+ * At least for LVM/DM thin, the result is effectively "discard_zeroes_data=1".
+ */
+int drbd_issue_discard_or_zero_out(struct drbd_device *device, sector_t start, unsigned int nr_sectors, bool discard)
+{
+	struct block_device *bdev = device->ldev->backing_bdev;
+	struct request_queue *q = bdev_get_queue(bdev);
+	sector_t tmp, nr;
+	unsigned int max_discard_sectors, granularity;
+	int alignment;
+	int err = 0;
+
+	if (!discard)
+		goto zero_out;
+
+	/* Zero-sector (unknown) and one-sector granularities are the same.  */
+	granularity = max(q->limits.discard_granularity >> 9, 1U);
+	alignment = (bdev_discard_alignment(bdev) >> 9) % granularity;
+
+	max_discard_sectors = min(q->limits.max_discard_sectors, (1U << 22));
+	max_discard_sectors -= max_discard_sectors % granularity;
+	if (unlikely(!max_discard_sectors))
+		goto zero_out;
+
+	if (nr_sectors < granularity)
+		goto zero_out;
+
+	tmp = start;
+	if (sector_div(tmp, granularity) != alignment) {
+		if (nr_sectors < 2*granularity)
+			goto zero_out;
+		/* start + gran - (start + gran - align) % gran */
+		tmp = start + granularity - alignment;
+		tmp = start + granularity - sector_div(tmp, granularity);
+
+		nr = tmp - start;
+		err |= blkdev_issue_zeroout(bdev, start, nr, GFP_NOIO, 0);
+		nr_sectors -= nr;
+		start = tmp;
+	}
+	while (nr_sectors >= granularity) {
+		nr = min_t(sector_t, nr_sectors, max_discard_sectors);
+		err |= blkdev_issue_discard(bdev, start, nr, GFP_NOIO, 0);
+		nr_sectors -= nr;
+		start += nr;
+	}
+ zero_out:
+	if (nr_sectors) {
+		err |= blkdev_issue_zeroout(bdev, start, nr_sectors, GFP_NOIO, 0);
+	}
+	return err != 0;
+}
+
+static bool can_do_reliable_discards(struct drbd_device *device)
+{
+	struct request_queue *q = bdev_get_queue(device->ldev->backing_bdev);
+	struct disk_conf *dc;
+	bool can_do;
+
+	if (!blk_queue_discard(q))
+		return false;
+
+	if (q->limits.discard_zeroes_data)
+		return true;
+
+	rcu_read_lock();
+	dc = rcu_dereference(device->ldev->disk_conf);
+	can_do = dc->discard_zeroes_if_aligned;
+	rcu_read_unlock();
+	return can_do;
+}
+
+void drbd_issue_peer_discard(struct drbd_device *device, struct drbd_peer_request *peer_req)
+{
+	/* If the backend cannot discard, or does not guarantee
+	 * read-back zeroes in discarded ranges, we fall back to
+	 * zero-out.  Unless configuration specifically requested
+	 * otherwise. */
+	if (!can_do_reliable_discards(device))
+		peer_req->flags |= EE_IS_TRIM_USE_ZEROOUT;
+
+	if (drbd_issue_discard_or_zero_out(device, peer_req->i.sector,
+	    peer_req->i.size >> 9, !(peer_req->flags & EE_IS_TRIM_USE_ZEROOUT)))
+		peer_req->flags |= EE_WAS_ERROR;
+	drbd_endio_write_sec_final(peer_req);
+}
+
 /**
  * drbd_submit_peer_request()
  * @device:	DRBD device.
@@ -1472,7 +1574,13 @@ int drbd_submit_peer_request(struct drbd_device *device,
 	unsigned nr_pages = (data_size + PAGE_SIZE -1) >> PAGE_SHIFT;
 	int err = -ENOMEM;
 
-	if (peer_req->flags & EE_IS_TRIM_USE_ZEROOUT) {
+	/* TRIM/DISCARD: for now, always use the helper function
+	 * blkdev_issue_zeroout(..., discard=true).
+	 * It's synchronous, but it does the right thing wrt. bio splitting.
+	 * Correctness first, performance later.  Next step is to code an
+	 * asynchronous variant of the same.
+	 */
+	if (peer_req->flags & EE_IS_TRIM) {
 		/* wait for all pending IO completions, before we start
 		 * zeroing things out. */
 		conn_wait_active_ee_empty(peer_req->peer_device->connection);
@@ -1489,19 +1597,10 @@ int drbd_submit_peer_request(struct drbd_device *device,
 			spin_unlock_irq(&device->resource->req_lock);
 		}
 
-		if (blkdev_issue_zeroout(device->ldev->backing_bdev,
-			sector, data_size >> 9, GFP_NOIO, false))
-			peer_req->flags |= EE_WAS_ERROR;
-		drbd_endio_write_sec_final(peer_req);
+		drbd_issue_peer_discard(device, peer_req);
 		return 0;
 	}
 
-	/* Discards don't have any payload.
-	 * But the scsi layer still expects a bio_vec it can use internally,
-	 * see sd_setup_discard_cmnd() and blk_add_request_payload(). */
-	if (peer_req->flags & EE_IS_TRIM)
-		nr_pages = 1;
-
 	/* In most cases, we will only need one bio.  But in case the lower
 	 * level restrictions happen to be different at this offset on this
 	 * side than those of the sending peer, we may need to submit the
@@ -1527,11 +1626,6 @@ next_bio:
 	bios = bio;
 	++n_bios;
 
-	if (rw & REQ_DISCARD) {
-		bio->bi_iter.bi_size = data_size;
-		goto submit;
-	}
-
 	page_chain_for_each(page) {
 		unsigned len = min_t(unsigned, data_size, PAGE_SIZE);
 		if (!bio_add_page(bio, page, len, 0)) {
@@ -1553,7 +1647,6 @@ next_bio:
 		--nr_pages;
 	}
 	D_ASSERT(device, data_size == 0);
-submit:
 	D_ASSERT(device, page == NULL);
 
 	atomic_set(&peer_req->pending_bios, n_bios);
@@ -2413,10 +2506,7 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 	dp_flags = be32_to_cpu(p->dp_flags);
 	rw |= wire_flags_to_bio(dp_flags);
 	if (pi->cmd == P_TRIM) {
-		struct request_queue *q = bdev_get_queue(device->ldev->backing_bdev);
 		peer_req->flags |= EE_IS_TRIM;
-		if (!blk_queue_discard(q))
-			peer_req->flags |= EE_IS_TRIM_USE_ZEROOUT;
 		D_ASSERT(peer_device, peer_req->i.size > 0);
 		D_ASSERT(peer_device, rw & REQ_DISCARD);
 		D_ASSERT(peer_device, peer_req->pages == NULL);
@@ -2487,7 +2577,7 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 	 * and we wait for all pending requests, respectively wait for
 	 * active_ee to become empty in drbd_submit_peer_request();
 	 * better not add ourselves here. */
-	if ((peer_req->flags & EE_IS_TRIM_USE_ZEROOUT) == 0)
+	if ((peer_req->flags & EE_IS_TRIM) == 0)
 		list_add_tail(&peer_req->w.list, &device->active_ee);
 	spin_unlock_irq(&device->resource->req_lock);
 
@@ -3903,14 +3993,14 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 	}
 
 	device->peer_max_bio_size = be32_to_cpu(p->max_bio_size);
-	/* Leave drbd_reconsider_max_bio_size() before drbd_determine_dev_size().
+	/* Leave drbd_reconsider_queue_parameters() before drbd_determine_dev_size().
 	   In case we cleared the QUEUE_FLAG_DISCARD from our queue in
-	   drbd_reconsider_max_bio_size(), we can be sure that after
+	   drbd_reconsider_queue_parameters(), we can be sure that after
 	   drbd_determine_dev_size() no REQ_DISCARDs are in the queue. */
 
 	ddsf = be16_to_cpu(p->dds_flags);
 	if (get_ldev(device)) {
-		drbd_reconsider_max_bio_size(device, device->ldev);
+		drbd_reconsider_queue_parameters(device, device->ldev);
 		dd = drbd_determine_dev_size(device, ddsf, NULL);
 		put_ldev(device);
 		if (dd == DS_ERROR)
@@ -3930,7 +4020,7 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 		 * However, if he sends a zero current size,
 		 * take his (user-capped or) backing disk size anyways.
 		 */
-		drbd_reconsider_max_bio_size(device, NULL);
+		drbd_reconsider_queue_parameters(device, NULL);
 		drbd_set_my_capacity(device, p_csize ?: p_usize ?: p_size);
 	}
 
diff --git a/include/linux/drbd_genl.h b/include/linux/drbd_genl.h
index ab649d8..c934d3a 100644
--- a/include/linux/drbd_genl.h
+++ b/include/linux/drbd_genl.h
@@ -132,6 +132,7 @@ GENL_struct(DRBD_NLA_DISK_CONF, 3, disk_conf,
 	__flg_field_def(18, DRBD_GENLA_F_MANDATORY,	disk_drain, DRBD_DISK_DRAIN_DEF)
 	__flg_field_def(19, DRBD_GENLA_F_MANDATORY,	md_flushes, DRBD_MD_FLUSHES_DEF)
 	__flg_field_def(23,     0 /* OPTIONAL */,	al_updates, DRBD_AL_UPDATES_DEF)
+	__flg_field_def(24,     0 /* OPTIONAL */,	discard_zeroes_if_aligned, DRBD_DISCARD_ZEROES_IF_ALIGNED)
 )
 
 GENL_struct(DRBD_NLA_RESOURCE_OPTS, 4, res_opts,
diff --git a/include/linux/drbd_limits.h b/include/linux/drbd_limits.h
index 2e4aad8..a351c40 100644
--- a/include/linux/drbd_limits.h
+++ b/include/linux/drbd_limits.h
@@ -210,6 +210,12 @@
 #define DRBD_MD_FLUSHES_DEF	1
 #define DRBD_TCP_CORK_DEF	1
 #define DRBD_AL_UPDATES_DEF     1
+/* We used to ignore the discard_zeroes_data setting.
+ * To not change established (and expected) behaviour,
+ * by default assume that, for discard_zeroes_data=0,
+ * we can make that an effective discard_zeroes_data=1,
+ * if we only explicitly zero-out unaligned partial chunks. */
+#define DRBD_DISCARD_ZEROES_IF_ALIGNED 1
 
 #define DRBD_ALLOW_TWO_PRIMARIES_DEF	0
 #define DRBD_ALWAYS_ASBP_DEF	0
-- 
2.7.4

