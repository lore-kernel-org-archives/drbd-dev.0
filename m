Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A0C471056326
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 77ACA360050
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:33 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id t365a7L7AjdA for <drbd-dev@lists.linbit.com>;
	Tue, 12 Jan 2016 11:09:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 35D7E364792
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:33 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZvHr9mMoJ0Ut for <drbd-dev@lists.linbit.com>;
	Tue, 12 Jan 2016 11:09:33 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id E520D360050
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:32 +0100 (CET)
Resent-Message-ID: <20160112100932.GF3313@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 957A31056318
	for <drbd-dev@lists.linbit.com>; Mon, 11 Jan 2016 21:21:47 +0100 (CET)
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
Date: Mon, 11 Jan 2016 14:21:00 -0600
Message-Id: <1452543693-4440-3-git-send-email-mchristi@redhat.com>
In-Reply-To: <1452543693-4440-1-git-send-email-mchristi@redhat.com>
References: <1452543693-4440-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 02/35] block: add REQ_OP definitions and bi_op/op
	fields
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

The following patches separate the operation (write, read, discard,
etc) from the flags in bi_rw/cmd_flags. This patch adds definitions
for request/bio operations, adds fields to the request/bio to set
them, and some temporary compat code so the kernel/modules can use
either one. In the final patches this compat code will be removed
when everything is converted.

Also, in this patch the REQ_OPs match the REQ rq_flag_bits ones
for compat reasons while all the code is converted in this set. In the
last patches that will also be removed.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 block/blk-core.c          | 19 ++++++++++++++++---
 include/linux/blk_types.h | 15 ++++++++++++++-
 include/linux/blkdev.h    |  1 +
 include/linux/fs.h        | 37 +++++++++++++++++++++++++++++++++++--
 4 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9b887e3..954a450 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1697,7 +1697,8 @@ void init_request_from_bio(struct request *req, struct bio *bio)
 {
 	req->cmd_type = REQ_TYPE_FS;
 
-	req->cmd_flags |= bio->bi_rw & REQ_COMMON_MASK;
+	/* tmp compat. Allow users to set bi_op or bi_rw */
+	req->cmd_flags |= (bio->bi_rw | bio->bi_op) & REQ_COMMON_MASK;
 	if (bio->bi_rw & REQ_RAHEAD)
 		req->cmd_flags |= REQ_FAILFAST_MASK;
 
@@ -2032,6 +2033,12 @@ blk_qc_t generic_make_request(struct bio *bio)
 	struct bio_list bio_list_on_stack;
 	blk_qc_t ret = BLK_QC_T_NONE;
 
+	/* tmp compat. Allow users to set either one or both.
+	 * This will be removed when we have converted
+	 * everyone in the next patches.
+	 */
+	bio->bi_rw |= bio->bi_op;
+
 	if (!generic_make_request_checks(bio))
 		goto out;
 
@@ -2101,6 +2108,12 @@ EXPORT_SYMBOL(generic_make_request);
  */
 blk_qc_t submit_bio(struct bio *bio)
 {
+	/* tmp compat. Allow users to set either one or both.
+	 * This will be removed when we have converted
+	 * everyone in the next patches.
+	 */
+	bio->bi_rw |= bio->bi_op;
+
 	/*
 	 * If it's a regular read/write or a barrier with data attached,
 	 * go through the normal accounting stuff before submission.
@@ -2972,8 +2985,8 @@ EXPORT_SYMBOL_GPL(__blk_end_request_err);
 void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
 		     struct bio *bio)
 {
-	/* Bit 0 (R/W) is identical in rq->cmd_flags and bio->bi_rw */
-	rq->cmd_flags |= bio->bi_rw & REQ_WRITE;
+	/* tmp compat. Allow users to set bi_op or bi_rw */
+	rq->cmd_flags |= bio_data_dir(bio);
 
 	if (bio_has_data(bio))
 		rq->nr_phys_segments = bio_phys_segments(q, bio);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 86a38ea..6e49c91 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -48,9 +48,15 @@ struct bio {
 	struct block_device	*bi_bdev;
 	unsigned int		bi_flags;	/* status, command, etc */
 	int			bi_error;
-	unsigned long		bi_rw;		/* bottom bits READ/WRITE,
+	unsigned long		bi_rw;		/* bottom bits rq_flags_bits
 						 * top bits priority
 						 */
+	/*
+	 * this will be a u8 in the next patches and bi_rw can be shrunk to
+	 * a u32. For compat in these transistional patches op is a int here.
+	 */
+	int			bi_op;		/* REQ_OP */
+
 
 	struct bvec_iter	bi_iter;
 
@@ -242,6 +248,13 @@ enum rq_flag_bits {
 #define REQ_HASHED		(1ULL << __REQ_HASHED)
 #define REQ_MQ_INFLIGHT		(1ULL << __REQ_MQ_INFLIGHT)
 
+enum req_op {
+	REQ_OP_READ,
+	REQ_OP_WRITE		= REQ_WRITE,
+	REQ_OP_DISCARD		= REQ_DISCARD,
+	REQ_OP_WRITE_SAME	= REQ_WRITE_SAME,
+};
+
 typedef unsigned int blk_qc_t;
 #define BLK_QC_T_NONE	-1U
 #define BLK_QC_T_SHIFT	16
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 29189ae..35b9eb3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -96,6 +96,7 @@ struct request {
 	struct request_queue *q;
 	struct blk_mq_ctx *mq_ctx;
 
+	int op;
 	u64 cmd_flags;
 	unsigned cmd_type;
 	unsigned long atomic_flags;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index afa9df4..afca758 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2405,15 +2405,48 @@ extern void make_bad_inode(struct inode *);
 extern bool is_bad_inode(struct inode *);
 
 #ifdef CONFIG_BLOCK
+
+static inline bool op_is_write(int op)
+{
+	switch (op) {
+	case REQ_OP_WRITE:
+	case REQ_OP_WRITE_SAME:
+	case REQ_OP_DISCARD:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /*
  * return READ, READA, or WRITE
  */
-#define bio_rw(bio)		((bio)->bi_rw & (RW_MASK | RWA_MASK))
+static inline int bio_rw(struct bio *bio)
+{
+	/*
+	 * tmp cpmpat. Allow users to set either op or rw, until
+	 * all code is converted in the next patches.
+	 */
+	if (op_is_write(bio->bi_op))
+		return WRITE;
+
+	return bio->bi_rw & (RW_MASK | RWA_MASK);
+}
 
 /*
  * return data direction, READ or WRITE
  */
-#define bio_data_dir(bio)	((bio)->bi_rw & 1)
+static inline int bio_data_dir(struct bio *bio)
+{
+	/*
+	 * tmp cpmpat. Allow users to set either op or rw, until
+	 * all code is converted in the next patches.
+	 */
+	if (op_is_write(bio->bi_op))
+		return WRITE;
+
+	return bio->bi_rw & 1;
+}
 
 extern void check_disk_size_change(struct gendisk *disk,
 				   struct block_device *bdev);
-- 
1.8.3.1

