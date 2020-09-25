Return-Path: <BATV+158bd042e2069d5d3a43+6242+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B06C9420F4F
	for <drbd-dev@lists.linbit.com>; Fri, 25 Sep 2020 18:08:52 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Fri, 25 Sep 2020 18:06:18 +0200
Message-Id: <20200925160618.1481450-3-hch@lst.de>
In-Reply-To: <20200925160618.1481450-1-hch@lst.de>
References: <20200925160618.1481450-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org
Subject: [Drbd-dev] [PATCH 2/2] block: add a bdget_part helper
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

All remaining callers of bdget() outside of fs/block_dev.c want to get a
reference to the struct block_device for a given struct hd_struct.  Add
a helper just for that and then mark bdget static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c           | 2 +-
 block/partitions/core.c | 2 +-
 fs/block_dev.c          | 9 ++++++---
 include/linux/blkdev.h  | 2 +-
 kernel/trace/blktrace.c | 9 ++-------
 5 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index e5f17f022ec700..0a273211fec283 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1048,7 +1048,7 @@ struct block_device *bdget_disk(struct gendisk *disk, int partno)
 
 	part = disk_get_part(disk, partno);
 	if (part)
-		bdev = bdget(part_devt(part));
+		bdev = bdget_part(part);
 	disk_put_part(part);
 
 	return bdev;
diff --git a/block/partitions/core.c b/block/partitions/core.c
index dd6811422a87af..5309e0f44ba352 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -580,7 +580,7 @@ int bdev_resize_partition(struct block_device *bdev, int partno,
 		return -ENXIO;
 
 	ret = -ENOMEM;
-	bdevp = bdget(part_devt(part));
+	bdevp = bdget_part(part);
 	if (!bdevp)
 		goto out_put_part;
 
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6b9d19ffa5af7b..9e84b1928b9401 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -891,7 +891,7 @@ static int bdev_set(struct inode *inode, void *data)
 	return 0;
 }
 
-struct block_device *bdget(dev_t dev)
+static struct block_device *bdget(dev_t dev)
 {
 	struct block_device *bdev;
 	struct inode *inode;
@@ -920,8 +920,6 @@ struct block_device *bdget(dev_t dev)
 	return bdev;
 }
 
-EXPORT_SYMBOL(bdget);
-
 /**
  * bdgrab -- Grab a reference to an already referenced block device
  * @bdev:	Block device to grab a reference to.
@@ -933,6 +931,11 @@ struct block_device *bdgrab(struct block_device *bdev)
 }
 EXPORT_SYMBOL(bdgrab);
 
+struct block_device *bdget_part(struct hd_struct *part)
+{
+	return bdget(part_devt(part));
+}
+
 long nr_blockdev_pages(void)
 {
 	struct inode *inode;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d5a3e1a4c2f79b..cf80e61b4c5e1a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -2003,7 +2003,7 @@ void bd_abort_claiming(struct block_device *bdev, struct block_device *whole,
 void blkdev_put(struct block_device *bdev, fmode_t mode);
 
 struct block_device *I_BDEV(struct inode *inode);
-struct block_device *bdget(dev_t);
+struct block_device *bdget_part(struct hd_struct *part);
 struct block_device *bdgrab(struct block_device *bdev);
 void bdput(struct block_device *);
 
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ec874ea040922a..f1022945e3460b 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1827,13 +1827,11 @@ static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	struct hd_struct *p = dev_to_part(dev);
+	struct block_device *bdev = bdget_part(dev_to_part(dev));
 	struct request_queue *q;
-	struct block_device *bdev;
 	struct blk_trace *bt;
 	ssize_t ret = -ENXIO;
 
-	bdev = bdget(part_devt(p));
 	if (bdev == NULL)
 		goto out;
 
@@ -1875,7 +1873,6 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 {
 	struct block_device *bdev;
 	struct request_queue *q;
-	struct hd_struct *p;
 	struct blk_trace *bt;
 	u64 value;
 	ssize_t ret = -EINVAL;
@@ -1895,9 +1892,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 		goto out;
 
 	ret = -ENXIO;
-
-	p = dev_to_part(dev);
-	bdev = bdget(part_devt(p));
+	bdev = bdget_part(dev_to_part(dev));
 	if (bdev == NULL)
 		goto out;
 
-- 
2.28.0

