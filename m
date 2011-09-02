Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri,  2 Sep 2011 12:00:37 +0200
Message-Id: <1314957648-13242-6-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314957648-13242-1-git-send-email-philipp.reisner@linbit.com>
References: <1314957648-13242-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/16] drbd: Moved CONN_DRY_RUN to the per
	connection (tconn) flags
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
 drivers/block/drbd/drbd_int.h      |    2 +-
 drivers/block/drbd/drbd_receiver.c |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 05bb9fd..99b34f9 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -791,7 +791,6 @@ enum {
 	RESYNC_AFTER_NEG,       /* Resync after online grow after the attach&negotiate finished. */
 	RESIZE_PENDING,		/* Size change detected locally, waiting for the response from
 				 * the peer, if it changed there as well. */
-	CONN_DRY_RUN,		/* Expect disconnect after resync handshake. */
 	NEW_CUR_UUID,		/* Create new current UUID when thawing IO */
 	AL_SUSPENDED,		/* Activity logging is currently suspended. */
 	AHEAD_TO_SYNC_SOURCE,   /* Ahead -> SyncSource queued */
@@ -915,6 +914,7 @@ enum {
 				 * but worker thread is still handling the cleanup.
 				 * reconfiguring (nl_disk_conf, nl_net_conf) is dissalowed,
 				 * while this is set. */
+	CONN_DRY_RUN,		/* Expect disconnect after resync handshake. */
 };
 
 struct drbd_tconn {			/* is a resource from the config file */
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index f239902..7bb5e5c 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2803,7 +2803,7 @@ static enum drbd_conns drbd_sync_handshake(struct drbd_conf *mdev, enum drbd_rol
 		}
 	}
 
-	if (mdev->tconn->net_conf->dry_run || test_bit(CONN_DRY_RUN, &mdev->flags)) {
+	if (mdev->tconn->net_conf->dry_run || test_bit(CONN_DRY_RUN, &mdev->tconn->flags)) {
 		if (hg == 0)
 			dev_info(DEV, "dry-run connect: No resync, would become Connected immediately.\n");
 		else
@@ -2872,10 +2872,10 @@ static int receive_protocol(struct drbd_conf *mdev, enum drbd_packet cmd,
 	cf		= be32_to_cpu(p->conn_flags);
 	p_want_lose = cf & CF_WANT_LOSE;
 
-	clear_bit(CONN_DRY_RUN, &mdev->flags);
+	clear_bit(CONN_DRY_RUN, &mdev->tconn->flags);
 
 	if (cf & CF_DRY_RUN)
-		set_bit(CONN_DRY_RUN, &mdev->flags);
+		set_bit(CONN_DRY_RUN, &mdev->tconn->flags);
 
 	if (p_proto != mdev->tconn->net_conf->wire_protocol) {
 		dev_err(DEV, "incompatible communication protocols\n");
@@ -3442,7 +3442,7 @@ static int receive_state(struct drbd_conf *mdev, enum drbd_packet cmd,
 				peer_state.disk = D_DISKLESS;
 				real_peer_disk = D_DISKLESS;
 			} else {
-				if (test_and_clear_bit(CONN_DRY_RUN, &mdev->flags))
+				if (test_and_clear_bit(CONN_DRY_RUN, &mdev->tconn->flags))
 					return false;
 				D_ASSERT(os.conn == C_WF_REPORT_PARAMS);
 				conn_request_state(mdev->tconn, NS(conn, C_DISCONNECTING), CS_HARD);
-- 
1.7.4.1

