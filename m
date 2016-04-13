Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8031A1056461
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 13:26:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 6440A40A530
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 13:26:46 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id hekQDgsolRJU for <drbd-dev@lists.linbit.com>;
	Thu, 14 Apr 2016 13:26:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 16ECC40A546
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 13:26:46 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lnPsiC3yaK1j for <drbd-dev@lists.linbit.com>;
	Thu, 14 Apr 2016 13:26:46 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id E26EF40A530
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 13:26:45 +0200 (CEST)
Resent-Message-ID: <20160414112645.GO3078@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A954F1056454
	for <drbd-dev@lists.linbit.com>; Wed, 13 Apr 2016 21:37:47 +0200 (CEST)
From: mchristi@redhat.com
To: linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
	konrad.wilk@oracle.com, drbd-dev@lists.linbit.com,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	linux-raid@vger.kernel.org, dm-devel@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-mtd@lists.infradead.org,
	target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	osd-dev@open-osd.org, xfs@oss.sgi.com, ocfs2-devel@oss.oracle.com
Date: Wed, 13 Apr 2016 14:36:17 -0500
Message-Id: <1460576188-5751-32-git-send-email-mchristi@redhat.com>
In-Reply-To: <1460576188-5751-1-git-send-email-mchristi@redhat.com>
References: <1460576188-5751-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 31/42] block: convert merge/insert code to check
	for REQ_OPs.
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

From: Mike Christie <mchristi@redhat.com>

This patch converts the block layer merging code to use separate variables
for the operation and flags, and to check request->op for the REQ_OP.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       |  2 +-
 block/blk-merge.c      | 10 ++++++----
 include/linux/blkdev.h | 20 ++++++++++----------
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 3ec1310..5632cd1 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2175,7 +2175,7 @@ EXPORT_SYMBOL(submit_bio);
 static int blk_cloned_rq_check_limits(struct request_queue *q,
 				      struct request *rq)
 {
-	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, rq->cmd_flags)) {
+	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, rq->op)) {
 		printk(KERN_ERR "%s: over max size limit.\n", __func__);
 		return -EIO;
 	}
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2613531..c02371f 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -649,7 +649,8 @@ static int attempt_merge(struct request_queue *q, struct request *req,
 	if (!rq_mergeable(req) || !rq_mergeable(next))
 		return 0;
 
-	if (!blk_check_merge_flags(req->cmd_flags, next->cmd_flags))
+	if (!blk_check_merge_flags(req->cmd_flags, req->op, next->cmd_flags,
+				   next->op))
 		return 0;
 
 	/*
@@ -663,7 +664,7 @@ static int attempt_merge(struct request_queue *q, struct request *req,
 	    || req_no_special_merge(next))
 		return 0;
 
-	if (req->cmd_flags & REQ_WRITE_SAME &&
+	if (req->op == REQ_OP_WRITE_SAME &&
 	    !blk_write_same_mergeable(req->bio, next->bio))
 		return 0;
 
@@ -751,7 +752,8 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (!rq_mergeable(rq) || !bio_mergeable(bio))
 		return false;
 
-	if (!blk_check_merge_flags(rq->cmd_flags, bio->bi_rw))
+	if (!blk_check_merge_flags(rq->cmd_flags, rq->op, bio->bi_rw,
+				   bio->bi_op))
 		return false;
 
 	/* different data direction or already started, don't merge */
@@ -767,7 +769,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 		return false;
 
 	/* must be using the same buffer */
-	if (rq->cmd_flags & REQ_WRITE_SAME &&
+	if (rq->op == REQ_OP_WRITE_SAME &&
 	    !blk_write_same_mergeable(rq->bio, bio))
 		return false;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e2b2881..39df8ef 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -660,16 +660,16 @@ static inline bool rq_mergeable(struct request *rq)
 	return true;
 }
 
-static inline bool blk_check_merge_flags(unsigned int flags1,
-					 unsigned int flags2)
+static inline bool blk_check_merge_flags(unsigned int flags1, unsigned int op1,
+					 unsigned int flags2, unsigned int op2)
 {
-	if ((flags1 & REQ_DISCARD) != (flags2 & REQ_DISCARD))
+	if ((op1 == REQ_OP_DISCARD) != (op2 == REQ_OP_DISCARD))
 		return false;
 
 	if ((flags1 & REQ_SECURE) != (flags2 & REQ_SECURE))
 		return false;
 
-	if ((flags1 & REQ_WRITE_SAME) != (flags2 & REQ_WRITE_SAME))
+	if ((op1 == REQ_OP_WRITE_SAME) != (op2 == REQ_OP_WRITE_SAME))
 		return false;
 
 	return true;
@@ -870,12 +870,12 @@ static inline unsigned int blk_rq_cur_sectors(const struct request *rq)
 }
 
 static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
-						     unsigned int cmd_flags)
+						     int op)
 {
-	if (unlikely(cmd_flags & REQ_DISCARD))
+	if (unlikely(op == REQ_OP_DISCARD))
 		return min(q->limits.max_discard_sectors, UINT_MAX >> 9);
 
-	if (unlikely(cmd_flags & REQ_WRITE_SAME))
+	if (unlikely(op == REQ_OP_WRITE_SAME))
 		return q->limits.max_write_same_sectors;
 
 	return q->limits.max_sectors;
@@ -902,11 +902,11 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq)
 	if (unlikely(rq->cmd_type != REQ_TYPE_FS))
 		return q->limits.max_hw_sectors;
 
-	if (!q->limits.chunk_sectors || (rq->cmd_flags & REQ_DISCARD))
-		return blk_queue_get_max_sectors(q, rq->cmd_flags);
+	if (!q->limits.chunk_sectors || (rq->op == REQ_OP_DISCARD))
+		return blk_queue_get_max_sectors(q, rq->op);
 
 	return min(blk_max_size_offset(q, blk_rq_pos(rq)),
-			blk_queue_get_max_sectors(q, rq->cmd_flags));
+			blk_queue_get_max_sectors(q, rq->op));
 }
 
 static inline unsigned int blk_rq_count_bios(struct request *rq)
-- 
2.7.2

