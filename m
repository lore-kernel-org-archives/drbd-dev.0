Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:08:53 +0200
Message-Id: <1314284934-17999-118-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 117/118] drbd: implemented receiving of
	P_CONN_ST_CHG_REQ
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
 drivers/block/drbd/drbd_receiver.c |   10 ++++++++--
 drivers/block/drbd/drbd_state.h    |    1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index bdd3f00..e346245 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3235,9 +3235,14 @@ static int receive_req_state(struct drbd_conf *mdev, enum drbd_packet cmd,
 	mask = convert_state(mask);
 	val = convert_state(val);
 
-	rv = drbd_change_state(mdev, CS_VERBOSE, mask, val);
+	if (cmd == P_CONN_ST_CHG_REQ) {
+		rv = conn_request_state(mdev->tconn, mask, val, CS_VERBOSE | CS_LOCAL_ONLY);
+		conn_send_sr_reply(mdev->tconn, rv);
+	} else {
+		rv = drbd_change_state(mdev, CS_VERBOSE, mask, val);
+		drbd_send_sr_reply(mdev, rv);
+	}
 
-	drbd_send_sr_reply(mdev, rv);
 	drbd_md_sync(mdev);
 
 	return true;
@@ -3771,6 +3776,7 @@ static struct data_cmd drbd_cmd_handler[] = {
 	[P_CSUM_RS_REQUEST] = { 1, sizeof(struct p_block_req), receive_DataRequest },
 	[P_DELAY_PROBE]     = { 0, sizeof(struct p_delay_probe93), receive_skip },
 	[P_OUT_OF_SYNC]     = { 0, sizeof(struct p_block_desc), receive_out_of_sync },
+	[P_CONN_ST_CHG_REQ] = { 0, sizeof(struct p_req_state), receive_req_state },
 	/* anything missing from this table is in
 	 * the asender_tbl, see get_asender_cmd */
 	[P_MAX_CMD]	    = { 0, 0, NULL },
diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
index d312d84..5fdbdf0 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -63,6 +63,7 @@ enum chg_state_flags {
 	CS_SERIALIZE    = 8,
 	CS_ORDERED      = CS_WAIT_COMPLETE + CS_SERIALIZE,
 	CS_NO_CSTATE_CHG = 16, /* Do not display changes in cstate. Internal to drbd_state.c */
+	CS_LOCAL_ONLY = 32, /* Do not consider a device pair wide state change */
 };
 
 extern enum drbd_state_rv drbd_change_state(struct drbd_conf *mdev,
-- 
1.7.4.1

