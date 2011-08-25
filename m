Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:08:47 +0200
Message-Id: <1314284934-17999-112-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 111/118] drbd: Removed drbd_state_lock() and
	drbd_state_unlock()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

The lock they constructed is only taken when the state_mutex
was already taken. It is superficial.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h      |   18 ------------------
 drivers/block/drbd/drbd_receiver.c |    5 +++--
 drivers/block/drbd/drbd_state.c    |    4 ----
 drivers/block/drbd/drbd_worker.c   |   10 +++++-----
 4 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 0ea0b15..d5e45c2 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -763,7 +763,6 @@ enum {
 	UNPLUG_REMOTE,		/* sending a "UnplugRemote" could help */
 	MD_DIRTY,		/* current uuids and flags not yet on disk */
 	USE_DEGR_WFC_T,		/* degr-wfc-timeout instead of wfc-timeout. */
-	CLUSTER_ST_CHANGE,	/* Cluster wide state change going on... */
 	CL_ST_CHG_SUCCESS,
 	CL_ST_CHG_FAIL,
 	CRASHED_PRIMARY,	/* This node was a crashed primary.
@@ -1663,23 +1662,6 @@ static inline int drbd_ee_has_active_page(struct drbd_peer_request *peer_req)
 	return 0;
 }
 
-
-
-
-
-
-static inline void drbd_state_lock(struct drbd_conf *mdev)
-{
-	wait_event(mdev->misc_wait,
-		   !test_and_set_bit(CLUSTER_ST_CHANGE, &mdev->flags));
-}
-
-static inline void drbd_state_unlock(struct drbd_conf *mdev)
-{
-	clear_bit(CLUSTER_ST_CHANGE, &mdev->flags);
-	wake_up(&mdev->misc_wait);
-}
-
 static inline enum drbd_state_rv
 _drbd_set_state(struct drbd_conf *mdev, union drbd_state ns,
 		enum chg_state_flags flags, struct completion *done)
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index f755134..6a30180 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3170,7 +3170,8 @@ static int receive_uuids(struct drbd_conf *mdev, enum drbd_packet cmd,
 	   ongoing cluster wide state change is finished. That is important if
 	   we are primary and are detaching from our disk. We need to see the
 	   new disk state... */
-	wait_event(mdev->misc_wait, !test_bit(CLUSTER_ST_CHANGE, &mdev->flags));
+	mutex_lock(&mdev->state_mutex);
+	mutex_unlock(&mdev->state_mutex);
 	if (mdev->state.conn >= C_CONNECTED && mdev->state.disk < D_INCONSISTENT)
 		updated_uuids |= drbd_set_ed_uuid(mdev, p_uuid[UI_CURRENT]);
 
@@ -3221,7 +3222,7 @@ static int receive_req_state(struct drbd_conf *mdev, enum drbd_packet cmd,
 	val.i = be32_to_cpu(p->val);
 
 	if (test_bit(DISCARD_CONCURRENT, &mdev->tconn->flags) &&
-	    test_bit(CLUSTER_ST_CHANGE, &mdev->flags)) {
+	    mutex_is_locked(&mdev->state_mutex)) {
 		drbd_send_sr_reply(mdev, SS_CONCURRENT_ST_CHG);
 		return true;
 	}
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 405ed12..bb05d67 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -184,9 +184,7 @@ drbd_req_state(struct drbd_conf *mdev, union drbd_state mask,
 			goto abort;
 		}
 
-		drbd_state_lock(mdev);
 		if (!drbd_send_state_req(mdev, mask, val)) {
-			drbd_state_unlock(mdev);
 			rv = SS_CW_FAILED_BY_PEER;
 			if (f & CS_VERBOSE)
 				print_st_err(mdev, os, ns, rv);
@@ -197,7 +195,6 @@ drbd_req_state(struct drbd_conf *mdev, union drbd_state mask,
 			(rv = _req_st_cond(mdev, mask, val)));
 
 		if (rv < SS_SUCCESS) {
-			drbd_state_unlock(mdev);
 			if (f & CS_VERBOSE)
 				print_st_err(mdev, os, ns, rv);
 			goto abort;
@@ -205,7 +202,6 @@ drbd_req_state(struct drbd_conf *mdev, union drbd_state mask,
 		spin_lock_irqsave(&mdev->tconn->req_lock, flags);
 		ns = apply_mask_val(mdev->state, mask, val);
 		rv = _drbd_set_state(mdev, ns, f, &done);
-		drbd_state_unlock(mdev);
 	} else {
 		rv = _drbd_set_state(mdev, ns, f, &done);
 	}
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index eee017d..e844871 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1536,21 +1536,21 @@ void drbd_start_resync(struct drbd_conf *mdev, enum drbd_conns side)
 	}
 
 	if (current == mdev->tconn->worker.task) {
-		/* The worker should not sleep waiting for drbd_state_lock(),
+		/* The worker should not sleep waiting for state_mutex,
 		   that can take long */
-		if (test_and_set_bit(CLUSTER_ST_CHANGE, &mdev->flags)) {
+		if (!mutex_trylock(&mdev->state_mutex)) {
 			set_bit(B_RS_H_DONE, &mdev->flags);
 			mdev->start_resync_timer.expires = jiffies + HZ/5;
 			add_timer(&mdev->start_resync_timer);
 			return;
 		}
 	} else {
-		drbd_state_lock(mdev);
+		mutex_lock(&mdev->state_mutex);
 	}
 	clear_bit(B_RS_H_DONE, &mdev->flags);
 
 	if (!get_ldev_if_state(mdev, D_NEGOTIATING)) {
-		drbd_state_unlock(mdev);
+		mutex_unlock(&mdev->state_mutex);
 		return;
 	}
 
@@ -1639,7 +1639,7 @@ void drbd_start_resync(struct drbd_conf *mdev, enum drbd_conns side)
 		drbd_md_sync(mdev);
 	}
 	put_ldev(mdev);
-	drbd_state_unlock(mdev);
+	mutex_unlock(&mdev->state_mutex);
 }
 
 static int _worker_dying(int vnr, void *p, void *data)
-- 
1.7.4.1

