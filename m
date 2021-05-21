Return-Path: <BATV+940d4f53d1157bf1ee93+6480+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 88DEE4205C8
	for <drbd-dev@lists.linbit.com>; Fri, 21 May 2021 09:03:34 +0200 (CEST)
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
Date: Fri, 21 May 2021 07:50:52 +0200
Message-Id: <20210521055116.1053587-3-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 02/26] block: move the DISK_MAX_PARTS sanity
	check into __device_add_disk
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

Keep this together with the first place that actually looks at
->minors and prepare for not passing a minors argument to
alloc_disk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 2c00bc3261d9..7f9beaeede11 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -491,6 +491,12 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	 */
 	if (disk->major) {
 		WARN_ON(!disk->minors);
+
+		if (disk->minors > DISK_MAX_PARTS) {
+			pr_err("block: can't allocate more than %d partitions\n",
+				DISK_MAX_PARTS);
+			disk->minors = DISK_MAX_PARTS;
+		}
 	} else {
 		WARN_ON(disk->minors);
 		WARN_ON(!(disk->flags & (GENHD_FL_EXT_DEVT | GENHD_FL_HIDDEN)));
@@ -1264,13 +1270,6 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 {
 	struct gendisk *disk;
 
-	if (minors > DISK_MAX_PARTS) {
-		printk(KERN_ERR
-			"block: can't allocate more than %d partitions\n",
-			DISK_MAX_PARTS);
-		minors = DISK_MAX_PARTS;
-	}
-
 	disk = kzalloc_node(sizeof(struct gendisk), GFP_KERNEL, node_id);
 	if (!disk)
 		return NULL;
-- 
2.30.2

