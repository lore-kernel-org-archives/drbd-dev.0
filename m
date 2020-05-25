Return-Path: <BATV+ab9bb8b38cf50d3a9241+6119+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6EE2E4202B5
	for <drbd-dev@lists.linbit.com>; Mon, 25 May 2020 13:30:35 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Mon, 25 May 2020 13:30:01 +0200
Message-Id: <20200525113014.345997-4-hch@lst.de>
In-Reply-To: <20200525113014.345997-1-hch@lst.de>
References: <20200525113014.345997-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-nvdimm@lists.01.org,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
	linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
	dm-devel@redhat.com, Nitin Gupta <ngupta@vflare.org>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/16] rsxx: use bio_{start,end}_io_acct
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

Switch rsxx to use the nicer bio accounting helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/rsxx/dev.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/block/rsxx/dev.c b/drivers/block/rsxx/dev.c
index 8ffa8260dcafe..3ba07ab30c84f 100644
--- a/drivers/block/rsxx/dev.c
+++ b/drivers/block/rsxx/dev.c
@@ -96,20 +96,6 @@ static const struct block_device_operations rsxx_fops = {
 	.ioctl		= rsxx_blkdev_ioctl,
 };
 
-static void disk_stats_start(struct rsxx_cardinfo *card, struct bio *bio)
-{
-	generic_start_io_acct(card->queue, bio_op(bio), bio_sectors(bio),
-			     &card->gendisk->part0);
-}
-
-static void disk_stats_complete(struct rsxx_cardinfo *card,
-				struct bio *bio,
-				unsigned long start_time)
-{
-	generic_end_io_acct(card->queue, bio_op(bio),
-			    &card->gendisk->part0, start_time);
-}
-
 static void bio_dma_done_cb(struct rsxx_cardinfo *card,
 			    void *cb_data,
 			    unsigned int error)
@@ -121,7 +107,7 @@ static void bio_dma_done_cb(struct rsxx_cardinfo *card,
 
 	if (atomic_dec_and_test(&meta->pending_dmas)) {
 		if (!card->eeh_state && card->gendisk)
-			disk_stats_complete(card, meta->bio, meta->start_time);
+			bio_end_io_acct(meta->bio, meta->start_time);
 
 		if (atomic_read(&meta->error))
 			bio_io_error(meta->bio);
@@ -167,10 +153,9 @@ static blk_qc_t rsxx_make_request(struct request_queue *q, struct bio *bio)
 	bio_meta->bio = bio;
 	atomic_set(&bio_meta->error, 0);
 	atomic_set(&bio_meta->pending_dmas, 0);
-	bio_meta->start_time = jiffies;
 
 	if (!unlikely(card->halt))
-		disk_stats_start(card, bio);
+		bio_meta->start_time = bio_start_io_acct(bio);
 
 	dev_dbg(CARD_TO_DEV(card), "BIO[%c]: meta: %p addr8: x%llx size: %d\n",
 		 bio_data_dir(bio) ? 'W' : 'R', bio_meta,
-- 
2.26.2

