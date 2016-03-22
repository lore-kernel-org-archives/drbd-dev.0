Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 10DB0105632B
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 064A4406FF6
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:44 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id OCJic0H4IqrS for <drbd-dev@lists.linbit.com>;
	Tue, 22 Mar 2016 11:52:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id DEBF340700B
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:43 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8LIpQIv5e13v for <drbd-dev@lists.linbit.com>;
	Tue, 22 Mar 2016 11:52:43 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id B6C30406FF6
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:43 +0100 (CET)
Resent-Message-ID: <20160322105243.GI4437@soda.linbit>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
	[209.85.192.196]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 0CACA1056332
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 07:24:30 +0100 (CET)
Received: by mail-pf0-f196.google.com with SMTP id n5so33960454pfn.1
	for <drbd-dev@lists.linbit.com>; Mon, 21 Mar 2016 23:24:29 -0700 (PDT)
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Date: Tue, 22 Mar 2016 14:12:25 +0800
Message-Id: <1458627149-12988-5-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1458627149-12988-1-git-send-email-ming.lei@canonical.com>
References: <1458627149-12988-1-git-send-email-ming.lei@canonical.com>
Cc: Christoph Hellwig <hch@infradead.org>, Boaz Harrosh <boaz@plexistor.com>,
	Ming Lei <ming.lei@canonical.com>, Dave Chinner <david@fromorbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, xfs@oss.sgi.com,
	linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 4/8] iov_iter: use bvec iterator to implement
	iterate_bvec()
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

bvec has provided one iterator already, so not necessary
to invent a new wheel for this job.

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 lib/iov_iter.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 5fecddc..5e1b224 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -3,6 +3,7 @@
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/bvec_iter.h>
 #include <net/checksum.h>
 
 #define iterate_iovec(i, n, __v, __p, skip, STEP) {	\
@@ -57,35 +58,25 @@
 }
 
 #define iterate_bvec(i, n, __v, __p, skip, STEP) {	\
-	size_t wanted = n;				\
+	struct bvec_iter __bi, __start;			\
+	__start.bi_size = n;				\
+	__start.bi_bvec_done = skip;			\
+	__start.bi_idx = 0;				\
 	__p = i->bvec;					\
-	__v.bv_len = min_t(size_t, n, __p->bv_len - skip);	\
-	if (likely(__v.bv_len)) {			\
-		__v.bv_page = __p->bv_page;		\
-		__v.bv_offset = __p->bv_offset + skip; 	\
+	for_each_bvec(__v, __p, __bi, __start) {	\
 		(void)(STEP);				\
-		skip += __v.bv_len;			\
-		n -= __v.bv_len;			\
 	}						\
-	while (unlikely(n)) {				\
-		__p++;					\
-		__v.bv_len = min_t(size_t, n, __p->bv_len);	\
-		if (unlikely(!__v.bv_len))		\
-			continue;			\
-		__v.bv_page = __p->bv_page;		\
-		__v.bv_offset = __p->bv_offset;		\
-		(void)(STEP);				\
+	if (!__bi.bi_idx)				\
+		skip += __v.bv_len;			\
+	else						\
 		skip = __v.bv_len;			\
-		n -= __v.bv_len;			\
-	}						\
-	n = wanted;					\
 }
 
 #define iterate_all_kinds(i, n, v, I, B, K) {			\
 	size_t skip = i->iov_offset;				\
 	if (unlikely(i->type & ITER_BVEC)) {			\
 		const struct bio_vec *bvec;			\
-		struct bio_vec v;				\
+		struct bio_vec v = { 0 };			\
 		iterate_bvec(i, n, v, bvec, skip, (B))		\
 	} else if (unlikely(i->type & ITER_KVEC)) {		\
 		const struct kvec *kvec;			\
@@ -102,7 +93,7 @@
 	size_t skip = i->iov_offset;				\
 	if (unlikely(i->type & ITER_BVEC)) {			\
 		const struct bio_vec *bvec;			\
-		struct bio_vec v;				\
+		struct bio_vec v = { 0 };			\
 		iterate_bvec(i, n, v, bvec, skip, (B))		\
 		if (skip == bvec->bv_len) {			\
 			bvec++;					\
-- 
1.9.1

