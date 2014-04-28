Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:25 +0200
Message-Id: <1398703415-17780-15-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 14/24] drbd: Enable QUEUE_FLAG_DISCARD only if
	the peer can recieve P_TRIM
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Allow the user of REQ_DISCARD.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h      |  1 +
 drivers/block/drbd/drbd_nl.c       | 20 ++++++++++++++++++++
 drivers/block/drbd/drbd_protocol.h |  2 ++
 drivers/block/drbd/drbd_receiver.c | 18 ++++++++++++++----
 4 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 29123df..d5f39fd 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -618,6 +618,7 @@ struct drbd_connection {
 	struct drbd_socket data;	/* data/barrier/cstate/parameter packets */
 	struct drbd_socket meta;	/* ping/ack (metadata) packets */
 	int agreed_pro_version;		/* actually used protocol version */
+	u32 agreed_features;
 	unsigned long last_received;	/* in jiffies, either socket */
 	unsigned int ko_count;
 
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index bb36792..2364b78 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1133,6 +1133,26 @@ static void drbd_setup_queue_param(struct drbd_device *device, unsigned int max_
 
 	if (get_ldev_if_state(device, D_ATTACHING)) {
 		struct request_queue * const b = device->ldev->backing_bdev->bd_disk->queue;
+		struct drbd_connection *connection = first_peer_device(device)->connection;
+
+		if (blk_queue_discard(b) &&
+		    (connection->cstate < C_CONNECTED || connection->agreed_features & FF_TRIM)) {
+			/* inherit from backing queue */
+			q->limits.discard_zeroes_data = 1;
+			/* For now, don't allow more than one activity log extent worth of data
+			 * to be discarded in one go. We may need to rework drbd_al_begin_io()
+			 * to allow for even larger discard ranges */
+			q->limits.max_discard_sectors = DRBD_MAX_DISCARD_SECTORS;
+
+			queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
+			/* REALLY? Is stacking secdiscard "legal"? */
+			if (blk_queue_secdiscard(b))
+				queue_flag_set_unlocked(QUEUE_FLAG_SECDISCARD, q);
+		} else {
+			q->limits.max_discard_sectors = 0;
+			queue_flag_clear_unlocked(QUEUE_FLAG_DISCARD, q);
+			queue_flag_clear_unlocked(QUEUE_FLAG_SECDISCARD, q);
+		}
 
 		blk_queue_stack_limits(q, b);
 
diff --git a/drivers/block/drbd/drbd_protocol.h b/drivers/block/drbd/drbd_protocol.h
index 478c63d..2da9104a 100644
--- a/drivers/block/drbd/drbd_protocol.h
+++ b/drivers/block/drbd/drbd_protocol.h
@@ -160,6 +160,8 @@ struct p_block_req {
  *   ReportParams
  */
 
+#define FF_TRIM      1
+
 struct p_connection_features {
 	u32 protocol_min;
 	u32 feature_flags;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 9640b64..3fa3b78 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -46,9 +46,10 @@
 #include "drbd_int.h"
 #include "drbd_protocol.h"
 #include "drbd_req.h"
-
 #include "drbd_vli.h"
 
+#define PRO_FEATURES (FF_TRIM)
+
 struct packet_info {
 	enum drbd_packet cmd;
 	unsigned int size;
@@ -3705,6 +3706,13 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 		put_ldev(device);
 	}
 
+	device->peer_max_bio_size = be32_to_cpu(p->max_bio_size);
+	drbd_reconsider_max_bio_size(device);
+	/* Leave drbd_reconsider_max_bio_size() before drbd_determine_dev_size().
+	   In case we cleared the QUEUE_FLAG_DISCARD from our queue in
+	   drbd_reconsider_max_bio_size(), we can be sure that after
+	   drbd_determine_dev_size() no REQ_DISCARDs are in the queue. */
+
 	ddsf = be16_to_cpu(p->dds_flags);
 	if (get_ldev(device)) {
 		dd = drbd_determine_dev_size(device, ddsf, NULL);
@@ -3717,9 +3725,6 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 		drbd_set_my_capacity(device, p_size);
 	}
 
-	device->peer_max_bio_size = be32_to_cpu(p->max_bio_size);
-	drbd_reconsider_max_bio_size(device);
-
 	if (get_ldev(device)) {
 		if (device->ldev->known_size != drbd_get_capacity(device->ldev->backing_bdev)) {
 			device->ldev->known_size = drbd_get_capacity(device->ldev->backing_bdev);
@@ -4688,6 +4693,7 @@ static int drbd_send_features(struct drbd_connection *connection)
 	memset(p, 0, sizeof(*p));
 	p->protocol_min = cpu_to_be32(PRO_VERSION_MIN);
 	p->protocol_max = cpu_to_be32(PRO_VERSION_MAX);
+	p->feature_flags = cpu_to_be32(PRO_FEATURES);
 	return conn_send_command(connection, sock, P_CONNECTION_FEATURES, sizeof(*p), NULL, 0);
 }
 
@@ -4741,10 +4747,14 @@ static int drbd_do_features(struct drbd_connection *connection)
 		goto incompat;
 
 	connection->agreed_pro_version = min_t(int, PRO_VERSION_MAX, p->protocol_max);
+	connection->agreed_features = PRO_FEATURES & be32_to_cpu(p->feature_flags);
 
 	drbd_info(connection, "Handshake successful: "
 	     "Agreed network protocol version %d\n", connection->agreed_pro_version);
 
+	drbd_info(connection, "Agreed to%ssupport TRIM on protocol level\n",
+		  connection->agreed_features & FF_TRIM ? " " : " not ");
+
 	return 1;
 
  incompat:
-- 
1.9.1

