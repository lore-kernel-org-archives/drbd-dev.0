Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri,  2 Sep 2011 12:00:43 +0200
Message-Id: <1314957648-13242-12-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314957648-13242-1-git-send-email-philipp.reisner@linbit.com>
References: <1314957648-13242-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/16] drbd: Separate connection state changes
	from minor dev state changes #2
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

New function got_conn_RqSReply()

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |   47 ++++++++++++++++++++----------------
 1 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index e28f194..5fd78f4 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4415,32 +4415,37 @@ int drbdd_init(struct drbd_thread *thi)
 
 /* ********* acknowledge sender ******** */
 
+static int got_conn_RqSReply(struct drbd_tconn *tconn, enum drbd_packet cmd)
+{
+	struct p_req_state_reply *p = &tconn->meta.rbuf.req_state_reply;
+	int retcode = be32_to_cpu(p->retcode);
+
+	if (retcode >= SS_SUCCESS) {
+		set_bit(CONN_WD_ST_CHG_OKAY, &tconn->flags);
+	} else {
+		set_bit(CONN_WD_ST_CHG_FAIL, &tconn->flags);
+		conn_err(tconn, "Requested state change failed by peer: %s (%d)\n",
+			 drbd_set_st_err_str(retcode), retcode);
+	}
+	wake_up(&tconn->ping_wait);
+
+	return true;
+}
+
 static int got_RqSReply(struct drbd_conf *mdev, enum drbd_packet cmd)
 {
 	struct p_req_state_reply *p = &mdev->tconn->meta.rbuf.req_state_reply;
-	struct drbd_tconn *tconn = mdev->tconn;
-
 	int retcode = be32_to_cpu(p->retcode);
 
-	if (cmd == P_STATE_CHG_REPLY) {
-		if (retcode >= SS_SUCCESS) {
-			set_bit(CL_ST_CHG_SUCCESS, &mdev->flags);
-		} else {
-			set_bit(CL_ST_CHG_FAIL, &mdev->flags);
-			dev_err(DEV, "Requested state change failed by peer: %s (%d)\n",
-				drbd_set_st_err_str(retcode), retcode);
-		}
-		wake_up(&mdev->state_wait);
-	} else /* conn == P_CONN_ST_CHG_REPLY */ {
-		if (retcode >= SS_SUCCESS) {
-			set_bit(CONN_WD_ST_CHG_OKAY, &tconn->flags);
-		} else {
-			set_bit(CONN_WD_ST_CHG_FAIL, &tconn->flags);
-			conn_err(tconn, "Requested state change failed by peer: %s (%d)\n",
-				 drbd_set_st_err_str(retcode), retcode);
-		}
-		wake_up(&tconn->ping_wait);
+	if (retcode >= SS_SUCCESS) {
+		set_bit(CL_ST_CHG_SUCCESS, &mdev->flags);
+	} else {
+		set_bit(CL_ST_CHG_FAIL, &mdev->flags);
+		dev_err(DEV, "Requested state change failed by peer: %s (%d)\n",
+			drbd_set_st_err_str(retcode), retcode);
 	}
+	wake_up(&mdev->state_wait);
+
 	return true;
 }
 
@@ -4746,7 +4751,7 @@ static struct asender_cmd asender_tbl[] = {
 	[P_RS_IS_IN_SYNC]   = { sizeof(struct p_block_ack), MDEV, { got_IsInSync } },
 	[P_DELAY_PROBE]     = { sizeof(struct p_delay_probe93), MDEV, { got_skip } },
 	[P_RS_CANCEL]       = { sizeof(struct p_block_ack), MDEV, { got_NegRSDReply } },
-	[P_CONN_ST_CHG_REPLY]={ sizeof(struct p_req_state_reply), MDEV, { got_RqSReply } },
+	[P_CONN_ST_CHG_REPLY]={ sizeof(struct p_req_state_reply), CONN, {.conn_fn = got_conn_RqSReply}},
 	[P_RETRY_WRITE]	    = { sizeof(struct p_block_ack), MDEV, { got_BlockAck } },
 };
 
-- 
1.7.4.1

