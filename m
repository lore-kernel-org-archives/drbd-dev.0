Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri,  2 Sep 2011 12:00:41 +0200
Message-Id: <1314957648-13242-10-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314957648-13242-1-git-send-email-philipp.reisner@linbit.com>
References: <1314957648-13242-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/16] drbd: Allow packet handler functions that
	take a connection (meta connection)
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
 drivers/block/drbd/drbd_receiver.c |   66 ++++++++++++++++++++++-------------
 1 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 7e25a80..0117dcd 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -60,6 +60,11 @@ enum finish_epoch {
 	FE_RECYCLED,
 };
 
+enum mdev_or_conn {
+	MDEV,
+	CONN,
+};
+
 static int drbd_do_handshake(struct drbd_tconn *tconn);
 static int drbd_do_auth(struct drbd_tconn *tconn);
 static int drbd_disconnected(int vnr, void *p, void *data);
@@ -3879,10 +3884,7 @@ static int receive_out_of_sync(struct drbd_conf *mdev, enum drbd_packet cmd,
 struct data_cmd {
 	int expect_payload;
 	size_t pkt_size;
-	enum {
-		MDEV,
-		CONN,
-	} type;
+	enum mdev_or_conn fa_type; /* first argument's type */
 	union {
 		int (*mdev_fn)(struct drbd_conf *, enum drbd_packet cmd,
 				  unsigned int to_receive);
@@ -3957,7 +3959,7 @@ static void drbdd(struct drbd_tconn *tconn)
 			}
 		}
 
-		if (drbd_cmd_handler[pi.cmd].type == CONN) {
+		if (drbd_cmd_handler[pi.cmd].fa_type == CONN) {
 			rv = drbd_cmd_handler[pi.cmd].conn_fn(tconn, pi.cmd, pi.size - shs);
 		} else {
 			struct drbd_conf *mdev = vnr_to_mdev(tconn, pi.vnr);
@@ -4722,27 +4724,31 @@ static int tconn_process_done_ee(struct drbd_tconn *tconn)
 
 struct asender_cmd {
 	size_t pkt_size;
-	int (*process)(struct drbd_conf *, enum drbd_packet);
+	enum mdev_or_conn fa_type; /* first argument's type */
+	union {
+		int (*mdev_fn)(struct drbd_conf *mdev, enum drbd_packet cmd);
+		int (*conn_fn)(struct drbd_tconn *tconn, enum drbd_packet cmd);
+	};
 };
 
 static struct asender_cmd asender_tbl[] = {
-	[P_PING]	    = { sizeof(struct p_header), got_Ping },
-	[P_PING_ACK]	    = { sizeof(struct p_header), got_PingAck },
-	[P_RECV_ACK]	    = { sizeof(struct p_block_ack), got_BlockAck },
-	[P_WRITE_ACK]	    = { sizeof(struct p_block_ack), got_BlockAck },
-	[P_RS_WRITE_ACK]    = { sizeof(struct p_block_ack), got_BlockAck },
-	[P_DISCARD_WRITE]   = { sizeof(struct p_block_ack), got_BlockAck },
-	[P_NEG_ACK]	    = { sizeof(struct p_block_ack), got_NegAck },
-	[P_NEG_DREPLY]	    = { sizeof(struct p_block_ack), got_NegDReply },
-	[P_NEG_RS_DREPLY]   = { sizeof(struct p_block_ack), got_NegRSDReply},
-	[P_OV_RESULT]	    = { sizeof(struct p_block_ack), got_OVResult },
-	[P_BARRIER_ACK]	    = { sizeof(struct p_barrier_ack), got_BarrierAck },
-	[P_STATE_CHG_REPLY] = { sizeof(struct p_req_state_reply), got_RqSReply },
-	[P_RS_IS_IN_SYNC]   = { sizeof(struct p_block_ack), got_IsInSync },
-	[P_DELAY_PROBE]     = { sizeof(struct p_delay_probe93), got_skip },
-	[P_RS_CANCEL]       = { sizeof(struct p_block_ack), got_NegRSDReply},
-	[P_CONN_ST_CHG_REPLY]={ sizeof(struct p_req_state_reply), got_RqSReply },
-	[P_RETRY_WRITE]	    = { sizeof(struct p_block_ack), got_BlockAck },
+	[P_PING]	    = { sizeof(struct p_header), MDEV, { got_Ping } },
+	[P_PING_ACK]	    = { sizeof(struct p_header), MDEV, { got_PingAck } },
+	[P_RECV_ACK]	    = { sizeof(struct p_block_ack), MDEV, { got_BlockAck } },
+	[P_WRITE_ACK]	    = { sizeof(struct p_block_ack), MDEV, { got_BlockAck } },
+	[P_RS_WRITE_ACK]    = { sizeof(struct p_block_ack), MDEV, { got_BlockAck } },
+	[P_DISCARD_WRITE]   = { sizeof(struct p_block_ack), MDEV, { got_BlockAck } },
+	[P_NEG_ACK]	    = { sizeof(struct p_block_ack), MDEV, { got_NegAck } },
+	[P_NEG_DREPLY]	    = { sizeof(struct p_block_ack), MDEV, { got_NegDReply } },
+	[P_NEG_RS_DREPLY]   = { sizeof(struct p_block_ack), MDEV, { got_NegRSDReply } },
+	[P_OV_RESULT]	    = { sizeof(struct p_block_ack), MDEV, { got_OVResult } },
+	[P_BARRIER_ACK]	    = { sizeof(struct p_barrier_ack), MDEV, { got_BarrierAck } },
+	[P_STATE_CHG_REPLY] = { sizeof(struct p_req_state_reply), MDEV, { got_RqSReply } },
+	[P_RS_IS_IN_SYNC]   = { sizeof(struct p_block_ack), MDEV, { got_IsInSync } },
+	[P_DELAY_PROBE]     = { sizeof(struct p_delay_probe93), MDEV, { got_skip } },
+	[P_RS_CANCEL]       = { sizeof(struct p_block_ack), MDEV, { got_NegRSDReply } },
+	[P_CONN_ST_CHG_REPLY]={ sizeof(struct p_req_state_reply), MDEV, { got_RqSReply } },
+	[P_RETRY_WRITE]	    = { sizeof(struct p_block_ack), MDEV, { got_BlockAck } },
 };
 
 int drbd_asender(struct drbd_thread *thi)
@@ -4845,10 +4851,20 @@ int drbd_asender(struct drbd_thread *thi)
 			}
 		}
 		if (received == expect) {
-			tconn->last_received = jiffies;
-			if (!cmd->process(vnr_to_mdev(tconn, pi.vnr), pi.cmd))
+			bool rv;
+
+			if (cmd->fa_type == CONN) {
+				rv = cmd->conn_fn(tconn, pi.cmd);
+			} else {
+				struct drbd_conf *mdev = vnr_to_mdev(tconn, pi.vnr);
+				rv = cmd->mdev_fn(mdev, pi.cmd);
+			}
+
+			if (!rv)
 				goto reconnect;
 
+			tconn->last_received = jiffies;
+
 			/* the idle_timeout (ping-int)
 			 * has been restored in got_PingAck() */
 			if (cmd == &asender_tbl[P_PING_ACK])
-- 
1.7.4.1

