Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9520C1056431
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:31:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 8F41D2A5C46
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:31:54 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id VpSnyLpKhkRi for <drbd-dev@lists.linbit.com>;
	Fri,  8 Jan 2016 21:31:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 731572A5C4B
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:31:54 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ngtkie-UnpRS for <drbd-dev@lists.linbit.com>;
	Fri,  8 Jan 2016 21:31:54 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 488212A5C46
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:31:54 +0100 (CET)
Resent-Message-ID: <20160108203153.GP28982@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 986C91056333
	for <drbd-dev@lists.linbit.com>; Tue,  5 Jan 2016 22:02:47 +0100 (CET)
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
Date: Tue,  5 Jan 2016 14:53:16 -0600
Message-Id: <1452027218-32303-14-git-send-email-mchristi@redhat.com>
In-Reply-To: <1452027218-32303-1-git-send-email-mchristi@redhat.com>
References: <1452027218-32303-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 13/35] xfs: set bi_op to REQ_OP
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

This patch has xfs set the bio bi_op to a REQ_OP, and
rq_flag_bits to bi_rw.

Note:
I have run xfs tests on these btrfs patches. There were some failures
with and without the patches. I have not had time to track down why
xfstest fails without the patches.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 fs/xfs/xfs_aops.c |  3 ++-
 fs/xfs/xfs_buf.c  | 27 +++++++++++++++------------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index a1052d2..3a00935 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -382,7 +382,8 @@ xfs_submit_ioend_bio(
 	atomic_inc(&ioend->io_remaining);
 	bio->bi_private = ioend;
 	bio->bi_end_io = xfs_end_bio;
-	bio->bi_rw |= (wbc->sync_mode == WB_SYNC_ALL ? WRITE_SYNC : WRITE);
+	bio->bi_op = REQ_OP_WRITE;
+	bio->bi_rw |= WB_SYNC_ALL ? WRITE_SYNC : 0;
 	submit_bio(bio);
 }
 
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 644e676..4cfba72 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1124,7 +1124,8 @@ xfs_buf_ioapply_map(
 	int		map,
 	int		*buf_offset,
 	int		*count,
-	int		rw)
+	int		op,
+	int		op_flags)
 {
 	int		page_index;
 	int		total_nr_pages = bp->b_page_count;
@@ -1163,7 +1164,8 @@ next_chunk:
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_end_io = xfs_buf_bio_end_io;
 	bio->bi_private = bp;
-	bio->bi_rw |= rw;
+	bio->bi_op = op;
+	bio->bi_rw |= op_flags;
 
 	for (; size && nr_pages; nr_pages--, page_index++) {
 		int	rbytes, nbytes = PAGE_SIZE - offset;
@@ -1207,7 +1209,8 @@ _xfs_buf_ioapply(
 	struct xfs_buf	*bp)
 {
 	struct blk_plug	plug;
-	int		rw;
+	int		op;
+	int		op_flags = 0;
 	int		offset;
 	int		size;
 	int		i;
@@ -1226,14 +1229,13 @@ _xfs_buf_ioapply(
 		bp->b_ioend_wq = bp->b_target->bt_mount->m_buf_workqueue;
 
 	if (bp->b_flags & XBF_WRITE) {
+		op = REQ_OP_WRITE;
 		if (bp->b_flags & XBF_SYNCIO)
-			rw = WRITE_SYNC;
-		else
-			rw = WRITE;
+			op_flags = WRITE_SYNC;
 		if (bp->b_flags & XBF_FUA)
-			rw |= REQ_FUA;
+			op_flags |= REQ_FUA;
 		if (bp->b_flags & XBF_FLUSH)
-			rw |= REQ_FLUSH;
+			op_flags |= REQ_FLUSH;
 
 		/*
 		 * Run the write verifier callback function if it exists. If
@@ -1263,13 +1265,14 @@ _xfs_buf_ioapply(
 			}
 		}
 	} else if (bp->b_flags & XBF_READ_AHEAD) {
-		rw = READA;
+		op = REQ_OP_READ;
+		op_flags = REQ_RAHEAD;
 	} else {
-		rw = READ;
+		op = REQ_OP_READ;
 	}
 
 	/* we only use the buffer cache for meta-data */
-	rw |= REQ_META;
+	op_flags |= REQ_META;
 
 	/*
 	 * Walk all the vectors issuing IO on them. Set up the initial offset
@@ -1281,7 +1284,7 @@ _xfs_buf_ioapply(
 	size = BBTOB(bp->b_io_length);
 	blk_start_plug(&plug);
 	for (i = 0; i < bp->b_map_count; i++) {
-		xfs_buf_ioapply_map(bp, i, &offset, &size, rw);
+		xfs_buf_ioapply_map(bp, i, &offset, &size, op, op_flags);
 		if (bp->b_error)
 			break;
 		if (size <= 0)
-- 
1.8.3.1

