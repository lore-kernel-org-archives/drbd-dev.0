Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu,  1 Sep 2011 14:48:53 +0200
Message-Id: <1314881345-6420-7-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314881345-6420-1-git-send-email-philipp.reisner@linbit.com>
References: <1314881345-6420-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 06/18] drbd: fix drbd_delete_device: remove vnr
	from volumes; idr_remove(); synchronize_rcu(); before cleanup
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Still missing: rcu_readlock() on the various call sites that
access/iterate over those idrs.

We don't need a specific write lock, as we only modify from
configuration context, which is already strictly serialized.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_main.c |   42 ++++++++++++++++++++++-----------------
 1 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 26bcd13..21914f4 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2124,7 +2124,9 @@ void drbd_delete_device(unsigned int minor)
 	if (!mdev)
 		return;
 
-	idr_remove(&mdev->tconn->volumes, minor);
+	idr_remove(&mdev->tconn->volumes, mdev->vnr);
+	idr_remove(&minors, minor);
+	synchronize_rcu();
 
 	/* paranoia asserts */
 	D_ASSERT(mdev->open_cnt == 0);
@@ -2153,7 +2155,6 @@ void drbd_delete_device(unsigned int minor)
 	 * allocated from drbd_new_device
 	 * and actually free the mdev itself */
 	drbd_free_mdev(mdev);
-	idr_remove(&minors, minor);
 }
 
 static void drbd_cleanup(void)
@@ -2331,15 +2332,6 @@ enum drbd_ret_code conn_new_minor(struct drbd_tconn *tconn, unsigned int minor,
 		return ERR_NOMEM;
 
 	mdev->tconn = tconn;
-	if (!idr_pre_get(&tconn->volumes, GFP_KERNEL))
-		goto out_no_idr;
-	if (idr_get_new(&tconn->volumes, mdev, &vnr_got))
-		goto out_no_idr;
-	if (vnr_got != vnr) {
-		dev_err(DEV, "vnr_got (%d) != vnr (%d)\n", vnr_got, vnr);
-		goto out_no_q;
-	}
-
 	mdev->minor = minor;
 
 	drbd_init_set_defaults(mdev);
@@ -2395,19 +2387,35 @@ enum drbd_ret_code conn_new_minor(struct drbd_tconn *tconn, unsigned int minor,
 	INIT_LIST_HEAD(&mdev->current_epoch->list);
 	mdev->epochs = 1;
 
+	if (!idr_pre_get(&tconn->volumes, GFP_KERNEL))
+		goto out_no_vol_idr;
+	if (idr_get_new(&tconn->volumes, mdev, &vnr_got))
+		goto out_no_vol_idr;
+	if (vnr_got != vnr) {
+		dev_err(DEV, "vnr_got (%d) != vnr (%d)\n", vnr_got, vnr);
+		goto out_idr_remove_vol;
+	}
+
 	if (!idr_pre_get(&minors, GFP_KERNEL))
-		goto out_no_minor_idr;
+		goto out_idr_remove_vol;
 	if (idr_get_new(&minors, mdev, &minor_got))
-		goto out_no_minor_idr;
+		goto out_idr_remove_vol;
 	if (minor_got != minor) {
-		idr_remove(&minors, minor_got);
-		goto out_no_minor_idr;
+		/* minor exists, or other idr strangeness? */
+		dev_err(DEV, "available minor (%d) != requested minor (%d)\n",
+				minor_got, minor);
+		goto out_idr_remove_minor;
 	}
 	add_disk(disk);
 
 	return NO_ERROR;
 
-out_no_minor_idr:
+out_idr_remove_minor:
+	idr_remove(&minors, minor_got);
+out_idr_remove_vol:
+	idr_remove(&tconn->volumes, vnr_got);
+	synchronize_rcu();
+out_no_vol_idr:
 	kfree(mdev->current_epoch);
 out_no_epoch:
 	drbd_bm_cleanup(mdev);
@@ -2418,8 +2426,6 @@ out_no_io_page:
 out_no_disk:
 	blk_cleanup_queue(q);
 out_no_q:
-	idr_remove(&tconn->volumes, vnr_got);
-out_no_idr:
 	kfree(mdev);
 	return ERR_NOMEM;
 }
-- 
1.7.4.1

