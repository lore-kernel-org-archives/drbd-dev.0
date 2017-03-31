Return-Path: <BATV+2133f6211fed31f2c605+4968+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DCCF61057FD5
	for <drbd-dev@lists.linbit.com>;
	Fri, 31 Mar 2017 18:33:46 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Fri, 31 Mar 2017 18:32:57 +0200
Message-Id: <20170331163313.31821-10-hch@lst.de>
In-Reply-To: <20170331163313.31821-1-hch@lst.de>
References: <20170331163313.31821-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/25] block: stop using blkdev_issue_write_same
	for zeroing
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

We'll always use the WRITE ZEROES code for zeroing now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e5b853f2b8a2..2a8d638544a7 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -364,10 +364,6 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 			return 0;
 	}
 
-	if (!blkdev_issue_write_same(bdev, sector, nr_sects, gfp_mask,
-			ZERO_PAGE(0)))
-		return 0;
-
 	blk_start_plug(&plug);
 	ret = __blkdev_issue_zeroout(bdev, sector, nr_sects, gfp_mask,
 			&bio, discard);
-- 
2.11.0

