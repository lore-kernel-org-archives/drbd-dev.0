Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4DDBD105644E
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 14:08:23 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 25 Apr 2016 14:07:33 +0200
Message-Id: <1461586077-11581-7-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
References: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 06/30] drbd: Create the protocol feature
	THIN_RESYNC
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

If thinly provisioned volumes are used, during a resync the sync source
tries to find out if a block is deallocated. If it is deallocated, then
the resync target uses block_dev_issue_zeroout() on the range in
question.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_protocol.h |  1 +
 drivers/block/drbd/drbd_receiver.c |  5 ++++-
 drivers/block/drbd/drbd_worker.c   | 13 ++++++++++++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_protocol.h b/drivers/block/drbd/drbd_protocol.h
index e5e74e3..7acc2e0 100644
--- a/drivers/block/drbd/drbd_protocol.h
+++ b/drivers/block/drbd/drbd_protocol.h
@@ -165,6 +165,7 @@ struct p_block_req {
  */
 
 #define FF_TRIM      1
+#define FF_THIN_RESYNC 2
 
 struct p_connection_features {
 	u32 protocol_min;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 3a6c2ec..4cfc721 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -48,7 +48,7 @@
 #include "drbd_req.h"
 #include "drbd_vli.h"
 
-#define PRO_FEATURES (FF_TRIM)
+#define PRO_FEATURES (FF_TRIM | FF_THIN_RESYNC)
 
 struct packet_info {
 	enum drbd_packet cmd;
@@ -4979,6 +4979,9 @@ static int drbd_do_features(struct drbd_connection *connection)
 	drbd_info(connection, "Agreed to%ssupport TRIM on protocol level\n",
 		  connection->agreed_features & FF_TRIM ? " " : " not ");
 
+	drbd_info(connection, "Agreed to%ssupport THIN_RESYNC on protocol level\n",
+		  connection->agreed_features & FF_THIN_RESYNC ? " " : " not ");
+
 	return 1;
 
  incompat:
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 01d74ee2..fa63c22 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -582,6 +582,7 @@ static int make_resync_request(struct drbd_device *const device, int cancel)
 	int number, rollback_i, size;
 	int align, requeue = 0;
 	int i = 0;
+	int discard_granularity = 0;
 
 	if (unlikely(cancel))
 		return 0;
@@ -601,6 +602,12 @@ static int make_resync_request(struct drbd_device *const device, int cancel)
 		return 0;
 	}
 
+	if (connection->agreed_features & FF_THIN_RESYNC) {
+		rcu_read_lock();
+		discard_granularity = rcu_dereference(device->ldev->disk_conf)->rs_discard_granularity;
+		rcu_read_unlock();
+	}
+
 	max_bio_size = queue_max_hw_sectors(device->rq_queue) << 9;
 	number = drbd_rs_number_requests(device);
 	if (number <= 0)
@@ -665,6 +672,9 @@ next_sector:
 			if (sector & ((1<<(align+3))-1))
 				break;
 
+			if (discard_granularity && size == discard_granularity)
+				break;
+
 			/* do not cross extent boundaries */
 			if (((bit+1) & BM_BLOCKS_PER_BM_EXT_MASK) == 0)
 				break;
@@ -711,7 +721,8 @@ next_sector:
 			int err;
 
 			inc_rs_pending(device);
-			err = drbd_send_drequest(peer_device, P_RS_DATA_REQUEST,
+			err = drbd_send_drequest(peer_device,
+						 size == discard_granularity ? P_RS_THIN_REQ : P_RS_DATA_REQUEST,
 						 sector, size, ID_SYNCER);
 			if (err) {
 				drbd_err(device, "drbd_send_drequest() failed, aborting...\n");
-- 
1.9.1

