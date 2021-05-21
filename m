Return-Path: <BATV+940d4f53d1157bf1ee93+6480+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7C7DE420620
	for <drbd-dev@lists.linbit.com>; Fri, 21 May 2021 10:03:32 +0200 (CEST)
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
Date: Fri, 21 May 2021 07:50:59 +0200
Message-Id: <20210521055116.1053587-10-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 09/26] rsxx: convert to
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

Convert the rsxx driver to use the blk_alloc_disk and blk_cleanup_disk
helpers to simplify gendisk and request_queue allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/rsxx/dev.c       | 39 +++++++++++++---------------------
 drivers/block/rsxx/rsxx_priv.h |  1 -
 2 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/block/rsxx/dev.c b/drivers/block/rsxx/dev.c
index 9a28322a8cd8..1cc40b0ea761 100644
--- a/drivers/block/rsxx/dev.c
+++ b/drivers/block/rsxx/dev.c
@@ -236,47 +236,40 @@ int rsxx_setup_dev(struct rsxx_cardinfo *card)
 		return -ENOMEM;
 	}
 
-	card->queue = blk_alloc_queue(NUMA_NO_NODE);
-	if (!card->queue) {
-		dev_err(CARD_TO_DEV(card), "Failed queue alloc\n");
-		unregister_blkdev(card->major, DRIVER_NAME);
-		return -ENOMEM;
-	}
-
-	card->gendisk = alloc_disk(blkdev_minors);
+	card->gendisk = blk_alloc_disk(blkdev_minors);
 	if (!card->gendisk) {
 		dev_err(CARD_TO_DEV(card), "Failed disk alloc\n");
-		blk_cleanup_queue(card->queue);
 		unregister_blkdev(card->major, DRIVER_NAME);
 		return -ENOMEM;
 	}
 
 	if (card->config_valid) {
 		blk_size = card->config.data.block_size;
-		blk_queue_dma_alignment(card->queue, blk_size - 1);
-		blk_queue_logical_block_size(card->queue, blk_size);
+		blk_queue_dma_alignment(card->gendisk->queue, blk_size - 1);
+		blk_queue_logical_block_size(card->gendisk->queue, blk_size);
 	}
 
-	blk_queue_max_hw_sectors(card->queue, blkdev_max_hw_sectors);
-	blk_queue_physical_block_size(card->queue, RSXX_HW_BLK_SIZE);
+	blk_queue_max_hw_sectors(card->gendisk->queue, blkdev_max_hw_sectors);
+	blk_queue_physical_block_size(card->gendisk->queue, RSXX_HW_BLK_SIZE);
 
-	blk_queue_flag_set(QUEUE_FLAG_NONROT, card->queue);
-	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, card->queue);
+	blk_queue_flag_set(QUEUE_FLAG_NONROT, card->gendisk->queue);
+	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, card->gendisk->queue);
 	if (rsxx_discard_supported(card)) {
-		blk_queue_flag_set(QUEUE_FLAG_DISCARD, card->queue);
-		blk_queue_max_discard_sectors(card->queue,
+		blk_queue_flag_set(QUEUE_FLAG_DISCARD, card->gendisk->queue);
+		blk_queue_max_discard_sectors(card->gendisk->queue,
 						RSXX_HW_BLK_SIZE >> 9);
-		card->queue->limits.discard_granularity = RSXX_HW_BLK_SIZE;
-		card->queue->limits.discard_alignment   = RSXX_HW_BLK_SIZE;
+		card->gendisk->queue->limits.discard_granularity =
+			RSXX_HW_BLK_SIZE;
+		card->gendisk->queue->limits.discard_alignment =
+			RSXX_HW_BLK_SIZE;
 	}
 
 	snprintf(card->gendisk->disk_name, sizeof(card->gendisk->disk_name),
 		 "rsxx%d", card->disk_id);
 	card->gendisk->major = card->major;
-	card->gendisk->first_minor = 0;
+	card->gendisk->minors = blkdev_minors;
 	card->gendisk->fops = &rsxx_fops;
 	card->gendisk->private_data = card;
-	card->gendisk->queue = card->queue;
 
 	return 0;
 }
@@ -286,10 +279,8 @@ void rsxx_destroy_dev(struct rsxx_cardinfo *card)
 	if (!enable_blkdev)
 		return;
 
-	put_disk(card->gendisk);
+	blk_cleanup_disk(card->gendisk);
 	card->gendisk = NULL;
-
-	blk_cleanup_queue(card->queue);
 	unregister_blkdev(card->major, DRIVER_NAME);
 }
 
diff --git a/drivers/block/rsxx/rsxx_priv.h b/drivers/block/rsxx/rsxx_priv.h
index 6147977994ff..26c320c0d924 100644
--- a/drivers/block/rsxx/rsxx_priv.h
+++ b/drivers/block/rsxx/rsxx_priv.h
@@ -154,7 +154,6 @@ struct rsxx_cardinfo {
 	bool			bdev_attached;
 	int			disk_id;
 	int			major;
-	struct request_queue	*queue;
 	struct gendisk		*gendisk;
 	struct {
 		/* Used to convert a byte address to a device address. */
-- 
2.30.2

