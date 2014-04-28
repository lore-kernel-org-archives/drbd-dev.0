Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:23 +0200
Message-Id: <1398703415-17780-13-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 12/24] drbd: prepare receiving side for
	REQ_DISCARD
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

If the receiver needs to serve a discard request on a queue that does
not announce to be discard cabable, it falls back to do synchronous
blkdev_issue_zeroout().

We expect only "reasonably" large (up to one activity log extent?)
discard requests.

We do this to not to not block the receiver for too long in this
fallback code path, and to not set/clear too many bits inside one
spinlock_irq_save() in drbd_set_in_sync/drbd_set_out_of_sync,

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c   |  6 +--
 drivers/block/drbd/drbd_int.h      | 19 ++++++++-
 drivers/block/drbd/drbd_protocol.h | 10 +++++
 drivers/block/drbd/drbd_receiver.c | 79 +++++++++++++++++++++++++++++---------
 drivers/block/drbd/drbd_worker.c   | 12 ++++--
 5 files changed, 100 insertions(+), 26 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 8dd09a7..8fc5d71 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -845,7 +845,7 @@ void __drbd_set_in_sync(struct drbd_device *device, sector_t sector, int size,
 	int wake_up = 0;
 	unsigned long flags;
 
-	if (size <= 0 || !IS_ALIGNED(size, 512) || size > DRBD_MAX_BIO_SIZE) {
+	if (size <= 0 || !IS_ALIGNED(size, 512) || size > DRBD_MAX_DISCARD_SIZE) {
 		drbd_err(device, "drbd_set_in_sync: sector=%llus size=%d nonsense!\n",
 				(unsigned long long)sector, size);
 		return;
@@ -919,7 +919,7 @@ int __drbd_set_out_of_sync(struct drbd_device *device, sector_t sector, int size
 	if (size == 0)
 		return 0;
 
-	if (size < 0 || !IS_ALIGNED(size, 512) || size > DRBD_MAX_BIO_SIZE) {
+	if (size < 0 || !IS_ALIGNED(size, 512) || size > DRBD_MAX_DISCARD_SIZE) {
 		drbd_err(device, "sector: %llus, size: %d\n",
 			(unsigned long long)sector, size);
 		return 0;
@@ -1286,7 +1286,7 @@ void drbd_rs_failed_io(struct drbd_device *device, sector_t sector, int size)
 	sector_t esector, nr_sectors;
 	int wake_up = 0;
 
-	if (size <= 0 || !IS_ALIGNED(size, 512) || size > DRBD_MAX_BIO_SIZE) {
+	if (size <= 0 || !IS_ALIGNED(size, 512) || size > DRBD_MAX_DISCARD_SIZE) {
 		drbd_err(device, "drbd_rs_failed_io: sector=%llus size=%d nonsense!\n",
 				(unsigned long long)sector, size);
 		return;
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index fe6295c..29123df 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -382,6 +382,12 @@ enum {
 	__EE_CALL_AL_COMPLETE_IO,
 	__EE_MAY_SET_IN_SYNC,
 
+	/* is this a TRIM aka REQ_DISCARD? */
+	__EE_IS_TRIM,
+	/* our lower level cannot handle trim,
+	 * and we want to fall back to zeroout instead */
+	__EE_IS_TRIM_USE_ZEROOUT,
+
 	/* In case a barrier failed,
 	 * we need to resubmit without the barrier flag. */
 	__EE_RESUBMITTED,
@@ -405,7 +411,9 @@ enum {
 };
 #define EE_CALL_AL_COMPLETE_IO (1<<__EE_CALL_AL_COMPLETE_IO)
 #define EE_MAY_SET_IN_SYNC     (1<<__EE_MAY_SET_IN_SYNC)
-#define	EE_RESUBMITTED         (1<<__EE_RESUBMITTED)
+#define EE_IS_TRIM             (1<<__EE_IS_TRIM)
+#define EE_IS_TRIM_USE_ZEROOUT (1<<__EE_IS_TRIM_USE_ZEROOUT)
+#define EE_RESUBMITTED         (1<<__EE_RESUBMITTED)
 #define EE_WAS_ERROR           (1<<__EE_WAS_ERROR)
 #define EE_HAS_DIGEST          (1<<__EE_HAS_DIGEST)
 #define EE_RESTART_REQUESTS	(1<<__EE_RESTART_REQUESTS)
@@ -1162,6 +1170,12 @@ struct bm_extent {
 #define DRBD_MAX_SIZE_H80_PACKET (1U << 15) /* Header 80 only allows packets up to 32KiB data */
 #define DRBD_MAX_BIO_SIZE_P95    (1U << 17) /* Protocol 95 to 99 allows bios up to 128KiB */
 
+/* For now, don't allow more than one activity log extent worth of data
+ * to be discarded in one go. We may need to rework drbd_al_begin_io()
+ * to allow for even larger discard ranges */
+#define DRBD_MAX_DISCARD_SIZE	AL_EXTENT_SIZE
+#define DRBD_MAX_DISCARD_SECTORS (DRBD_MAX_DISCARD_SIZE >> 9)
+
 extern int  drbd_bm_init(struct drbd_device *device);
 extern int  drbd_bm_resize(struct drbd_device *device, sector_t sectors, int set_new_bits);
 extern void drbd_bm_cleanup(struct drbd_device *device);
@@ -1359,6 +1373,8 @@ extern int w_start_resync(struct drbd_work *, int);
 extern void resync_timer_fn(unsigned long data);
 extern void start_resync_timer_fn(unsigned long data);
 
+extern void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req);
+
 /* drbd_receiver.c */
 extern int drbd_receiver(struct drbd_thread *thi);
 extern int drbd_asender(struct drbd_thread *thi);
@@ -1370,6 +1386,7 @@ extern int drbd_submit_peer_request(struct drbd_device *,
 extern int drbd_free_peer_reqs(struct drbd_device *, struct list_head *);
 extern struct drbd_peer_request *drbd_alloc_peer_req(struct drbd_peer_device *, u64,
 						     sector_t, unsigned int,
+						     bool,
 						     gfp_t) __must_hold(local);
 extern void __drbd_free_peer_req(struct drbd_device *, struct drbd_peer_request *,
 				 int);
diff --git a/drivers/block/drbd/drbd_protocol.h b/drivers/block/drbd/drbd_protocol.h
index 3c04ec0..478c63d 100644
--- a/drivers/block/drbd/drbd_protocol.h
+++ b/drivers/block/drbd/drbd_protocol.h
@@ -54,6 +54,11 @@ enum drbd_packet {
 	P_CONN_ST_CHG_REPLY   = 0x2b, /* meta sock: Connection side state req reply */
 	P_RETRY_WRITE	      = 0x2c, /* Protocol C: retry conflicting write request */
 	P_PROTOCOL_UPDATE     = 0x2d, /* data sock: is used in established connections */
+        /* 0x2e to 0x30 reserved, used in drbd 9 */
+
+	/* REQ_DISCARD. We used "discard" in different contexts before,
+	 * which is why I chose TRIM here, to disambiguate. */
+	P_TRIM                = 0x31,
 
 	P_MAY_IGNORE	      = 0x100, /* Flag to test if (cmd > P_MAY_IGNORE) ... */
 	P_MAX_OPT_CMD	      = 0x101,
@@ -119,6 +124,11 @@ struct p_data {
 	u32	    dp_flags;
 } __packed;
 
+struct p_trim {
+	struct p_data p_data;
+	u32	    size;	/* == bio->bi_size */
+} __packed;
+
 /*
  * commands which share a struct:
  *  p_block_ack:
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 10d2dcb..9640b64 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -65,7 +65,7 @@ enum finish_epoch {
 static int drbd_do_features(struct drbd_connection *connection);
 static int drbd_do_auth(struct drbd_connection *connection);
 static int drbd_disconnected(struct drbd_peer_device *);
-
+static void conn_wait_active_ee_empty(struct drbd_connection *connection);
 static enum finish_epoch drbd_may_finish_epoch(struct drbd_connection *, struct drbd_epoch *, enum epoch_event);
 static int e_end_block(struct drbd_work *, int);
 
@@ -338,7 +338,7 @@ You must not have the req_lock:
 
 struct drbd_peer_request *
 drbd_alloc_peer_req(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
-		    unsigned int data_size, gfp_t gfp_mask) __must_hold(local)
+		    unsigned int data_size, bool has_payload, gfp_t gfp_mask) __must_hold(local)
 {
 	struct drbd_device *device = peer_device->device;
 	struct drbd_peer_request *peer_req;
@@ -355,7 +355,7 @@ drbd_alloc_peer_req(struct drbd_peer_device *peer_device, u64 id, sector_t secto
 		return NULL;
 	}
 
-	if (data_size) {
+	if (has_payload && data_size) {
 		page = drbd_alloc_pages(peer_device, nr_pages, (gfp_mask & __GFP_WAIT));
 		if (!page)
 			goto fail;
@@ -1325,6 +1325,20 @@ int drbd_submit_peer_request(struct drbd_device *device,
 	unsigned nr_pages = (ds + PAGE_SIZE -1) >> PAGE_SHIFT;
 	int err = -ENOMEM;
 
+	if (peer_req->flags & EE_IS_TRIM_USE_ZEROOUT) {
+		/* wait for all pending IO completions, before we start
+		 * zeroing things out. */
+		conn_wait_active_ee_empty(first_peer_device(device)->connection);
+		if (blkdev_issue_zeroout(device->ldev->backing_bdev,
+			sector, ds >> 9, GFP_NOIO))
+			peer_req->flags |= EE_WAS_ERROR;
+		drbd_endio_write_sec_final(peer_req);
+		return 0;
+	}
+
+	if (peer_req->flags & EE_IS_TRIM)
+		nr_pages = 0; /* discards don't have any payload. */
+
 	/* In most cases, we will only need one bio.  But in case the lower
 	 * level restrictions happen to be different at this offset on this
 	 * side than those of the sending peer, we may need to submit the
@@ -1336,7 +1350,7 @@ int drbd_submit_peer_request(struct drbd_device *device,
 next_bio:
 	bio = bio_alloc(GFP_NOIO, nr_pages);
 	if (!bio) {
-		drbd_err(device, "submit_ee: Allocation of a bio failed\n");
+		drbd_err(device, "submit_ee: Allocation of a bio failed (nr_pages=%u)\n", nr_pages);
 		goto fail;
 	}
 	/* > peer_req->i.sector, unless this is the first bio */
@@ -1350,6 +1364,11 @@ next_bio:
 	bios = bio;
 	++n_bios;
 
+	if (rw & REQ_DISCARD) {
+		bio->bi_iter.bi_size = ds;
+		goto submit;
+	}
+
 	page_chain_for_each(page) {
 		unsigned len = min_t(unsigned, ds, PAGE_SIZE);
 		if (!bio_add_page(bio, page, len, 0)) {
@@ -1370,8 +1389,9 @@ next_bio:
 		sector += len >> 9;
 		--nr_pages;
 	}
-	D_ASSERT(device, page == NULL);
 	D_ASSERT(device, ds == 0);
+submit:
+	D_ASSERT(device, page == NULL);
 
 	atomic_set(&peer_req->pending_bios, n_bios);
 	do {
@@ -1500,19 +1520,21 @@ static int receive_Barrier(struct drbd_connection *connection, struct packet_inf
  * and from receive_Data */
 static struct drbd_peer_request *
 read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
-	      int data_size) __must_hold(local)
+	      struct packet_info *pi) __must_hold(local)
 {
 	struct drbd_device *device = peer_device->device;
 	const sector_t capacity = drbd_get_capacity(device->this_bdev);
 	struct drbd_peer_request *peer_req;
 	struct page *page;
 	int dgs, ds, err;
+	int data_size = pi->size;
 	void *dig_in = peer_device->connection->int_dig_in;
 	void *dig_vv = peer_device->connection->int_dig_vv;
 	unsigned long *data;
+	struct p_trim *trim = (pi->cmd == P_TRIM) ? pi->data : NULL;
 
 	dgs = 0;
-	if (peer_device->connection->peer_integrity_tfm) {
+	if (!trim && peer_device->connection->peer_integrity_tfm) {
 		dgs = crypto_hash_digestsize(peer_device->connection->peer_integrity_tfm);
 		/*
 		 * FIXME: Receive the incoming digest into the receive buffer
@@ -1524,9 +1546,15 @@ read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
 		data_size -= dgs;
 	}
 
+	if (trim) {
+		D_ASSERT(peer_device, data_size == 0);
+		data_size = be32_to_cpu(trim->size);
+	}
+
 	if (!expect(IS_ALIGNED(data_size, 512)))
 		return NULL;
-	if (!expect(data_size <= DRBD_MAX_BIO_SIZE))
+	/* prepare for larger trim requests. */
+	if (!trim && !expect(data_size <= DRBD_MAX_BIO_SIZE))
 		return NULL;
 
 	/* even though we trust out peer,
@@ -1542,11 +1570,11 @@ read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
 	/* GFP_NOIO, because we must not cause arbitrary write-out: in a DRBD
 	 * "criss-cross" setup, that might cause write-out on some other DRBD,
 	 * which in turn might block on the other node at this very place.  */
-	peer_req = drbd_alloc_peer_req(peer_device, id, sector, data_size, GFP_NOIO);
+	peer_req = drbd_alloc_peer_req(peer_device, id, sector, data_size, trim == NULL, GFP_NOIO);
 	if (!peer_req)
 		return NULL;
 
-	if (!data_size)
+	if (trim)
 		return peer_req;
 
 	ds = data_size;
@@ -1686,12 +1714,12 @@ static int e_end_resync_block(struct drbd_work *w, int unused)
 }
 
 static int recv_resync_read(struct drbd_peer_device *peer_device, sector_t sector,
-			    int data_size) __releases(local)
+			    struct packet_info *pi) __releases(local)
 {
 	struct drbd_device *device = peer_device->device;
 	struct drbd_peer_request *peer_req;
 
-	peer_req = read_in_block(peer_device, ID_SYNCER, sector, data_size);
+	peer_req = read_in_block(peer_device, ID_SYNCER, sector, pi);
 	if (!peer_req)
 		goto fail;
 
@@ -1707,7 +1735,7 @@ static int recv_resync_read(struct drbd_peer_device *peer_device, sector_t secto
 	list_add(&peer_req->w.list, &device->sync_ee);
 	spin_unlock_irq(&device->resource->req_lock);
 
-	atomic_add(data_size >> 9, &device->rs_sect_ev);
+	atomic_add(pi->size >> 9, &device->rs_sect_ev);
 	if (drbd_submit_peer_request(device, peer_req, WRITE, DRBD_FAULT_RS_WR) == 0)
 		return 0;
 
@@ -1795,7 +1823,7 @@ static int receive_RSDataReply(struct drbd_connection *connection, struct packet
 		/* data is submitted to disk within recv_resync_read.
 		 * corresponding put_ldev done below on error,
 		 * or in drbd_peer_request_endio. */
-		err = recv_resync_read(peer_device, sector, pi->size);
+		err = recv_resync_read(peer_device, sector, pi);
 	} else {
 		if (__ratelimit(&drbd_ratelimit_state))
 			drbd_err(device, "Can not write resync data to local disk.\n");
@@ -2206,7 +2234,7 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 	 */
 
 	sector = be64_to_cpu(p->sector);
-	peer_req = read_in_block(peer_device, p->block_id, sector, pi->size);
+	peer_req = read_in_block(peer_device, p->block_id, sector, pi);
 	if (!peer_req) {
 		put_ldev(device);
 		return -EIO;
@@ -2216,7 +2244,15 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 
 	dp_flags = be32_to_cpu(p->dp_flags);
 	rw |= wire_flags_to_bio(dp_flags);
-	if (peer_req->pages == NULL) {
+	if (pi->cmd == P_TRIM) {
+		struct request_queue *q = bdev_get_queue(device->ldev->backing_bdev);
+		peer_req->flags |= EE_IS_TRIM;
+		if (!blk_queue_discard(q))
+			peer_req->flags |= EE_IS_TRIM_USE_ZEROOUT;
+		D_ASSERT(peer_device, peer_req->i.size > 0);
+		D_ASSERT(peer_device, rw & REQ_DISCARD);
+		D_ASSERT(peer_device, peer_req->pages == NULL);
+	} else if (peer_req->pages == NULL) {
 		D_ASSERT(device, peer_req->i.size == 0);
 		D_ASSERT(device, dp_flags & DP_FLUSH);
 	}
@@ -2252,7 +2288,12 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 		update_peer_seq(peer_device, peer_seq);
 		spin_lock_irq(&device->resource->req_lock);
 	}
-	list_add(&peer_req->w.list, &device->active_ee);
+	/* if we use the zeroout fallback code, we process synchronously
+	 * and we wait for all pending requests, respectively wait for
+	 * active_ee to become empty in drbd_submit_peer_request();
+	 * better not add ourselves here. */
+	if ((peer_req->flags & EE_IS_TRIM_USE_ZEROOUT) == 0)
+		list_add(&peer_req->w.list, &device->active_ee);
 	spin_unlock_irq(&device->resource->req_lock);
 
 	if (device->state.conn == C_SYNC_TARGET)
@@ -2451,7 +2492,8 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 	/* GFP_NOIO, because we must not cause arbitrary write-out: in a DRBD
 	 * "criss-cross" setup, that might cause write-out on some other DRBD,
 	 * which in turn might block on the other node at this very place.  */
-	peer_req = drbd_alloc_peer_req(peer_device, p->block_id, sector, size, GFP_NOIO);
+	peer_req = drbd_alloc_peer_req(peer_device, p->block_id, sector, size,
+			true /* has real payload */, GFP_NOIO);
 	if (!peer_req) {
 		put_ldev(device);
 		return -ENOMEM;
@@ -4438,6 +4480,7 @@ static struct data_cmd drbd_cmd_handler[] = {
 	[P_OUT_OF_SYNC]     = { 0, sizeof(struct p_block_desc), receive_out_of_sync },
 	[P_CONN_ST_CHG_REQ] = { 0, sizeof(struct p_req_state), receive_req_conn_state },
 	[P_PROTOCOL_UPDATE] = { 1, sizeof(struct p_protocol), receive_protocol },
+	[P_TRIM]	    = { 0, sizeof(struct p_trim), receive_Data },
 };
 
 static void drbdd(struct drbd_connection *connection)
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 7e633ca..5fd4eae 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -118,7 +118,7 @@ static void drbd_endio_read_sec_final(struct drbd_peer_request *peer_req) __rele
 
 /* writes on behalf of the partner, or resync writes,
  * "submitted" by the receiver, final stage.  */
-static void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req) __releases(local)
+void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req) __releases(local)
 {
 	unsigned long flags = 0;
 	struct drbd_peer_device *peer_device = peer_req->peer_device;
@@ -150,7 +150,9 @@ static void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req) __rel
 
 	do_wake = list_empty(block_id == ID_SYNCER ? &device->sync_ee : &device->active_ee);
 
-	if (test_bit(__EE_WAS_ERROR, &peer_req->flags))
+	/* FIXME do we want to detach for failed REQ_DISCARD?
+	 * ((peer_req->flags & (EE_WAS_ERROR|EE_IS_TRIM)) == EE_WAS_ERROR) */
+	if (peer_req->flags & EE_WAS_ERROR)
 		__drbd_chk_io_error(device, DRBD_WRITE_ERROR);
 	spin_unlock_irqrestore(&device->resource->req_lock, flags);
 
@@ -176,10 +178,12 @@ void drbd_peer_request_endio(struct bio *bio, int error)
 	struct drbd_device *device = peer_req->peer_device->device;
 	int uptodate = bio_flagged(bio, BIO_UPTODATE);
 	int is_write = bio_data_dir(bio) == WRITE;
+	int is_discard = !!(bio->bi_rw & REQ_DISCARD);
 
 	if (error && __ratelimit(&drbd_ratelimit_state))
 		drbd_warn(device, "%s: error=%d s=%llus\n",
-				is_write ? "write" : "read", error,
+				is_write ? (is_discard ? "discard" : "write")
+					: "read", error,
 				(unsigned long long)peer_req->i.sector);
 	if (!error && !uptodate) {
 		if (__ratelimit(&drbd_ratelimit_state))
@@ -395,7 +399,7 @@ static int read_for_csum(struct drbd_peer_device *peer_device, sector_t sector,
 	/* GFP_TRY, because if there is no memory available right now, this may
 	 * be rescheduled for later. It is "only" background resync, after all. */
 	peer_req = drbd_alloc_peer_req(peer_device, ID_SYNCER /* unused */, sector,
-				       size, GFP_TRY);
+				       size, true /* has real payload */, GFP_TRY);
 	if (!peer_req)
 		goto defer;
 
-- 
1.9.1

