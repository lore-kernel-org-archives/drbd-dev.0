Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri, 23 Sep 2011 16:31:16 +0200
Message-Id: <1316788285-17433-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1316788285-17433-1-git-send-email-philipp.reisner@linbit.com>
References: <1316788285-17433-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/10] drbd: drbd_send_ping(),
	drbd_send_ping(): Return 0 upon success and an error code otherwise
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
 drivers/block/drbd/drbd_main.c     |    4 ++--
 drivers/block/drbd/drbd_receiver.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index a6459f7..7d7b30c 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -768,13 +768,13 @@ int conn_send_cmd2(struct drbd_tconn *tconn, enum drbd_packet cmd, char *data,
 int drbd_send_ping(struct drbd_tconn *tconn)
 {
 	struct p_header h;
-	return !conn_send_cmd(tconn, 0, &tconn->meta, P_PING, &h, sizeof(h));
+	return conn_send_cmd(tconn, 0, &tconn->meta, P_PING, &h, sizeof(h));
 }
 
 int drbd_send_ping_ack(struct drbd_tconn *tconn)
 {
 	struct p_header h;
-	return !conn_send_cmd(tconn, 0, &tconn->meta, P_PING_ACK, &h, sizeof(h));
+	return conn_send_cmd(tconn, 0, &tconn->meta, P_PING_ACK, &h, sizeof(h));
 }
 
 int drbd_send_sync_param(struct drbd_conf *mdev)
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 6e6b829..6879082 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4501,7 +4501,7 @@ static int got_RqSReply(struct drbd_tconn *tconn, struct packet_info *pi)
 
 static int got_Ping(struct drbd_tconn *tconn, struct packet_info *pi)
 {
-	return drbd_send_ping_ack(tconn);
+	return !drbd_send_ping_ack(tconn);
 
 }
 
@@ -4854,7 +4854,7 @@ int drbd_asender(struct drbd_thread *thi)
 	while (get_t_state(thi) == RUNNING) {
 		drbd_thread_current_set_cpu(thi);
 		if (test_and_clear_bit(SEND_PING, &tconn->flags)) {
-			if (!drbd_send_ping(tconn)) {
+			if (drbd_send_ping(tconn)) {
 				conn_err(tconn, "drbd_send_ping has failed\n");
 				goto reconnect;
 			}
-- 
1.7.4.1

