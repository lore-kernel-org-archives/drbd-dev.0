Return-Path: <lars.ellenberg@linbit.com>
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Date: Thu, 20 Dec 2018 17:23:42 +0100
Message-Id: <20181220162344.8430-16-lars.ellenberg@linbit.com>
In-Reply-To: <20181220162344.8430-1-lars.ellenberg@linbit.com>
References: <20181220162344.8430-1-lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 15/17] drbd: introduce P_ZEROES
	(REQ_OP_WRITE_ZEROES on the "wire")
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

And also re-enable partial-zero-out + discard aligned.

With the introduction of REQ_OP_WRITE_ZEROES,
we started to use that for both WRITE_ZEROES and DISCARDS,
hoping that WRITE_ZEROES would "do what we want",
UNMAP if possible, zero-out the rest.

The example scenario is some LVM "thin" backend.

While an un-allocated block on dm-thin reads as zeroes, on a dm-thin
with "skip_block_zeroing=true", after a partial block write allocated
that block, that same block may well map "undefined old garbage" from
the backends on LBAs that have not yet been written to.

If we cannot distinguish between zero-out and discard on the receiving
side, to avoid "undefined old garbage" to pop up randomly at later times
on supposedly zero-initialized blocks, we'd need to map all discards to
zero-out on the receiving side.  But that would potentially do a full
alloc on thinly provisioned backends, even when the expectation was to
unmap/trim/discard/de-allocate.

We need to distinguish on the protocol level, whether we need to guarantee
zeroes (and thus use zero-out, potentially doing the mentioned full-alloc),
or if we want to put the emphasis on discard, and only do a "best effort
zeroing" (by "discarding" blocks aligned to discard-granularity, and zeroing
only potential unaligned head and tail clippings to at least *try* to
avoid "false positives" in an online-verify later), hoping that someone
set skip_block_zeroing=false.

For some discussion regarding this on dm-devel, see also
https://www.mail-archive.com/dm-devel%40redhat.com/msg07965.html
https://www.redhat.com/archives/dm-devel/2018-January/msg00271.html

For backward compatibility, P_TRIM means zero-out, unless the
DRBD_FF_WZEROES feature flag is agreed upon during handshake.

To have upper layers even try to submit WRITE ZEROES requests,
we need to announce "efficient zeroout" independently.

We need to fixup max_write_zeroes_sectors after blk_queue_stack_limits():
if we can handle "zeroes" efficiently on the protocol,
we want to do that, even if our backend does not announce
max_write_zeroes_sectors itself.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_debugfs.c  |   2 +
 drivers/block/drbd/drbd_int.h      |  11 +-
 drivers/block/drbd/drbd_main.c     |  11 +-
 drivers/block/drbd/drbd_nl.c       |  16 +++
 drivers/block/drbd/drbd_protocol.h |  47 ++++++++
 drivers/block/drbd/drbd_receiver.c | 171 ++++++++++++++++++++++++++---
 drivers/block/drbd/drbd_req.c      |  19 ++--
 drivers/block/drbd/drbd_req.h      |   2 +
 drivers/block/drbd/drbd_worker.c   |   2 +-
 include/linux/drbd.h               |   2 +-
 10 files changed, 252 insertions(+), 31 deletions(-)

diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index 5d5e8d6a8a56..f13b48ff5f43 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -237,6 +237,8 @@ static void seq_print_peer_request_flags(struct seq_file *m, struct drbd_peer_re
 	seq_print_rq_state_bit(m, f & EE_CALL_AL_COMPLETE_IO, &sep, "in-AL");
 	seq_print_rq_state_bit(m, f & EE_SEND_WRITE_ACK, &sep, "C");
 	seq_print_rq_state_bit(m, f & EE_MAY_SET_IN_SYNC, &sep, "set-in-sync");
+	seq_print_rq_state_bit(m, f & EE_TRIM, &sep, "trim");
+	seq_print_rq_state_bit(m, f & EE_ZEROOUT, &sep, "zero-out");
 	seq_print_rq_state_bit(m, f & EE_WRITE_SAME, &sep, "write-same");
 	seq_putc(m, '\n');
 }
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index ab718582a092..000a2f4c0e92 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -430,7 +430,11 @@ enum {
 	__EE_MAY_SET_IN_SYNC,
 
 	/* is this a TRIM aka REQ_OP_DISCARD? */
-	__EE_IS_TRIM,
+	__EE_TRIM,
+	/* explicit zero-out requested, or
+	 * our lower level cannot handle trim,
+	 * and we want to fall back to zeroout instead */
+	__EE_ZEROOUT,
 
 	/* In case a barrier failed,
 	 * we need to resubmit without the barrier flag. */
@@ -472,7 +476,8 @@ enum {
 };
 #define EE_CALL_AL_COMPLETE_IO (1<<__EE_CALL_AL_COMPLETE_IO)
 #define EE_MAY_SET_IN_SYNC     (1<<__EE_MAY_SET_IN_SYNC)
-#define EE_IS_TRIM             (1<<__EE_IS_TRIM)
+#define EE_TRIM                (1<<__EE_TRIM)
+#define EE_ZEROOUT             (1<<__EE_ZEROOUT)
 #define EE_RESUBMITTED         (1<<__EE_RESUBMITTED)
 #define EE_WAS_ERROR           (1<<__EE_WAS_ERROR)
 #define EE_HAS_DIGEST          (1<<__EE_HAS_DIGEST)
@@ -1556,6 +1561,8 @@ extern void start_resync_timer_fn(struct timer_list *t);
 extern void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req);
 
 /* drbd_receiver.c */
+extern int drbd_issue_discard_or_zero_out(struct drbd_device *device,
+		sector_t start, unsigned int nr_sectors, int flags);
 extern int drbd_receiver(struct drbd_thread *thi);
 extern int drbd_ack_receiver(struct drbd_thread *thi);
 extern void drbd_send_ping_wf(struct work_struct *ws);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index f9b4228cc2d9..714eb64fabfd 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1668,7 +1668,11 @@ static u32 bio_flags_to_wire(struct drbd_connection *connection,
 			(bio->bi_opf & REQ_PREFLUSH ? DP_FLUSH : 0) |
 			(bio_op(bio) == REQ_OP_WRITE_SAME ? DP_WSAME : 0) |
 			(bio_op(bio) == REQ_OP_DISCARD ? DP_DISCARD : 0) |
-			(bio_op(bio) == REQ_OP_WRITE_ZEROES ? DP_DISCARD : 0);
+			(bio_op(bio) == REQ_OP_WRITE_ZEROES ?
+			  ((connection->agreed_features & DRBD_FF_WZEROES) ?
+			   (DP_ZEROES |(!(bio->bi_opf & REQ_NOUNMAP) ? DP_DISCARD : 0))
+			   : DP_DISCARD)
+			: 0);
 	else
 		return bio->bi_opf & REQ_SYNC ? DP_RW_SYNC : 0;
 }
@@ -1712,10 +1716,11 @@ int drbd_send_dblock(struct drbd_peer_device *peer_device, struct drbd_request *
 	}
 	p->dp_flags = cpu_to_be32(dp_flags);
 
-	if (dp_flags & DP_DISCARD) {
+	if (dp_flags & (DP_DISCARD|DP_ZEROES)) {
+		enum drbd_packet cmd = (dp_flags & DP_ZEROES) ? P_ZEROES : P_TRIM;
 		struct p_trim *t = (struct p_trim*)p;
 		t->size = cpu_to_be32(req->i.size);
-		err = __send_command(peer_device->connection, device->vnr, sock, P_TRIM, sizeof(*t), NULL, 0);
+		err = __send_command(peer_device->connection, device->vnr, sock, cmd, sizeof(*t), NULL, 0);
 		goto out;
 	}
 	if (dp_flags & DP_WSAME) {
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index bfe1b0062d62..f2471172a961 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1261,6 +1261,21 @@ static void fixup_discard_if_not_supported(struct request_queue *q)
 	}
 }
 
+static void fixup_write_zeroes(struct drbd_device *device, struct request_queue *q)
+{
+	/* Fixup max_write_zeroes_sectors after blk_queue_stack_limits():
+	 * if we can handle "zeroes" efficiently on the protocol,
+	 * we want to do that, even if our backend does not announce
+	 * max_write_zeroes_sectors itself. */
+	struct drbd_connection *connection = first_peer_device(device)->connection;
+	/* If the peer announces WZEROES support, use it.  Otherwise, rather
+	 * send explicit zeroes than rely on some discard-zeroes-data magic. */
+	if (connection->agreed_features & DRBD_FF_WZEROES)
+		q->limits.max_write_zeroes_sectors = DRBD_MAX_BBIO_SECTORS;
+	else
+		q->limits.max_write_zeroes_sectors = 0;
+}
+
 static void decide_on_write_same_support(struct drbd_device *device,
 			struct request_queue *q,
 			struct request_queue *b, struct o_qlim *o,
@@ -1371,6 +1386,7 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 		}
 	}
 	fixup_discard_if_not_supported(q);
+	fixup_write_zeroes(device, q);
 }
 
 void drbd_reconsider_queue_parameters(struct drbd_device *device, struct drbd_backing_dev *bdev, struct o_qlim *o)
diff --git a/drivers/block/drbd/drbd_protocol.h b/drivers/block/drbd/drbd_protocol.h
index 48dabbb21e11..e6fc5ad72501 100644
--- a/drivers/block/drbd/drbd_protocol.h
+++ b/drivers/block/drbd/drbd_protocol.h
@@ -70,6 +70,11 @@ enum drbd_packet {
 	 * we may fall back to an opencoded loop instead. */
 	P_WSAME               = 0x34,
 
+	/* 0x35 already claimed in DRBD 9 */
+	P_ZEROES              = 0x36, /* data sock: zero-out, WRITE_ZEROES */
+
+	/* 0x40 .. 0x48 already claimed in DRBD 9 */
+
 	P_MAY_IGNORE	      = 0x100, /* Flag to test if (cmd > P_MAY_IGNORE) ... */
 	P_MAX_OPT_CMD	      = 0x101,
 
@@ -130,6 +135,12 @@ struct p_header100 {
 #define DP_SEND_RECEIVE_ACK 128 /* This is a proto B write request */
 #define DP_SEND_WRITE_ACK   256 /* This is a proto C write request */
 #define DP_WSAME            512 /* equiv. REQ_WRITE_SAME */
+#define DP_ZEROES          1024 /* equiv. REQ_OP_WRITE_ZEROES */
+
+/* possible combinations:
+ * REQ_OP_WRITE_ZEROES:  DP_DISCARD | DP_ZEROES
+ * REQ_OP_WRITE_ZEROES + REQ_NOUNMAP: DP_ZEROES
+ */
 
 struct p_data {
 	u64	    sector;    /* 64 bits sector number */
@@ -197,6 +208,42 @@ struct p_block_req {
  */
 #define DRBD_FF_WSAME 4
 
+/* supports REQ_OP_WRITE_ZEROES on the "wire" protocol.
+ *
+ * We used to map that to "discard" on the sending side, and if we cannot
+ * guarantee that discard zeroes data, the receiving side would map discard
+ * back to zero-out.
+ *
+ * With the introduction of REQ_OP_WRITE_ZEROES,
+ * we started to use that for both WRITE_ZEROES and DISCARDS,
+ * hoping that WRITE_ZEROES would "do what we want",
+ * UNMAP if possible, zero-out the rest.
+ *
+ * The example scenario is some LVM "thin" backend.
+ *
+ * While an un-allocated block on dm-thin reads as zeroes, on a dm-thin
+ * with "skip_block_zeroing=true", after a partial block write allocated
+ * that block, that same block may well map "undefined old garbage" from
+ * the backends on LBAs that have not yet been written to.
+ *
+ * If we cannot distinguish between zero-out and discard on the receiving
+ * side, to avoid "undefined old garbage" to pop up randomly at later times
+ * on supposedly zero-initialized blocks, we'd need to map all discards to
+ * zero-out on the receiving side.  But that would potentially do a full
+ * alloc on thinly provisioned backends, even when the expectation was to
+ * unmap/trim/discard/de-allocate.
+ *
+ * We need to distinguish on the protocol level, whether we need to guarantee
+ * zeroes (and thus use zero-out, potentially doing the mentioned full-alloc),
+ * or if we want to put the emphasis on discard, and only do a "best effort
+ * zeroing" (by "discarding" blocks aligned to discard-granularity, and zeroing
+ * only potential unaligned head and tail clippings), to at least *try* to
+ * avoid "false positives" in an online-verify later, hoping that someone
+ * set skip_block_zeroing=false.
+ */
+#define DRBD_FF_WZEROES 8
+
+
 struct p_connection_features {
 	u32 protocol_min;
 	u32 feature_flags;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 02a327891568..47d2d6f87c2c 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -50,7 +50,7 @@
 #include "drbd_req.h"
 #include "drbd_vli.h"
 
-#define PRO_FEATURES (DRBD_FF_TRIM|DRBD_FF_THIN_RESYNC|DRBD_FF_WSAME)
+#define PRO_FEATURES (DRBD_FF_TRIM|DRBD_FF_THIN_RESYNC|DRBD_FF_WSAME|DRBD_FF_WZEROES)
 
 struct packet_info {
 	enum drbd_packet cmd;
@@ -1490,14 +1490,129 @@ void drbd_bump_write_ordering(struct drbd_resource *resource, struct drbd_backin
 		drbd_info(resource, "Method to ensure write ordering: %s\n", write_ordering_str[resource->write_ordering]);
 }
 
-static void drbd_issue_peer_discard(struct drbd_device *device, struct drbd_peer_request *peer_req)
+/*
+ * Mapping "discard" to ZEROOUT with UNMAP does not work for us:
+ * Drivers have to "announce" q->limits.max_write_zeroes_sectors, or it
+ * will directly go to fallback mode, submitting normal writes, and
+ * never even try to UNMAP.
+ *
+ * And dm-thin does not do this (yet), mostly because in general it has
+ * to assume that "skip_block_zeroing" is set.  See also:
+ * https://www.mail-archive.com/dm-devel%40redhat.com/msg07965.html
+ * https://www.redhat.com/archives/dm-devel/2018-January/msg00271.html
+ *
+ * We *may* ignore the discard-zeroes-data setting, if so configured.
+ *
+ * Assumption is that this "discard_zeroes_data=0" is only because the backend
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
+ * At least for LVM/DM thin, with skip_block_zeroing=false,
+ * the result is effectively "discard_zeroes_data=1".
+ */
+/* flags: EE_TRIM|EE_ZEROOUT */
+int drbd_issue_discard_or_zero_out(struct drbd_device *device, sector_t start, unsigned int nr_sectors, int flags)
 {
 	struct block_device *bdev = device->ldev->backing_bdev;
+	struct request_queue *q = bdev_get_queue(bdev);
+	sector_t tmp, nr;
+	unsigned int max_discard_sectors, granularity;
+	int alignment;
+	int err = 0;
 
-	if (blkdev_issue_zeroout(bdev, peer_req->i.sector, peer_req->i.size >> 9,
-			GFP_NOIO, 0))
-		peer_req->flags |= EE_WAS_ERROR;
+	if ((flags & EE_ZEROOUT) || !(flags & EE_TRIM))
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
+		/* don't flag BLKDEV_ZERO_NOUNMAP, we don't know how many
+		 * layers are below us, some may have smaller granularity */
+		err |= blkdev_issue_zeroout(bdev, start, nr, GFP_NOIO, 0);
+		nr_sectors -= nr;
+		start = tmp;
+	}
+	while (nr_sectors >= max_discard_sectors) {
+		err |= blkdev_issue_discard(bdev, start, max_discard_sectors, GFP_NOIO, 0);
+		nr_sectors -= max_discard_sectors;
+		start += max_discard_sectors;
+	}
+	if (nr_sectors) {
+		/* max_discard_sectors is unsigned int (and a multiple of
+		 * granularity, we made sure of that above already);
+		 * nr is < max_discard_sectors;
+		 * I don't need sector_div here, even though nr is sector_t */
+		nr = nr_sectors;
+		nr -= (unsigned int)nr % granularity;
+		if (nr) {
+			err |= blkdev_issue_discard(bdev, start, nr, GFP_NOIO, 0);
+			nr_sectors -= nr;
+			start += nr;
+		}
+	}
+ zero_out:
+	if (nr_sectors) {
+		err |= blkdev_issue_zeroout(bdev, start, nr_sectors, GFP_NOIO,
+				(flags & EE_TRIM) ? 0 : BLKDEV_ZERO_NOUNMAP);
+	}
+	return err != 0;
+}
+
+static bool can_do_reliable_discards(struct drbd_device *device)
+{
+	struct request_queue *q = bdev_get_queue(device->ldev->backing_bdev);
+	struct disk_conf *dc;
+	bool can_do;
 
+	if (!blk_queue_discard(q))
+		return false;
+
+	rcu_read_lock();
+	dc = rcu_dereference(device->ldev->disk_conf);
+	can_do = dc->discard_zeroes_if_aligned;
+	rcu_read_unlock();
+	return can_do;
+}
+
+static void drbd_issue_peer_discard_or_zero_out(struct drbd_device *device, struct drbd_peer_request *peer_req)
+{
+	/* If the backend cannot discard, or does not guarantee
+	 * read-back zeroes in discarded ranges, we fall back to
+	 * zero-out.  Unless configuration specifically requested
+	 * otherwise. */
+	if (!can_do_reliable_discards(device))
+		peer_req->flags |= EE_ZEROOUT;
+
+	if (drbd_issue_discard_or_zero_out(device, peer_req->i.sector,
+	    peer_req->i.size >> 9, peer_req->flags & (EE_ZEROOUT|EE_TRIM)))
+		peer_req->flags |= EE_WAS_ERROR;
 	drbd_endio_write_sec_final(peer_req);
 }
 
@@ -1550,7 +1665,7 @@ int drbd_submit_peer_request(struct drbd_device *device,
 	 * Correctness first, performance later.  Next step is to code an
 	 * asynchronous variant of the same.
 	 */
-	if (peer_req->flags & (EE_IS_TRIM|EE_WRITE_SAME)) {
+	if (peer_req->flags & (EE_TRIM|EE_WRITE_SAME|EE_ZEROOUT)) {
 		/* wait for all pending IO completions, before we start
 		 * zeroing things out. */
 		conn_wait_active_ee_empty(peer_req->peer_device->connection);
@@ -1567,8 +1682,8 @@ int drbd_submit_peer_request(struct drbd_device *device,
 			spin_unlock_irq(&device->resource->req_lock);
 		}
 
-		if (peer_req->flags & EE_IS_TRIM)
-			drbd_issue_peer_discard(device, peer_req);
+		if (peer_req->flags & (EE_TRIM|EE_ZEROOUT))
+			drbd_issue_peer_discard_or_zero_out(device, peer_req);
 		else /* EE_WRITE_SAME */
 			drbd_issue_peer_wsame(device, peer_req);
 		return 0;
@@ -1765,6 +1880,7 @@ read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
 	void *dig_vv = peer_device->connection->int_dig_vv;
 	unsigned long *data;
 	struct p_trim *trim = (pi->cmd == P_TRIM) ? pi->data : NULL;
+	struct p_trim *zeroes = (pi->cmd == P_ZEROES) ? pi->data : NULL;
 	struct p_trim *wsame = (pi->cmd == P_WSAME) ? pi->data : NULL;
 
 	digest_size = 0;
@@ -1786,6 +1902,10 @@ read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
 		if (!expect(data_size == 0))
 			return NULL;
 		ds = be32_to_cpu(trim->size);
+	} else if (zeroes) {
+		if (!expect(data_size == 0))
+			return NULL;
+		ds = be32_to_cpu(zeroes->size);
 	} else if (wsame) {
 		if (data_size != queue_logical_block_size(device->rq_queue)) {
 			drbd_err(peer_device, "data size (%u) != drbd logical block size (%u)\n",
@@ -1802,7 +1922,7 @@ read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
 
 	if (!expect(IS_ALIGNED(ds, 512)))
 		return NULL;
-	if (trim || wsame) {
+	if (trim || wsame || zeroes) {
 		if (!expect(ds <= (DRBD_MAX_BBIO_SECTORS << 9)))
 			return NULL;
 	} else if (!expect(ds <= DRBD_MAX_BIO_SIZE))
@@ -1827,7 +1947,11 @@ read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
 
 	peer_req->flags |= EE_WRITE;
 	if (trim) {
-		peer_req->flags |= EE_IS_TRIM;
+		peer_req->flags |= EE_TRIM;
+		return peer_req;
+	}
+	if (zeroes) {
+		peer_req->flags |= EE_ZEROOUT;
 		return peer_req;
 	}
 	if (wsame)
@@ -2326,8 +2450,12 @@ static unsigned long wire_flags_to_bio_flags(u32 dpf)
 
 static unsigned long wire_flags_to_bio_op(u32 dpf)
 {
-	if (dpf & DP_DISCARD)
+	if (dpf & DP_ZEROES)
 		return REQ_OP_WRITE_ZEROES;
+	if (dpf & DP_DISCARD)
+		return REQ_OP_DISCARD;
+	if (dpf & DP_WSAME)
+		return REQ_OP_WRITE_SAME;
 	else
 		return REQ_OP_WRITE;
 }
@@ -2517,9 +2645,20 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 	op = wire_flags_to_bio_op(dp_flags);
 	op_flags = wire_flags_to_bio_flags(dp_flags);
 	if (pi->cmd == P_TRIM) {
+		D_ASSERT(peer_device, peer_req->i.size > 0);
+		D_ASSERT(peer_device, op == REQ_OP_DISCARD);
+		D_ASSERT(peer_device, peer_req->pages == NULL);
+		/* need to play safe: an older DRBD sender
+		 * may mean zero-out while sending P_TRIM. */
+		if (0 == (connection->agreed_features & DRBD_FF_WZEROES))
+			peer_req->flags |= EE_ZEROOUT;
+	} else if (pi->cmd == P_ZEROES) {
 		D_ASSERT(peer_device, peer_req->i.size > 0);
 		D_ASSERT(peer_device, op == REQ_OP_WRITE_ZEROES);
 		D_ASSERT(peer_device, peer_req->pages == NULL);
+		/* Do (not) pass down BLKDEV_ZERO_NOUNMAP? */
+		if (dp_flags & DP_DISCARD)
+			peer_req->flags |= EE_TRIM;
 	} else if (peer_req->pages == NULL) {
 		D_ASSERT(device, peer_req->i.size == 0);
 		D_ASSERT(device, dp_flags & DP_FLUSH);
@@ -2587,7 +2726,7 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 	 * we wait for all pending requests, respectively wait for
 	 * active_ee to become empty in drbd_submit_peer_request();
 	 * better not add ourselves here. */
-	if ((peer_req->flags & (EE_IS_TRIM|EE_WRITE_SAME)) == 0)
+	if ((peer_req->flags & (EE_TRIM|EE_WRITE_SAME|EE_ZEROOUT)) == 0)
 		list_add_tail(&peer_req->w.list, &device->active_ee);
 	spin_unlock_irq(&device->resource->req_lock);
 
@@ -4893,7 +5032,7 @@ static int receive_rs_deallocated(struct drbd_connection *connection, struct pac
 
 		peer_req->w.cb = e_end_resync_block;
 		peer_req->submit_jif = jiffies;
-		peer_req->flags |= EE_IS_TRIM;
+		peer_req->flags |= EE_TRIM;
 
 		spin_lock_irq(&device->resource->req_lock);
 		list_add_tail(&peer_req->w.list, &device->sync_ee);
@@ -4961,6 +5100,7 @@ static struct data_cmd drbd_cmd_handler[] = {
 	[P_CONN_ST_CHG_REQ] = { 0, sizeof(struct p_req_state), receive_req_conn_state },
 	[P_PROTOCOL_UPDATE] = { 1, sizeof(struct p_protocol), receive_protocol },
 	[P_TRIM]	    = { 0, sizeof(struct p_trim), receive_Data },
+	[P_ZEROES]	    = { 0, sizeof(struct p_trim), receive_Data },
 	[P_RS_DEALLOCATED]  = { 0, sizeof(struct p_block_desc), receive_rs_deallocated },
 	[P_WSAME]	    = { 1, sizeof(struct p_wsame), receive_Data },
 };
@@ -5245,11 +5385,12 @@ static int drbd_do_features(struct drbd_connection *connection)
 	drbd_info(connection, "Handshake successful: "
 	     "Agreed network protocol version %d\n", connection->agreed_pro_version);
 
-	drbd_info(connection, "Feature flags enabled on protocol level: 0x%x%s%s%s.\n",
+	drbd_info(connection, "Feature flags enabled on protocol level: 0x%x%s%s%s%s.\n",
 		  connection->agreed_features,
 		  connection->agreed_features & DRBD_FF_TRIM ? " TRIM" : "",
 		  connection->agreed_features & DRBD_FF_THIN_RESYNC ? " THIN_RESYNC" : "",
-		  connection->agreed_features & DRBD_FF_WSAME ? " WRITE_SAME" :
+		  connection->agreed_features & DRBD_FF_WSAME ? " WRITE_SAME" : "",
+		  connection->agreed_features & DRBD_FF_WZEROES ? " WRITE_ZEROES" :
 		  connection->agreed_features ? "" : " none");
 
 	return 1;
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 1c4da17e902e..643a04af213b 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -63,7 +63,7 @@ static struct drbd_request *drbd_req_new(struct drbd_device *device, struct bio
 	drbd_req_make_private_bio(req, bio_src);
 	req->rq_state = (bio_data_dir(bio_src) == WRITE ? RQ_WRITE : 0)
 		      | (bio_op(bio_src) == REQ_OP_WRITE_SAME ? RQ_WSAME : 0)
-		      | (bio_op(bio_src) == REQ_OP_WRITE_ZEROES ? RQ_UNMAP : 0)
+		      | (bio_op(bio_src) == REQ_OP_WRITE_ZEROES ? RQ_ZEROES : 0)
 		      | (bio_op(bio_src) == REQ_OP_DISCARD ? RQ_UNMAP : 0);
 	req->device = device;
 	req->master_bio = bio_src;
@@ -1155,12 +1155,11 @@ static int drbd_process_write_request(struct drbd_request *req)
 	return remote;
 }
 
-static void drbd_process_discard_req(struct drbd_request *req)
+static void drbd_process_discard_or_zeroes_req(struct drbd_request *req, int flags)
 {
-	struct block_device *bdev = req->device->ldev->backing_bdev;
-
-	if (blkdev_issue_zeroout(bdev, req->i.sector, req->i.size >> 9,
-			GFP_NOIO, 0))
+	int err = drbd_issue_discard_or_zero_out(req->device,
+				req->i.sector, req->i.size >> 9, flags);
+	if (err)
 		req->private_bio->bi_status = BLK_STS_IOERR;
 	bio_endio(req->private_bio);
 }
@@ -1189,9 +1188,11 @@ drbd_submit_req_private_bio(struct drbd_request *req)
 	if (get_ldev(device)) {
 		if (drbd_insert_fault(device, type))
 			bio_io_error(bio);
-		else if (bio_op(bio) == REQ_OP_WRITE_ZEROES ||
-			 bio_op(bio) == REQ_OP_DISCARD)
-			drbd_process_discard_req(req);
+		else if (bio_op(bio) == REQ_OP_WRITE_ZEROES)
+			drbd_process_discard_or_zeroes_req(req, EE_ZEROOUT |
+			    ((bio->bi_opf & REQ_NOUNMAP) ? 0 : EE_TRIM));
+		else if (bio_op(bio) == REQ_OP_DISCARD)
+			drbd_process_discard_or_zeroes_req(req, EE_TRIM);
 		else
 			generic_make_request(bio);
 		put_ldev(device);
diff --git a/drivers/block/drbd/drbd_req.h b/drivers/block/drbd/drbd_req.h
index 94c654020f0f..c2f569d2661b 100644
--- a/drivers/block/drbd/drbd_req.h
+++ b/drivers/block/drbd/drbd_req.h
@@ -208,6 +208,7 @@ enum drbd_req_state_bits {
 	__RQ_WRITE,
 	__RQ_WSAME,
 	__RQ_UNMAP,
+	__RQ_ZEROES,
 
 	/* Should call drbd_al_complete_io() for this request... */
 	__RQ_IN_ACT_LOG,
@@ -253,6 +254,7 @@ enum drbd_req_state_bits {
 #define RQ_WRITE           (1UL << __RQ_WRITE)
 #define RQ_WSAME           (1UL << __RQ_WSAME)
 #define RQ_UNMAP           (1UL << __RQ_UNMAP)
+#define RQ_ZEROES          (1UL << __RQ_ZEROES)
 #define RQ_IN_ACT_LOG      (1UL << __RQ_IN_ACT_LOG)
 #define RQ_UNPLUG          (1UL << __RQ_UNPLUG)
 #define RQ_POSTPONED	   (1UL << __RQ_POSTPONED)
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 99255d0c9e2f..268ef0c5d4ab 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -153,7 +153,7 @@ void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req) __releases(l
 	do_wake = list_empty(block_id == ID_SYNCER ? &device->sync_ee : &device->active_ee);
 
 	/* FIXME do we want to detach for failed REQ_OP_DISCARD?
-	 * ((peer_req->flags & (EE_WAS_ERROR|EE_IS_TRIM)) == EE_WAS_ERROR) */
+	 * ((peer_req->flags & (EE_WAS_ERROR|EE_TRIM)) == EE_WAS_ERROR) */
 	if (peer_req->flags & EE_WAS_ERROR)
 		__drbd_chk_io_error(device, DRBD_WRITE_ERROR);
 
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index 2d0259327721..a19d98367f08 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -51,7 +51,7 @@
 #endif
 
 extern const char *drbd_buildtag(void);
-#define REL_VERSION "8.4.10"
+#define REL_VERSION "8.4.11"
 #define API_VERSION 1
 #define PRO_VERSION_MIN 86
 #define PRO_VERSION_MAX 101
-- 
2.17.1

