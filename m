Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D378D105645E
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 14:08:29 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 25 Apr 2016 14:07:49 +0200
Message-Id: <1461586077-11581-23-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
References: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 22/30] drbd: introduce WRITE_SAME support
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

From: Lars Ellenberg <lars@linbit.com>

We will support WRITE_SAME, if
 * all peers support WRITE_SAME (both in kernel and DRBD version),
 * all peer devices support WRITE_SAME
 * logical_block_size is identical on all peers.

We may at some point introduce a fallback on the receiving side
for devices/kernels that do not support WRITE_SAME,
by open-coding a submit loop. But not yet.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c   |   9 ++-
 drivers/block/drbd/drbd_debugfs.c  |  11 +--
 drivers/block/drbd/drbd_int.h      |  13 ++--
 drivers/block/drbd/drbd_main.c     |  82 +++++++++++++++++++---
 drivers/block/drbd/drbd_nl.c       |  88 +++++++++++++++++++++---
 drivers/block/drbd/drbd_protocol.h |  74 ++++++++++++++++++--
 drivers/block/drbd/drbd_receiver.c | 137 +++++++++++++++++++++++++++----------
 drivers/block/drbd/drbd_req.c      |  13 ++--
 drivers/block/drbd/drbd_req.h      |   5 +-
 drivers/block/drbd/drbd_worker.c   |   8 ++-
 10 files changed, 360 insertions(+), 80 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 4e07cff..99a2b92 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -838,6 +838,13 @@ static int update_sync_bits(struct drbd_device *device,
 	return count;
 }
 
+static bool plausible_request_size(int size)
+{
+	return size > 0
+		&& size <= DRBD_MAX_BATCH_BIO_SIZE
+		&& IS_ALIGNED(size, 512);
+}
+
 /* clear the bit corresponding to the piece of storage in question:
  * size byte of data starting from sector.  Only clear a bits of the affected
  * one ore more _aligned_ BM_BLOCK_SIZE blocks.
@@ -857,7 +864,7 @@ int __drbd_change_sync(struct drbd_device *device, sector_t sector, int size,
 	if ((mode == SET_OUT_OF_SYNC) && size == 0)
 		return 0;
 
-	if (size <= 0 || !IS_ALIGNED(size, 512) || size > DRBD_MAX_DISCARD_SIZE) {
+	if (!plausible_request_size(size)) {
 		drbd_err(device, "%s: sector=%llus size=%d nonsense!\n",
 				drbd_change_sync_fname[mode],
 				(unsigned long long)sector, size);
diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index 4de95bb..8a90812 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -237,14 +237,9 @@ static void seq_print_peer_request_flags(struct seq_file *m, struct drbd_peer_re
 	seq_print_rq_state_bit(m, f & EE_SEND_WRITE_ACK, &sep, "C");
 	seq_print_rq_state_bit(m, f & EE_MAY_SET_IN_SYNC, &sep, "set-in-sync");
 
-	if (f & EE_IS_TRIM) {
-		seq_putc(m, sep);
-		sep = '|';
-		if (f & EE_IS_TRIM_USE_ZEROOUT)
-			seq_puts(m, "zero-out");
-		else
-			seq_puts(m, "trim");
-	}
+	if (f & EE_IS_TRIM)
+		__seq_print_rq_state_bit(m, f & EE_IS_TRIM_USE_ZEROOUT, &sep, "zero-out", "trim");
+	seq_print_rq_state_bit(m, f & EE_WRITE_SAME, &sep, "write-same");
 	seq_putc(m, '\n');
 }
 
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index cb42f6c..cb47809 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -468,6 +468,9 @@ enum {
 	/* this is/was a write request */
 	__EE_WRITE,
 
+	/* this is/was a write same request */
+	__EE_WRITE_SAME,
+
 	/* this originates from application on peer
 	 * (not some resync or verify or other DRBD internal request) */
 	__EE_APPLICATION,
@@ -487,6 +490,7 @@ enum {
 #define EE_IN_INTERVAL_TREE	(1<<__EE_IN_INTERVAL_TREE)
 #define EE_SUBMITTED		(1<<__EE_SUBMITTED)
 #define EE_WRITE		(1<<__EE_WRITE)
+#define EE_WRITE_SAME		(1<<__EE_WRITE_SAME)
 #define EE_APPLICATION		(1<<__EE_APPLICATION)
 #define EE_RS_THIN_REQ		(1<<__EE_RS_THIN_REQ)
 
@@ -1350,8 +1354,8 @@ struct bm_extent {
 /* For now, don't allow more than half of what we can "activate" in one
  * activity log transaction to be discarded in one go. We may need to rework
  * drbd_al_begin_io() to allow for even larger discard ranges */
-#define DRBD_MAX_DISCARD_SIZE	(AL_UPDATES_PER_TRANSACTION/2*AL_EXTENT_SIZE)
-#define DRBD_MAX_DISCARD_SECTORS (DRBD_MAX_DISCARD_SIZE >> 9)
+#define DRBD_MAX_BATCH_BIO_SIZE	 (AL_UPDATES_PER_TRANSACTION/2*AL_EXTENT_SIZE)
+#define DRBD_MAX_BBIO_SECTORS    (DRBD_MAX_BATCH_BIO_SIZE >> 9)
 
 extern int  drbd_bm_init(struct drbd_device *device);
 extern int  drbd_bm_resize(struct drbd_device *device, sector_t sectors, int set_new_bits);
@@ -1488,7 +1492,8 @@ enum determine_dev_size {
 extern enum determine_dev_size
 drbd_determine_dev_size(struct drbd_device *, enum dds_flags, struct resize_parms *) __must_hold(local);
 extern void resync_after_online_grow(struct drbd_device *);
-extern void drbd_reconsider_queue_parameters(struct drbd_device *device, struct drbd_backing_dev *bdev);
+extern void drbd_reconsider_queue_parameters(struct drbd_device *device,
+			struct drbd_backing_dev *bdev, struct o_qlim *o);
 extern enum drbd_state_rv drbd_set_role(struct drbd_device *device,
 					enum drbd_role new_role,
 					int force);
@@ -1569,7 +1574,7 @@ extern int drbd_submit_peer_request(struct drbd_device *,
 extern int drbd_free_peer_reqs(struct drbd_device *, struct list_head *);
 extern struct drbd_peer_request *drbd_alloc_peer_req(struct drbd_peer_device *, u64,
 						     sector_t, unsigned int,
-						     bool,
+						     unsigned int,
 						     gfp_t) __must_hold(local);
 extern void __drbd_free_peer_req(struct drbd_device *, struct drbd_peer_request *,
 				 int);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 3127bba..e3aff25 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -920,6 +920,31 @@ void drbd_gen_and_send_sync_uuid(struct drbd_peer_device *peer_device)
 	}
 }
 
+/* communicated if (agreed_features & DRBD_FF_WSAME) */
+void assign_p_sizes_qlim(struct drbd_device *device, struct p_sizes *p, struct request_queue *q)
+{
+	if (q) {
+		p->qlim->physical_block_size = cpu_to_be32(queue_physical_block_size(q));
+		p->qlim->logical_block_size = cpu_to_be32(queue_logical_block_size(q));
+		p->qlim->alignment_offset = cpu_to_be32(queue_alignment_offset(q));
+		p->qlim->io_min = cpu_to_be32(queue_io_min(q));
+		p->qlim->io_opt = cpu_to_be32(queue_io_opt(q));
+		p->qlim->discard_enabled = blk_queue_discard(q);
+		p->qlim->discard_zeroes_data = queue_discard_zeroes_data(q);
+		p->qlim->write_same_capable = !!q->limits.max_write_same_sectors;
+	} else {
+		q = device->rq_queue;
+		p->qlim->physical_block_size = cpu_to_be32(queue_physical_block_size(q));
+		p->qlim->logical_block_size = cpu_to_be32(queue_logical_block_size(q));
+		p->qlim->alignment_offset = 0;
+		p->qlim->io_min = cpu_to_be32(queue_io_min(q));
+		p->qlim->io_opt = cpu_to_be32(queue_io_opt(q));
+		p->qlim->discard_enabled = 0;
+		p->qlim->discard_zeroes_data = 0;
+		p->qlim->write_same_capable = 0;
+	}
+}
+
 int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enum dds_flags flags)
 {
 	struct drbd_device *device = peer_device->device;
@@ -928,29 +953,37 @@ int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enu
 	sector_t d_size, u_size;
 	int q_order_type;
 	unsigned int max_bio_size;
+	unsigned int packet_size;
+
+	sock = &peer_device->connection->data;
+	p = drbd_prepare_command(peer_device, sock);
+	if (!p)
+		return -EIO;
 
+	packet_size = sizeof(*p);
+	if (peer_device->connection->agreed_features & DRBD_FF_WSAME)
+		packet_size += sizeof(p->qlim[0]);
+
+	memset(p, 0, packet_size);
 	if (get_ldev_if_state(device, D_NEGOTIATING)) {
-		D_ASSERT(device, device->ldev->backing_bdev);
+		struct request_queue *q = bdev_get_queue(device->ldev->backing_bdev);
 		d_size = drbd_get_max_capacity(device->ldev);
 		rcu_read_lock();
 		u_size = rcu_dereference(device->ldev->disk_conf)->disk_size;
 		rcu_read_unlock();
 		q_order_type = drbd_queue_order_type(device);
-		max_bio_size = queue_max_hw_sectors(device->ldev->backing_bdev->bd_disk->queue) << 9;
+		max_bio_size = queue_max_hw_sectors(q) << 9;
 		max_bio_size = min(max_bio_size, DRBD_MAX_BIO_SIZE);
+		assign_p_sizes_qlim(device, p, q);
 		put_ldev(device);
 	} else {
 		d_size = 0;
 		u_size = 0;
 		q_order_type = QUEUE_ORDERED_NONE;
 		max_bio_size = DRBD_MAX_BIO_SIZE; /* ... multiple BIOs per peer_request */
+		assign_p_sizes_qlim(device, p, NULL);
 	}
 
-	sock = &peer_device->connection->data;
-	p = drbd_prepare_command(peer_device, sock);
-	if (!p)
-		return -EIO;
-
 	if (peer_device->connection->agreed_pro_version <= 94)
 		max_bio_size = min(max_bio_size, DRBD_MAX_SIZE_H80_PACKET);
 	else if (peer_device->connection->agreed_pro_version < 100)
@@ -962,7 +995,8 @@ int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enu
 	p->max_bio_size = cpu_to_be32(max_bio_size);
 	p->queue_order_type = cpu_to_be16(q_order_type);
 	p->dds_flags = cpu_to_be16(flags);
-	return drbd_send_command(peer_device, sock, P_SIZES, sizeof(*p), NULL, 0);
+
+	return drbd_send_command(peer_device, sock, P_SIZES, packet_size, NULL, 0);
 }
 
 /**
@@ -1577,6 +1611,9 @@ static int _drbd_send_bio(struct drbd_peer_device *peer_device, struct bio *bio)
 					 ? 0 : MSG_MORE);
 		if (err)
 			return err;
+		/* REQ_WRITE_SAME has only one segment */
+		if (bio->bi_rw & REQ_WRITE_SAME)
+			break;
 	}
 	return 0;
 }
@@ -1595,6 +1632,9 @@ static int _drbd_send_zc_bio(struct drbd_peer_device *peer_device, struct bio *b
 				      bio_iter_last(bvec, iter) ? 0 : MSG_MORE);
 		if (err)
 			return err;
+		/* REQ_WRITE_SAME has only one segment */
+		if (bio->bi_rw & REQ_WRITE_SAME)
+			break;
 	}
 	return 0;
 }
@@ -1625,6 +1665,7 @@ static u32 bio_flags_to_wire(struct drbd_connection *connection, unsigned long b
 		return  (bi_rw & REQ_SYNC ? DP_RW_SYNC : 0) |
 			(bi_rw & REQ_FUA ? DP_FUA : 0) |
 			(bi_rw & REQ_FLUSH ? DP_FLUSH : 0) |
+			(bi_rw & REQ_WRITE_SAME ? DP_WSAME : 0) |
 			(bi_rw & REQ_DISCARD ? DP_DISCARD : 0);
 	else
 		return bi_rw & REQ_SYNC ? DP_RW_SYNC : 0;
@@ -1638,6 +1679,8 @@ int drbd_send_dblock(struct drbd_peer_device *peer_device, struct drbd_request *
 	struct drbd_device *device = peer_device->device;
 	struct drbd_socket *sock;
 	struct p_data *p;
+	struct p_wsame *wsame = NULL;
+	void *digest_out;
 	unsigned int dp_flags = 0;
 	int digest_size;
 	int err;
@@ -1673,12 +1716,29 @@ int drbd_send_dblock(struct drbd_peer_device *peer_device, struct drbd_request *
 		err = __send_command(peer_device->connection, device->vnr, sock, P_TRIM, sizeof(*t), NULL, 0);
 		goto out;
 	}
+	if (dp_flags & DP_WSAME) {
+		/* this will only work if DRBD_FF_WSAME is set AND the
+		 * handshake agreed that all nodes and backend devices are
+		 * WRITE_SAME capable and agree on logical_block_size */
+		wsame = (struct p_wsame*)p;
+		digest_out = wsame + 1;
+		wsame->size = cpu_to_be32(req->i.size);
+	} else
+		digest_out = p + 1;
 
 	/* our digest is still only over the payload.
 	 * TRIM does not carry any payload. */
 	if (digest_size)
-		drbd_csum_bio(peer_device->connection->integrity_tfm, req->master_bio, p + 1);
-	err = __send_command(peer_device->connection, device->vnr, sock, P_DATA, sizeof(*p) + digest_size, NULL, req->i.size);
+		drbd_csum_bio(peer_device->connection->integrity_tfm, req->master_bio, digest_out);
+	if (wsame) {
+		err =
+		    __send_command(peer_device->connection, device->vnr, sock, P_WSAME,
+				   sizeof(*wsame) + digest_size, NULL,
+				   bio_iovec(req->master_bio).bv_len);
+	} else
+		err =
+		    __send_command(peer_device->connection, device->vnr, sock, P_DATA,
+				   sizeof(*p) + digest_size, NULL, req->i.size);
 	if (!err) {
 		/* For protocol A, we have to memcpy the payload into
 		 * socket buffers, as we may complete right away
@@ -3658,6 +3718,8 @@ const char *cmdname(enum drbd_packet cmd)
 	 * one PRO_VERSION */
 	static const char *cmdnames[] = {
 		[P_DATA]	        = "Data",
+		[P_WSAME]	        = "WriteSame",
+		[P_TRIM]	        = "Trim",
 		[P_DATA_REPLY]	        = "DataReply",
 		[P_RS_DATA_REPLY]	= "RSDataReply",
 		[P_BARRIER]	        = "Barrier",
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 48fa6c3..3704fad 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1174,6 +1174,17 @@ static void blk_queue_discard_granularity(struct request_queue *q, unsigned int
 {
 	q->limits.discard_granularity = granularity;
 }
+
+static unsigned int drbd_max_discard_sectors(struct drbd_connection *connection)
+{
+	/* when we introduced REQ_WRITE_SAME support, we also bumped
+	 * our maximum supported batch bio size used for discards. */
+	if (connection->agreed_features & DRBD_FF_WSAME)
+		return DRBD_MAX_BBIO_SECTORS;
+	/* before, with DRBD <= 8.4.6, we only allowed up to one AL_EXTENT_SIZE. */
+	return AL_EXTENT_SIZE >> 9;
+}
+
 static void decide_on_discard_support(struct drbd_device *device,
 			struct request_queue *q,
 			struct request_queue *b,
@@ -1190,7 +1201,7 @@ static void decide_on_discard_support(struct drbd_device *device,
 		can_do = false;
 		drbd_info(device, "discard_zeroes_data=0 and discard_zeroes_if_aligned=no: disabling discards\n");
 	}
-	if (can_do && connection->cstate >= C_CONNECTED && !(connection->agreed_features & FF_TRIM)) {
+	if (can_do && connection->cstate >= C_CONNECTED && !(connection->agreed_features & DRBD_FF_TRIM)) {
 		can_do = false;
 		drbd_info(connection, "peer DRBD too old, does not support TRIM: disabling discards\n");
 	}
@@ -1202,7 +1213,7 @@ static void decide_on_discard_support(struct drbd_device *device,
 		 * you care, you need to use devices with similar
 		 * topology on all peers. */
 		blk_queue_discard_granularity(q, 512);
-		q->limits.max_discard_sectors = DRBD_MAX_DISCARD_SECTORS;
+		q->limits.max_discard_sectors = drbd_max_discard_sectors(connection);
 		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
 	} else {
 		queue_flag_clear_unlocked(QUEUE_FLAG_DISCARD, q);
@@ -1223,8 +1234,67 @@ static void fixup_discard_if_not_supported(struct request_queue *q)
 	}
 }
 
+static void decide_on_write_same_support(struct drbd_device *device,
+			struct request_queue *q,
+			struct request_queue *b, struct o_qlim *o)
+{
+	struct drbd_peer_device *peer_device = first_peer_device(device);
+	struct drbd_connection *connection = peer_device->connection;
+	bool can_do = b ? b->limits.max_write_same_sectors : true;
+
+	if (can_do && connection->cstate >= C_CONNECTED && !(connection->agreed_features & DRBD_FF_WSAME)) {
+		can_do = false;
+		drbd_info(peer_device, "peer does not support WRITE_SAME\n");
+	}
+
+	if (o) {
+		/* logical block size; queue_logical_block_size(NULL) is 512 */
+		unsigned int peer_lbs = be32_to_cpu(o->logical_block_size);
+		unsigned int me_lbs_b = queue_logical_block_size(b);
+		unsigned int me_lbs = queue_logical_block_size(q);
+
+		if (me_lbs_b != me_lbs) {
+			drbd_warn(device,
+				"logical block size of local backend does not match (drbd:%u, backend:%u); was this a late attach?\n",
+				me_lbs, me_lbs_b);
+			/* rather disable write same than trigger some BUG_ON later in the scsi layer. */
+			can_do = false;
+		}
+		if (me_lbs_b != peer_lbs) {
+			drbd_warn(peer_device, "logical block sizes do not match (me:%u, peer:%u); this may cause problems.\n",
+				me_lbs, peer_lbs);
+			if (can_do) {
+				drbd_dbg(peer_device, "logical block size mismatch: WRITE_SAME disabled.\n");
+				can_do = false;
+			}
+			me_lbs = max(me_lbs, me_lbs_b);
+			/* We cannot change the logical block size of an in-use queue.
+			 * We can only hope that access happens to be properly aligned.
+			 * If not, the peer will likely produce an IO error, and detach. */
+			if (peer_lbs > me_lbs) {
+				if (device->state.role != R_PRIMARY) {
+					blk_queue_logical_block_size(q, peer_lbs);
+					drbd_warn(peer_device, "logical block size set to %u\n", peer_lbs);
+				} else {
+					drbd_warn(peer_device,
+						"current Primary must NOT adjust logical block size (%u -> %u); hope for the best.\n",
+						me_lbs, peer_lbs);
+				}
+			}
+		}
+		if (can_do && !o->write_same_capable) {
+			/* If we introduce an open-coded write-same loop on the receiving side,
+			 * the peer would present itself as "capable". */
+			drbd_dbg(peer_device, "WRITE_SAME disabled (peer device not capable)\n");
+			can_do = false;
+		}
+	}
+
+	blk_queue_max_write_same_sectors(q, can_do ? DRBD_MAX_BBIO_SECTORS : 0);
+}
+
 static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backing_dev *bdev,
-				   unsigned int max_bio_size)
+				   unsigned int max_bio_size, struct o_qlim *o)
 {
 	struct request_queue * const q = device->rq_queue;
 	unsigned int max_hw_sectors = max_bio_size >> 9;
@@ -1244,15 +1314,15 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 		rcu_read_unlock();
 
 		blk_set_stacking_limits(&q->limits);
-		blk_queue_max_write_same_sectors(q, 0);
 	}
 
-	blk_queue_logical_block_size(q, 512);
 	blk_queue_max_hw_sectors(q, max_hw_sectors);
 	/* This is the workaround for "bio would need to, but cannot, be split" */
 	blk_queue_max_segments(q, max_segments ? max_segments : BLK_MAX_SEGMENTS);
 	blk_queue_segment_boundary(q, PAGE_SIZE-1);
 	decide_on_discard_support(device, q, b, discard_zeroes_if_aligned);
+	decide_on_write_same_support(device, q, b, o);
+
 	if (b) {
 		blk_queue_stack_limits(q, b);
 
@@ -1266,7 +1336,7 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 	fixup_discard_if_not_supported(q);
 }
 
-void drbd_reconsider_queue_parameters(struct drbd_device *device, struct drbd_backing_dev *bdev)
+void drbd_reconsider_queue_parameters(struct drbd_device *device, struct drbd_backing_dev *bdev, struct o_qlim *o)
 {
 	unsigned int now, new, local, peer;
 
@@ -1309,7 +1379,7 @@ void drbd_reconsider_queue_parameters(struct drbd_device *device, struct drbd_ba
 	if (new != now)
 		drbd_info(device, "max BIO size = %u\n", new);
 
-	drbd_setup_queue_param(device, bdev, new);
+	drbd_setup_queue_param(device, bdev, new, o);
 }
 
 /* Starts the worker thread */
@@ -1542,7 +1612,7 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 		drbd_bump_write_ordering(device->resource, NULL, WO_BDEV_FLUSH);
 
 	if (old_disk_conf->discard_zeroes_if_aligned != new_disk_conf->discard_zeroes_if_aligned)
-		drbd_reconsider_queue_parameters(device, device->ldev);
+		drbd_reconsider_queue_parameters(device, device->ldev, NULL);
 
 	drbd_md_sync(device);
 
@@ -1922,7 +1992,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	device->read_cnt = 0;
 	device->writ_cnt = 0;
 
-	drbd_reconsider_queue_parameters(device, device->ldev);
+	drbd_reconsider_queue_parameters(device, device->ldev, NULL);
 
 	/* If I am currently not R_PRIMARY,
 	 * but meta data primary indicator is set,
diff --git a/drivers/block/drbd/drbd_protocol.h b/drivers/block/drbd/drbd_protocol.h
index 7acc2e0..d695e44 100644
--- a/drivers/block/drbd/drbd_protocol.h
+++ b/drivers/block/drbd/drbd_protocol.h
@@ -64,6 +64,11 @@ enum drbd_packet {
 	P_RS_THIN_REQ         = 0x32, /* Request a block for resync or reply P_RS_DEALLOCATED */
 	P_RS_DEALLOCATED      = 0x33, /* Contains only zeros on sync source node */
 
+	/* REQ_WRITE_SAME.
+	 * On a receiving side without REQ_WRITE_SAME,
+	 * we may fall back to an opencoded loop instead. */
+	P_WSAME               = 0x34,
+
 	P_MAY_IGNORE	      = 0x100, /* Flag to test if (cmd > P_MAY_IGNORE) ... */
 	P_MAX_OPT_CMD	      = 0x101,
 
@@ -110,8 +115,11 @@ struct p_header100 {
 	u32	  pad;
 } __packed;
 
-/* these defines must not be changed without changing the protocol version */
-#define DP_HARDBARRIER	      1 /* depricated */
+/* These defines must not be changed without changing the protocol version.
+ * New defines may only be introduced together with protocol version bump or
+ * new protocol feature flags.
+ */
+#define DP_HARDBARRIER	      1 /* no longer used */
 #define DP_RW_SYNC	      2 /* equals REQ_SYNC    */
 #define DP_MAY_SET_IN_SYNC    4
 #define DP_UNPLUG             8 /* not used anymore   */
@@ -120,6 +128,7 @@ struct p_header100 {
 #define DP_DISCARD           64 /* equals REQ_DISCARD */
 #define DP_SEND_RECEIVE_ACK 128 /* This is a proto B write request */
 #define DP_SEND_WRITE_ACK   256 /* This is a proto C write request */
+#define DP_WSAME            512 /* equiv. REQ_WRITE_SAME */
 
 struct p_data {
 	u64	    sector;    /* 64 bits sector number */
@@ -133,6 +142,11 @@ struct p_trim {
 	u32	    size;	/* == bio->bi_size */
 } __packed;
 
+struct p_wsame {
+	struct p_data p_data;
+	u32           size;     /* == bio->bi_size */
+} __packed;
+
 /*
  * commands which share a struct:
  *  p_block_ack:
@@ -164,8 +178,23 @@ struct p_block_req {
  *   ReportParams
  */
 
-#define FF_TRIM      1
-#define FF_THIN_RESYNC 2
+/* supports TRIM/DISCARD on the "wire" protocol */
+#define DRBD_FF_TRIM 1
+
+/* Detect all-zeros during resync, and rather TRIM/UNMAP/DISCARD those blocks
+ * instead of fully allocate a supposedly thin volume on initial resync */
+#define DRBD_FF_THIN_RESYNC 2
+
+/* supports REQ_WRITE_SAME on the "wire" protocol.
+ * Note: this flag is overloaded,
+ * its presence also
+ *   - indicates support for 128 MiB "batch bios",
+ *     max discard size of 128 MiB
+ *     instead of 4M before that.
+ *   - indicates that we exchange additional settings in p_sizes
+ *     drbd_send_sizes()/receive_sizes()
+ */
+#define DRBD_FF_WSAME 4
 
 struct p_connection_features {
 	u32 protocol_min;
@@ -240,6 +269,40 @@ struct p_rs_uuid {
 	u64	    uuid;
 } __packed;
 
+/* optional queue_limits if (agreed_features & DRBD_FF_WSAME)
+ * see also struct queue_limits, as of late 2015 */
+struct o_qlim {
+	/* we don't need it yet, but we may as well communicate it now */
+	u32 physical_block_size;
+
+	/* so the original in struct queue_limits is unsigned short,
+	 * but I'd have to put in padding anyways. */
+	u32 logical_block_size;
+
+	/* One incoming bio becomes one DRBD request,
+	 * which may be translated to several bio on the receiving side.
+	 * We don't need to communicate chunk/boundary/segment ... limits.
+	 */
+
+	/* various IO hints may be useful with "diskless client" setups */
+	u32 alignment_offset;
+	u32 io_min;
+	u32 io_opt;
+
+	/* We may need to communicate integrity stuff at some point,
+	 * but let's not get ahead of ourselves. */
+
+	/* Backend discard capabilities.
+	 * Receiving side uses "blkdev_issue_discard()", no need to communicate
+	 * more specifics.  If the backend cannot do discards, the DRBD peer
+	 * may fall back to blkdev_issue_zeroout().
+	 */
+	u8 discard_enabled;
+	u8 discard_zeroes_data;
+	u8 write_same_capable;
+	u8 _pad;
+} __packed;
+
 struct p_sizes {
 	u64	    d_size;  /* size of disk */
 	u64	    u_size;  /* user requested size */
@@ -247,6 +310,9 @@ struct p_sizes {
 	u32	    max_bio_size;  /* Maximal size of a BIO */
 	u16	    queue_order_type;  /* not yet implemented in DRBD*/
 	u16	    dds_flags; /* use enum dds_flags here. */
+
+	/* optional queue_limits if (agreed_features & DRBD_FF_WSAME) */
+	struct o_qlim qlim[0];
 } __packed;
 
 struct p_state {
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 99f4519..1320bb8 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -48,7 +48,7 @@
 #include "drbd_req.h"
 #include "drbd_vli.h"
 
-#define PRO_FEATURES (FF_TRIM | FF_THIN_RESYNC)
+#define PRO_FEATURES (DRBD_FF_TRIM|DRBD_FF_THIN_RESYNC|DRBD_FF_WSAME)
 
 struct packet_info {
 	enum drbd_packet cmd;
@@ -361,14 +361,17 @@ You must not have the req_lock:
  drbd_wait_ee_list_empty()
 */
 
+/* normal: payload_size == request size (bi_size)
+ * w_same: payload_size == logical_block_size
+ * trim: payload_size == 0 */
 struct drbd_peer_request *
 drbd_alloc_peer_req(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
-		    unsigned int data_size, bool has_payload, gfp_t gfp_mask) __must_hold(local)
+		    unsigned int request_size, unsigned int payload_size, gfp_t gfp_mask) __must_hold(local)
 {
 	struct drbd_device *device = peer_device->device;
 	struct drbd_peer_request *peer_req;
 	struct page *page = NULL;
-	unsigned nr_pages = (data_size + PAGE_SIZE -1) >> PAGE_SHIFT;
+	unsigned nr_pages = (payload_size + PAGE_SIZE -1) >> PAGE_SHIFT;
 
 	if (drbd_insert_fault(device, DRBD_FAULT_AL_EE))
 		return NULL;
@@ -380,7 +383,7 @@ drbd_alloc_peer_req(struct drbd_peer_device *peer_device, u64 id, sector_t secto
 		return NULL;
 	}
 
-	if (has_payload && data_size) {
+	if (nr_pages) {
 		page = drbd_alloc_pages(peer_device, nr_pages,
 					gfpflags_allow_blocking(gfp_mask));
 		if (!page)
@@ -390,7 +393,7 @@ drbd_alloc_peer_req(struct drbd_peer_device *peer_device, u64 id, sector_t secto
 	memset(peer_req, 0, sizeof(*peer_req));
 	INIT_LIST_HEAD(&peer_req->w.list);
 	drbd_clear_interval(&peer_req->i);
-	peer_req->i.size = data_size;
+	peer_req->i.size = request_size;
 	peer_req->i.sector = sector;
 	peer_req->submit_jif = jiffies;
 	peer_req->peer_device = peer_device;
@@ -1529,7 +1532,7 @@ static bool can_do_reliable_discards(struct drbd_device *device)
 	return can_do;
 }
 
-void drbd_issue_peer_discard(struct drbd_device *device, struct drbd_peer_request *peer_req)
+static void drbd_issue_peer_discard(struct drbd_device *device, struct drbd_peer_request *peer_req)
 {
 	/* If the backend cannot discard, or does not guarantee
 	 * read-back zeroes in discarded ranges, we fall back to
@@ -1544,6 +1547,18 @@ void drbd_issue_peer_discard(struct drbd_device *device, struct drbd_peer_reques
 	drbd_endio_write_sec_final(peer_req);
 }
 
+static void drbd_issue_peer_wsame(struct drbd_device *device,
+				  struct drbd_peer_request *peer_req)
+{
+	struct block_device *bdev = device->ldev->backing_bdev;
+	sector_t s = peer_req->i.sector;
+	sector_t nr = peer_req->i.size >> 9;
+	if (blkdev_issue_write_same(bdev, s, nr, GFP_NOIO, peer_req->pages))
+		peer_req->flags |= EE_WAS_ERROR;
+	drbd_endio_write_sec_final(peer_req);
+}
+
+
 /**
  * drbd_submit_peer_request()
  * @device:	DRBD device.
@@ -1580,7 +1595,7 @@ int drbd_submit_peer_request(struct drbd_device *device,
 	 * Correctness first, performance later.  Next step is to code an
 	 * asynchronous variant of the same.
 	 */
-	if (peer_req->flags & EE_IS_TRIM) {
+	if (peer_req->flags & (EE_IS_TRIM|EE_WRITE_SAME)) {
 		/* wait for all pending IO completions, before we start
 		 * zeroing things out. */
 		conn_wait_active_ee_empty(peer_req->peer_device->connection);
@@ -1597,7 +1612,10 @@ int drbd_submit_peer_request(struct drbd_device *device,
 			spin_unlock_irq(&device->resource->req_lock);
 		}
 
-		drbd_issue_peer_discard(device, peer_req);
+		if (peer_req->flags & EE_IS_TRIM)
+			drbd_issue_peer_discard(device, peer_req);
+		else /* EE_WRITE_SAME */
+			drbd_issue_peer_wsame(device, peer_req);
 		return 0;
 	}
 
@@ -1770,8 +1788,26 @@ static int receive_Barrier(struct drbd_connection *connection, struct packet_inf
 	return 0;
 }
 
+/* quick wrapper in case payload size != request_size (write same) */
+static void drbd_csum_ee_size(struct crypto_ahash *h,
+			      struct drbd_peer_request *r, void *d,
+			      unsigned int payload_size)
+{
+	unsigned int tmp = r->i.size;
+	r->i.size = payload_size;
+	drbd_csum_ee(h, r, d);
+	r->i.size = tmp;
+}
+
 /* used from receive_RSDataReply (recv_resync_read)
- * and from receive_Data */
+ * and from receive_Data.
+ * data_size: actual payload ("data in")
+ * 	for normal writes that is bi_size.
+ * 	for discards, that is zero.
+ * 	for write same, it is logical_block_size.
+ * both trim and write same have the bi_size ("data len to be affected")
+ * as extra argument in the packet header.
+ */
 static struct drbd_peer_request *
 read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
 	      struct packet_info *pi) __must_hold(local)
@@ -1786,6 +1822,7 @@ read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
 	void *dig_vv = peer_device->connection->int_dig_vv;
 	unsigned long *data;
 	struct p_trim *trim = (pi->cmd == P_TRIM) ? pi->data : NULL;
+	struct p_trim *wsame = (pi->cmd == P_WSAME) ? pi->data : NULL;
 
 	digest_size = 0;
 	if (!trim && peer_device->connection->peer_integrity_tfm) {
@@ -1800,38 +1837,60 @@ read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
 		data_size -= digest_size;
 	}
 
+	/* assume request_size == data_size, but special case trim and wsame. */
+	ds = data_size;
 	if (trim) {
-		D_ASSERT(peer_device, data_size == 0);
-		data_size = be32_to_cpu(trim->size);
+		if (!expect(data_size == 0))
+			return NULL;
+		ds = be32_to_cpu(trim->size);
+	} else if (wsame) {
+		if (data_size != queue_logical_block_size(device->rq_queue)) {
+			drbd_err(peer_device, "data size (%u) != drbd logical block size (%u)\n",
+				data_size, queue_logical_block_size(device->rq_queue));
+			return NULL;
+		}
+		if (data_size != bdev_logical_block_size(device->ldev->backing_bdev)) {
+			drbd_err(peer_device, "data size (%u) != backend logical block size (%u)\n",
+				data_size, bdev_logical_block_size(device->ldev->backing_bdev));
+			return NULL;
+		}
+		ds = be32_to_cpu(wsame->size);
 	}
 
-	if (!expect(IS_ALIGNED(data_size, 512)))
+	if (!expect(IS_ALIGNED(ds, 512)))
 		return NULL;
-	/* prepare for larger trim requests. */
-	if (!trim && !expect(data_size <= DRBD_MAX_BIO_SIZE))
+	if (trim || wsame) {
+		if (!expect(ds <= (DRBD_MAX_BBIO_SECTORS << 9)))
+			return NULL;
+	} else if (!expect(ds <= DRBD_MAX_BIO_SIZE))
 		return NULL;
 
 	/* even though we trust out peer,
 	 * we sometimes have to double check. */
-	if (sector + (data_size>>9) > capacity) {
+	if (sector + (ds>>9) > capacity) {
 		drbd_err(device, "request from peer beyond end of local disk: "
 			"capacity: %llus < sector: %llus + size: %u\n",
 			(unsigned long long)capacity,
-			(unsigned long long)sector, data_size);
+			(unsigned long long)sector, ds);
 		return NULL;
 	}
 
 	/* GFP_NOIO, because we must not cause arbitrary write-out: in a DRBD
 	 * "criss-cross" setup, that might cause write-out on some other DRBD,
 	 * which in turn might block on the other node at this very place.  */
-	peer_req = drbd_alloc_peer_req(peer_device, id, sector, data_size, trim == NULL, GFP_NOIO);
+	peer_req = drbd_alloc_peer_req(peer_device, id, sector, ds, data_size, GFP_NOIO);
 	if (!peer_req)
 		return NULL;
 
 	peer_req->flags |= EE_WRITE;
-	if (trim)
+	if (trim) {
+		peer_req->flags |= EE_IS_TRIM;
 		return peer_req;
+	}
+	if (wsame)
+		peer_req->flags |= EE_WRITE_SAME;
 
+	/* receive payload size bytes into page chain */
 	ds = data_size;
 	page = peer_req->pages;
 	page_chain_for_each(page) {
@@ -1851,7 +1910,7 @@ read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
 	}
 
 	if (digest_size) {
-		drbd_csum_ee(peer_device->connection->peer_integrity_tfm, peer_req, dig_vv);
+		drbd_csum_ee_size(peer_device->connection->peer_integrity_tfm, peer_req, dig_vv, data_size);
 		if (memcmp(dig_in, dig_vv, digest_size)) {
 			drbd_err(device, "Digest integrity check FAILED: %llus +%u\n",
 				(unsigned long long)sector, data_size);
@@ -2506,7 +2565,6 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 	dp_flags = be32_to_cpu(p->dp_flags);
 	rw |= wire_flags_to_bio(dp_flags);
 	if (pi->cmd == P_TRIM) {
-		peer_req->flags |= EE_IS_TRIM;
 		D_ASSERT(peer_device, peer_req->i.size > 0);
 		D_ASSERT(peer_device, rw & REQ_DISCARD);
 		D_ASSERT(peer_device, peer_req->pages == NULL);
@@ -2573,11 +2631,11 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 		update_peer_seq(peer_device, peer_seq);
 		spin_lock_irq(&device->resource->req_lock);
 	}
-	/* if we use the zeroout fallback code, we process synchronously
-	 * and we wait for all pending requests, respectively wait for
+	/* TRIM and WRITE_SAME are processed synchronously,
+	 * we wait for all pending requests, respectively wait for
 	 * active_ee to become empty in drbd_submit_peer_request();
 	 * better not add ourselves here. */
-	if ((peer_req->flags & EE_IS_TRIM) == 0)
+	if ((peer_req->flags & (EE_IS_TRIM|EE_WRITE_SAME)) == 0)
 		list_add_tail(&peer_req->w.list, &device->active_ee);
 	spin_unlock_irq(&device->resource->req_lock);
 
@@ -2759,7 +2817,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 	 * "criss-cross" setup, that might cause write-out on some other DRBD,
 	 * which in turn might block on the other node at this very place.  */
 	peer_req = drbd_alloc_peer_req(peer_device, p->block_id, sector, size,
-			true /* has real payload */, GFP_NOIO);
+			size, GFP_NOIO);
 	if (!peer_req) {
 		put_ldev(device);
 		return -ENOMEM;
@@ -3920,6 +3978,7 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 	struct drbd_peer_device *peer_device;
 	struct drbd_device *device;
 	struct p_sizes *p = pi->data;
+	struct o_qlim *o = (connection->agreed_features & DRBD_FF_WSAME) ? p->qlim : NULL;
 	enum determine_dev_size dd = DS_UNCHANGED;
 	sector_t p_size, p_usize, p_csize, my_usize;
 	int ldsc = 0; /* local disk size changed */
@@ -4003,7 +4062,7 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 
 	ddsf = be16_to_cpu(p->dds_flags);
 	if (get_ldev(device)) {
-		drbd_reconsider_queue_parameters(device, device->ldev);
+		drbd_reconsider_queue_parameters(device, device->ldev, o);
 		dd = drbd_determine_dev_size(device, ddsf, NULL);
 		put_ldev(device);
 		if (dd == DS_ERROR)
@@ -4023,7 +4082,7 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 		 * However, if he sends a zero current size,
 		 * take his (user-capped or) backing disk size anyways.
 		 */
-		drbd_reconsider_queue_parameters(device, NULL);
+		drbd_reconsider_queue_parameters(device, NULL, o);
 		drbd_set_my_capacity(device, p_csize ?: p_usize ?: p_size);
 	}
 
@@ -4779,7 +4838,7 @@ static int receive_rs_deallocated(struct drbd_connection *connection, struct pac
 		const int rw = REQ_WRITE | REQ_DISCARD;
 
 		peer_req = drbd_alloc_peer_req(peer_device, ID_SYNCER, sector,
-					       size, false, GFP_NOIO);
+					       size, 0, GFP_NOIO);
 		if (!peer_req) {
 			put_ldev(device);
 			return -ENOMEM;
@@ -4824,7 +4883,7 @@ static int receive_rs_deallocated(struct drbd_connection *connection, struct pac
 
 struct data_cmd {
 	int expect_payload;
-	size_t pkt_size;
+	unsigned int pkt_size;
 	int (*fn)(struct drbd_connection *, struct packet_info *);
 };
 
@@ -4856,7 +4915,7 @@ static struct data_cmd drbd_cmd_handler[] = {
 	[P_PROTOCOL_UPDATE] = { 1, sizeof(struct p_protocol), receive_protocol },
 	[P_TRIM]	    = { 0, sizeof(struct p_trim), receive_Data },
 	[P_RS_DEALLOCATED]  = { 0, sizeof(struct p_block_desc), receive_rs_deallocated },
-
+	[P_WSAME]	    = { 1, sizeof(struct p_wsame), receive_Data },
 };
 
 static void drbdd(struct drbd_connection *connection)
@@ -4866,7 +4925,7 @@ static void drbdd(struct drbd_connection *connection)
 	int err;
 
 	while (get_t_state(&connection->receiver) == RUNNING) {
-		struct data_cmd *cmd;
+		struct data_cmd const *cmd;
 
 		drbd_thread_current_set_cpu(&connection->receiver);
 		update_receiver_timing_details(connection, drbd_recv_header);
@@ -4881,11 +4940,18 @@ static void drbdd(struct drbd_connection *connection)
 		}
 
 		shs = cmd->pkt_size;
+		if (pi.cmd == P_SIZES && connection->agreed_features & DRBD_FF_WSAME)
+			shs += sizeof(struct o_qlim);
 		if (pi.size > shs && !cmd->expect_payload) {
 			drbd_err(connection, "No payload expected %s l:%d\n",
 				 cmdname(pi.cmd), pi.size);
 			goto err_out;
 		}
+		if (pi.size < shs) {
+			drbd_err(connection, "%s: unexpected packet size, expected:%d received:%d\n",
+				 cmdname(pi.cmd), (int)shs, pi.size);
+			goto err_out;
+		}
 
 		if (shs) {
 			update_receiver_timing_details(connection, drbd_recv_all_warn);
@@ -5132,11 +5198,12 @@ static int drbd_do_features(struct drbd_connection *connection)
 	drbd_info(connection, "Handshake successful: "
 	     "Agreed network protocol version %d\n", connection->agreed_pro_version);
 
-	drbd_info(connection, "Agreed to%ssupport TRIM on protocol level\n",
-		  connection->agreed_features & FF_TRIM ? " " : " not ");
-
-	drbd_info(connection, "Agreed to%ssupport THIN_RESYNC on protocol level\n",
-		  connection->agreed_features & FF_THIN_RESYNC ? " " : " not ");
+	drbd_info(connection, "Feature flags enabled on protocol level: 0x%x%s%s%s.\n",
+		  connection->agreed_features,
+		  connection->agreed_features & DRBD_FF_TRIM ? " TRIM" : "",
+		  connection->agreed_features & DRBD_FF_THIN_RESYNC ? " THIN_RESYNC" : "",
+		  connection->agreed_features & DRBD_FF_WSAME ? " WRITE_SAME" :
+		  connection->agreed_features ? "" : " none");
 
 	return 1;
 
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 8260dfa6..72bb1b1 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -47,8 +47,7 @@ static void _drbd_end_io_acct(struct drbd_device *device, struct drbd_request *r
 			    &device->vdisk->part0, req->start_jif);
 }
 
-static struct drbd_request *drbd_req_new(struct drbd_device *device,
-					       struct bio *bio_src)
+static struct drbd_request *drbd_req_new(struct drbd_device *device, struct bio *bio_src)
 {
 	struct drbd_request *req;
 
@@ -58,10 +57,12 @@ static struct drbd_request *drbd_req_new(struct drbd_device *device,
 	memset(req, 0, sizeof(*req));
 
 	drbd_req_make_private_bio(req, bio_src);
-	req->rq_state    = bio_data_dir(bio_src) == WRITE ? RQ_WRITE : 0;
-	req->device   = device;
-	req->master_bio  = bio_src;
-	req->epoch       = 0;
+	req->rq_state = (bio_data_dir(bio_src) == WRITE ? RQ_WRITE : 0)
+	              | (bio_src->bi_rw & REQ_WRITE_SAME ? RQ_WSAME : 0)
+	              | (bio_src->bi_rw & REQ_DISCARD ? RQ_UNMAP : 0);
+	req->device = device;
+	req->master_bio = bio_src;
+	req->epoch = 0;
 
 	drbd_clear_interval(&req->i);
 	req->i.sector     = bio_src->bi_iter.bi_sector;
diff --git a/drivers/block/drbd/drbd_req.h b/drivers/block/drbd/drbd_req.h
index bb2ef78..eb49e7f 100644
--- a/drivers/block/drbd/drbd_req.h
+++ b/drivers/block/drbd/drbd_req.h
@@ -206,6 +206,8 @@ enum drbd_req_state_bits {
 
 	/* Set when this is a write, clear for a read */
 	__RQ_WRITE,
+	__RQ_WSAME,
+	__RQ_UNMAP,
 
 	/* Should call drbd_al_complete_io() for this request... */
 	__RQ_IN_ACT_LOG,
@@ -241,10 +243,11 @@ enum drbd_req_state_bits {
 #define RQ_NET_OK          (1UL << __RQ_NET_OK)
 #define RQ_NET_SIS         (1UL << __RQ_NET_SIS)
 
-/* 0x1f8 */
 #define RQ_NET_MASK        (((1UL << __RQ_NET_MAX)-1) & ~RQ_LOCAL_MASK)
 
 #define RQ_WRITE           (1UL << __RQ_WRITE)
+#define RQ_WSAME           (1UL << __RQ_WSAME)
+#define RQ_UNMAP           (1UL << __RQ_UNMAP)
 #define RQ_IN_ACT_LOG      (1UL << __RQ_IN_ACT_LOG)
 #define RQ_POSTPONED	   (1UL << __RQ_POSTPONED)
 #define RQ_COMPLETION_SUSP (1UL << __RQ_COMPLETION_SUSP)
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index f9e142d..ed422a5 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -320,6 +320,10 @@ void drbd_csum_bio(struct crypto_ahash *tfm, struct bio *bio, void *digest)
 		sg_set_page(&sg, bvec.bv_page, bvec.bv_len, bvec.bv_offset);
 		ahash_request_set_crypt(req, &sg, NULL, sg.length);
 		crypto_ahash_update(req);
+		/* REQ_WRITE_SAME has only one segment,
+		 * checksum the payload only once. */
+		if (bio->bi_rw & REQ_WRITE_SAME)
+			break;
 	}
 	ahash_request_set_crypt(req, NULL, digest, 0);
 	crypto_ahash_final(req);
@@ -387,7 +391,7 @@ static int read_for_csum(struct drbd_peer_device *peer_device, sector_t sector,
 	/* GFP_TRY, because if there is no memory available right now, this may
 	 * be rescheduled for later. It is "only" background resync, after all. */
 	peer_req = drbd_alloc_peer_req(peer_device, ID_SYNCER /* unused */, sector,
-				       size, true /* has real payload */, GFP_TRY);
+				       size, size, GFP_TRY);
 	if (!peer_req)
 		goto defer;
 
@@ -602,7 +606,7 @@ static int make_resync_request(struct drbd_device *const device, int cancel)
 		return 0;
 	}
 
-	if (connection->agreed_features & FF_THIN_RESYNC) {
+	if (connection->agreed_features & DRBD_FF_THIN_RESYNC) {
 		rcu_read_lock();
 		discard_granularity = rcu_dereference(device->ldev->disk_conf)->rs_discard_granularity;
 		rcu_read_unlock();
-- 
1.9.1



