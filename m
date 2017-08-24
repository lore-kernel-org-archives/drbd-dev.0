Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EF771105800B
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 23:30:00 +0200 (CEST)
Received: by mail-wm0-f43.google.com with SMTP id z132so4514077wmg.1
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 14:30:00 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 24 Aug 2017 23:23:04 +0200
Message-Id: <1503609794-13233-8-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
References: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 07/17] drbd: new disk-option disable-write-same
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

Some backend devices claim to support write-same,
but would fail actual write-same requests.

Allow to set (or toggle) whether or not DRBD tries to support write-same.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index ad0fcb4..c383b6c 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1236,12 +1236,18 @@ static void fixup_discard_if_not_supported(struct request_queue *q)
 
 static void decide_on_write_same_support(struct drbd_device *device,
 			struct request_queue *q,
-			struct request_queue *b, struct o_qlim *o)
+			struct request_queue *b, struct o_qlim *o,
+			bool disable_write_same)
 {
 	struct drbd_peer_device *peer_device = first_peer_device(device);
 	struct drbd_connection *connection = peer_device->connection;
 	bool can_do = b ? b->limits.max_write_same_sectors : true;
 
+	if (can_do && disable_write_same) {
+		can_do = false;
+		drbd_info(peer_device, "WRITE_SAME disabled by config\n");
+	}
+
 	if (can_do && connection->cstate >= C_CONNECTED && !(connection->agreed_features & DRBD_FF_WSAME)) {
 		can_do = false;
 		drbd_info(peer_device, "peer does not support WRITE_SAME\n");
@@ -1302,6 +1308,7 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 	struct request_queue *b = NULL;
 	struct disk_conf *dc;
 	bool discard_zeroes_if_aligned = true;
+	bool disable_write_same = false;
 
 	if (bdev) {
 		b = bdev->backing_bdev->bd_disk->queue;
@@ -1311,6 +1318,7 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 		dc = rcu_dereference(device->ldev->disk_conf);
 		max_segments = dc->max_bio_bvecs;
 		discard_zeroes_if_aligned = dc->discard_zeroes_if_aligned;
+		disable_write_same = dc->disable_write_same;
 		rcu_read_unlock();
 
 		blk_set_stacking_limits(&q->limits);
@@ -1321,7 +1329,7 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 	blk_queue_max_segments(q, max_segments ? max_segments : BLK_MAX_SEGMENTS);
 	blk_queue_segment_boundary(q, PAGE_SIZE-1);
 	decide_on_discard_support(device, q, b, discard_zeroes_if_aligned);
-	decide_on_write_same_support(device, q, b, o);
+	decide_on_write_same_support(device, q, b, o, disable_write_same);
 
 	if (b) {
 		blk_queue_stack_limits(q, b);
@@ -1612,7 +1620,8 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 	if (write_ordering_changed(old_disk_conf, new_disk_conf))
 		drbd_bump_write_ordering(device->resource, NULL, WO_BDEV_FLUSH);
 
-	if (old_disk_conf->discard_zeroes_if_aligned != new_disk_conf->discard_zeroes_if_aligned)
+	if (old_disk_conf->discard_zeroes_if_aligned != new_disk_conf->discard_zeroes_if_aligned
+	||  old_disk_conf->disable_write_same != new_disk_conf->disable_write_same)
 		drbd_reconsider_queue_parameters(device, device->ldev, NULL);
 
 	drbd_md_sync(device);
diff --git a/include/linux/drbd_genl.h b/include/linux/drbd_genl.h
index 2896f93..4e6d4d4 100644
--- a/include/linux/drbd_genl.h
+++ b/include/linux/drbd_genl.h
@@ -132,7 +132,8 @@ GENL_struct(DRBD_NLA_DISK_CONF, 3, disk_conf,
 	__flg_field_def(18, DRBD_GENLA_F_MANDATORY,	disk_drain, DRBD_DISK_DRAIN_DEF)
 	__flg_field_def(19, DRBD_GENLA_F_MANDATORY,	md_flushes, DRBD_MD_FLUSHES_DEF)
 	__flg_field_def(23,     0 /* OPTIONAL */,	al_updates, DRBD_AL_UPDATES_DEF)
-	__flg_field_def(24,     0 /* OPTIONAL */,	discard_zeroes_if_aligned, DRBD_DISCARD_ZEROES_IF_ALIGNED)
+	__flg_field_def(24,     0 /* OPTIONAL */,	discard_zeroes_if_aligned, DRBD_DISCARD_ZEROES_IF_ALIGNED_DEF)
+	__flg_field_def(26,     0 /* OPTIONAL */,	disable_write_same, DRBD_DISABLE_WRITE_SAME_DEF)
 )
 
 GENL_struct(DRBD_NLA_RESOURCE_OPTS, 4, res_opts,
diff --git a/include/linux/drbd_limits.h b/include/linux/drbd_limits.h
index ddac684..24ae1b9 100644
--- a/include/linux/drbd_limits.h
+++ b/include/linux/drbd_limits.h
@@ -209,12 +209,18 @@
 #define DRBD_MD_FLUSHES_DEF	1
 #define DRBD_TCP_CORK_DEF	1
 #define DRBD_AL_UPDATES_DEF     1
+
 /* We used to ignore the discard_zeroes_data setting.
  * To not change established (and expected) behaviour,
  * by default assume that, for discard_zeroes_data=0,
  * we can make that an effective discard_zeroes_data=1,
  * if we only explicitly zero-out unaligned partial chunks. */
-#define DRBD_DISCARD_ZEROES_IF_ALIGNED 1
+#define DRBD_DISCARD_ZEROES_IF_ALIGNED_DEF 1
+
+/* Some backends pretend to support WRITE SAME,
+ * but fail such requests when they are actually submitted.
+ * This is to tell DRBD to not even try. */
+#define DRBD_DISABLE_WRITE_SAME_DEF 0
 
 #define DRBD_ALLOW_TWO_PRIMARIES_DEF	0
 #define DRBD_ALWAYS_ASBP_DEF	0
-- 
2.7.4

