Return-Path: <BATV+2133f6211fed31f2c605+4968+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DA2191057FFC
	for <drbd-dev@lists.linbit.com>;
	Fri, 31 Mar 2017 19:05:17 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Fri, 31 Mar 2017 18:33:01 +0200
Message-Id: <20170331163313.31821-14-hch@lst.de>
In-Reply-To: <20170331163313.31821-1-hch@lst.de>
References: <20170331163313.31821-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 13/25] block_dev: use blkdev_issue_zerout for
	hole punches
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

This gets us support for non-discard efficient write of zeroes (e.g. NVMe)
and prepare for removing the discard_zeroes_data flag.

Also remove a pointless discard support check, which is done in
blkdev_issue_discard already.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 2f704c3a816f..e405d8e58e31 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2069,7 +2069,6 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 			     loff_t len)
 {
 	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
-	struct request_queue *q = bdev_get_queue(bdev);
 	struct address_space *mapping;
 	loff_t end = start + len - 1;
 	loff_t isize;
@@ -2108,15 +2107,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 					    GFP_KERNEL, BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
-		/* Only punch if the device can do zeroing discard. */
-		if (!blk_queue_discard(q) || !q->limits.discard_zeroes_data)
-			return -EOPNOTSUPP;
-		error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
-					     GFP_KERNEL, 0);
+		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
+					     GFP_KERNEL, BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
-		if (!blk_queue_discard(q))
-			return -EOPNOTSUPP;
 		error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
 					     GFP_KERNEL, 0);
 		break;
-- 
2.11.0

