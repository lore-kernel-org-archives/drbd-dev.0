Return-Path: <BATV+940d4f53d1157bf1ee93+6480+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 33ADA420BB6
	for <drbd-dev@lists.linbit.com>; Fri, 21 May 2021 11:03:36 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jim Paris <jim@jtan.com>,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>,
	Nitin Gupta <ngupta@vflare.org>, Matias Bjorling <mb@lightnvm.io>,
	Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
	Song Liu <song@kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 21 May 2021 07:51:12 +0200
Message-Id: <20210521055116.1053587-23-hch@lst.de>
In-Reply-To: <20210521055116.1053587-1-hch@lst.de>
References: <20210521055116.1053587-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org,
	linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-s390@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	linuxppc-dev@lists.ozlabs.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 22/26] ps3vram: convert to
	blk_alloc_disk/blk_cleanup_disk
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

Convert the ps3vram driver to use the blk_alloc_disk and blk_cleanup_disk
helpers to simplify gendisk and request_queue allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/ps3vram.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 1d738999fb69..7fbf469651c4 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -67,7 +67,6 @@ struct ps3vram_cache {
 };
 
 struct ps3vram_priv {
-	struct request_queue *queue;
 	struct gendisk *gendisk;
 
 	u64 size;
@@ -613,7 +612,6 @@ static int ps3vram_probe(struct ps3_system_bus_device *dev)
 {
 	struct ps3vram_priv *priv;
 	int error, status;
-	struct request_queue *queue;
 	struct gendisk *gendisk;
 	u64 ddr_size, ddr_lpar, ctrl_lpar, info_lpar, reports_lpar,
 	    reports_size, xdr_lpar;
@@ -736,33 +734,23 @@ static int ps3vram_probe(struct ps3_system_bus_device *dev)
 
 	ps3vram_proc_init(dev);
 
-	queue = blk_alloc_queue(NUMA_NO_NODE);
-	if (!queue) {
-		dev_err(&dev->core, "blk_alloc_queue failed\n");
-		error = -ENOMEM;
-		goto out_cache_cleanup;
-	}
-
-	priv->queue = queue;
-	blk_queue_max_segments(queue, BLK_MAX_SEGMENTS);
-	blk_queue_max_segment_size(queue, BLK_MAX_SEGMENT_SIZE);
-	blk_queue_max_hw_sectors(queue, BLK_SAFE_MAX_SECTORS);
-
-	gendisk = alloc_disk(1);
+	gendisk = blk_alloc_disk(NUMA_NO_NODE);
 	if (!gendisk) {
-		dev_err(&dev->core, "alloc_disk failed\n");
+		dev_err(&dev->core, "blk_alloc_disk failed\n");
 		error = -ENOMEM;
-		goto fail_cleanup_queue;
+		goto out_cache_cleanup;
 	}
 
 	priv->gendisk = gendisk;
 	gendisk->major = ps3vram_major;
-	gendisk->first_minor = 0;
+	gendisk->minors = 1;
 	gendisk->fops = &ps3vram_fops;
-	gendisk->queue = queue;
 	gendisk->private_data = dev;
 	strlcpy(gendisk->disk_name, DEVICE_NAME, sizeof(gendisk->disk_name));
 	set_capacity(gendisk, priv->size >> 9);
+	blk_queue_max_segments(gendisk->queue, BLK_MAX_SEGMENTS);
+	blk_queue_max_segment_size(gendisk->queue, BLK_MAX_SEGMENT_SIZE);
+	blk_queue_max_hw_sectors(gendisk->queue, BLK_SAFE_MAX_SECTORS);
 
 	dev_info(&dev->core, "%s: Using %llu MiB of GPU memory\n",
 		 gendisk->disk_name, get_capacity(gendisk) >> 11);
@@ -770,8 +758,6 @@ static int ps3vram_probe(struct ps3_system_bus_device *dev)
 	device_add_disk(&dev->core, gendisk, NULL);
 	return 0;
 
-fail_cleanup_queue:
-	blk_cleanup_queue(queue);
 out_cache_cleanup:
 	remove_proc_entry(DEVICE_NAME, NULL);
 	ps3vram_cache_cleanup(dev);
@@ -802,8 +788,7 @@ static void ps3vram_remove(struct ps3_system_bus_device *dev)
 	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 
 	del_gendisk(priv->gendisk);
-	put_disk(priv->gendisk);
-	blk_cleanup_queue(priv->queue);
+	blk_cleanup_disk(priv->gendisk);
 	remove_proc_entry(DEVICE_NAME, NULL);
 	ps3vram_cache_cleanup(dev);
 	iounmap(priv->reports);
-- 
2.30.2

