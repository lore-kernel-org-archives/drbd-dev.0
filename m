Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri,  9 Sep 2011 13:17:30 +0200
Message-Id: <1315567056-32314-6-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315567056-32314-1-git-send-email-philipp.reisner@linbit.com>
References: <1315567056-32314-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/11] drbd: Renamed nms to ns_max
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
 drivers/block/drbd/drbd_state.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 64284b8..bd50644 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1340,7 +1340,7 @@ static void after_state_ch(struct drbd_conf *mdev, union drbd_state os,
 struct after_conn_state_chg_work {
 	struct drbd_work w;
 	enum drbd_conns oc;
-	union drbd_state nms; /* new, max state, over all mdevs */
+	union drbd_state ns_max; /* new, max state, over all mdevs */
 	enum chg_state_flags flags;
 };
 
@@ -1358,12 +1358,12 @@ static int w_after_conn_state_ch(struct drbd_work *w, int unused)
 		container_of(w, struct after_conn_state_chg_work, w);
 	struct drbd_tconn *tconn = w->tconn;
 	enum drbd_conns oc = acscw->oc;
-	union drbd_state nms = acscw->nms;
+	union drbd_state ns_max = acscw->ns_max;
 
 	kfree(acscw);
 
 	/* Upon network configuration, we need to start the receiver */
-	if (oc == C_STANDALONE && nms.conn == C_UNCONNECTED)
+	if (oc == C_STANDALONE && ns_max.conn == C_UNCONNECTED)
 		drbd_thread_start(&tconn->receiver);
 
 	//conn_err(tconn, STATE_FMT, STATE_ARGS("nms", nms));
@@ -1541,7 +1541,7 @@ _conn_request_state(struct drbd_tconn *tconn, union drbd_state mask, union drbd_
 	enum drbd_state_rv rv = SS_SUCCESS;
 	struct after_conn_state_chg_work *acscw;
 	enum drbd_conns oc = tconn->cstate;
-	union drbd_state ms, os;
+	union drbd_state ns_max, os;
 
 	rv = is_valid_conn_transition(oc, val.conn);
 	if (rv < SS_SUCCESS)
@@ -1558,14 +1558,14 @@ _conn_request_state(struct drbd_tconn *tconn, union drbd_state mask, union drbd_
 	}
 
 	conn_old_common_state(tconn, &os, &flags);
-	ms = conn_set_state(tconn, mask, val, flags);
-	ms.conn = val.conn;
-	conn_pr_state_change(tconn, os, ms, flags);
+	ns_max = conn_set_state(tconn, mask, val, flags);
+	ns_max.conn = val.conn;
+	conn_pr_state_change(tconn, os, ns_max, flags);
 
 	acscw = kmalloc(sizeof(*acscw), GFP_ATOMIC);
 	if (acscw) {
 		acscw->oc = os.conn;
-		acscw->nms = ms;
+		acscw->ns_max = ns_max;
 		acscw->flags = flags;
 		acscw->w.cb = w_after_conn_state_ch;
 		acscw->w.tconn = tconn;
-- 
1.7.4.1

