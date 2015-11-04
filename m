Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 35C4010561A4
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 18:09:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 28E5E2A24E3
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 18:09:45 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 8Awscstw_vDr for <drbd-dev@lists.linbit.com>;
	Wed,  4 Nov 2015 18:09:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 093922A2BCB
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 18:09:45 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id En4mQwhOPeFR for <drbd-dev@lists.linbit.com>;
	Wed,  4 Nov 2015 18:09:44 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id CACA82A24E3
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 18:09:44 +0100 (CET)
Resent-Message-ID: <20151104170944.GT14472@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 464A41056187
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 17:33:41 +0100 (CET)
From: mchristi@redhat.com
To: linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Date: Wed,  4 Nov 2015 10:33:01 -0600
Message-Id: <1446654807-6935-7-git-send-email-mchristi@redhat.com>
In-Reply-To: <1446654807-6935-1-git-send-email-mchristi@redhat.com>
References: <1446654807-6935-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 06/32] xen blkback: prepare for bi_rw split
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

This patch prepares xen blkback submit_bio use for the next
patches that split bi_rw into a operation and flags field.
Instead of passing in a bitmap with both the operation and
flags mixed in, the callers will now pass them in seperately.

This patch modifies the code related to the submit_bio calls
so the flags and operation are seperated. When this is done
for all code, one of the later patches in the series will
modify the actual submit_bio call, so the patches are bisectable.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/block/xen-blkback/blkback.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 6a685ae..bfffab3 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -488,7 +488,7 @@ static int xen_vbd_translate(struct phys_req *req, struct xen_blkif *blkif,
 	struct xen_vbd *vbd = &blkif->vbd;
 	int rc = -EACCES;
 
-	if ((operation != READ) && vbd->readonly)
+	if ((operation != REQ_OP_READ) && vbd->readonly)
 		goto out;
 
 	if (likely(req->nr_sects)) {
@@ -990,7 +990,7 @@ static int dispatch_discard_io(struct xen_blkif *blkif,
 	preq.sector_number = req->u.discard.sector_number;
 	preq.nr_sects      = req->u.discard.nr_sectors;
 
-	err = xen_vbd_translate(&preq, blkif, WRITE);
+	err = xen_vbd_translate(&preq, blkif, REQ_OP_WRITE);
 	if (err) {
 		pr_warn("access denied: DISCARD [%llu->%llu] on dev=%04x\n",
 			preq.sector_number,
@@ -1203,6 +1203,7 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
 	struct bio **biolist = pending_req->biolist;
 	int i, nbio = 0;
 	int operation;
+	int operation_flags = 0;
 	struct blk_plug plug;
 	bool drain = false;
 	struct grant_page **pages = pending_req->segments;
@@ -1220,17 +1221,19 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
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
@@ -1242,7 +1245,7 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
 	nseg = req->operation == BLKIF_OP_INDIRECT ?
 	       req->u.indirect.nr_segments : req->u.rw.nr_segments;
 
-	if (unlikely(nseg == 0 && operation != WRITE_FLUSH) ||
+	if (unlikely(nseg == 0 && operation_flags != WRITE_FLUSH) ||
 	    unlikely((req->operation != BLKIF_OP_INDIRECT) &&
 		     (nseg > BLKIF_MAX_SEGMENTS_PER_REQUEST)) ||
 	    unlikely((req->operation == BLKIF_OP_INDIRECT) &&
@@ -1349,7 +1352,7 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
 
 	/* This will be hit if the operation was a flush or discard. */
 	if (!bio) {
-		BUG_ON(operation != WRITE_FLUSH);
+		BUG_ON(operation_flags != WRITE_FLUSH);
 
 		bio = bio_alloc(GFP_KERNEL, 0);
 		if (unlikely(bio == NULL))
@@ -1365,14 +1368,14 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
 	blk_start_plug(&plug);
 
 	for (i = 0; i < nbio; i++)
-		submit_bio(operation, biolist[i]);
+		submit_bio(operation | operation_flags, biolist[i]);
 
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

