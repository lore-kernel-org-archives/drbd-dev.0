Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  3 Oct 2011 22:58:33 +0200
Message-Id: <1317675513-12745-11-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317675513-12745-1-git-send-email-philipp.reisner@linbit.com>
References: <1317675513-12745-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 10/10] drbd: fix various disconnecting races
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

If an admin requests disconnect at a time when the state handling
already disconnects/reconnects, there have been some races.

Make sure to always really stop the network threads before
returning success for disconnect. Do not pretend successfull
forced disconnect, if the state handling returned an error.

Return success from drbd_adm_down() only after all threads are finished.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c       |   21 ++++++++++++---------
 drivers/block/drbd/drbd_receiver.c |    2 +-
 drivers/block/drbd/drbd_state.c    |   20 +++++++++++++-------
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index c475654..512410c 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -2120,10 +2120,9 @@ static enum drbd_state_rv conn_try_disconnect(struct drbd_tconn *tconn, bool for
 	enum drbd_state_rv rv;
 	if (force) {
 		spin_lock_irq(&tconn->req_lock);
-		if (tconn->cstate >= C_WF_CONNECTION)
-			_conn_request_state(tconn, NS(conn, C_DISCONNECTING), CS_HARD);
+		rv = _conn_request_state(tconn, NS(conn, C_DISCONNECTING), CS_HARD);
 		spin_unlock_irq(&tconn->req_lock);
-		return SS_SUCCESS;
+		return rv;
 	}
 
 	rv = conn_request_state(tconn, NS(conn, C_DISCONNECTING), 0);
@@ -2182,10 +2181,12 @@ int drbd_adm_disconnect(struct sk_buff *skb, struct genl_info *info)
 	if (rv < SS_SUCCESS)
 		goto fail;
 
+	/* No one else can reconfigure the network while I am here.
+	 * The state handling only uses drbd_thread_stop_nowait(),
+	 * we want to really wait here until the receiver is no more. */
+	drbd_thread_stop(&tconn->receiver);
 	if (wait_event_interruptible(tconn->ping_wait,
-				     tconn->cstate != C_DISCONNECTING)) {
-		/* Do not test for mdev->state.conn == C_STANDALONE, since
-		   someone else might connect us in the mean time! */
+				     tconn->cstate == C_STANDALONE)) {
 		retcode = ERR_INTR;
 		goto fail;
 	}
@@ -3093,6 +3094,10 @@ int drbd_adm_down(struct sk_buff *skb, struct genl_info *info)
 		goto out_unlock;
 	}
 
+	/* Make sure the network threads have actually stopped,
+	 * state handling only does drbd_thread_stop_nowait(). */
+	drbd_thread_stop(&adm_ctx.tconn->receiver);
+
 	/* detach */
 	idr_for_each_entry(&adm_ctx.tconn->volumes, mdev, i) {
 		rv = adm_detach(mdev);
@@ -3116,11 +3121,9 @@ int drbd_adm_down(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	/* stop all threads */
-	conn_reconfig_done(adm_ctx.tconn);
-
 	/* delete connection */
 	if (conn_lowest_minor(adm_ctx.tconn) < 0) {
+		drbd_thread_stop(&adm_ctx.tconn->worker);
 		list_del(&adm_ctx.tconn->all_tconn);
 		kref_put(&adm_ctx.tconn->kref, &conn_destroy);
 
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 4665ad7..6da7aeb 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4226,7 +4226,7 @@ static void drbd_disconnect(struct drbd_tconn *tconn)
 		synchronize_rcu();
 		kfree(old_conf);
 
-		conn_request_state(tconn, NS(conn, C_STANDALONE), CS_VERBOSE);
+		conn_request_state(tconn, NS(conn, C_STANDALONE), CS_VERBOSE | CS_HARD);
 	}
 }
 
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 4465be8..231e3fe 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -586,21 +586,27 @@ is_valid_soft_transition(union drbd_state os, union drbd_state ns)
 static enum drbd_state_rv
 is_valid_conn_transition(enum drbd_conns oc, enum drbd_conns nc)
 {
-	enum drbd_state_rv rv = SS_SUCCESS;
+	/* no change -> nothing to do, at least for the connection part */
+	if (oc == nc)
+		return SS_NOTHING_TO_DO;
 
-	/* Disallow Network errors to configure a device's network part */
-	if ((nc >= C_TIMEOUT && nc <= C_TEAR_DOWN) && oc <= C_DISCONNECTING)
-		rv = SS_NEED_CONNECTION;
+	/* disconnect of an unconfigured connection does not make sense */
+	if (oc == C_STANDALONE && nc == C_DISCONNECTING)
+		return SS_ALREADY_STANDALONE;
+
+	/* from C_STANDALONE, we start with C_UNCONNECTED */
+	if (oc == C_STANDALONE && nc != C_UNCONNECTED)
+		return SS_NEED_CONNECTION;
 
 	/* After a network error only C_UNCONNECTED or C_DISCONNECTING may follow. */
 	if (oc >= C_TIMEOUT && oc <= C_TEAR_DOWN && nc != C_UNCONNECTED && nc != C_DISCONNECTING)
-		rv = SS_IN_TRANSIENT_STATE;
+		return SS_IN_TRANSIENT_STATE;
 
 	/* After C_DISCONNECTING only C_STANDALONE may follow */
 	if (oc == C_DISCONNECTING && nc != C_STANDALONE)
-		rv = SS_IN_TRANSIENT_STATE;
+		return SS_IN_TRANSIENT_STATE;
 
-	return rv;
+	return SS_SUCCESS;
 }
 
 
-- 
1.7.4.1

