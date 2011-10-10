Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 10 Oct 2011 13:54:56 +0200
Message-Id: <1318247706-7732-4-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1318247706-7732-1-git-send-email-philipp.reisner@linbit.com>
References: <1318247706-7732-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/13] drbd: Made cmp_after_sb() more generic
	into convert_after_sb()
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
 drivers/block/drbd/drbd_receiver.c |   25 +++++++++----------------
 1 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 7deade1..b5eeb8d 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2984,25 +2984,18 @@ static enum drbd_conns drbd_sync_handshake(struct drbd_conf *mdev, enum drbd_rol
 	return rv;
 }
 
-/* returns 1 if invalid */
-static int cmp_after_sb(enum drbd_after_sb_p peer, enum drbd_after_sb_p self)
+static enum drbd_after_sb_p convert_after_sb(enum drbd_after_sb_p peer)
 {
 	/* ASB_DISCARD_REMOTE - ASB_DISCARD_LOCAL is valid */
-	if ((peer == ASB_DISCARD_REMOTE && self == ASB_DISCARD_LOCAL) ||
-	    (self == ASB_DISCARD_REMOTE && peer == ASB_DISCARD_LOCAL))
-		return 0;
+	if (peer == ASB_DISCARD_REMOTE)
+		return ASB_DISCARD_LOCAL;
 
 	/* any other things with ASB_DISCARD_REMOTE or ASB_DISCARD_LOCAL are invalid */
-	if (peer == ASB_DISCARD_REMOTE || peer == ASB_DISCARD_LOCAL ||
-	    self == ASB_DISCARD_REMOTE || self == ASB_DISCARD_LOCAL)
-		return 1;
+	if (peer == ASB_DISCARD_LOCAL)
+		return ASB_DISCARD_REMOTE;
 
 	/* everything else is valid if they are equal on both sides. */
-	if (peer == self)
-		return 0;
-
-	/* everything es is invalid. */
-	return 1;
+	return peer;
 }
 
 static int receive_protocol(struct drbd_tconn *tconn, struct packet_info *pi)
@@ -3060,17 +3053,17 @@ static int receive_protocol(struct drbd_tconn *tconn, struct packet_info *pi)
 		goto disconnect_rcu_unlock;
 	}
 
-	if (cmp_after_sb(p_after_sb_0p, nc->after_sb_0p)) {
+	if (convert_after_sb(p_after_sb_0p) != nc->after_sb_0p) {
 		conn_err(tconn, "incompatible after-sb-0pri settings\n");
 		goto disconnect_rcu_unlock;
 	}
 
-	if (cmp_after_sb(p_after_sb_1p, nc->after_sb_1p)) {
+	if (convert_after_sb(p_after_sb_1p) != nc->after_sb_1p) {
 		conn_err(tconn, "incompatible after-sb-1pri settings\n");
 		goto disconnect_rcu_unlock;
 	}
 
-	if (cmp_after_sb(p_after_sb_2p, nc->after_sb_2p)) {
+	if (convert_after_sb(p_after_sb_2p) != nc->after_sb_2p) {
 		conn_err(tconn, "incompatible after-sb-2pri settings\n");
 		goto disconnect_rcu_unlock;
 	}
-- 
1.7.4.1

