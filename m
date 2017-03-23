Return-Path: <BATV+f1fc5bea56d51e2fc981+4960+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 26A981057FFC
	for <drbd-dev@lists.linbit.com>; Thu, 23 Mar 2017 15:59:44 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Thu, 23 Mar 2017 10:33:33 -0400
Message-Id: <20170323143341.31549-16-hch@lst.de>
In-Reply-To: <20170323143341.31549-1-hch@lst.de>
References: <20170323143341.31549-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 15/23] loop: implement REQ_OP_WRITE_ZEROES
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

It's identical to discard as hole punches will always leave us with
zeroes on reads.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0ecb6461ed81..265cd2e33ff0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -528,6 +528,7 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 	case REQ_OP_FLUSH:
 		return lo_req_flush(lo, rq);
 	case REQ_OP_DISCARD:
+	case REQ_OP_WRITE_ZEROES:
 		return lo_discard(lo, rq, pos);
 	case REQ_OP_WRITE:
 		if (lo->transfer)
@@ -826,6 +827,7 @@ static void loop_config_discard(struct loop_device *lo)
 		q->limits.discard_granularity = 0;
 		q->limits.discard_alignment = 0;
 		blk_queue_max_discard_sectors(q, 0);
+		blk_queue_max_write_zeroes_sectors(q, 0);
 		q->limits.discard_zeroes_data = 0;
 		queue_flag_clear_unlocked(QUEUE_FLAG_DISCARD, q);
 		return;
@@ -834,6 +836,7 @@ static void loop_config_discard(struct loop_device *lo)
 	q->limits.discard_granularity = inode->i_sb->s_blocksize;
 	q->limits.discard_alignment = 0;
 	blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
+	blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
 	q->limits.discard_zeroes_data = 1;
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
 }
@@ -1660,6 +1663,7 @@ static int loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	switch (req_op(cmd->rq)) {
 	case REQ_OP_FLUSH:
 	case REQ_OP_DISCARD:
+	case REQ_OP_WRITE_ZEROES:
 		cmd->use_aio = false;
 		break;
 	default:
-- 
2.11.0

