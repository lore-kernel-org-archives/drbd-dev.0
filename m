Return-Path: <BATV+ade674efe42abf9194a0+6102+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id EC607420308
	for <drbd-dev@lists.linbit.com>; Fri,  8 May 2020 18:44:34 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Fri,  8 May 2020 18:15:06 +0200
Message-Id: <20200508161517.252308-5-hch@lst.de>
In-Reply-To: <20200508161517.252308-1-hch@lst.de>
References: <20200508161517.252308-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org,
	linux-raid@vger.kernel.org,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	linux-nvdimm@lists.01.org, Geoff Levand <geoff@infradead.org>,
	linux-kernel@vger.kernel.org, Jim Paris <jim@jtan.com>,
	linux-block@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
	linux-m68k@lists.linux-m68k.org, Philip Kelleher <pjk1939@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Joshua Morris <josh.h.morris@us.ibm.com>,
	Nitin Gupta <ngupta@vflare.org>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 04/15] null_blk: stop using ->queuedata for bio
	mode
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/null_blk_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 8efd8778e2095..d14df79feca89 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1365,7 +1365,7 @@ static blk_qc_t null_queue_bio(struct request_queue *q, struct bio *bio)
 {
 	sector_t sector = bio->bi_iter.bi_sector;
 	sector_t nr_sectors = bio_sectors(bio);
-	struct nullb *nullb = q->queuedata;
+	struct nullb *nullb = bio->bi_disk->private_data;
 	struct nullb_queue *nq = nullb_to_queue(nullb);
 	struct nullb_cmd *cmd;
 
-- 
2.26.2

