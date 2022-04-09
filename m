Return-Path: <BATV+43fc5532e856fea764d1+6803+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 042BD420FFA
	for <drbd-dev@lists.linbit.com>; Sat,  9 Apr 2022 07:22:01 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Sat,  9 Apr 2022 06:50:34 +0200
Message-Id: <20220409045043.23593-19-hch@lst.de>
In-Reply-To: <20220409045043.23593-1-hch@lst.de>
References: <20220409045043.23593-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: jfs-discussion@lists.sourceforge.net, linux-nvme@lists.infradead.org,
	virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
	dm-devel@redhat.com, target-devel@vger.kernel.org,
	linux-mtd@lists.infradead.org, drbd-dev@lists.linbit.com,
	linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
	linux-scsi@vger.kernel.org, cluster-devel@redhat.com,
	xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org,
	linux-um@lists.infradead.org, nbd@other.debian.org,
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-raid@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-mmc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
	linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev,
	linux-btrfs@vger.kernel.org
Subject: [Drbd-dev] [PATCH 18/27] block: move bdev_alignment_offset and
	queue_limit_alignment_offset out of line
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

No need to inline these fairly larger helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/blk-settings.c   | 23 +++++++++++++++++++++++
 include/linux/blkdev.h | 21 +--------------------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index b83df3d2eebca..94410a13c0dee 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -468,6 +468,16 @@ void blk_queue_io_opt(struct request_queue *q, unsigned int opt)
 }
 EXPORT_SYMBOL(blk_queue_io_opt);
 
+static int queue_limit_alignment_offset(struct queue_limits *lim,
+		sector_t sector)
+{
+	unsigned int granularity = max(lim->physical_block_size, lim->io_min);
+	unsigned int alignment = sector_div(sector, granularity >> SECTOR_SHIFT)
+		<< SECTOR_SHIFT;
+
+	return (granularity + lim->alignment_offset - alignment) % granularity;
+}
+
 static unsigned int blk_round_down_sectors(unsigned int sectors, unsigned int lbs)
 {
 	sectors = round_down(sectors, lbs >> SECTOR_SHIFT);
@@ -901,3 +911,16 @@ void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 	}
 }
 EXPORT_SYMBOL_GPL(blk_queue_set_zoned);
+
+int bdev_alignment_offset(struct block_device *bdev)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (q->limits.misaligned)
+		return -1;
+	if (bdev_is_partition(bdev))
+		return queue_limit_alignment_offset(&q->limits,
+				bdev->bd_start_sect);
+	return q->limits.alignment_offset;
+}
+EXPORT_SYMBOL_GPL(bdev_alignment_offset);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d5346e72e3645..0a1795ac26275 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1251,26 +1251,7 @@ bdev_zone_write_granularity(struct block_device *bdev)
 	return queue_zone_write_granularity(bdev_get_queue(bdev));
 }
 
-static inline int queue_limit_alignment_offset(struct queue_limits *lim, sector_t sector)
-{
-	unsigned int granularity = max(lim->physical_block_size, lim->io_min);
-	unsigned int alignment = sector_div(sector, granularity >> SECTOR_SHIFT)
-		<< SECTOR_SHIFT;
-
-	return (granularity + lim->alignment_offset - alignment) % granularity;
-}
-
-static inline int bdev_alignment_offset(struct block_device *bdev)
-{
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (q->limits.misaligned)
-		return -1;
-	if (bdev_is_partition(bdev))
-		return queue_limit_alignment_offset(&q->limits,
-				bdev->bd_start_sect);
-	return q->limits.alignment_offset;
-}
+int bdev_alignment_offset(struct block_device *bdev);
 
 static inline int queue_discard_alignment(const struct request_queue *q)
 {
-- 
2.30.2

