Return-Path: <BATV+940d4f53d1157bf1ee93+6480+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 93F1342062F
	for <drbd-dev@lists.linbit.com>; Fri, 21 May 2021 10:03:33 +0200 (CEST)
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
Date: Fri, 21 May 2021 07:51:10 +0200
Message-Id: <20210521055116.1053587-21-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 20/26] simdisk: convert to
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

Convert the simdisk driver to use the blk_alloc_disk and blk_cleanup_disk
helpers to simplify gendisk and request_queue allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/xtensa/platforms/iss/simdisk.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index fc09be7b1347..3cdfa00738e0 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -27,7 +27,6 @@
 struct simdisk {
 	const char *filename;
 	spinlock_t lock;
-	struct request_queue *queue;
 	struct gendisk *gd;
 	struct proc_dir_entry *procfile;
 	int users;
@@ -266,21 +265,13 @@ static int __init simdisk_setup(struct simdisk *dev, int which,
 	spin_lock_init(&dev->lock);
 	dev->users = 0;
 
-	dev->queue = blk_alloc_queue(NUMA_NO_NODE);
-	if (dev->queue == NULL) {
-		pr_err("blk_alloc_queue failed\n");
-		goto out_alloc_queue;
-	}
-
-	dev->gd = alloc_disk(SIMDISK_MINORS);
-	if (dev->gd == NULL) {
-		pr_err("alloc_disk failed\n");
-		goto out_alloc_disk;
-	}
+	dev->gd = blk_alloc_disk(NUMA_NO_NODE);
+	if (!dev->gd)
+		return -ENOMEM;
 	dev->gd->major = simdisk_major;
 	dev->gd->first_minor = which;
+	dev->gd->minors = SIMDISK_MINORS;
 	dev->gd->fops = &simdisk_ops;
-	dev->gd->queue = dev->queue;
 	dev->gd->private_data = dev;
 	snprintf(dev->gd->disk_name, 32, "simdisk%d", which);
 	set_capacity(dev->gd, 0);
@@ -288,12 +279,6 @@ static int __init simdisk_setup(struct simdisk *dev, int which,
 
 	dev->procfile = proc_create_data(tmp, 0644, procdir, &simdisk_proc_ops, dev);
 	return 0;
-
-out_alloc_disk:
-	blk_cleanup_queue(dev->queue);
-	dev->queue = NULL;
-out_alloc_queue:
-	return -ENOMEM;
 }
 
 static int __init simdisk_init(void)
@@ -343,10 +328,10 @@ static void simdisk_teardown(struct simdisk *dev, int which,
 	char tmp[2] = { '0' + which, 0 };
 
 	simdisk_detach(dev);
-	if (dev->gd)
+	if (dev->gd) {
 		del_gendisk(dev->gd);
-	if (dev->queue)
-		blk_cleanup_queue(dev->queue);
+		blk_cleanup_disk(dev->gd);
+	}
 	remove_proc_entry(tmp, procdir);
 }
 
-- 
2.30.2

