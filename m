Return-Path: <BATV+f1fc5bea56d51e2fc981+4960+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 73F3F1058008
	for <drbd-dev@lists.linbit.com>; Thu, 23 Mar 2017 16:00:52 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Thu, 23 Mar 2017 10:33:32 -0400
Message-Id: <20170323143341.31549-15-hch@lst.de>
In-Reply-To: <20170323143341.31549-1-hch@lst.de>
References: <20170323143341.31549-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 14/23] zram: implement REQ_OP_WRITE_ZEROES
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Just the same as discard if the block size equals the system page size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index dceb5edd1e54..1710b06f04a7 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -829,10 +829,14 @@ static void __zram_make_request(struct zram *zram, struct bio *bio)
 	offset = (bio->bi_iter.bi_sector &
 		  (SECTORS_PER_PAGE - 1)) << SECTOR_SHIFT;
 
-	if (unlikely(bio_op(bio) == REQ_OP_DISCARD)) {
+	switch (bio_op(bio)) {
+	case REQ_OP_DISCARD:
+	case REQ_OP_WRITE_ZEROES:
 		zram_bio_discard(zram, index, offset, bio);
 		bio_endio(bio);
 		return;
+	default:
+		break;
 	}
 
 	bio_for_each_segment(bvec, bio, iter) {
@@ -1192,6 +1196,8 @@ static int zram_add(void)
 	zram->disk->queue->limits.max_sectors = SECTORS_PER_PAGE;
 	zram->disk->queue->limits.chunk_sectors = 0;
 	blk_queue_max_discard_sectors(zram->disk->queue, UINT_MAX);
+	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, zram->disk->queue);
+
 	/*
 	 * zram_bio_discard() will clear all logical blocks if logical block
 	 * size is identical with physical block size(PAGE_SIZE). But if it is
@@ -1201,10 +1207,7 @@ static int zram_add(void)
 	 * zeroed.
 	 */
 	if (ZRAM_LOGICAL_BLOCK_SIZE == PAGE_SIZE)
-		zram->disk->queue->limits.discard_zeroes_data = 1;
-	else
-		zram->disk->queue->limits.discard_zeroes_data = 0;
-	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, zram->disk->queue);
+		blk_queue_max_write_zeroes_sectors(zram->disk->queue, UINT_MAX);
 
 	add_disk(zram->disk);
 
-- 
2.11.0

