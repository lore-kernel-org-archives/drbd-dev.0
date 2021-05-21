Return-Path: <BATV+940d4f53d1157bf1ee93+6480+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 755A8420955
	for <drbd-dev@lists.linbit.com>; Fri, 21 May 2021 10:03:36 +0200 (CEST)
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
Date: Fri, 21 May 2021 07:51:04 +0200
Message-Id: <20210521055116.1053587-15-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 14/26] md: convert to
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

Convert the md driver to use the blk_alloc_disk and blk_cleanup_disk
helpers to simplify gendisk and request_queue allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 49f897fbb89b..d806be8cc210 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5598,12 +5598,10 @@ static void md_free(struct kobject *ko)
 	if (mddev->sysfs_level)
 		sysfs_put(mddev->sysfs_level);
 
-	if (mddev->gendisk)
+	if (mddev->gendisk) {
 		del_gendisk(mddev->gendisk);
-	if (mddev->queue)
-		blk_cleanup_queue(mddev->queue);
-	if (mddev->gendisk)
-		put_disk(mddev->gendisk);
+		blk_cleanup_disk(mddev->gendisk);
+	}
 	percpu_ref_exit(&mddev->writes_pending);
 
 	bioset_exit(&mddev->bio_set);
@@ -5711,20 +5709,13 @@ static int md_alloc(dev_t dev, char *name)
 		goto abort;
 
 	error = -ENOMEM;
-	mddev->queue = blk_alloc_queue(NUMA_NO_NODE);
-	if (!mddev->queue)
+	disk = blk_alloc_disk(NUMA_NO_NODE);
+	if (!disk)
 		goto abort;
 
-	blk_set_stacking_limits(&mddev->queue->limits);
-
-	disk = alloc_disk(1 << shift);
-	if (!disk) {
-		blk_cleanup_queue(mddev->queue);
-		mddev->queue = NULL;
-		goto abort;
-	}
 	disk->major = MAJOR(mddev->unit);
 	disk->first_minor = unit << shift;
+	disk->minors = 1 << shift;
 	if (name)
 		strcpy(disk->disk_name, name);
 	else if (partitioned)
@@ -5733,7 +5724,9 @@ static int md_alloc(dev_t dev, char *name)
 		sprintf(disk->disk_name, "md%d", unit);
 	disk->fops = &md_fops;
 	disk->private_data = mddev;
-	disk->queue = mddev->queue;
+
+	mddev->queue = disk->queue;
+	blk_set_stacking_limits(&mddev->queue->limits);
 	blk_queue_write_cache(mddev->queue, true, true);
 	/* Allow extended partitions.  This makes the
 	 * 'mdp' device redundant, but we can't really
-- 
2.30.2

