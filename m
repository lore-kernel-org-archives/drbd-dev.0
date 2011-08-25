Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:07:03 +0200
Message-Id: <1314284934-17999-8-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 007/118] drbd: Move drbd_free_tl_hash() to
	drbd_main()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

This is the only place where this function is used.  Make it static.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h      |    1 -
 drivers/block/drbd/drbd_main.c     |   30 ++++++++++++++++++++++++++++++
 drivers/block/drbd/drbd_receiver.c |   30 ------------------------------
 3 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index c1d1755..c6d8200 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1592,7 +1592,6 @@ extern void _drbd_wait_ee_list_empty(struct drbd_conf *mdev,
 extern void drbd_set_recv_tcq(struct drbd_conf *mdev, int tcq_enabled);
 extern void _drbd_clear_done_ee(struct drbd_conf *mdev, struct list_head *to_be_freed);
 extern void drbd_flush_workqueue(struct drbd_conf *mdev);
-extern void drbd_free_tl_hash(struct drbd_conf *mdev);
 
 /* yes, there is kernel_setsockopt, but only since 2.6.18. we don't need to
  * mess with get_fs/set_fs, we know we are KERNEL_DS always. */
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index f65b8c5..eecbfc8 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -228,6 +228,36 @@ static void tl_cleanup(struct drbd_conf *mdev)
 	mdev->tl_hash_s = 0;
 }
 
+static void drbd_free_tl_hash(struct drbd_conf *mdev)
+{
+	struct hlist_head *h;
+
+	spin_lock_irq(&mdev->req_lock);
+
+	if (!mdev->tl_hash || mdev->state.conn != C_STANDALONE) {
+		spin_unlock_irq(&mdev->req_lock);
+		return;
+	}
+	/* paranoia code */
+	for (h = mdev->ee_hash; h < mdev->ee_hash + mdev->ee_hash_s; h++)
+		if (h->first)
+			dev_err(DEV, "ASSERT FAILED ee_hash[%u].first == %p, expected NULL\n",
+				(int)(h - mdev->ee_hash), h->first);
+	kfree(mdev->ee_hash);
+	mdev->ee_hash = NULL;
+	mdev->ee_hash_s = 0;
+
+	/* paranoia code */
+	for (h = mdev->tl_hash; h < mdev->tl_hash + mdev->tl_hash_s; h++)
+		if (h->first)
+			dev_err(DEV, "ASSERT FAILED tl_hash[%u] == %p, expected NULL\n",
+				(int)(h - mdev->tl_hash), h->first);
+	kfree(mdev->tl_hash);
+	mdev->tl_hash = NULL;
+	mdev->tl_hash_s = 0;
+	spin_unlock_irq(&mdev->req_lock);
+}
+
 /**
  * _tl_add_barrier() - Adds a barrier to the transfer log
  * @mdev:	DRBD device.
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index efe141e..bafc233 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3740,36 +3740,6 @@ void drbd_flush_workqueue(struct drbd_conf *mdev)
 	wait_for_completion(&barr.done);
 }
 
-void drbd_free_tl_hash(struct drbd_conf *mdev)
-{
-	struct hlist_head *h;
-
-	spin_lock_irq(&mdev->req_lock);
-
-	if (!mdev->tl_hash || mdev->state.conn != C_STANDALONE) {
-		spin_unlock_irq(&mdev->req_lock);
-		return;
-	}
-	/* paranoia code */
-	for (h = mdev->ee_hash; h < mdev->ee_hash + mdev->ee_hash_s; h++)
-		if (h->first)
-			dev_err(DEV, "ASSERT FAILED ee_hash[%u].first == %p, expected NULL\n",
-				(int)(h - mdev->ee_hash), h->first);
-	kfree(mdev->ee_hash);
-	mdev->ee_hash = NULL;
-	mdev->ee_hash_s = 0;
-
-	/* paranoia code */
-	for (h = mdev->tl_hash; h < mdev->tl_hash + mdev->tl_hash_s; h++)
-		if (h->first)
-			dev_err(DEV, "ASSERT FAILED tl_hash[%u] == %p, expected NULL\n",
-				(int)(h - mdev->tl_hash), h->first);
-	kfree(mdev->tl_hash);
-	mdev->tl_hash = NULL;
-	mdev->tl_hash_s = 0;
-	spin_unlock_irq(&mdev->req_lock);
-}
-
 static void drbd_disconnect(struct drbd_conf *mdev)
 {
 	enum drbd_fencing_p fp;
-- 
1.7.4.1

