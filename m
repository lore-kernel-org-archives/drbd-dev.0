Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu,  8 Sep 2011 14:45:31 +0200
Message-Id: <1315485937-18989-11-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315485937-18989-1-git-send-email-philipp.reisner@linbit.com>
References: <1315485937-18989-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 10/16] drbd: Change how the initial packets are
	called
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

The first packets exchanged when a connection is established are
referred to as P_HAND_SHAKE_S and P_HAND_SHAKE_M in the code, followed
by P_HAND_SHAKE packets.  To avoid confusion between these two unrelated
things, call the initial packets P_INITIAL_DATA and P_INITIAL_META.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h      |    4 ++--
 drivers/block/drbd/drbd_main.c     |    8 ++++----
 drivers/block/drbd/drbd_receiver.c |    8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 4ee6fc5..33cc132 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -232,8 +232,8 @@ enum drbd_packet {
 
 	/* special command ids for handshake */
 
-	P_HAND_SHAKE_M	      = 0xfff1, /* First Packet on the MetaSock */
-	P_HAND_SHAKE_S	      = 0xfff2, /* First Packet on the Socket */
+	P_INITIAL_META	      = 0xfff1, /* First Packet on the MetaSock */
+	P_INITIAL_DATA	      = 0xfff2, /* First Packet on the Socket */
 
 	P_HAND_SHAKE	      = 0xfffe	/* FIXED for the next century! */
 };
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 05960ab..3df84ad 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3147,10 +3147,10 @@ const char *cmdname(enum drbd_packet cmd)
 		[P_RETRY_WRITE]		= "RetryWrite",
 	};
 
-	if (cmd == P_HAND_SHAKE_M)
-		return "HandShakeM";
-	if (cmd == P_HAND_SHAKE_S)
-		return "HandShakeS";
+	if (cmd == P_INITIAL_META)
+		return "InitialMeta";
+	if (cmd == P_INITIAL_DATA)
+		return "InitialData";
 	if (cmd == P_HAND_SHAKE)
 		return "HandShake";
 	if (cmd >= ARRAY_SIZE(cmdnames))
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 80d85af..865c6e9 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -833,10 +833,10 @@ static int drbd_connect(struct drbd_tconn *tconn)
 		if (s) {
 			if (!tconn->data.socket) {
 				tconn->data.socket = s;
-				drbd_send_fp(tconn, &tconn->data, P_HAND_SHAKE_S);
+				drbd_send_fp(tconn, &tconn->data, P_INITIAL_DATA);
 			} else if (!tconn->meta.socket) {
 				tconn->meta.socket = s;
-				drbd_send_fp(tconn, &tconn->meta, P_HAND_SHAKE_M);
+				drbd_send_fp(tconn, &tconn->meta, P_INITIAL_META);
 			} else {
 				conn_err(tconn, "Logic error in drbd_connect()\n");
 				goto out_release_sockets;
@@ -858,14 +858,14 @@ retry:
 			drbd_socket_okay(&tconn->data.socket);
 			drbd_socket_okay(&tconn->meta.socket);
 			switch (try) {
-			case P_HAND_SHAKE_S:
+			case P_INITIAL_DATA:
 				if (tconn->data.socket) {
 					conn_warn(tconn, "initial packet S crossed\n");
 					sock_release(tconn->data.socket);
 				}
 				tconn->data.socket = s;
 				break;
-			case P_HAND_SHAKE_M:
+			case P_INITIAL_META:
 				if (tconn->meta.socket) {
 					conn_warn(tconn, "initial packet M crossed\n");
 					sock_release(tconn->meta.socket);
-- 
1.7.4.1

