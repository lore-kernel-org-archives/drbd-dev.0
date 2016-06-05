Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5C8F21056488
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 56818420308
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:06 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id uc-5xWJj_7bt for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:47:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 392DE42030E
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:06 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1lc-z8EYRDNi for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:47:06 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id BFE72420308
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:05 +0200 (CEST)
Resent-Message-ID: <20160610114705.GT3235@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3B26B105646E
	for <drbd-dev@lists.linbit.com>; Sun,  5 Jun 2016 21:40:58 +0200 (CEST)
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
Date: Sun,  5 Jun 2016 14:32:24 -0500
Message-Id: <1465155145-10812-45-git-send-email-mchristi@redhat.com>
In-Reply-To: <1465155145-10812-1-git-send-email-mchristi@redhat.com>
References: <1465155145-10812-1-git-send-email-mchristi@redhat.com>
Cc: Juergen Gross <kernel@pfupf.net>, Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 44/45] block: do not use REQ_FLUSH for tracking
	flush support
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

The last patch added a REQ_OP_FLUSH for request_fn drivers
and the next patch renames REQ_FLUSH to REQ_PREFLUSH which
will be used by file systems and make_request_fn drivers so
they can send a write/flush combo.

This patch drops xen's use of REQ_FLUSH to track if it supports
REQ_OP_FLUSH requests, so REQ_FLUSH can be deleted.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Juergen Gross <kernel@pfupf.net>
---

v7:
- Fix feature_flush/fua use.

v6:
- Dropped parts of patch handled by Jens's QUEUE_FLAG_WC/FUA
patches and modified patch to check feature_flush/fua bits.

 drivers/block/xen-blkfront.c | 47 ++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 3aeb25b..343ef7a 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -196,6 +196,7 @@ struct blkfront_info
 	unsigned int nr_ring_pages;
 	struct request_queue *rq;
 	unsigned int feature_flush;
+	unsigned int feature_fua;
 	unsigned int feature_discard:1;
 	unsigned int feature_secdiscard:1;
 	unsigned int discard_granularity;
@@ -763,19 +764,14 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
 			 * implement it the same way.  (It's also a FLUSH+FUA,
 			 * since it is guaranteed ordered WRT previous writes.)
 			 */
-			switch (info->feature_flush &
-				((REQ_FLUSH|REQ_FUA))) {
-			case REQ_FLUSH|REQ_FUA:
+			if (info->feature_flush && info->feature_fua)
 				ring_req->operation =
 					BLKIF_OP_WRITE_BARRIER;
-				break;
-			case REQ_FLUSH:
+			else if (info->feature_flush)
 				ring_req->operation =
 					BLKIF_OP_FLUSH_DISKCACHE;
-				break;
-			default:
+			else
 				ring_req->operation = 0;
-			}
 		}
 		ring_req->u.rw.nr_segments = num_grant;
 		if (unlikely(require_extra_req)) {
@@ -866,9 +862,9 @@ static inline bool blkif_request_flush_invalid(struct request *req,
 {
 	return ((req->cmd_type != REQ_TYPE_FS) ||
 		((req_op(req) == REQ_OP_FLUSH) &&
-		 !(info->feature_flush & REQ_FLUSH)) ||
+		 !info->feature_flush) ||
 		((req->cmd_flags & REQ_FUA) &&
-		 !(info->feature_flush & REQ_FUA)));
+		 !info->feature_fua));
 }
 
 static int blkif_queue_rq(struct blk_mq_hw_ctx *hctx,
@@ -985,24 +981,22 @@ static int xlvbd_init_blk_queue(struct gendisk *gd, u16 sector_size,
 	return 0;
 }
 
-static const char *flush_info(unsigned int feature_flush)
+static const char *flush_info(struct blkfront_info *info)
 {
-	switch (feature_flush & ((REQ_FLUSH | REQ_FUA))) {
-	case REQ_FLUSH|REQ_FUA:
+	if (info->feature_flush && info->feature_fua)
 		return "barrier: enabled;";
-	case REQ_FLUSH:
+	else if (info->feature_flush)
 		return "flush diskcache: enabled;";
-	default:
+	else
 		return "barrier or flush: disabled;";
-	}
 }
 
 static void xlvbd_flush(struct blkfront_info *info)
 {
-	blk_queue_write_cache(info->rq, info->feature_flush & REQ_FLUSH,
-				info->feature_flush & REQ_FUA);
+	blk_queue_write_cache(info->rq, info->feature_flush ? true : false,
+			      info->feature_fua ? true : false);
 	pr_info("blkfront: %s: %s %s %s %s %s\n",
-		info->gd->disk_name, flush_info(info->feature_flush),
+		info->gd->disk_name, flush_info(info),
 		"persistent grants:", info->feature_persistent ?
 		"enabled;" : "disabled;", "indirect descriptors:",
 		info->max_indirect_segments ? "enabled;" : "disabled;");
@@ -1621,6 +1615,7 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 			if (unlikely(error)) {
 				if (error == -EOPNOTSUPP)
 					error = 0;
+				info->feature_fua = 0;
 				info->feature_flush = 0;
 				xlvbd_flush(info);
 			}
@@ -2315,6 +2310,7 @@ static void blkfront_gather_backend_features(struct blkfront_info *info)
 	unsigned int indirect_segments;
 
 	info->feature_flush = 0;
+	info->feature_fua = 0;
 
 	err = xenbus_gather(XBT_NIL, info->xbdev->otherend,
 			"feature-barrier", "%d", &barrier,
@@ -2327,8 +2323,11 @@ static void blkfront_gather_backend_features(struct blkfront_info *info)
 	 *
 	 * If there are barriers, then we use flush.
 	 */
-	if (!err && barrier)
-		info->feature_flush = REQ_FLUSH | REQ_FUA;
+	if (!err && barrier) {
+		info->feature_flush = 1;
+		info->feature_fua = 1;
+	}
+
 	/*
 	 * And if there is "feature-flush-cache" use that above
 	 * barriers.
@@ -2337,8 +2336,10 @@ static void blkfront_gather_backend_features(struct blkfront_info *info)
 			"feature-flush-cache", "%d", &flush,
 			NULL);
 
-	if (!err && flush)
-		info->feature_flush = REQ_FLUSH;
+	if (!err && flush) {
+		info->feature_flush = 1;
+		info->feature_fua = 0;
+	}
 
 	err = xenbus_gather(XBT_NIL, info->xbdev->otherend,
 			"feature-discard", "%d", &discard,
-- 
2.7.2

