Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  5 Sep 2011 13:45:22 +0200
Message-Id: <1315223145-20640-32-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
References: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 31/54] drbd: drbd_send_block(): Return 0 upon
	success and an error code otherwise
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_main.c   |   23 ++++++++++++-----------
 drivers/block/drbd/drbd_worker.c |    6 +++---
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 1b61727..9b53d86 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1610,7 +1610,7 @@ int drbd_send_dblock(struct drbd_conf *mdev, struct drbd_request *req)
 int drbd_send_block(struct drbd_conf *mdev, enum drbd_packet cmd,
 		    struct drbd_peer_request *peer_req)
 {
-	int ok;
+	int err;
 	struct p_data p;
 	void *dgb;
 	int dgs;
@@ -1629,21 +1629,22 @@ int drbd_send_block(struct drbd_conf *mdev, enum drbd_packet cmd,
 	 * This one may be interrupted by DRBD_SIG and/or DRBD_SIGKILL
 	 * in response to admin command or module unload.
 	 */
-	if (drbd_get_data_sock(mdev->tconn))
-		return 0;
-
-	ok = sizeof(p) == drbd_send(mdev->tconn, mdev->tconn->data.socket, &p, sizeof(p), dgs ? MSG_MORE : 0);
-	if (ok && dgs) {
+	err = drbd_get_data_sock(mdev->tconn);
+	if (err)
+		return err;
+	err = drbd_send_all(mdev->tconn, mdev->tconn->data.socket, &p,
+			    sizeof(p), dgs ? MSG_MORE : 0);
+	if (!err && dgs) {
 		dgb = mdev->tconn->int_dig_out;
 		drbd_csum_ee(mdev, mdev->tconn->integrity_w_tfm, peer_req, dgb);
-		ok = dgs == drbd_send(mdev->tconn, mdev->tconn->data.socket, dgb, dgs, 0);
+		err = drbd_send_all(mdev->tconn, mdev->tconn->data.socket, dgb,
+				    dgs, 0);
 	}
-	if (ok)
-		ok = !_drbd_send_zc_ee(mdev, peer_req);
-
+	if (!err)
+		err = _drbd_send_zc_ee(mdev, peer_req);
 	drbd_put_data_sock(mdev->tconn);
 
-	return ok;
+	return err;
 }
 
 int drbd_send_oos(struct drbd_conf *mdev, struct drbd_request *req)
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index a64cb99..2528f3d 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -920,7 +920,7 @@ int w_e_end_data_req(struct drbd_work *w, int cancel)
 	}
 
 	if (likely((peer_req->flags & EE_WAS_ERROR) == 0)) {
-		ok = drbd_send_block(mdev, P_DATA_REPLY, peer_req);
+		ok = !drbd_send_block(mdev, P_DATA_REPLY, peer_req);
 	} else {
 		if (__ratelimit(&drbd_ratelimit_state))
 			dev_err(DEV, "Sending NegDReply. sector=%llus.\n",
@@ -966,7 +966,7 @@ int w_e_end_rsdata_req(struct drbd_work *w, int cancel)
 	} else if (likely((peer_req->flags & EE_WAS_ERROR) == 0)) {
 		if (likely(mdev->state.pdsk >= D_INCONSISTENT)) {
 			inc_rs_pending(mdev);
-			ok = drbd_send_block(mdev, P_RS_DATA_REPLY, peer_req);
+			ok = !drbd_send_block(mdev, P_RS_DATA_REPLY, peer_req);
 		} else {
 			if (__ratelimit(&drbd_ratelimit_state))
 				dev_err(DEV, "Not sending RSDataReply, "
@@ -1040,7 +1040,7 @@ int w_e_end_csum_rs_req(struct drbd_work *w, int cancel)
 			peer_req->block_id = ID_SYNCER; /* By setting block_id, digest pointer becomes invalid! */
 			peer_req->flags &= ~EE_HAS_DIGEST; /* This peer request no longer has a digest pointer */
 			kfree(di);
-			ok = drbd_send_block(mdev, P_RS_DATA_REPLY, peer_req);
+			ok = !drbd_send_block(mdev, P_RS_DATA_REPLY, peer_req);
 		}
 	} else {
 		ok = !drbd_send_ack(mdev, P_NEG_RS_DREPLY, peer_req);
-- 
1.7.4.1

