Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 31 Aug 2011 17:11:03 +0200
Message-Id: <1314803468-1201-12-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314803468-1201-1-git-send-email-philipp.reisner@linbit.com>
References: <1314803468-1201-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/16] drbd: Improved the dec_*() macros
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Now those can be used with a struct drbd_conf * that has an other
name than 'mdev'.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h |   51 +++++++++++++++++++++++-----------------
 1 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index d53fb0f..004419e 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1988,17 +1988,19 @@ static inline void inc_ap_pending(struct drbd_conf *mdev)
 	atomic_inc(&mdev->ap_pending_cnt);
 }
 
-#define ERR_IF_CNT_IS_NEGATIVE(which)				\
-	if (atomic_read(&mdev->which) < 0)			\
+#define ERR_IF_CNT_IS_NEGATIVE(which, func, line)			\
+	if (atomic_read(&mdev->which) < 0)				\
 		dev_err(DEV, "in %s:%d: " #which " = %d < 0 !\n",	\
-		    __func__ , __LINE__ ,			\
-		    atomic_read(&mdev->which))
+			func, line,					\
+			atomic_read(&mdev->which))
 
-#define dec_ap_pending(mdev)	do {				\
-	typecheck(struct drbd_conf *, mdev);			\
-	if (atomic_dec_and_test(&mdev->ap_pending_cnt))		\
-		wake_up(&mdev->misc_wait);			\
-	ERR_IF_CNT_IS_NEGATIVE(ap_pending_cnt); } while (0)
+#define dec_ap_pending(mdev) _dec_ap_pending(mdev, __FUNCTION__, __LINE__)
+static inline void _dec_ap_pending(struct drbd_conf *mdev, const char *func, int line)
+{
+	if (atomic_dec_and_test(&mdev->ap_pending_cnt))
+		wake_up(&mdev->misc_wait);
+	ERR_IF_CNT_IS_NEGATIVE(ap_pending_cnt, func, line);
+}
 
 /* counts how many resync-related answers we still expect from the peer
  *		     increase			decrease
@@ -2011,10 +2013,12 @@ static inline void inc_rs_pending(struct drbd_conf *mdev)
 	atomic_inc(&mdev->rs_pending_cnt);
 }
 
-#define dec_rs_pending(mdev)	do {				\
-	typecheck(struct drbd_conf *, mdev);			\
-	atomic_dec(&mdev->rs_pending_cnt);			\
-	ERR_IF_CNT_IS_NEGATIVE(rs_pending_cnt); } while (0)
+#define dec_rs_pending(mdev) _dec_rs_pending(mdev, __FUNCTION__, __LINE__)
+static inline void _dec_rs_pending(struct drbd_conf *mdev, const char *func, int line)
+{
+	atomic_dec(&mdev->rs_pending_cnt);
+	ERR_IF_CNT_IS_NEGATIVE(rs_pending_cnt, func, line);
+}
 
 /* counts how many answers we still need to send to the peer.
  * increased on
@@ -2030,16 +2034,19 @@ static inline void inc_unacked(struct drbd_conf *mdev)
 	atomic_inc(&mdev->unacked_cnt);
 }
 
-#define dec_unacked(mdev)	do {				\
-	typecheck(struct drbd_conf *, mdev);			\
-	atomic_dec(&mdev->unacked_cnt);				\
-	ERR_IF_CNT_IS_NEGATIVE(unacked_cnt); } while (0)
-
-#define sub_unacked(mdev, n)	do {				\
-	typecheck(struct drbd_conf *, mdev);			\
-	atomic_sub(n, &mdev->unacked_cnt);			\
-	ERR_IF_CNT_IS_NEGATIVE(unacked_cnt); } while (0)
+#define dec_unacked(mdev) _dec_unacked(mdev, __FUNCTION__, __LINE__)
+static inline void _dec_unacked(struct drbd_conf *mdev, const char *func, int line)
+{
+	atomic_dec(&mdev->unacked_cnt);
+	ERR_IF_CNT_IS_NEGATIVE(unacked_cnt, func, line);
+}
 
+#define sub_unacked(mdev, n) _sub_unacked(mdev, n, __FUNCTION__, __LINE__)
+static inline void _sub_unacked(struct drbd_conf *mdev, int n, const char *func, int line)
+{
+	atomic_sub(n, &mdev->unacked_cnt);
+	ERR_IF_CNT_IS_NEGATIVE(unacked_cnt, func, line);
+}
 
 static inline void put_net_conf(struct drbd_tconn *tconn)
 {
-- 
1.7.4.1

