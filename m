Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 98D381056426
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 8F2A436457E
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:54 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ZZ1FTAw_kcqW for <drbd-dev@lists.linbit.com>;
	Tue, 12 Jan 2016 11:09:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 73988364792
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:54 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UXquln-gh_Eq for <drbd-dev@lists.linbit.com>;
	Tue, 12 Jan 2016 11:09:54 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 1DFB636457E
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:54 +0100 (CET)
Resent-Message-ID: <20160112100953.GE3313@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 37CA0105632B
	for <drbd-dev@lists.linbit.com>; Mon, 11 Jan 2016 21:31:12 +0100 (CET)
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
Date: Mon, 11 Jan 2016 14:21:14 -0600
Message-Id: <1452543693-4440-17-git-send-email-mchristi@redhat.com>
In-Reply-To: <1452543693-4440-1-git-send-email-mchristi@redhat.com>
References: <1452543693-4440-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 16/35] nilfs: set bi_op to REQ_OP
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

This patch has nilfs set the bio bi_op to a REQ_OP, and
rq_flag_bits to bi_rw.

This patch is compile tested only.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 fs/nilfs2/segbuf.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 7666f1d..7b13e14 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -350,7 +350,8 @@ static void nilfs_end_bio_write(struct bio *bio)
 }
 
 static int nilfs_segbuf_submit_bio(struct nilfs_segment_buffer *segbuf,
-				   struct nilfs_write_info *wi, int mode)
+				   struct nilfs_write_info *wi, int mode,
+				   int mode_flags)
 {
 	struct bio *bio = wi->bio;
 	int err;
@@ -368,7 +369,8 @@ static int nilfs_segbuf_submit_bio(struct nilfs_segment_buffer *segbuf,
 
 	bio->bi_end_io = nilfs_end_bio_write;
 	bio->bi_private = segbuf;
-	bio->bi_rw = mode;
+	bio->bi_op = mode;
+	bio->bi_rw = mode_flags;
 	submit_bio(bio);
 	segbuf->sb_nbio++;
 
@@ -442,7 +444,7 @@ static int nilfs_segbuf_submit_bh(struct nilfs_segment_buffer *segbuf,
 		return 0;
 	}
 	/* bio is FULL */
-	err = nilfs_segbuf_submit_bio(segbuf, wi, mode);
+	err = nilfs_segbuf_submit_bio(segbuf, wi, mode, 0);
 	/* never submit current bh */
 	if (likely(!err))
 		goto repeat;
@@ -466,19 +468,19 @@ static int nilfs_segbuf_write(struct nilfs_segment_buffer *segbuf,
 {
 	struct nilfs_write_info wi;
 	struct buffer_head *bh;
-	int res = 0, rw = WRITE;
+	int res = 0;
 
 	wi.nilfs = nilfs;
 	nilfs_segbuf_prepare_write(segbuf, &wi);
 
 	list_for_each_entry(bh, &segbuf->sb_segsum_buffers, b_assoc_buffers) {
-		res = nilfs_segbuf_submit_bh(segbuf, &wi, bh, rw);
+		res = nilfs_segbuf_submit_bh(segbuf, &wi, bh, REQ_OP_WRITE);
 		if (unlikely(res))
 			goto failed_bio;
 	}
 
 	list_for_each_entry(bh, &segbuf->sb_payload_buffers, b_assoc_buffers) {
-		res = nilfs_segbuf_submit_bh(segbuf, &wi, bh, rw);
+		res = nilfs_segbuf_submit_bh(segbuf, &wi, bh, REQ_OP_WRITE);
 		if (unlikely(res))
 			goto failed_bio;
 	}
@@ -488,8 +490,8 @@ static int nilfs_segbuf_write(struct nilfs_segment_buffer *segbuf,
 		 * Last BIO is always sent through the following
 		 * submission.
 		 */
-		rw |= REQ_SYNC;
-		res = nilfs_segbuf_submit_bio(segbuf, &wi, rw);
+		res = nilfs_segbuf_submit_bio(segbuf, &wi, REQ_OP_WRITE,
+					      REQ_SYNC);
 	}
 
  failed_bio:
-- 
1.8.3.1

