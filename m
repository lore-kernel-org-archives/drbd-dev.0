Return-Path: <BATV+2133f6211fed31f2c605+4968+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A85E11057FD3
	for <drbd-dev@lists.linbit.com>;
	Fri, 31 Mar 2017 18:59:42 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Fri, 31 Mar 2017 18:33:08 +0200
Message-Id: <20170331163313.31821-21-hch@lst.de>
In-Reply-To: <20170331163313.31821-1-hch@lst.de>
References: <20170331163313.31821-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 20/25] rsxx: remove the discard_zeroes_data flag
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

rsxx only supports discarding on large alignments, so the zeroing code
would always fall back to explicit writings of zeroes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/rsxx/dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/rsxx/dev.c b/drivers/block/rsxx/dev.c
index f81d70b39d10..9c566364ac9c 100644
--- a/drivers/block/rsxx/dev.c
+++ b/drivers/block/rsxx/dev.c
@@ -300,7 +300,6 @@ int rsxx_setup_dev(struct rsxx_cardinfo *card)
 						RSXX_HW_BLK_SIZE >> 9);
 		card->queue->limits.discard_granularity = RSXX_HW_BLK_SIZE;
 		card->queue->limits.discard_alignment   = RSXX_HW_BLK_SIZE;
-		card->queue->limits.discard_zeroes_data = 1;
 	}
 
 	card->queue->queuedata = card;
-- 
2.11.0

