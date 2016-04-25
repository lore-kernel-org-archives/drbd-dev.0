Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 64DC2105644A
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 14:08:26 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 25 Apr 2016 14:07:39 +0200
Message-Id: <1461586077-11581-13-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
References: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 12/30] drbd: possibly disable discard support,
	if backend has discard_zeroes_data=0
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

Now that we have the discard_zeroes_if_aligned setting, we should also
check it when setting up our queue parameters on the primary,
not only on the receiving side.

We announce discard support,
UNLESS

 * we are connected to a peer that does not support TRIM
   on the DRBD protocol level.  Otherwise, it would either discard, or
   do a fallback to zero-out, depending on its backend and configuration.

 * our local backend does not support discards,
   or (discard_zeroes_data=0 AND discard_zeroes_if_aligned=no).

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 80 ++++++++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 25 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 4a0b184..f335549 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1154,6 +1154,59 @@ static int drbd_check_al_size(struct drbd_device *device, struct disk_conf *dc)
 	return 0;
 }
 
+static void blk_queue_discard_granularity(struct request_queue *q, unsigned int granularity)
+{
+	q->limits.discard_granularity = granularity;
+}
+static void decide_on_discard_support(struct drbd_device *device,
+			struct request_queue *q,
+			struct request_queue *b,
+			bool discard_zeroes_if_aligned)
+{
+	/* q = drbd device queue (device->rq_queue)
+	 * b = backing device queue (device->ldev->backing_bdev->bd_disk->queue),
+	 *     or NULL if diskless
+	 */
+	struct drbd_connection *connection = first_peer_device(device)->connection;
+	bool can_do = b ? blk_queue_discard(b) : true;
+
+	if (can_do && b && !b->limits.discard_zeroes_data && !discard_zeroes_if_aligned) {
+		can_do = false;
+		drbd_info(device, "discard_zeroes_data=0 and discard_zeroes_if_aligned=no: disabling discards\n");
+	}
+	if (can_do && connection->cstate >= C_CONNECTED && !(connection->agreed_features & FF_TRIM)) {
+		can_do = false;
+		drbd_info(connection, "peer DRBD too old, does not support TRIM: disabling discards\n");
+	}
+	if (can_do) {
+		/* We don't care for the granularity, really.
+		 * Stacking limits below should fix it for the local
+		 * device.  Whether or not it is a suitable granularity
+		 * on the remote device is not our problem, really. If
+		 * you care, you need to use devices with similar
+		 * topology on all peers. */
+		blk_queue_discard_granularity(q, 512);
+		q->limits.max_discard_sectors = DRBD_MAX_DISCARD_SECTORS;
+		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
+	} else {
+		queue_flag_clear_unlocked(QUEUE_FLAG_DISCARD, q);
+		blk_queue_discard_granularity(q, 0);
+		q->limits.max_discard_sectors = 0;
+	}
+}
+
+static void fixup_discard_if_not_supported(struct request_queue *q)
+{
+	/* To avoid confusion, if this queue does not support discard, clear
+	 * max_discard_sectors, which is what lsblk -D reports to the user.
+	 * Older kernels got this wrong in "stack limits".
+	 * */
+	if (!blk_queue_discard(q)) {
+		blk_queue_max_discard_sectors(q, 0);
+		blk_queue_discard_granularity(q, 0);
+	}
+}
+
 static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backing_dev *bdev,
 				   unsigned int max_bio_size)
 {
@@ -1183,26 +1236,8 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 	/* This is the workaround for "bio would need to, but cannot, be split" */
 	blk_queue_max_segments(q, max_segments ? max_segments : BLK_MAX_SEGMENTS);
 	blk_queue_segment_boundary(q, PAGE_SIZE-1);
-
+	decide_on_discard_support(device, q, b, discard_zeroes_if_aligned);
 	if (b) {
-		struct drbd_connection *connection = first_peer_device(device)->connection;
-
-		blk_queue_max_discard_sectors(q, DRBD_MAX_DISCARD_SECTORS);
-
-		if (blk_queue_discard(b) && (b->limits.discard_zeroes_data || discard_zeroes_if_aligned) &&
-		    (connection->cstate < C_CONNECTED || connection->agreed_features & FF_TRIM)) {
-			/* We don't care, stacking below should fix it for the local device.
-			 * Whether or not it is a suitable granularity on the remote device
-			 * is not our problem, really. If you care, you need to
-			 * use devices with similar topology on all peers. */
-			q->limits.discard_granularity = 512;
-			queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
-		} else {
-			blk_queue_max_discard_sectors(q, 0);
-			queue_flag_clear_unlocked(QUEUE_FLAG_DISCARD, q);
-			q->limits.discard_granularity = 0;
-		}
-
 		blk_queue_stack_limits(q, b);
 
 		if (q->backing_dev_info.ra_pages != b->backing_dev_info.ra_pages) {
@@ -1212,12 +1247,7 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 			q->backing_dev_info.ra_pages = b->backing_dev_info.ra_pages;
 		}
 	}
-	/* To avoid confusion, if this queue does not support discard, clear
-	 * max_discard_sectors, which is what lsblk -D reports to the user.  */
-	if (!blk_queue_discard(q)) {
-		blk_queue_max_discard_sectors(q, 0);
-		q->limits.discard_granularity = 0;
-	}
+	fixup_discard_if_not_supported(q);
 }
 
 void drbd_reconsider_queue_parameters(struct drbd_device *device, struct drbd_backing_dev *bdev)
-- 
1.9.1

