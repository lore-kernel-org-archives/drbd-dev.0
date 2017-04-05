Return-Path: <BATV+9cf0d970ddff402c2c33+4973+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4BE571057FD4
	for <drbd-dev@lists.linbit.com>;
	Wed,  5 Apr 2017 19:37:20 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Wed,  5 Apr 2017 19:21:19 +0200
Message-Id: <20170405172125.22600-22-hch@lst.de>
In-Reply-To: <20170405172125.22600-1-hch@lst.de>
References: <20170405172125.22600-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 21/27] mmc: remove the discard_zeroes_data flag
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

mmc only supports discarding on large alignments, so the zeroing code
would always fall back to explicit writings of zeroes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 drivers/mmc/core/queue.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 493eb10ce580..4c54ad34e17a 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -167,8 +167,6 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
 	blk_queue_max_discard_sectors(q, max_discard);
-	if (card->erased_byte == 0 && !mmc_can_discard(card))
-		q->limits.discard_zeroes_data = 1;
 	q->limits.discard_granularity = card->pref_erase << 9;
 	/* granularity must not be greater than max. discard */
 	if (card->pref_erase > max_discard)
-- 
2.11.0

