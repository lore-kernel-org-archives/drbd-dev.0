Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7E2DE1056452
	for <drbd-dev@lists.linbit.com>; Mon,  4 Apr 2016 11:19:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 77E8A36CCF5
	for <drbd-dev@lists.linbit.com>; Mon,  4 Apr 2016 11:19:35 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id CzFwEleBNCzs for <drbd-dev@lists.linbit.com>;
	Mon,  4 Apr 2016 11:19:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 5B0ED36CCE9
	for <drbd-dev@lists.linbit.com>; Mon,  4 Apr 2016 11:19:35 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SuhT-rpaAmpk for <drbd-dev@lists.linbit.com>;
	Mon,  4 Apr 2016 11:19:35 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 33BAB36CCD8
	for <drbd-dev@lists.linbit.com>; Mon,  4 Apr 2016 11:19:35 +0200 (CEST)
Resent-Message-ID: <20160404091934.GQ3078@soda.linbit>
Received: from mail-pf0-f173.google.com (mail-pf0-f173.google.com
	[209.85.192.173]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 387DC1056442
	for <drbd-dev@lists.linbit.com>; Mon,  4 Apr 2016 08:57:04 +0200 (CEST)
Received: by mail-pf0-f173.google.com with SMTP id 184so38028462pff.0
	for <drbd-dev@lists.linbit.com>; Sun, 03 Apr 2016 23:57:04 -0700 (PDT)
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon,  4 Apr 2016 14:56:30 +0800
Message-Id: <1459752994-2205-5-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1459752994-2205-1-git-send-email-ming.lei@canonical.com>
References: <1459752994-2205-1-git-send-email-ming.lei@canonical.com>
Cc: Christoph Hellwig <hch@infradead.org>, Boaz Harrosh <boaz@plexistor.com>,
	Ming Lei <ming.lei@canonical.com>, Dave Chinner <david@fromorbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, xfs@oss.sgi.com,
	linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v3 4/8] iov_iter: use bvec iterator to implement
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
to reinvent a new wheel for this job.

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 lib/iov_iter.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 5fecddc..c8691ac 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -57,35 +57,25 @@
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
@@ -102,7 +92,7 @@
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

