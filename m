Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 56FCB1056465
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jun 2016 16:09:20 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 13 Jun 2016 16:08:51 +0200
Message-Id: <1465826958-19398-4-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1465826958-19398-1-git-send-email-philipp.reisner@linbit.com>
References: <1465826958-19398-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/30] drbd: Kill code duplication
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

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 0bac9c8..fad03e4 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1348,6 +1348,14 @@ static bool write_ordering_changed(struct disk_conf *a, struct disk_conf *b)
 		a->disk_drain != b->disk_drain;
 }
 
+static void sanitize_disk_conf(struct disk_conf *disk_conf, struct drbd_backing_dev *nbc)
+{
+	if (disk_conf->al_extents < DRBD_AL_EXTENTS_MIN)
+		disk_conf->al_extents = DRBD_AL_EXTENTS_MIN;
+	if (disk_conf->al_extents > drbd_al_extents_max(nbc))
+		disk_conf->al_extents = drbd_al_extents_max(nbc);
+}
+
 int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 {
 	struct drbd_config_context adm_ctx;
@@ -1395,10 +1403,7 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 	if (!expect(new_disk_conf->resync_rate >= 1))
 		new_disk_conf->resync_rate = 1;
 
-	if (new_disk_conf->al_extents < DRBD_AL_EXTENTS_MIN)
-		new_disk_conf->al_extents = DRBD_AL_EXTENTS_MIN;
-	if (new_disk_conf->al_extents > drbd_al_extents_max(device->ldev))
-		new_disk_conf->al_extents = drbd_al_extents_max(device->ldev);
+	sanitize_disk_conf(new_disk_conf, device->ldev);
 
 	if (new_disk_conf->c_plan_ahead > DRBD_C_PLAN_AHEAD_MAX)
 		new_disk_conf->c_plan_ahead = DRBD_C_PLAN_AHEAD_MAX;
@@ -1693,10 +1698,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	if (retcode != NO_ERROR)
 		goto fail;
 
-	if (new_disk_conf->al_extents < DRBD_AL_EXTENTS_MIN)
-		new_disk_conf->al_extents = DRBD_AL_EXTENTS_MIN;
-	if (new_disk_conf->al_extents > drbd_al_extents_max(nbc))
-		new_disk_conf->al_extents = drbd_al_extents_max(nbc);
+	sanitize_disk_conf(new_disk_conf, nbc);
 
 	if (drbd_get_max_capacity(nbc) < new_disk_conf->disk_size) {
 		drbd_err(device, "max capacity %llu smaller than disk size %llu\n",
-- 
2.7.4

