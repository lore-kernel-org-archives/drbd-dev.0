Return-Path: <BATV+940d4f53d1157bf1ee93+6480+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0F7EA4205D5
	for <drbd-dev@lists.linbit.com>; Fri, 21 May 2021 09:03:36 +0200 (CEST)
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
Date: Fri, 21 May 2021 07:51:14 +0200
Message-Id: <20210521055116.1053587-25-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 24/26] xpram: convert to
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

Convert the xpram driver to use the blk_alloc_disk and blk_cleanup_disk
helpers to simplify gendisk and request_queue allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/s390/block/xpram.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
index d1ed39162943..91ef710edfd2 100644
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -56,7 +56,6 @@ typedef struct {
 static xpram_device_t xpram_devices[XPRAM_MAX_DEVS];
 static unsigned int xpram_sizes[XPRAM_MAX_DEVS];
 static struct gendisk *xpram_disks[XPRAM_MAX_DEVS];
-static struct request_queue *xpram_queues[XPRAM_MAX_DEVS];
 static unsigned int xpram_pages;
 static int xpram_devs;
 
@@ -341,17 +340,13 @@ static int __init xpram_setup_blkdev(void)
 	int i, rc = -ENOMEM;
 
 	for (i = 0; i < xpram_devs; i++) {
-		xpram_disks[i] = alloc_disk(1);
+		xpram_disks[i] = blk_alloc_disk(NUMA_NO_NODE);
 		if (!xpram_disks[i])
 			goto out;
-		xpram_queues[i] = blk_alloc_queue(NUMA_NO_NODE);
-		if (!xpram_queues[i]) {
-			put_disk(xpram_disks[i]);
-			goto out;
-		}
-		blk_queue_flag_set(QUEUE_FLAG_NONROT, xpram_queues[i]);
-		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, xpram_queues[i]);
-		blk_queue_logical_block_size(xpram_queues[i], 4096);
+		blk_queue_flag_set(QUEUE_FLAG_NONROT, xpram_disks[i]->queue);
+		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM,
+				xpram_disks[i]->queue);
+		blk_queue_logical_block_size(xpram_disks[i]->queue, 4096);
 	}
 
 	/*
@@ -373,9 +368,9 @@ static int __init xpram_setup_blkdev(void)
 		offset += xpram_devices[i].size;
 		disk->major = XPRAM_MAJOR;
 		disk->first_minor = i;
+		disk->minors = 1;
 		disk->fops = &xpram_devops;
 		disk->private_data = &xpram_devices[i];
-		disk->queue = xpram_queues[i];
 		sprintf(disk->disk_name, "slram%d", i);
 		set_capacity(disk, xpram_sizes[i] << 1);
 		add_disk(disk);
@@ -383,10 +378,8 @@ static int __init xpram_setup_blkdev(void)
 
 	return 0;
 out:
-	while (i--) {
-		blk_cleanup_queue(xpram_queues[i]);
-		put_disk(xpram_disks[i]);
-	}
+	while (i--)
+		blk_cleanup_disk(xpram_disks[i]);
 	return rc;
 }
 
@@ -434,8 +427,7 @@ static void __exit xpram_exit(void)
 	int i;
 	for (i = 0; i < xpram_devs; i++) {
 		del_gendisk(xpram_disks[i]);
-		blk_cleanup_queue(xpram_queues[i]);
-		put_disk(xpram_disks[i]);
+		blk_cleanup_disk(xpram_disks[i]);
 	}
 	unregister_blkdev(XPRAM_MAJOR, XPRAM_NAME);
 	platform_device_unregister(xpram_pdev);
-- 
2.30.2

