Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 92F6E100540A
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:14:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 6E2371B4262
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:14:49 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wQOT-yGCl5El for <drbd-dev@lists.linbit.com>;
	Thu, 24 May 2012 18:14:49 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 52D3F1B40FA
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:14:49 +0200 (CEST)
Resent-Message-ID: <20120524161449.GE5734@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C9DB81013802
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 02:03:26 +0200 (CEST)
Received: by mail-pb0-f54.google.com with SMTP id ro2so13647885pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2012 17:03:26 -0700 (PDT)
From: Kent Overstreet <koverstreet@google.com>
To: linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	dm-devel@redhat.com, linux-fsdevel@vger.kernel.org
Date: Wed, 23 May 2012 17:02:42 -0700
Message-Id: <1337817771-25038-6-git-send-email-koverstreet@google.com>
In-Reply-To: <1337817771-25038-1-git-send-email-koverstreet@google.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, neilb@suse.de,
	Kent Overstreet <koverstreet@google.com>, mpatocka@redhat.com,
	vgoyal@redhat.com, bharrosh@panasas.com, tj@kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v2 05/14] block: Only clone bio vecs that are in
	use
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

bcache creates large bios internally, and then splits them according to
the device requirements before it sends them down. If a lower level
device tries to clone the bio, and the original bio had more than
BIO_MAX_PAGES, the clone will fail unecessarily.

We can fix this by only cloning the bio vecs that are actually in use.

Signed-off-by: Kent Overstreet <koverstreet@google.com>
---
 fs/bio.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/bio.c b/fs/bio.c
index e2c0970..de0733e 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -435,8 +435,9 @@ EXPORT_SYMBOL(bio_phys_segments);
  */
 void __bio_clone(struct bio *bio, struct bio *bio_src)
 {
-	memcpy(bio->bi_io_vec, bio_src->bi_io_vec,
-		bio_src->bi_max_vecs * sizeof(struct bio_vec));
+	memcpy(bio->bi_io_vec,
+	       bio_iovec(bio_src),
+	       bio_segments(bio_src) * sizeof(struct bio_vec));
 
 	/*
 	 * most users will be overriding ->bi_bdev with a new target,
@@ -445,10 +446,10 @@ void __bio_clone(struct bio *bio, struct bio *bio_src)
 	bio->bi_sector = bio_src->bi_sector;
 	bio->bi_bdev = bio_src->bi_bdev;
 	bio->bi_flags |= 1 << BIO_CLONED;
+	bio->bi_flags &= ~(1 << BIO_SEG_VALID);
 	bio->bi_rw = bio_src->bi_rw;
-	bio->bi_vcnt = bio_src->bi_vcnt;
+	bio->bi_vcnt = bio_segments(bio_src);
 	bio->bi_size = bio_src->bi_size;
-	bio->bi_idx = bio_src->bi_idx;
 }
 EXPORT_SYMBOL(__bio_clone);
 
@@ -463,7 +464,7 @@ EXPORT_SYMBOL(__bio_clone);
 struct bio *bio_clone_bioset(struct bio *bio, gfp_t gfp_mask,
 			     struct bio_set *bs)
 {
-	struct bio *b = bio_alloc_bioset(gfp_mask, bio->bi_max_vecs, bs);
+	struct bio *b = bio_alloc_bioset(gfp_mask, bio_segments(bio), bs);
 
 	if (!b)
 		return NULL;
@@ -493,7 +494,7 @@ EXPORT_SYMBOL(bio_clone);
 
 struct bio *bio_clone_kmalloc(struct bio *bio, gfp_t gfp_mask)
 {
-	struct bio *b = bio_kmalloc(gfp_mask, bio->bi_max_vecs);
+	struct bio *b = bio_kmalloc(gfp_mask, bio_segments(bio));
 
 	if (!b)
 		return NULL;
-- 
1.7.9.3.327.g2980b

