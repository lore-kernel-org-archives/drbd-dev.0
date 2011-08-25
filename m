Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:08:40 +0200
Message-Id: <1314284934-17999-105-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 104/118] drbd: Extracted after_conn_state_ch()
	out of after_state_ch()
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
 drivers/block/drbd/drbd_state.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index d577715..18feba6 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -45,10 +45,6 @@ static void after_state_ch(struct drbd_conf *mdev, union drbd_state os,
 			   union drbd_state ns, enum chg_state_flags flags);
 static void after_conn_state_ch(struct drbd_tconn *tconn, union drbd_state os,
 				union drbd_state ns, enum chg_state_flags flags);
-static enum drbd_state_rv is_valid_state(struct drbd_conf *, union drbd_state);
-static enum drbd_state_rv is_valid_soft_transition(union drbd_state, union drbd_state);
-static union drbd_state sanitize_state(struct drbd_conf *mdev, union drbd_state os,
-				       union drbd_state ns, const char **warn_sync_abort);
 
 /**
  * cl_wide_st_chg() - true if the state change is a cluster wide one
@@ -98,6 +94,15 @@ void drbd_force_state(struct drbd_conf *mdev,
 	drbd_change_state(mdev, CS_HARD, mask, val);
 }
 
+static enum drbd_state_rv is_valid_state(struct drbd_conf *, union drbd_state);
+static enum drbd_state_rv is_valid_state_transition(struct drbd_conf *,
+						    union drbd_state,
+						    union drbd_state);
+static union drbd_state sanitize_state(struct drbd_conf *mdev, union drbd_state os,
+				       union drbd_state ns, const char **warn_sync_abort);
+int drbd_send_state_req(struct drbd_conf *,
+			union drbd_state, union drbd_state);
+
 static enum drbd_state_rv
 _req_st_cond(struct drbd_conf *mdev, union drbd_state mask,
 	     union drbd_state val)
@@ -123,7 +128,7 @@ _req_st_cond(struct drbd_conf *mdev, union drbd_state mask,
 	if (!rv) {
 		rv = is_valid_state(mdev, ns);
 		if (rv == SS_SUCCESS) {
-			rv = is_valid_soft_transition(os, ns);
+			rv = is_valid_state_transition(mdev, ns, os);
 			if (rv == SS_SUCCESS)
 				rv = SS_UNKNOWN_ERROR; /* cont waiting, otherwise fail. */
 		}
@@ -166,7 +171,7 @@ drbd_req_state(struct drbd_conf *mdev, union drbd_state mask,
 	if (cl_wide_st_chg(mdev, os, ns)) {
 		rv = is_valid_state(mdev, ns);
 		if (rv == SS_SUCCESS)
-			rv = is_valid_soft_transition(os, ns);
+			rv = is_valid_state_transition(mdev, ns, os);
 		spin_unlock_irqrestore(&mdev->tconn->req_lock, flags);
 
 		if (rv < SS_SUCCESS) {
@@ -339,13 +344,14 @@ is_valid_state(struct drbd_conf *mdev, union drbd_state ns)
 }
 
 /**
- * is_valid_soft_transition() - Returns an SS_ error code if the state transition is not possible
+ * is_valid_state_transition() - Returns an SS_ error code if the state transition is not possible
  * @mdev:	DRBD device.
  * @ns:		new state.
  * @os:		old state.
  */
 static enum drbd_state_rv
-is_valid_soft_transition(union drbd_state os, union drbd_state ns)
+is_valid_state_transition(struct drbd_conf *mdev, union drbd_state ns,
+			  union drbd_state os)
 {
 	enum drbd_state_rv rv = SS_SUCCESS;
 
@@ -651,9 +657,9 @@ __drbd_set_state(struct drbd_conf *mdev, union drbd_state ns,
 			   this happen...*/
 
 			if (is_valid_state(mdev, os) == rv)
-				rv = is_valid_soft_transition(os, ns);
+				rv = is_valid_state_transition(mdev, ns, os);
 		} else
-			rv = is_valid_soft_transition(os, ns);
+			rv = is_valid_state_transition(mdev, ns, os);
 	}
 
 	if (rv < SS_SUCCESS) {
-- 
1.7.4.1

