Return-Path: <BATV+3075c4dbfe213c24d6b2+7491+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2796442064B
	for <drbd-dev@lists.linbit.com>; Mon, 26 Feb 2024 12:43:00 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>, Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 13/16] drbd: merge drbd_setup_queue_param into
	drbd_reconsider_queue_parameters
Date: Mon, 26 Feb 2024 11:30:01 +0100
Message-Id: <20240226103004.281412-14-hch@lst.de>
In-Reply-To: <20240226103004.281412-1-hch@lst.de>
References: <20240226103004.281412-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org, drbd-dev@lists.linbit.com
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

drbd_setup_queue_param is only called by drbd_reconsider_queue_parameters
and there is no really clear boundary of responsibilities between the
two.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_nl.c | 56 ++++++++++++++----------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 0326b7322ceb48..0f40fdee089971 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1309,45 +1309,16 @@ static unsigned int drbd_backing_dev_max_segments(struct drbd_device *device)
 	return max_segments;
 }
 
-static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backing_dev *bdev,
-				   unsigned int max_bio_size, struct o_qlim *o)
-{
-	struct request_queue * const q = device->rq_queue;
-	unsigned int max_hw_sectors = max_bio_size >> 9;
-	unsigned int max_segments = BLK_MAX_SEGMENTS;
-	struct request_queue *b = NULL;
-
-	if (bdev) {
-		b = bdev->backing_bdev->bd_disk->queue;
-
-		max_hw_sectors = min(queue_max_hw_sectors(b), max_bio_size >> 9);
-		max_segments = drbd_backing_dev_max_segments(device);
-
-		blk_set_stacking_limits(&q->limits);
-	}
-
-	blk_queue_max_hw_sectors(q, max_hw_sectors);
-	blk_queue_max_segments(q, max_segments);
-	blk_queue_segment_boundary(q, PAGE_SIZE-1);
-	decide_on_discard_support(device, bdev);
-
-	if (b) {
-		blk_stack_limits(&q->limits, &b->limits, 0);
-		disk_update_readahead(device->vdisk);
-	}
-	fixup_write_zeroes(device, q);
-	fixup_discard_support(device, q);
-}
-
 void drbd_reconsider_queue_parameters(struct drbd_device *device,
 		struct drbd_backing_dev *bdev, struct o_qlim *o)
 {
-	unsigned int now = queue_max_hw_sectors(device->rq_queue) <<
-			SECTOR_SHIFT;
+	struct request_queue * const q = device->rq_queue;
+	unsigned int now = queue_max_hw_sectors(q) << 9;
+	struct request_queue *b = NULL;
 	unsigned int new;
 
 	if (bdev) {
-		struct request_queue *b = bdev->backing_bdev->bd_disk->queue;
+		b = bdev->backing_bdev->bd_disk->queue;
 
 		device->local_max_bio_size =
 			queue_max_hw_sectors(b) << SECTOR_SHIFT;
@@ -1369,7 +1340,24 @@ void drbd_reconsider_queue_parameters(struct drbd_device *device,
 		drbd_info(device, "max BIO size = %u\n", new);
 	}
 
-	drbd_setup_queue_param(device, bdev, new, o);
+	if (bdev) {
+		blk_set_stacking_limits(&q->limits);
+		blk_queue_max_segments(q,
+			drbd_backing_dev_max_segments(device));
+	} else {
+		blk_queue_max_segments(q, BLK_MAX_SEGMENTS);
+	}
+
+	blk_queue_max_hw_sectors(q, new >> SECTOR_SHIFT);
+	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
+	decide_on_discard_support(device, bdev);
+
+	if (bdev) {
+		blk_stack_limits(&q->limits, &b->limits, 0);
+		disk_update_readahead(device->vdisk);
+	}
+	fixup_write_zeroes(device, q);
+	fixup_discard_support(device, q);
 }
 
 /* Starts the worker thread */
-- 
2.39.2

