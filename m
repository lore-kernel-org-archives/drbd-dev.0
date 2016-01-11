Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E86EA1056421
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E2C49360050
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:47 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id nhFJ1cwy4cYW for <drbd-dev@lists.linbit.com>;
	Tue, 12 Jan 2016 11:09:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C5C60364792
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:47 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GaHvAY9Ioo98 for <drbd-dev@lists.linbit.com>;
	Tue, 12 Jan 2016 11:09:47 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 9E787360050
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:47 +0100 (CET)
Resent-Message-ID: <20160112100947.GZ3313@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id AA1D71056323
	for <drbd-dev@lists.linbit.com>; Mon, 11 Jan 2016 21:30:40 +0100 (CET)
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
Date: Mon, 11 Jan 2016 14:21:13 -0600
Message-Id: <1452543693-4440-16-git-send-email-mchristi@redhat.com>
In-Reply-To: <1452543693-4440-1-git-send-email-mchristi@redhat.com>
References: <1452543693-4440-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 15/35] mpage: set bi_op to REQ_OP
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

This patch has the mpage.c code set the bio bi_op to a REQ_OP, and
rq_flag_bits to bi_rw.

I have run xfstest with xfs, but I am not sure
if I have stressed these code paths well.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 fs/mpage.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index d9adde2..006a3ef 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -55,11 +55,12 @@ static void mpage_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-static struct bio *mpage_bio_submit(int rw, struct bio *bio)
+static struct bio *mpage_bio_submit(int op, int op_flags, struct bio *bio)
 {
 	bio->bi_end_io = mpage_end_io;
-	bio->bi_rw = rw;
-	guard_bio_eod(rw, bio);
+	bio->bi_op = op;
+	bio->bi_rw = op_flags;
+	guard_bio_eod(op, bio);
 	submit_bio(bio);
 	return NULL;
 }
@@ -269,7 +270,7 @@ do_mpage_readpage(struct bio *bio, struct page *page, unsigned nr_pages,
 	 * This page will go to BIO.  Do we need to send this BIO off first?
 	 */
 	if (bio && (*last_block_in_bio != blocks[0] - 1))
-		bio = mpage_bio_submit(READ, bio);
+		bio = mpage_bio_submit(REQ_OP_READ, 0, bio);
 
 alloc_new:
 	if (bio == NULL) {
@@ -286,7 +287,7 @@ alloc_new:
 
 	length = first_hole << blkbits;
 	if (bio_add_page(bio, page, length, 0) < length) {
-		bio = mpage_bio_submit(READ, bio);
+		bio = mpage_bio_submit(REQ_OP_READ, 0, bio);
 		goto alloc_new;
 	}
 
@@ -294,7 +295,7 @@ alloc_new:
 	nblocks = map_bh->b_size >> blkbits;
 	if ((buffer_boundary(map_bh) && relative_block == nblocks) ||
 	    (first_hole != blocks_per_page))
-		bio = mpage_bio_submit(READ, bio);
+		bio = mpage_bio_submit(REQ_OP_READ, 0, bio);
 	else
 		*last_block_in_bio = blocks[blocks_per_page - 1];
 out:
@@ -302,7 +303,7 @@ out:
 
 confused:
 	if (bio)
-		bio = mpage_bio_submit(READ, bio);
+		bio = mpage_bio_submit(REQ_OP_READ, 0, bio);
 	if (!PageUptodate(page))
 	        block_read_full_page(page, get_block);
 	else
@@ -384,7 +385,7 @@ mpage_readpages(struct address_space *mapping, struct list_head *pages,
 	}
 	BUG_ON(!list_empty(pages));
 	if (bio)
-		mpage_bio_submit(READ, bio);
+		mpage_bio_submit(REQ_OP_READ, 0, bio);
 	return 0;
 }
 EXPORT_SYMBOL(mpage_readpages);
@@ -405,7 +406,7 @@ int mpage_readpage(struct page *page, get_block_t get_block)
 	bio = do_mpage_readpage(bio, page, 1, &last_block_in_bio,
 			&map_bh, &first_logical_block, get_block, gfp);
 	if (bio)
-		mpage_bio_submit(READ, bio);
+		mpage_bio_submit(REQ_OP_READ, 0, bio);
 	return 0;
 }
 EXPORT_SYMBOL(mpage_readpage);
@@ -486,7 +487,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 	struct buffer_head map_bh;
 	loff_t i_size = i_size_read(inode);
 	int ret = 0;
-	int wr = (wbc->sync_mode == WB_SYNC_ALL ?  WRITE_SYNC : WRITE);
+	int op_flags = (wbc->sync_mode == WB_SYNC_ALL ?  WRITE_SYNC : 0);
 
 	if (page_has_buffers(page)) {
 		struct buffer_head *head = page_buffers(page);
@@ -595,7 +596,7 @@ page_is_mapped:
 	 * This page will go to BIO.  Do we need to send this BIO off first?
 	 */
 	if (bio && mpd->last_block_in_bio != blocks[0] - 1)
-		bio = mpage_bio_submit(wr, bio);
+		bio = mpage_bio_submit(REQ_OP_WRITE, op_flags, bio);
 
 alloc_new:
 	if (bio == NULL) {
@@ -622,7 +623,7 @@ alloc_new:
 	wbc_account_io(wbc, page, PAGE_SIZE);
 	length = first_unmapped << blkbits;
 	if (bio_add_page(bio, page, length, 0) < length) {
-		bio = mpage_bio_submit(wr, bio);
+		bio = mpage_bio_submit(REQ_OP_WRITE, op_flags, bio);
 		goto alloc_new;
 	}
 
@@ -632,7 +633,7 @@ alloc_new:
 	set_page_writeback(page);
 	unlock_page(page);
 	if (boundary || (first_unmapped != blocks_per_page)) {
-		bio = mpage_bio_submit(wr, bio);
+		bio = mpage_bio_submit(REQ_OP_WRITE, op_flags, bio);
 		if (boundary_block) {
 			write_boundary_block(boundary_bdev,
 					boundary_block, 1 << blkbits);
@@ -644,7 +645,7 @@ alloc_new:
 
 confused:
 	if (bio)
-		bio = mpage_bio_submit(wr, bio);
+		bio = mpage_bio_submit(REQ_OP_WRITE, op_flags, bio);
 
 	if (mpd->use_writepage) {
 		ret = mapping->a_ops->writepage(page, wbc);
@@ -701,9 +702,9 @@ mpage_writepages(struct address_space *mapping,
 
 		ret = write_cache_pages(mapping, wbc, __mpage_writepage, &mpd);
 		if (mpd.bio) {
-			int wr = (wbc->sync_mode == WB_SYNC_ALL ?
-				  WRITE_SYNC : WRITE);
-			mpage_bio_submit(wr, mpd.bio);
+			int op_flags = (wbc->sync_mode == WB_SYNC_ALL ?
+				  WRITE_SYNC : 0);
+			mpage_bio_submit(REQ_OP_WRITE, op_flags, mpd.bio);
 		}
 	}
 	blk_finish_plug(&plug);
@@ -722,9 +723,9 @@ int mpage_writepage(struct page *page, get_block_t get_block,
 	};
 	int ret = __mpage_writepage(page, wbc, &mpd);
 	if (mpd.bio) {
-		int wr = (wbc->sync_mode == WB_SYNC_ALL ?
-			  WRITE_SYNC : WRITE);
-		mpage_bio_submit(wr, mpd.bio);
+		int op_flags = (wbc->sync_mode == WB_SYNC_ALL ?
+			  WRITE_SYNC : 0);
+		mpage_bio_submit(REQ_OP_WRITE, op_flags, mpd.bio);
 	}
 	return ret;
 }
-- 
1.8.3.1

