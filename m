Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed,  7 Sep 2011 16:17:30 +0200
Message-Id: <1315405061-1473-4-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315405061-1473-1-git-send-email-philipp.reisner@linbit.com>
References: <1315405061-1473-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/14] drbd: Move drbd_send_ping() and
	drbd_send_ping_ack() to drbd_main.c
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
 drivers/block/drbd/drbd_int.h  |   13 ++-----------
 drivers/block/drbd/drbd_main.c |   12 ++++++++++++
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 72df107..1aec096 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1939,17 +1939,8 @@ static inline int drbd_send_short_cmd(struct drbd_conf *mdev,
 	return drbd_send_cmd(mdev, &mdev->tconn->data, cmd, &h, sizeof(h));
 }
 
-static inline int drbd_send_ping(struct drbd_tconn *tconn)
-{
-	struct p_header h;
-	return !conn_send_cmd(tconn, 0, &tconn->meta, P_PING, &h, sizeof(h));
-}
-
-static inline int drbd_send_ping_ack(struct drbd_tconn *tconn)
-{
-	struct p_header h;
-	return !conn_send_cmd(tconn, 0, &tconn->meta, P_PING_ACK, &h, sizeof(h));
-}
+extern int drbd_send_ping(struct drbd_tconn *tconn);
+extern int drbd_send_ping_ack(struct drbd_tconn *tconn);
 
 static inline int drbd_send_state_req(struct drbd_conf *mdev,
 				      union drbd_state mask, union drbd_state val)
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 0028b60ca..34627ae 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -765,6 +765,18 @@ int conn_send_cmd2(struct drbd_tconn *tconn, enum drbd_packet cmd, char *data,
 	return err;
 }
 
+int drbd_send_ping(struct drbd_tconn *tconn)
+{
+	struct p_header h;
+	return !conn_send_cmd(tconn, 0, &tconn->meta, P_PING, &h, sizeof(h));
+}
+
+int drbd_send_ping_ack(struct drbd_tconn *tconn)
+{
+	struct p_header h;
+	return !conn_send_cmd(tconn, 0, &tconn->meta, P_PING_ACK, &h, sizeof(h));
+}
+
 int drbd_send_sync_param(struct drbd_conf *mdev)
 {
 	struct p_rs_param_95 *p;
-- 
1.7.4.1

