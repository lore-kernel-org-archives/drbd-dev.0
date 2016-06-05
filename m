Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 02E001056482
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id EE920420308
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:01 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id lvV8LQRMSz43 for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:47:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id CB72742030E
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:01 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eDpBk5BZ0u4B for <drbd-dev@lists.linbit.com>;
	Fri, 10 Jun 2016 13:47:01 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id A30CE420308
	for <drbd-dev@lists.linbit.com>; Fri, 10 Jun 2016 13:47:01 +0200 (CEST)
Resent-Message-ID: <20160610114701.GN3235@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3C067105646A
	for <drbd-dev@lists.linbit.com>; Sun,  5 Jun 2016 21:40:54 +0200 (CEST)
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
Date: Sun,  5 Jun 2016 14:32:20 -0500
Message-Id: <1465155145-10812-41-git-send-email-mchristi@redhat.com>
In-Reply-To: <1465155145-10812-1-git-send-email-mchristi@redhat.com>
References: <1465155145-10812-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 40/45] block: move bio io prio to a new field
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

In the next patch, we move drop the compat code and make
the op a separate value that is hidden in bi_rw. To give
the op and rq bits flags room to grow this moves prio to
its own field.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 include/linux/bio.h       | 14 ++------------
 include/linux/blk_types.h |  5 ++---
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 4568647..35108c2 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -47,18 +47,8 @@
 #define bio_op(bio)				(op_from_rq_bits((bio)->bi_rw))
 #define bio_set_op_attrs(bio, op, flags)	((bio)->bi_rw |= (op | flags))
 
-/*
- * upper 16 bits of bi_rw define the io priority of this bio
- */
-#define BIO_PRIO_SHIFT	(8 * sizeof(unsigned long) - IOPRIO_BITS)
-#define bio_prio(bio)	((bio)->bi_rw >> BIO_PRIO_SHIFT)
-#define bio_prio_valid(bio)	ioprio_valid(bio_prio(bio))
-
-#define bio_set_prio(bio, prio)		do {			\
-	WARN_ON(prio >= (1 << IOPRIO_BITS));			\
-	(bio)->bi_rw &= ((1UL << BIO_PRIO_SHIFT) - 1);		\
-	(bio)->bi_rw |= ((unsigned long) (prio) << BIO_PRIO_SHIFT);	\
-} while (0)
+#define bio_prio(bio)			(bio)->bi_ioprio
+#define bio_set_prio(bio, prio)		((bio)->bi_ioprio = prio)
 
 /*
  * various member access, note that bio_data should of course not be used
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 6e60baa..2738413 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -48,9 +48,8 @@ struct bio {
 	struct block_device	*bi_bdev;
 	unsigned int		bi_flags;	/* status, command, etc */
 	int			bi_error;
-	unsigned long		bi_rw;		/* bottom bits READ/WRITE,
-						 * top bits priority
-						 */
+	unsigned long		bi_rw;		/* READ/WRITE */
+	unsigned short		bi_ioprio;
 
 	struct bvec_iter	bi_iter;
 
-- 
2.7.2

