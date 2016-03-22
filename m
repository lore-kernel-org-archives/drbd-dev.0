Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 37B0E1056433
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 32A97406FF6
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:52 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Ym9yJndNRJKF for <drbd-dev@lists.linbit.com>;
	Tue, 22 Mar 2016 11:52:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 1728A406FAB
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:52 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id O4ne_Wev8QIk for <drbd-dev@lists.linbit.com>;
	Tue, 22 Mar 2016 11:52:52 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id E5FBA406FBD
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:51 +0100 (CET)
Resent-Message-ID: <20160322105251.GP4437@soda.linbit>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
	[209.85.192.194]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 45C521056332
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 07:31:10 +0100 (CET)
Received: by mail-pf0-f194.google.com with SMTP id n5so33987815pfn.1
	for <drbd-dev@lists.linbit.com>; Mon, 21 Mar 2016 23:31:10 -0700 (PDT)
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Date: Tue, 22 Mar 2016 14:12:24 +0800
Message-Id: <1458627149-12988-4-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1458627149-12988-1-git-send-email-ming.lei@canonical.com>
References: <1458627149-12988-1-git-send-email-ming.lei@canonical.com>
Cc: Christoph Hellwig <hch@infradead.org>, Boaz Harrosh <boaz@plexistor.com>,
	Ming Lei <ming.lei@canonical.com>, Dave Chinner <david@fromorbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, xfs@oss.sgi.com,
	linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 3/8] block: mark 1st parameter of
	bvec_iter_advance as const
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

bvec_iter_advance() only writes the parameter of iterator,
so the base address of bvec can be marked as const safely.

Without the change, we can see compiling warning in the
following patch for implementing iterate_bvec(): lib/iov_iter.c
with bvec iterator.

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 include/linux/bvec_iter.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bvec_iter.h b/include/linux/bvec_iter.h
index cc43055..5798c21 100644
--- a/include/linux/bvec_iter.h
+++ b/include/linux/bvec_iter.h
@@ -49,7 +49,8 @@
 	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
 })
 
-static inline void bvec_iter_advance(struct bio_vec *bv, struct bvec_iter *iter,
+static inline void bvec_iter_advance(const struct bio_vec *bv,
+				     struct bvec_iter *iter,
 				     unsigned bytes)
 {
 	WARN_ONCE(bytes > iter->bi_size,
-- 
1.9.1

