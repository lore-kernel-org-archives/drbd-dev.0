Return-Path: <BATV+3075c4dbfe213c24d6b2+7491+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6BCE142021F
	for <drbd-dev@lists.linbit.com>; Mon, 26 Feb 2024 12:43:22 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>, Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 09/16] block: remove disk_stack_limits
Date: Mon, 26 Feb 2024 11:29:57 +0100
Message-Id: <20240226103004.281412-10-hch@lst.de>
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

disk_stack_limits is unused now, remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c   | 24 ------------------------
 include/linux/blkdev.h |  2 --
 2 files changed, 26 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 13865a9f89726c..3c7d8d638ab59d 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -916,30 +916,6 @@ void queue_limits_stack_bdev(struct queue_limits *t, struct block_device *bdev,
 }
 EXPORT_SYMBOL_GPL(queue_limits_stack_bdev);
 
-/**
- * disk_stack_limits - adjust queue limits for stacked drivers
- * @disk:  MD/DM gendisk (top)
- * @bdev:  the underlying block device (bottom)
- * @offset:  offset to beginning of data within component device
- *
- * Description:
- *    Merges the limits for a top level gendisk and a bottom level
- *    block_device.
- */
-void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
-		       sector_t offset)
-{
-	struct request_queue *t = disk->queue;
-
-	if (blk_stack_limits(&t->limits, &bdev_get_queue(bdev)->limits,
-			get_start_sect(bdev) + (offset >> 9)) < 0)
-		pr_notice("%s: Warning: Device %pg is misaligned\n",
-			disk->disk_name, bdev);
-
-	disk_update_readahead(disk);
-}
-EXPORT_SYMBOL(disk_stack_limits);
-
 /**
  * blk_queue_update_dma_pad - update pad mask
  * @q:     the request queue for the device
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 285e82723d641f..75c909865a8b7b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -926,8 +926,6 @@ extern int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 			    sector_t offset);
 void queue_limits_stack_bdev(struct queue_limits *t, struct block_device *bdev,
 		sector_t offset, const char *pfx);
-extern void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
-			      sector_t offset);
 extern void blk_queue_update_dma_pad(struct request_queue *, unsigned int);
 extern void blk_queue_segment_boundary(struct request_queue *, unsigned long);
 extern void blk_queue_virt_boundary(struct request_queue *, unsigned long);
-- 
2.39.2

