Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri, 30 Sep 2011 14:48:16 +0200
Message-Id: <1317386906-19260-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317386906-19260-1-git-send-email-philipp.reisner@linbit.com>
References: <1317386906-19260-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/11] drbd: drbd_delete_device() takes a struct
	drbd_conf * now
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
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
 drivers/block/drbd/drbd_int.h  |    2 +-
 drivers/block/drbd/drbd_main.c |   12 ++++--------
 drivers/block/drbd/drbd_nl.c   |    2 +-
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 9aca1f4..ce56aa0 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1367,7 +1367,7 @@ extern rwlock_t global_state_lock;
 extern int conn_lowest_minor(struct drbd_tconn *tconn);
 enum drbd_ret_code conn_new_minor(struct drbd_tconn *tconn, unsigned int minor, int vnr);
 extern void drbd_free_mdev(struct drbd_conf *mdev);
-extern void drbd_delete_device(unsigned int minor);
+extern void drbd_delete_device(struct drbd_conf *mdev);
 
 struct drbd_tconn *drbd_new_tconn(const char *name);
 extern void drbd_free_tconn(struct drbd_tconn *tconn);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 8097d7a..8466ee7 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2195,15 +2195,10 @@ static void drbd_release_all_peer_reqs(struct drbd_conf *mdev)
 }
 
 /* caution. no locking. */
-void drbd_delete_device(unsigned int minor)
+void drbd_delete_device(struct drbd_conf *mdev)
 {
-	struct drbd_conf *mdev = minor_to_mdev(minor);
-
-	if (!mdev)
-		return;
-
 	idr_remove(&mdev->tconn->volumes, mdev->vnr);
-	idr_remove(&minors, minor);
+	idr_remove(&minors, mdev_to_minor(mdev));
 	synchronize_rcu();
 
 	/* paranoia asserts */
@@ -2256,7 +2251,8 @@ static void drbd_cleanup(void)
 	drbd_genl_unregister();
 
 	idr_for_each_entry(&minors, mdev, i)
-		drbd_delete_device(i);
+		drbd_delete_device(mdev);
+
 	drbd_destroy_mempools();
 	unregister_blkdev(DRBD_MAJOR, "drbd");
 
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 4b60673..be2ca81 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -2916,7 +2916,7 @@ static enum drbd_ret_code adm_delete_minor(struct drbd_conf *mdev)
 	     * we may want to delete a minor from a live replication group.
 	     */
 	    mdev->state.role == R_SECONDARY) {
-		drbd_delete_device(mdev_to_minor(mdev));
+		drbd_delete_device(mdev);
 		return NO_ERROR;
 	} else
 		return ERR_MINOR_CONFIGURED;
-- 
1.7.4.1

