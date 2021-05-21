Return-Path: <BATV+940d4f53d1157bf1ee93+6480+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id ED4C1420BA7
	for <drbd-dev@lists.linbit.com>; Fri, 21 May 2021 11:03:33 +0200 (CEST)
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
Date: Fri, 21 May 2021 07:50:57 +0200
Message-Id: <20210521055116.1053587-8-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 07/26] drbd: convert to
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

Convert the drbd driver to use the blk_alloc_disk and blk_cleanup_disk
helpers to simplify gendisk and request_queue allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_main.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index de463773b530..55234a558e98 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2231,8 +2231,7 @@ void drbd_destroy_device(struct kref *kref)
 	if (device->bitmap) /* should no longer be there. */
 		drbd_bm_cleanup(device);
 	__free_page(device->md_io.page);
-	put_disk(device->vdisk);
-	blk_cleanup_queue(device->rq_queue);
+	blk_cleanup_disk(device->vdisk);
 	kfree(device->rs_plan_s);
 
 	/* not for_each_connection(connection, resource):
@@ -2701,7 +2700,6 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	struct drbd_device *device;
 	struct drbd_peer_device *peer_device, *tmp_peer_device;
 	struct gendisk *disk;
-	struct request_queue *q;
 	int id;
 	int vnr = adm_ctx->volume;
 	enum drbd_ret_code err = ERR_NOMEM;
@@ -2723,29 +2721,26 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 
 	drbd_init_set_defaults(device);
 
-	q = blk_alloc_queue(NUMA_NO_NODE);
-	if (!q)
-		goto out_no_q;
-	device->rq_queue = q;
-
-	disk = alloc_disk(1);
+	disk = blk_alloc_disk(NUMA_NO_NODE);
 	if (!disk)
 		goto out_no_disk;
+
 	device->vdisk = disk;
+	device->rq_queue = disk->queue;
 
 	set_disk_ro(disk, true);
 
-	disk->queue = q;
 	disk->major = DRBD_MAJOR;
 	disk->first_minor = minor;
+	disk->minors = 1;
 	disk->fops = &drbd_ops;
 	sprintf(disk->disk_name, "drbd%d", minor);
 	disk->private_data = device;
 
-	blk_queue_write_cache(q, true, true);
+	blk_queue_write_cache(disk->queue, true, true);
 	/* Setting the max_hw_sectors to an odd value of 8kibyte here
 	   This triggers a max_bio_size message upon first attach or connect */
-	blk_queue_max_hw_sectors(q, DRBD_MAX_BIO_SIZE_SAFE >> 8);
+	blk_queue_max_hw_sectors(disk->queue, DRBD_MAX_BIO_SIZE_SAFE >> 8);
 
 	device->md_io.page = alloc_page(GFP_KERNEL);
 	if (!device->md_io.page)
@@ -2834,10 +2829,8 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 out_no_bitmap:
 	__free_page(device->md_io.page);
 out_no_io_page:
-	put_disk(disk);
+	blk_cleanup_disk(disk);
 out_no_disk:
-	blk_cleanup_queue(q);
-out_no_q:
 	kref_put(&resource->kref, drbd_destroy_resource);
 	kfree(device);
 	return err;
-- 
2.30.2

