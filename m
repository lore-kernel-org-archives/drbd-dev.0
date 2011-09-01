Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu,  1 Sep 2011 14:49:00 +0200
Message-Id: <1314881345-6420-14-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314881345-6420-1-git-send-email-philipp.reisner@linbit.com>
References: <1314881345-6420-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 13/18] drbd: simplify conn_all_vols_unconf,
	make it bool
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Get rid of a temporary variable and, funny bitand assignment.
Just short circuit, returning false, once we encounter the first
still configured volume.

FIXME verify call sites for need of rcu_read_lock or stronger.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_state.c |   16 +++++++---------
 drivers/block/drbd/drbd_state.h |    2 +-
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 34be2ef..c6a659b 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -48,20 +48,18 @@ static enum drbd_state_rv is_valid_transition(union drbd_state os, union drbd_st
 static union drbd_state sanitize_state(struct drbd_conf *mdev, union drbd_state ns,
 				       const char **warn_sync_abort);
 
-int conn_all_vols_unconf(struct drbd_tconn *tconn)
+bool conn_all_vols_unconf(struct drbd_tconn *tconn)
 {
 	struct drbd_conf *mdev;
-	int minor, uncfg = 1;
+	int minor;
 
 	idr_for_each_entry(&tconn->volumes, mdev, minor) {
-		uncfg &= (mdev->state.disk == D_DISKLESS &&
-			  mdev->state.conn == C_STANDALONE &&
-			  mdev->state.role == R_SECONDARY);
-		if (!uncfg)
-			break;
+		if (mdev->state.disk != D_DISKLESS ||
+		    mdev->state.conn != C_STANDALONE ||
+		    mdev->state.role != R_SECONDARY)
+			return false;
 	}
-
-	return uncfg;
+	return true;
 }
 
 /**
diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
index d9536cd..55df072 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -91,7 +91,7 @@ conn_request_state(struct drbd_tconn *tconn, union drbd_state mask, union drbd_s
 		   enum chg_state_flags flags);
 
 extern void drbd_resume_al(struct drbd_conf *mdev);
-extern int conn_all_vols_unconf(struct drbd_tconn *tconn);
+extern bool conn_all_vols_unconf(struct drbd_tconn *tconn);
 
 /**
  * drbd_request_state() - Reqest a state change
-- 
1.7.4.1

