Return-Path: <BATV+0d14f5278154a06d8b22+6154+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7E15B4203E3
	for <drbd-dev@lists.linbit.com>; Mon, 29 Jun 2020 22:23:04 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Mon, 29 Jun 2020 21:39:35 +0200
Message-Id: <20200629193947.2705954-9-hch@lst.de>
In-Reply-To: <20200629193947.2705954-1-hch@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org,
	linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org,
	dm-devel@redhat.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 08/20] zram: stop using ->queuedata
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

Instead of setting up the queuedata as well just use one private data
field.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6e2ad90b17a376..0564e3f384089e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1586,7 +1586,7 @@ static void __zram_make_request(struct zram *zram, struct bio *bio)
  */
 static blk_qc_t zram_make_request(struct request_queue *queue, struct bio *bio)
 {
-	struct zram *zram = queue->queuedata;
+	struct zram *zram = bio->bi_disk->private_data;
 
 	if (!valid_io_request(zram, bio->bi_iter.bi_sector,
 					bio->bi_iter.bi_size)) {
@@ -1912,7 +1912,6 @@ static int zram_add(void)
 	zram->disk->first_minor = device_id;
 	zram->disk->fops = &zram_devops;
 	zram->disk->queue = queue;
-	zram->disk->queue->queuedata = zram;
 	zram->disk->private_data = zram;
 	snprintf(zram->disk->disk_name, 16, "zram%d", device_id);
 
-- 
2.26.2

