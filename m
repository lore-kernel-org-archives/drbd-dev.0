Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri,  2 Sep 2011 12:00:44 +0200
Message-Id: <1314957648-13242-13-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314957648-13242-1-git-send-email-philipp.reisner@linbit.com>
References: <1314957648-13242-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 12/16] drbd: fix conn_reconfig_start without
	conn_reconfig_done in drbd_adm_attach
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

If drbd_adm_attach failed early, it left the CONFIG_PENDING bit on,
blocking any further conn_reconfig_start on that connection.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 2970f45..7389e37 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1074,7 +1074,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	if (!adm_ctx.reply_skb)
 		return retcode;
 	if (retcode != NO_ERROR)
-		goto fail;
+		goto finish;
 
 	mdev = adm_ctx.mdev;
 	conn_reconfig_start(mdev->tconn);
@@ -1433,8 +1433,8 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
  force_diskless:
 	drbd_force_state(mdev, NS(disk, D_FAILED));
 	drbd_md_sync(mdev);
-	conn_reconfig_done(mdev->tconn);
  fail:
+	conn_reconfig_done(mdev->tconn);
 	if (nbc) {
 		if (nbc->backing_bdev)
 			blkdev_put(nbc->backing_bdev,
@@ -1446,6 +1446,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	}
 	lc_destroy(resync_lru);
 
+ finish:
 	drbd_adm_finish(info, retcode);
 	return 0;
 }
-- 
1.7.4.1

