Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 936AA105648B
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 8D80C420308
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:10 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id PsDCQ8fBIxmw for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:47:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 6C39C42030E
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:10 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HHAMYickymbB for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:47:10 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 3A380420308
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:10 +0200 (CEST)
Resent-Message-ID: <20160610114709.GW3235@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 0AB681056466
	for <drbd-dev@lists.linbit.com>; Sun,  5 Jun 2016 21:42:01 +0200 (CEST)
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
Date: Sun,  5 Jun 2016 14:32:00 -0500
Message-Id: <1465155145-10812-21-git-send-email-mchristi@redhat.com>
In-Reply-To: <1465155145-10812-1-git-send-email-mchristi@redhat.com>
References: <1465155145-10812-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 20/45] nilfs: use bio op accessors
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

Separate the op from the rq_flag_bits and have nilfs
set/get the bio using bio_set_op_attrs/bio_op.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Acked-by: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
---
 fs/nilfs2/segbuf.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 0f62909..a962d7d 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -346,7 +346,8 @@ static void nilfs_end_bio_write(struct bio *bio)
 }
 
 static int nilfs_segbuf_submit_bio(struct nilfs_segment_buffer *segbuf,
-				   struct nilfs_write_info *wi, int mode)
+				   struct nilfs_write_info *wi, int mode,
+				   int mode_flags)
 {
 	struct bio *bio = wi->bio;
 	int err;
@@ -364,7 +365,7 @@ static int nilfs_segbuf_submit_bio(struct nilfs_segment_buffer *segbuf,
 
 	bio->bi_end_io = nilfs_end_bio_write;
 	bio->bi_private = segbuf;
-	bio->bi_rw = mode;
+	bio_set_op_attrs(bio, mode, mode_flags);
 	submit_bio(bio);
 	segbuf->sb_nbio++;
 
@@ -438,7 +439,7 @@ static int nilfs_segbuf_submit_bh(struct nilfs_segment_buffer *segbuf,
 		return 0;
 	}
 	/* bio is FULL */
-	err = nilfs_segbuf_submit_bio(segbuf, wi, mode);
+	err = nilfs_segbuf_submit_bio(segbuf, wi, mode, 0);
 	/* never submit current bh */
 	if (likely(!err))
 		goto repeat;
@@ -462,19 +463,19 @@ static int nilfs_segbuf_write(struct nilfs_segment_buffer *segbuf,
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
@@ -484,8 +485,8 @@ static int nilfs_segbuf_write(struct nilfs_segment_buffer *segbuf,
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
2.7.2

