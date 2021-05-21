Return-Path: <BATV+940d4f53d1157bf1ee93+6480+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1CD75420BA1
	for <drbd-dev@lists.linbit.com>; Fri, 21 May 2021 11:03:32 +0200 (CEST)
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
Date: Fri, 21 May 2021 07:51:00 +0200
Message-Id: <20210521055116.1053587-11-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 10/26] zram: convert to
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

Convert the zram driver to use the blk_alloc_disk and blk_cleanup_disk
helpers to simplify gendisk and request_queue allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cf8deecc39ef..006416cc4969 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1890,7 +1890,6 @@ static const struct attribute_group *zram_disk_attr_groups[] = {
 static int zram_add(void)
 {
 	struct zram *zram;
-	struct request_queue *queue;
 	int ret, device_id;
 
 	zram = kzalloc(sizeof(struct zram), GFP_KERNEL);
@@ -1906,27 +1905,20 @@ static int zram_add(void)
 #ifdef CONFIG_ZRAM_WRITEBACK
 	spin_lock_init(&zram->wb_limit_lock);
 #endif
-	queue = blk_alloc_queue(NUMA_NO_NODE);
-	if (!queue) {
-		pr_err("Error allocating disk queue for device %d\n",
-			device_id);
-		ret = -ENOMEM;
-		goto out_free_idr;
-	}
 
 	/* gendisk structure */
-	zram->disk = alloc_disk(1);
+	zram->disk = blk_alloc_disk(NUMA_NO_NODE);
 	if (!zram->disk) {
 		pr_err("Error allocating disk structure for device %d\n",
 			device_id);
 		ret = -ENOMEM;
-		goto out_free_queue;
+		goto out_free_idr;
 	}
 
 	zram->disk->major = zram_major;
 	zram->disk->first_minor = device_id;
+	zram->disk->minors = 1;
 	zram->disk->fops = &zram_devops;
-	zram->disk->queue = queue;
 	zram->disk->private_data = zram;
 	snprintf(zram->disk->disk_name, 16, "zram%d", device_id);
 
@@ -1969,8 +1961,6 @@ static int zram_add(void)
 	pr_info("Added device: %s\n", zram->disk->disk_name);
 	return device_id;
 
-out_free_queue:
-	blk_cleanup_queue(queue);
 out_free_idr:
 	idr_remove(&zram_index_idr, device_id);
 out_free_dev:
@@ -2000,8 +1990,7 @@ static int zram_remove(struct zram *zram)
 	pr_info("Removed device: %s\n", zram->disk->disk_name);
 
 	del_gendisk(zram->disk);
-	blk_cleanup_queue(zram->disk->queue);
-	put_disk(zram->disk);
+	blk_cleanup_disk(zram->disk);
 	kfree(zram);
 	return 0;
 }
-- 
2.30.2

