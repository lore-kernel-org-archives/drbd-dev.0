Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DFB1F1056448
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 14:08:22 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 25 Apr 2016 14:07:32 +0200
Message-Id: <1461586077-11581-6-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
References: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/30] drbd: Introduce new disk config option
	rs-discard-granularity
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

As long as the value is 0 the feature is disabled. With setting
it to a positive value, DRBD limits and aligns its resync requests
to the rs-discard-granularity setting. If the sync source detects
all zeros in such a block, the resync target discards the range
on disk.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 32 +++++++++++++++++++++++++++++---
 include/linux/drbd_genl.h    |  6 +++---
 include/linux/drbd_limits.h  |  6 ++++++
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index bb71e73..ee4642f 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1348,12 +1348,38 @@ static bool write_ordering_changed(struct disk_conf *a, struct disk_conf *b)
 		a->disk_drain != b->disk_drain;
 }
 
-static void sanitize_disk_conf(struct disk_conf *disk_conf, struct drbd_backing_dev *nbc)
+static void sanitize_disk_conf(struct drbd_device *device, struct disk_conf *disk_conf,
+			       struct drbd_backing_dev *nbc)
 {
+	struct request_queue * const q = nbc->backing_bdev->bd_disk->queue;
+
 	if (disk_conf->al_extents < DRBD_AL_EXTENTS_MIN)
 		disk_conf->al_extents = DRBD_AL_EXTENTS_MIN;
 	if (disk_conf->al_extents > drbd_al_extents_max(nbc))
 		disk_conf->al_extents = drbd_al_extents_max(nbc);
+
+	if (!blk_queue_discard(q) || !q->limits.discard_zeroes_data) {
+		disk_conf->rs_discard_granularity = 0; /* disable feature */
+		drbd_info(device, "rs_discard_granularity feature disabled\n");
+	}
+
+	if (disk_conf->rs_discard_granularity) {
+		int orig_value = disk_conf->rs_discard_granularity;
+		int remainder;
+
+		if (q->limits.discard_granularity > disk_conf->rs_discard_granularity)
+			disk_conf->rs_discard_granularity = q->limits.discard_granularity;
+
+		remainder = disk_conf->rs_discard_granularity % q->limits.discard_granularity;
+		disk_conf->rs_discard_granularity += remainder;
+
+		if (disk_conf->rs_discard_granularity > q->limits.max_discard_sectors << 9)
+			disk_conf->rs_discard_granularity = q->limits.max_discard_sectors << 9;
+
+		if (disk_conf->rs_discard_granularity != orig_value)
+			drbd_info(device, "rs_discard_granularity changed to %d\n",
+				  disk_conf->rs_discard_granularity);
+	}
 }
 
 int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
@@ -1403,7 +1429,7 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 	if (!expect(new_disk_conf->resync_rate >= 1))
 		new_disk_conf->resync_rate = 1;
 
-	sanitize_disk_conf(new_disk_conf, device->ldev);
+	sanitize_disk_conf(device, new_disk_conf, device->ldev);
 
 	if (new_disk_conf->c_plan_ahead > DRBD_C_PLAN_AHEAD_MAX)
 		new_disk_conf->c_plan_ahead = DRBD_C_PLAN_AHEAD_MAX;
@@ -1698,7 +1724,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	if (retcode != NO_ERROR)
 		goto fail;
 
-	sanitize_disk_conf(new_disk_conf, nbc);
+	sanitize_disk_conf(device, new_disk_conf, nbc);
 
 	if (drbd_get_max_capacity(nbc) < new_disk_conf->disk_size) {
 		drbd_err(device, "max capacity %llu smaller than disk size %llu\n",
diff --git a/include/linux/drbd_genl.h b/include/linux/drbd_genl.h
index 2d0e5ad..ab649d8 100644
--- a/include/linux/drbd_genl.h
+++ b/include/linux/drbd_genl.h
@@ -123,14 +123,14 @@ GENL_struct(DRBD_NLA_DISK_CONF, 3, disk_conf,
 	__u32_field_def(13,	DRBD_GENLA_F_MANDATORY,	c_fill_target, DRBD_C_FILL_TARGET_DEF)
 	__u32_field_def(14,	DRBD_GENLA_F_MANDATORY,	c_max_rate, DRBD_C_MAX_RATE_DEF)
 	__u32_field_def(15,	DRBD_GENLA_F_MANDATORY,	c_min_rate, DRBD_C_MIN_RATE_DEF)
+	__u32_field_def(20,     DRBD_GENLA_F_MANDATORY, disk_timeout, DRBD_DISK_TIMEOUT_DEF)
+	__u32_field_def(21,     0 /* OPTIONAL */,       read_balancing, DRBD_READ_BALANCING_DEF)
+	__u32_field_def(25,     0 /* OPTIONAL */,       rs_discard_granularity, DRBD_RS_DISCARD_GRANULARITY_DEF)
 
 	__flg_field_def(16, DRBD_GENLA_F_MANDATORY,	disk_barrier, DRBD_DISK_BARRIER_DEF)
 	__flg_field_def(17, DRBD_GENLA_F_MANDATORY,	disk_flushes, DRBD_DISK_FLUSHES_DEF)
 	__flg_field_def(18, DRBD_GENLA_F_MANDATORY,	disk_drain, DRBD_DISK_DRAIN_DEF)
 	__flg_field_def(19, DRBD_GENLA_F_MANDATORY,	md_flushes, DRBD_MD_FLUSHES_DEF)
-	__u32_field_def(20,	DRBD_GENLA_F_MANDATORY,	disk_timeout, DRBD_DISK_TIMEOUT_DEF)
-	__u32_field_def(21,	0 /* OPTIONAL */,       read_balancing, DRBD_READ_BALANCING_DEF)
-	/* 9: __u32_field_def(22,	DRBD_GENLA_F_MANDATORY,	unplug_watermark, DRBD_UNPLUG_WATERMARK_DEF) */
 	__flg_field_def(23,     0 /* OPTIONAL */,	al_updates, DRBD_AL_UPDATES_DEF)
 )
 
diff --git a/include/linux/drbd_limits.h b/include/linux/drbd_limits.h
index 8ac8c5d..2e4aad8 100644
--- a/include/linux/drbd_limits.h
+++ b/include/linux/drbd_limits.h
@@ -230,4 +230,10 @@
 #define DRBD_SOCKET_CHECK_TIMEO_MAX DRBD_PING_TIMEO_MAX
 #define DRBD_SOCKET_CHECK_TIMEO_DEF 0
 #define DRBD_SOCKET_CHECK_TIMEO_SCALE '1'
+
+#define DRBD_RS_DISCARD_GRANULARITY_MIN 0
+#define DRBD_RS_DISCARD_GRANULARITY_MAX (1<<20)  /* 1MiByte */
+#define DRBD_RS_DISCARD_GRANULARITY_DEF 0     /* disabled by default */
+#define DRBD_RS_DISCARD_GRANULARITY_SCALE '1' /* bytes */
+
 #endif
-- 
1.9.1

