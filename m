Return-Path: <BATV+3075c4dbfe213c24d6b2+7491+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 210DA4205E5
	for <drbd-dev@lists.linbit.com>; Mon, 26 Feb 2024 12:34:51 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>, Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 02/16] block: add a queue_limits_stack_bdev helper
Date: Mon, 26 Feb 2024 11:29:50 +0100
Message-Id: <20240226103004.281412-3-hch@lst.de>
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

Add a small wrapper around blk_stack_limits that allows passing a bdev
for the bottom device and prints an error in case of misaligned
device. The name fits into the new queue limits API and the intent is
to eventually replace disk_stack_limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c   | 25 +++++++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 1989a177be201b..865fe4ebbf9b83 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -891,6 +891,31 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 }
 EXPORT_SYMBOL(blk_stack_limits);
 
+/**
+ * queue_limits_stack_bdev - adjust queue_limits for stacked devices
+ * @t:	the stacking driver limits (top device)
+ * @bdev:  the underlying block device (bottom)
+ * @offset:  offset to beginning of data within component device
+ * @pfx: prefix to use for warnings logged
+ *
+ * Description:
+ *    This function is used by stacking drivers like MD and DM to ensure
+ *    that all component devices have compatible block sizes and
+ *    alignments.  The stacking driver must provide a queue_limits
+ *    struct (top) and then iteratively call the stacking function for
+ *    all component (bottom) devices.  The stacking function will
+ *    attempt to combine the values and ensure proper alignment.
+ */
+void queue_limits_stack_bdev(struct queue_limits *t, struct block_device *bdev,
+		sector_t offset, const char *pfx)
+{
+	if (blk_stack_limits(t, &bdev_get_queue(bdev)->limits,
+			get_start_sect(bdev) + offset))
+		pr_notice("%s: Warning: Device %pg is misaligned\n",
+			pfx, bdev);
+}
+EXPORT_SYMBOL_GPL(queue_limits_stack_bdev);
+
 /**
  * disk_stack_limits - adjust queue limits for stacked drivers
  * @disk:  MD/DM gendisk (top)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index dd510ad7ce4b45..285e82723d641f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -924,6 +924,8 @@ extern void blk_set_queue_depth(struct request_queue *q, unsigned int depth);
 extern void blk_set_stacking_limits(struct queue_limits *lim);
 extern int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 			    sector_t offset);
+void queue_limits_stack_bdev(struct queue_limits *t, struct block_device *bdev,
+		sector_t offset, const char *pfx);
 extern void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
 			      sector_t offset);
 extern void blk_queue_update_dma_pad(struct request_queue *, unsigned int);
-- 
2.39.2

