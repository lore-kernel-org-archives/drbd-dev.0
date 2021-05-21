Return-Path: <BATV+940d4f53d1157bf1ee93+6480+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D3EB0420956
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
Date: Fri, 21 May 2021 07:51:03 +0200
Message-Id: <20210521055116.1053587-14-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 13/26] dm: convert to
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

Convert the dm driver to use the blk_alloc_disk and blk_cleanup_disk
helpers to simplify gendisk and request_queue allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index ca2aedd8ee7d..3c7c2d257018 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1801,13 +1801,13 @@ static void cleanup_mapped_device(struct mapped_device *md)
 		md->disk->private_data = NULL;
 		spin_unlock(&_minor_lock);
 		del_gendisk(md->disk);
-		put_disk(md->disk);
 	}
 
-	if (md->queue) {
+	if (md->queue)
 		dm_queue_destroy_keyslot_manager(md->queue);
-		blk_cleanup_queue(md->queue);
-	}
+
+	if (md->disk)
+		blk_cleanup_disk(md->disk);
 
 	cleanup_srcu_struct(&md->io_barrier);
 
@@ -1869,13 +1869,10 @@ static struct mapped_device *alloc_dev(int minor)
 	 * established. If request-based table is loaded: blk-mq will
 	 * override accordingly.
 	 */
-	md->queue = blk_alloc_queue(numa_node_id);
-	if (!md->queue)
-		goto bad;
-
-	md->disk = alloc_disk_node(1, md->numa_node_id);
+	md->disk = blk_alloc_disk(md->numa_node_id);
 	if (!md->disk)
 		goto bad;
+	md->queue = md->disk->queue;
 
 	init_waitqueue_head(&md->wait);
 	INIT_WORK(&md->work, dm_wq_work);
@@ -1888,6 +1885,7 @@ static struct mapped_device *alloc_dev(int minor)
 
 	md->disk->major = _major;
 	md->disk->first_minor = minor;
+	md->disk->minors = 1;
 	md->disk->fops = &dm_blk_dops;
 	md->disk->queue = md->queue;
 	md->disk->private_data = md;
-- 
2.30.2

