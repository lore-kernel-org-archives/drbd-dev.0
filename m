Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id EC38A1056443
	for <drbd-dev@lists.linbit.com>; Mon,  4 Apr 2016 11:19:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id DF83436CCD8
	for <drbd-dev@lists.linbit.com>; Mon,  4 Apr 2016 11:19:22 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 8Q3FtaGdJiZt for <drbd-dev@lists.linbit.com>;
	Mon,  4 Apr 2016 11:19:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C023936CCF5
	for <drbd-dev@lists.linbit.com>; Mon,  4 Apr 2016 11:19:22 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id g93TLZR6W22i for <drbd-dev@lists.linbit.com>;
	Mon,  4 Apr 2016 11:19:22 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 9AD1136CCE9
	for <drbd-dev@lists.linbit.com>; Mon,  4 Apr 2016 11:19:22 +0200 (CEST)
Resent-Message-ID: <20160404091922.GE3078@soda.linbit>
Received: from mail-pf0-f171.google.com (mail-pf0-f171.google.com
	[209.85.192.171]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 45FE8105643E
	for <drbd-dev@lists.linbit.com>; Sun,  3 Apr 2016 18:31:34 +0200 (CEST)
Received: by mail-pf0-f171.google.com with SMTP id n1so21973302pfn.2
	for <drbd-dev@lists.linbit.com>; Sun, 03 Apr 2016 09:31:34 -0700 (PDT)
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon,  4 Apr 2016 00:31:03 +0800
Message-Id: <1459701069-31406-3-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1459701069-31406-1-git-send-email-ming.lei@canonical.com>
References: <1459701069-31406-1-git-send-email-ming.lei@canonical.com>
Cc: Christoph Hellwig <hch@infradead.org>, Boaz Harrosh <boaz@plexistor.com>,
	Ming Lei <ming.lei@canonical.com>, Dave Chinner <david@fromorbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, xfs@oss.sgi.com,
	linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v2 2/8] block: move two bvec structure into bvec.h
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

This patch moves 'struct bio_vec' and 'struct bvec_iter'
into 'include/linux/bvec.h', then always include this header
into 'include/linux/blk_types.h'.

With this change, both 'struct bvec_iter' and bvec iterator
helpers don't depend on CONFIG_BLOCK any more, then we can
use bvec iterator to implement iterate_bvec(): lib/iov_iter.c.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 include/linux/bio.h       |  1 -
 include/linux/blk_types.h | 22 +---------------------
 include/linux/bvec.h      | 20 +++++++++++++++++++-
 3 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 78cf737..7f998ac 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -31,7 +31,6 @@
 
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
 #include <linux/blk_types.h>
-#include <linux/bvec.h>
 
 #define BIO_DEBUG
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 86a38ea..a8d8e1f 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -6,6 +6,7 @@
 #define __LINUX_BLK_TYPES_H
 
 #include <linux/types.h>
+#include <linux/bvec.h>
 
 struct bio_set;
 struct bio;
@@ -17,28 +18,7 @@ struct cgroup_subsys_state;
 typedef void (bio_end_io_t) (struct bio *);
 typedef void (bio_destructor_t) (struct bio *);
 
-/*
- * was unsigned short, but we might as well be ready for > 64kB I/O pages
- */
-struct bio_vec {
-	struct page	*bv_page;
-	unsigned int	bv_len;
-	unsigned int	bv_offset;
-};
-
 #ifdef CONFIG_BLOCK
-
-struct bvec_iter {
-	sector_t		bi_sector;	/* device address in 512 byte
-						   sectors */
-	unsigned int		bi_size;	/* residual I/O count */
-
-	unsigned int		bi_idx;		/* current index into bvl_vec */
-
-	unsigned int            bi_bvec_done;	/* number of bytes completed in
-						   current bvec */
-};
-
 /*
  * main unit of I/O for the block layer and lower layers (ie drivers and
  * stacking drivers)
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 29c459d..e111124 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -20,7 +20,25 @@
 #ifndef __LINUX_BVEC_ITER_H
 #define __LINUX_BVEC_ITER_H
 
-#include <linux/blk_types.h>
+/*
+ * was unsigned short, but we might as well be ready for > 64kB I/O pages
+ */
+struct bio_vec {
+	struct page	*bv_page;
+	unsigned int	bv_len;
+	unsigned int	bv_offset;
+};
+
+struct bvec_iter {
+	sector_t		bi_sector;	/* device address in 512 byte
+						   sectors */
+	unsigned int		bi_size;	/* residual I/O count */
+
+	unsigned int		bi_idx;		/* current index into bvl_vec */
+
+	unsigned int            bi_bvec_done;	/* number of bytes completed in
+						   current bvec */
+};
 
 /*
  * various member access, note that bio_data should of course not be used
-- 
1.9.1

