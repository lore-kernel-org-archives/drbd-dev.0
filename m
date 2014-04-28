Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:32 +0200
Message-Id: <1398703415-17780-22-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 21/24] drbd: use blk_set_stacking_limits()
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

...instead directly assigning to q->limits.discard_zeroes_data

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 12 ++++++------
 include/linux/drbd.h         |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index a187c5b..b4fc401 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1114,15 +1114,18 @@ static void drbd_setup_queue_param(struct drbd_device *device, unsigned int max_
 	struct request_queue * const q = device->rq_queue;
 	unsigned int max_hw_sectors = max_bio_size >> 9;
 	unsigned int max_segments = 0;
+	struct request_queue *b = NULL;
 
 	if (get_ldev_if_state(device, D_ATTACHING)) {
-		struct request_queue * const b = device->ldev->backing_bdev->bd_disk->queue;
+		b = device->ldev->backing_bdev->bd_disk->queue;
 
 		max_hw_sectors = min(queue_max_hw_sectors(b), max_bio_size >> 9);
 		rcu_read_lock();
 		max_segments = rcu_dereference(device->ldev->disk_conf)->max_bio_bvecs;
 		rcu_read_unlock();
-		put_ldev(device);
+
+		blk_set_stacking_limits(&q->limits);
+		blk_queue_max_write_same_sectors(q, 0);
 	}
 
 	blk_queue_logical_block_size(q, 512);
@@ -1131,14 +1134,11 @@ static void drbd_setup_queue_param(struct drbd_device *device, unsigned int max_
 	blk_queue_max_segments(q, max_segments ? max_segments : BLK_MAX_SEGMENTS);
 	blk_queue_segment_boundary(q, PAGE_CACHE_SIZE-1);
 
-	if (get_ldev_if_state(device, D_ATTACHING)) {
-		struct request_queue * const b = device->ldev->backing_bdev->bd_disk->queue;
+	if (b) {
 		struct drbd_connection *connection = first_peer_device(device)->connection;
 
 		if (blk_queue_discard(b) &&
 		    (connection->cstate < C_CONNECTED || connection->agreed_features & FF_TRIM)) {
-			/* inherit from backing queue */
-			q->limits.discard_zeroes_data = 1;
 			/* For now, don't allow more than one activity log extent worth of data
 			 * to be discarded in one go. We may need to rework drbd_al_begin_io()
 			 * to allow for even larger discard ranges */
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index 3dbe9bd..fffd4b8 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -52,7 +52,7 @@
 #endif
 
 extern const char *drbd_buildtag(void);
-#define REL_VERSION "8.4.3"
+#define REL_VERSION "8.4.4"
 #define API_VERSION 1
 #define PRO_VERSION_MIN 86
 #define PRO_VERSION_MAX 101
-- 
1.9.1

