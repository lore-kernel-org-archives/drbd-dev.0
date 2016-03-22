Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 18068105632B
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 07B37406FF6
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:35 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id uJlyC_9JLiUi for <drbd-dev@lists.linbit.com>;
	Tue, 22 Mar 2016 11:52:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id DB5E9406FFA
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:34 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OhG_8XQbBK6M for <drbd-dev@lists.linbit.com>;
	Tue, 22 Mar 2016 11:52:34 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 85CE6406FF6
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:34 +0100 (CET)
Resent-Message-ID: <20160322105234.GH4437@soda.linbit>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
	[209.85.192.193]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 72A4A1056332
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 07:24:27 +0100 (CET)
Received: by mail-pf0-f193.google.com with SMTP id n5so33960278pfn.1
	for <drbd-dev@lists.linbit.com>; Mon, 21 Mar 2016 23:24:27 -0700 (PDT)
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Date: Tue, 22 Mar 2016 14:12:22 +0800
Message-Id: <1458627149-12988-2-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1458627149-12988-1-git-send-email-ming.lei@canonical.com>
References: <1458627149-12988-1-git-send-email-ming.lei@canonical.com>
Cc: Christoph Hellwig <hch@infradead.org>, Boaz Harrosh <boaz@plexistor.com>,
	Ming Lei <ming.lei@canonical.com>, Dave Chinner <david@fromorbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, xfs@oss.sgi.com,
	linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 1/8] block: move bvec iterator into
	include/linux/bvec_iter.h
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

bvec iterator helpers should be used to implement by
iterate_bvec():lib/iov_iter.c too, and move them into
one header, so that we can keep bvec iterator header
out of CONFIG_BLOCK. Then we can remove the inventing
of wheel in iterate_bvec().

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 include/linux/bio.h       | 55 +--------------------------------
 include/linux/bvec_iter.h | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 54 deletions(-)
 create mode 100644 include/linux/bvec_iter.h

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 88bc64f..4abc129 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -31,6 +31,7 @@
 
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
 #include <linux/blk_types.h>
+#include <linux/bvec_iter.h>
 
 #define BIO_DEBUG
 
@@ -40,10 +41,6 @@
 #define BIO_BUG_ON
 #endif
 
-#define BIO_MAX_PAGES		256
-#define BIO_MAX_SIZE		(BIO_MAX_PAGES << PAGE_CACHE_SHIFT)
-#define BIO_MAX_SECTORS		(BIO_MAX_SIZE >> 9)
-
 /*
  * upper 16 bits of bi_rw define the io priority of this bio
  */
@@ -57,29 +54,6 @@
 	(bio)->bi_rw |= ((unsigned long) (prio) << BIO_PRIO_SHIFT);	\
 } while (0)
 
-/*
- * various member access, note that bio_data should of course not be used
- * on highmem page vectors
- */
-#define __bvec_iter_bvec(bvec, iter)	(&(bvec)[(iter).bi_idx])
-
-#define bvec_iter_page(bvec, iter)				\
-	(__bvec_iter_bvec((bvec), (iter))->bv_page)
-
-#define bvec_iter_len(bvec, iter)				\
-	min((iter).bi_size,					\
-	    __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
-
-#define bvec_iter_offset(bvec, iter)				\
-	(__bvec_iter_bvec((bvec), (iter))->bv_offset + (iter).bi_bvec_done)
-
-#define bvec_iter_bvec(bvec, iter)				\
-((struct bio_vec) {						\
-	.bv_page	= bvec_iter_page((bvec), (iter)),	\
-	.bv_len		= bvec_iter_len((bvec), (iter)),	\
-	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
-})
-
 #define bio_iter_iovec(bio, iter)				\
 	bvec_iter_bvec((bio)->bi_io_vec, (iter))
 
@@ -193,33 +167,6 @@ static inline void *bio_data(struct bio *bio)
 #define bio_for_each_segment_all(bvl, bio, i)				\
 	for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
 
-static inline void bvec_iter_advance(struct bio_vec *bv, struct bvec_iter *iter,
-				     unsigned bytes)
-{
-	WARN_ONCE(bytes > iter->bi_size,
-		  "Attempted to advance past end of bvec iter\n");
-
-	while (bytes) {
-		unsigned len = min(bytes, bvec_iter_len(bv, *iter));
-
-		bytes -= len;
-		iter->bi_size -= len;
-		iter->bi_bvec_done += len;
-
-		if (iter->bi_bvec_done == __bvec_iter_bvec(bv, *iter)->bv_len) {
-			iter->bi_bvec_done = 0;
-			iter->bi_idx++;
-		}
-	}
-}
-
-#define for_each_bvec(bvl, bio_vec, iter, start)			\
-	for (iter = (start);						\
-	     (iter).bi_size &&						\
-		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
-	     bvec_iter_advance((bio_vec), &(iter), (bvl).bv_len))
-
-
 static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
 				    unsigned bytes)
 {
diff --git a/include/linux/bvec_iter.h b/include/linux/bvec_iter.h
new file mode 100644
index 0000000..cc43055
--- /dev/null
+++ b/include/linux/bvec_iter.h
@@ -0,0 +1,78 @@
+/*
+ * bvec iterator
+ *
+ * Copyright (C) 2001 Ming Lei <ming.lei@canonical.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public Licens
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-
+ */
+#ifndef __LINUX_BVEC_ITER_H
+#define __LINUX_BVEC_ITER_H
+
+#include <linux/blk_types.h>
+
+#define BIO_MAX_PAGES		256
+#define BIO_MAX_SIZE		(BIO_MAX_PAGES << PAGE_CACHE_SHIFT)
+#define BIO_MAX_SECTORS		(BIO_MAX_SIZE >> 9)
+
+/*
+ * various member access, note that bio_data should of course not be used
+ * on highmem page vectors
+ */
+#define __bvec_iter_bvec(bvec, iter)	(&(bvec)[(iter).bi_idx])
+
+#define bvec_iter_page(bvec, iter)				\
+	(__bvec_iter_bvec((bvec), (iter))->bv_page)
+
+#define bvec_iter_len(bvec, iter)				\
+	min((iter).bi_size,					\
+	    __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
+
+#define bvec_iter_offset(bvec, iter)				\
+	(__bvec_iter_bvec((bvec), (iter))->bv_offset + (iter).bi_bvec_done)
+
+#define bvec_iter_bvec(bvec, iter)				\
+((struct bio_vec) {						\
+	.bv_page	= bvec_iter_page((bvec), (iter)),	\
+	.bv_len		= bvec_iter_len((bvec), (iter)),	\
+	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
+})
+
+static inline void bvec_iter_advance(struct bio_vec *bv, struct bvec_iter *iter,
+				     unsigned bytes)
+{
+	WARN_ONCE(bytes > iter->bi_size,
+		  "Attempted to advance past end of bvec iter\n");
+
+	while (bytes) {
+		unsigned len = min(bytes, bvec_iter_len(bv, *iter));
+
+		bytes -= len;
+		iter->bi_size -= len;
+		iter->bi_bvec_done += len;
+
+		if (iter->bi_bvec_done == __bvec_iter_bvec(bv, *iter)->bv_len) {
+			iter->bi_bvec_done = 0;
+			iter->bi_idx++;
+		}
+	}
+}
+
+#define for_each_bvec(bvl, bio_vec, iter, start)			\
+	for (iter = (start);						\
+	     (iter).bi_size &&						\
+		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
+	     bvec_iter_advance((bio_vec), &(iter), (bvl).bv_len))
+
+#endif /* __LINUX_BVEC_ITER_H */
-- 
1.9.1

