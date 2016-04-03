Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 800401056444
	for <drbd-dev@lists.linbit.com>; Mon,  4 Apr 2016 11:19:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 7808836CCD8
	for <drbd-dev@lists.linbit.com>; Mon,  4 Apr 2016 11:19:23 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id KsTSgLu768v7 for <drbd-dev@lists.linbit.com>;
	Mon,  4 Apr 2016 11:19:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 59C0836CCE9
	for <drbd-dev@lists.linbit.com>; Mon,  4 Apr 2016 11:19:23 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NLEj7CypNzxE for <drbd-dev@lists.linbit.com>;
	Mon,  4 Apr 2016 11:19:23 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 344AF36CCD8
	for <drbd-dev@lists.linbit.com>; Mon,  4 Apr 2016 11:19:23 +0200 (CEST)
Resent-Message-ID: <20160404091922.GF3078@soda.linbit>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B32571056441
	for <drbd-dev@lists.linbit.com>; Sun,  3 Apr 2016 18:31:40 +0200 (CEST)
Received: by mail-pa0-f41.google.com with SMTP id tt10so126796873pab.3
	for <drbd-dev@lists.linbit.com>; Sun, 03 Apr 2016 09:31:40 -0700 (PDT)
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon,  4 Apr 2016 00:31:04 +0800
Message-Id: <1459701069-31406-4-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1459701069-31406-1-git-send-email-ming.lei@canonical.com>
References: <1459701069-31406-1-git-send-email-ming.lei@canonical.com>
Cc: Christoph Hellwig <hch@infradead.org>, Boaz Harrosh <boaz@plexistor.com>,
	Ming Lei <ming.lei@canonical.com>, Dave Chinner <david@fromorbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, xfs@oss.sgi.com,
	linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v2 3/8] block: mark 1st parameter of
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 include/linux/bvec.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index e111124..0c6fa42 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -63,7 +63,8 @@ struct bvec_iter {
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

