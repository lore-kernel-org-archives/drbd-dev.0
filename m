Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:08:45 +0200
Message-Id: <1314284934-17999-110-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 109/118] drbd: Code de-duplication;
	new function apply_mask_val()
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
 drivers/block/drbd/drbd_state.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 02516ed..0100aab 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -69,17 +69,24 @@ static int cl_wide_st_chg(struct drbd_conf *mdev,
 		(os.conn == C_CONNECTED && ns.conn == C_VERIFY_S);
 }
 
+static union drbd_state
+apply_mask_val(union drbd_state os, union drbd_state mask, union drbd_state val)
+{
+	union drbd_state ns;
+	ns.i = (os.i & ~mask.i) | val.i;
+	return ns;
+}
+
 enum drbd_state_rv
 drbd_change_state(struct drbd_conf *mdev, enum chg_state_flags f,
 		  union drbd_state mask, union drbd_state val)
 {
 	unsigned long flags;
-	union drbd_state os, ns;
+	union drbd_state ns;
 	enum drbd_state_rv rv;
 
 	spin_lock_irqsave(&mdev->tconn->req_lock, flags);
-	os = mdev->state;
-	ns.i = (os.i & ~mask.i) | val.i;
+	ns = apply_mask_val(mdev->state, mask, val);
 	rv = _drbd_set_state(mdev, ns, f, NULL);
 	ns = mdev->state;
 	spin_unlock_irqrestore(&mdev->tconn->req_lock, flags);
@@ -115,8 +122,7 @@ _req_st_cond(struct drbd_conf *mdev, union drbd_state mask,
 
 	spin_lock_irqsave(&mdev->tconn->req_lock, flags);
 	os = mdev->state;
-	ns.i = (os.i & ~mask.i) | val.i;
-	ns = sanitize_state(mdev, ns, NULL);
+	ns = sanitize_state(mdev, apply_mask_val(os, mask, val), NULL);
 	rv = is_valid_transition(os, ns);
 	if (rv == SS_SUCCESS)
 		rv = SS_UNKNOWN_ERROR;  /* cont waiting, otherwise fail. */
@@ -162,8 +168,7 @@ drbd_req_state(struct drbd_conf *mdev, union drbd_state mask,
 
 	spin_lock_irqsave(&mdev->tconn->req_lock, flags);
 	os = mdev->state;
-	ns.i = (os.i & ~mask.i) | val.i;
-	ns = sanitize_state(mdev, ns, NULL);
+	ns = sanitize_state(mdev, apply_mask_val(os, mask, val), NULL);
 	rv = is_valid_transition(os, ns);
 	if (rv < SS_SUCCESS)
 		goto abort;
@@ -199,8 +204,7 @@ drbd_req_state(struct drbd_conf *mdev, union drbd_state mask,
 			goto abort;
 		}
 		spin_lock_irqsave(&mdev->tconn->req_lock, flags);
-		os = mdev->state;
-		ns.i = (os.i & ~mask.i) | val.i;
+		ns = apply_mask_val(mdev->state, mask, val);
 		rv = _drbd_set_state(mdev, ns, f, &done);
 		drbd_state_unlock(mdev);
 	} else {
-- 
1.7.4.1

