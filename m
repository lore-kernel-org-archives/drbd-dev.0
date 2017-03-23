Return-Path: <BATV+f1fc5bea56d51e2fc981+4960+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 742361058005
	for <drbd-dev@lists.linbit.com>; Thu, 23 Mar 2017 16:00:49 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Thu, 23 Mar 2017 10:33:29 -0400
Message-Id: <20170323143341.31549-12-hch@lst.de>
In-Reply-To: <20170323143341.31549-1-hch@lst.de>
References: <20170323143341.31549-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/23] block_dev: use blkdev_issue_zerout for
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
and preparse for removing the discard_zeroes_data flag.

Also remove a pointless discard support check, which is done in
blkdev_issue_discard already.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6128283b7830..5c701c16e8ff 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2074,10 +2074,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 			     loff_t len)
 {
 	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
-	struct request_queue *q = bdev_get_queue(bdev);
 	struct address_space *mapping;
 	loff_t end = start + len - 1;
 	loff_t isize;
+	unsigned flags = 0;
 	int error;
 
 	/* Fail if we don't recognize the flags. */
@@ -2107,21 +2107,15 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	truncate_inode_pages_range(mapping, start, end);
 
 	switch (mode) {
+	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
+		flags = BLKDEV_ZERO_NOFALLBACK;
+		/*FALLTHRU*/
 	case FALLOC_FL_ZERO_RANGE:
 	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
 		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
-					    GFP_KERNEL, 0);
-		break;
-	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
-		/* Only punch if the device can do zeroing discard. */
-		if (!blk_queue_discard(q) || !q->limits.discard_zeroes_data)
-			return -EOPNOTSUPP;
-		error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
-					     GFP_KERNEL, 0);
+					     GFP_KERNEL, flags);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
-		if (!blk_queue_discard(q))
-			return -EOPNOTSUPP;
 		error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
 					     GFP_KERNEL, 0);
 		break;
-- 
2.11.0

