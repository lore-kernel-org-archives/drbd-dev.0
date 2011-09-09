Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri,  9 Sep 2011 13:17:28 +0200
Message-Id: <1315567056-32314-4-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315567056-32314-1-git-send-email-philipp.reisner@linbit.com>
References: <1315567056-32314-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/11] drbd: Moved susp,
	susp_nod and susp_fen to the connection object
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
 drivers/block/drbd/drbd_int.h   |   10 +++++++++-
 drivers/block/drbd/drbd_state.c |    3 +++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 4d17f9b..e33a770 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -862,6 +862,9 @@ struct drbd_tconn {			/* is a resource from the config file */
 	struct list_head all_tconn;	/* linked on global drbd_tconns */
 	struct idr volumes;		/* <tconn, vnr> to mdev mapping */
 	enum drbd_conns cstate;		/* Only C_STANDALONE to C_WF_REPORT_PARAMS */
+	unsigned susp:1;		/* IO suspended by user */
+	unsigned susp_nod:1;		/* IO suspended because no data */
+	unsigned susp_fen:1;		/* IO suspended because fence peer handler runs */
 	struct mutex cstate_mutex;	/* Protects graceful disconnects */
 
 	unsigned long flags;
@@ -1687,6 +1690,9 @@ static inline union drbd_state drbd_read_state(struct drbd_conf *mdev)
 	union drbd_state rv;
 
 	rv = mdev->state;
+	rv.susp = mdev->tconn->susp;
+	rv.susp_nod = mdev->tconn->susp_nod;
+	rv.susp_fen = mdev->tconn->susp_fen;
 
 	return rv;
 }
@@ -2219,7 +2225,9 @@ static inline int drbd_state_is_stable(struct drbd_conf *mdev)
 
 static inline int drbd_suspended(struct drbd_conf *mdev)
 {
-	return mdev->state.susp || mdev->state.susp_nod || mdev->state.susp_fen;
+	struct drbd_tconn *tconn = mdev->tconn;
+
+	return tconn->susp || tconn->susp_fen || tconn->susp_nod;
 }
 
 static inline bool may_inc_ap_bio(struct drbd_conf *mdev)
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index c9d9640..9354006 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -843,6 +843,9 @@ __drbd_set_state(struct drbd_conf *mdev, union drbd_state ns,
 		atomic_inc(&mdev->local_cnt);
 
 	mdev->state = ns;
+	mdev->tconn->susp = ns.susp;
+	mdev->tconn->susp_nod = ns.susp_nod;
+	mdev->tconn->susp_fen = ns.susp_fen;
 
 	/* solve the race between becoming unconfigured,
 	 * worker doing the cleanup, and
-- 
1.7.4.1

