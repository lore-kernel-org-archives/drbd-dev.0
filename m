Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri,  2 Sep 2011 12:00:42 +0200
Message-Id: <1314957648-13242-11-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314957648-13242-1-git-send-email-philipp.reisner@linbit.com>
References: <1314957648-13242-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 10/16] drbd: Converted got_Ping() and
	got_PingAck() from mdev to tconn
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
 drivers/block/drbd/drbd_receiver.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 0117dcd..e28f194 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4444,15 +4444,14 @@ static int got_RqSReply(struct drbd_conf *mdev, enum drbd_packet cmd)
 	return true;
 }
 
-static int got_Ping(struct drbd_conf *mdev, enum drbd_packet cmd)
+static int got_Ping(struct drbd_tconn *tconn, enum drbd_packet cmd)
 {
-	return drbd_send_ping_ack(mdev->tconn);
+	return drbd_send_ping_ack(tconn);
 
 }
 
-static int got_PingAck(struct drbd_conf *mdev, enum drbd_packet cmd)
+static int got_PingAck(struct drbd_tconn *tconn, enum drbd_packet cmd)
 {
-	struct drbd_tconn *tconn = mdev->tconn;
 	/* restore idle timeout */
 	tconn->meta.socket->sk->sk_rcvtimeo = tconn->net_conf->ping_int*HZ;
 	if (!test_and_set_bit(GOT_PING_ACK, &tconn->flags))
@@ -4732,8 +4731,8 @@ struct asender_cmd {
 };
 
 static struct asender_cmd asender_tbl[] = {
-	[P_PING]	    = { sizeof(struct p_header), MDEV, { got_Ping } },
-	[P_PING_ACK]	    = { sizeof(struct p_header), MDEV, { got_PingAck } },
+	[P_PING]	    = { sizeof(struct p_header), CONN, { .conn_fn = got_Ping } },
+	[P_PING_ACK]	    = { sizeof(struct p_header), CONN, { .conn_fn = got_PingAck } },
 	[P_RECV_ACK]	    = { sizeof(struct p_block_ack), MDEV, { got_BlockAck } },
 	[P_WRITE_ACK]	    = { sizeof(struct p_block_ack), MDEV, { got_BlockAck } },
 	[P_RS_WRITE_ACK]    = { sizeof(struct p_block_ack), MDEV, { got_BlockAck } },
-- 
1.7.4.1

