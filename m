Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 537101056337
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:31:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 396BF2A5C46
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:31:32 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id HQyPxs34rU-q for <drbd-dev@lists.linbit.com>;
	Fri,  8 Jan 2016 21:31:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 158162A5C4B
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:31:32 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4ys_SgK6P-g7 for <drbd-dev@lists.linbit.com>;
	Fri,  8 Jan 2016 21:31:32 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id E41972A5C46
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:31:31 +0100 (CET)
Resent-Message-ID: <20160108203131.GU28982@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 22B2D1056320
	for <drbd-dev@lists.linbit.com>; Tue,  5 Jan 2016 21:54:54 +0100 (CET)
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
Date: Tue,  5 Jan 2016 14:53:27 -0600
Message-Id: <1452027218-32303-25-git-send-email-mchristi@redhat.com>
In-Reply-To: <1452027218-32303-1-git-send-email-mchristi@redhat.com>
References: <1452027218-32303-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 24/35] xen: set bi_op to REQ_OP
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

This patch has xen set the bio bi_op to a REQ_OP, and rq_flag_bits
to bi_rw.

This patch is compile tested only.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/block/xen-blkback/blkback.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index c7e89af..c7d9643 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -488,7 +488,7 @@ static int xen_vbd_translate(struct phys_req *req, struct xen_blkif *blkif,
 	struct xen_vbd *vbd = &blkif->vbd;
 	int rc = -EACCES;
 
-	if ((operation != READ) && vbd->readonly)
+	if ((operation != REQ_OP_READ) && vbd->readonly)
 		goto out;
 
 	if (likely(req->nr_sects)) {
@@ -995,7 +995,7 @@ static int dispatch_discard_io(struct xen_blkif *blkif,
 	preq.sector_number = req->u.discard.sector_number;
 	preq.nr_sects      = req->u.discard.nr_sectors;
 
-	err = xen_vbd_translate(&preq, blkif, WRITE);
+	err = xen_vbd_translate(&preq, blkif, REQ_OP_WRITE);
 	if (err) {
 		pr_warn("access denied: DISCARD [%llu->%llu] on dev=%04x\n",
 			preq.sector_number,
@@ -1208,6 +1208,7 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
 	struct bio **biolist = pending_req->biolist;
 	int i, nbio = 0;
 	int operation;
+	int operation_flags = 0;
 	struct blk_plug plug;
 	bool drain = false;
 	struct grant_page **pages = pending_req->segments;
@@ -1226,17 +1227,19 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
 	switch (req_operation) {
 	case BLKIF_OP_READ:
 		blkif->st_rd_req++;
-		operation = READ;
+		operation = REQ_OP_READ;
 		break;
 	case BLKIF_OP_WRITE:
 		blkif->st_wr_req++;
-		operation = WRITE_ODIRECT;
+		operation = REQ_OP_WRITE;
+		operation_flags = WRITE_ODIRECT;
 		break;
 	case BLKIF_OP_WRITE_BARRIER:
 		drain = true;
 	case BLKIF_OP_FLUSH_DISKCACHE:
 		blkif->st_f_req++;
-		operation = WRITE_FLUSH;
+		operation = REQ_OP_WRITE;
+		operation_flags = WRITE_FLUSH;
 		break;
 	default:
 		operation = 0; /* make gcc happy */
@@ -1248,7 +1251,7 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
 	nseg = req->operation == BLKIF_OP_INDIRECT ?
 	       req->u.indirect.nr_segments : req->u.rw.nr_segments;
 
-	if (unlikely(nseg == 0 && operation != WRITE_FLUSH) ||
+	if (unlikely(nseg == 0 && operation_flags != WRITE_FLUSH) ||
 	    unlikely((req->operation != BLKIF_OP_INDIRECT) &&
 		     (nseg > BLKIF_MAX_SEGMENTS_PER_REQUEST)) ||
 	    unlikely((req->operation == BLKIF_OP_INDIRECT) &&
@@ -1289,7 +1292,7 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
 
 	if (xen_vbd_translate(&preq, blkif, operation) != 0) {
 		pr_debug("access denied: %s of [%llu,%llu] on dev=%04x\n",
-			 operation == READ ? "read" : "write",
+			 operation == REQ_OP_READ ? "read" : "write",
 			 preq.sector_number,
 			 preq.sector_number + preq.nr_sects,
 			 blkif->vbd.pdevice);
@@ -1348,7 +1351,8 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
 			bio->bi_private = pending_req;
 			bio->bi_end_io  = end_block_io_op;
 			bio->bi_iter.bi_sector  = preq.sector_number;
-			bio->bi_rw	|= operation;
+			bio->bi_op	= operation;
+			bio->bi_rw	|= operation_flags;
 		}
 
 		preq.sector_number += seg[i].nsec;
@@ -1356,7 +1360,7 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
 
 	/* This will be hit if the operation was a flush or discard. */
 	if (!bio) {
-		BUG_ON(operation != WRITE_FLUSH);
+		BUG_ON(operation_flags != WRITE_FLUSH);
 
 		bio = bio_alloc(GFP_KERNEL, 0);
 		if (unlikely(bio == NULL))
@@ -1366,7 +1370,8 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
 		bio->bi_bdev    = preq.bdev;
 		bio->bi_private = pending_req;
 		bio->bi_end_io  = end_block_io_op;
-		bio->bi_rw	|= operation;
+		bio->bi_op	= operation;
+		bio->bi_rw	|= operation_flags;
 	}
 
 	atomic_set(&pending_req->pendcnt, nbio);
@@ -1378,9 +1383,9 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
 	/* Let the I/Os go.. */
 	blk_finish_plug(&plug);
 
-	if (operation == READ)
+	if (operation == REQ_OP_READ)
 		blkif->st_rd_sect += preq.nr_sects;
-	else if (operation & WRITE)
+	else if (operation == REQ_OP_WRITE)
 		blkif->st_wr_sect += preq.nr_sects;
 
 	return 0;
-- 
1.8.3.1

