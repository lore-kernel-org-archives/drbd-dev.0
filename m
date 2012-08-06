Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4385F1055F5F
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 3C6281B435E
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:21 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LLAkzWUU9b-V for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:21 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id F05E91B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:20 +0200 (CEST)
Resent-Message-ID: <20120810203320.GQ31190@soda.linbit>
Received: from mail-yx0-f182.google.com (mail-yx0-f182.google.com
	[209.85.213.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 80DC6100542F
	for <drbd-dev@lists.linbit.com>; Tue,  7 Aug 2012 00:17:16 +0200 (CEST)
Received: by yenl8 with SMTP id l8so4488727yen.27
	for <drbd-dev@lists.linbit.com>; Mon, 06 Aug 2012 15:17:16 -0700 (PDT)
From: Kent Overstreet <koverstreet@google.com>
To: linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com
Date: Mon,  6 Aug 2012 15:08:40 -0700
Message-Id: <1344290921-25154-12-git-send-email-koverstreet@google.com>
In-Reply-To: <1344290921-25154-1-git-send-email-koverstreet@google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, neilb@suse.de, Kent Overstreet <koverstreet@google.com>,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	tj@kernel.org, sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v5 11/12] block: Add bio_clone_bioset()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This consolidates some code, and will help in a later patch changing how
bio cloning works.

Signed-off-by: Kent Overstreet <koverstreet@google.com>
---
 block/blk-core.c    |    8 +-------
 drivers/md/dm.c     |    4 ++--
 drivers/md/md.c     |   20 +-------------------
 fs/bio.c            |   16 ++++++++++++----
 include/linux/bio.h |    1 +
 5 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index e9058c2..10a6e08 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2768,16 +2768,10 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 	blk_rq_init(NULL, rq);
 
 	__rq_for_each_bio(bio_src, rq_src) {
-		bio = bio_alloc_bioset(gfp_mask, bio_src->bi_max_vecs, bs);
+		bio = bio_clone_bioset(bio_src, gfp_mask, bs);
 		if (!bio)
 			goto free_and_out;
 
-		__bio_clone(bio, bio_src);
-
-		if (bio_integrity(bio_src) &&
-		    bio_integrity_clone(bio, bio_src, gfp_mask, bs))
-			goto free_and_out;
-
 		if (bio_ctr && bio_ctr(bio, bio_src, data))
 			goto free_and_out;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 4014696..3f3c26e 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1101,8 +1101,8 @@ static void __issue_target_request(struct clone_info *ci, struct dm_target *ti,
 	 * ci->bio->bi_max_vecs is BIO_INLINE_VECS anyway, for both flush
 	 * and discard, so no need for concern about wasted bvec allocations.
 	 */
-	clone = bio_alloc_bioset(GFP_NOIO, ci->bio->bi_max_vecs, ci->md->bs);
-	__bio_clone(clone, ci->bio);
+	clone = bio_clone_bioset(ci->bio, GFP_NOIO, ci->md->bs);
+
 	if (len) {
 		clone->bi_sector = ci->sector;
 		clone->bi_size = to_bytes(len);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index f9d16dc..069c3bc 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -173,28 +173,10 @@ EXPORT_SYMBOL_GPL(bio_alloc_mddev);
 struct bio *bio_clone_mddev(struct bio *bio, gfp_t gfp_mask,
 			    struct mddev *mddev)
 {
-	struct bio *b;
-
 	if (!mddev || !mddev->bio_set)
 		return bio_clone(bio, gfp_mask);
 
-	b = bio_alloc_bioset(gfp_mask, bio->bi_max_vecs, mddev->bio_set);
-	if (!b)
-		return NULL;
-
-	__bio_clone(b, bio);
-	if (bio_integrity(bio)) {
-		int ret;
-
-		ret = bio_integrity_clone(b, bio, gfp_mask, mddev->bio_set);
-
-		if (ret < 0) {
-			bio_put(b);
-			return NULL;
-		}
-	}
-
-	return b;
+	return bio_clone_bioset(bio, gfp_mask, mddev->bio_set);
 }
 EXPORT_SYMBOL_GPL(bio_clone_mddev);
 
diff --git a/fs/bio.c b/fs/bio.c
index 77b9313..38ad026 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -467,15 +467,17 @@ void __bio_clone(struct bio *bio, struct bio *bio_src)
 EXPORT_SYMBOL(__bio_clone);
 
 /**
- *	bio_clone	-	clone a bio
+ *	bio_clone_bioset -	clone a bio
  *	@bio: bio to clone
  *	@gfp_mask: allocation priority
+ *	@bs: bio_set to allocate from
  *
  * 	Like __bio_clone, only also allocates the returned bio
  */
-struct bio *bio_clone(struct bio *bio, gfp_t gfp_mask)
+struct bio *bio_clone_bioset(struct bio *bio, gfp_t gfp_mask,
+			     struct bio_set *bs)
 {
-	struct bio *b = bio_alloc(gfp_mask, bio->bi_max_vecs);
+	struct bio *b = bio_alloc_bioset(gfp_mask, bio->bi_max_vecs, bs);
 
 	if (!b)
 		return NULL;
@@ -485,7 +487,7 @@ struct bio *bio_clone(struct bio *bio, gfp_t gfp_mask)
 	if (bio_integrity(bio)) {
 		int ret;
 
-		ret = bio_integrity_clone(b, bio, gfp_mask, fs_bio_set);
+		ret = bio_integrity_clone(b, bio, gfp_mask, bs);
 
 		if (ret < 0) {
 			bio_put(b);
@@ -495,6 +497,12 @@ struct bio *bio_clone(struct bio *bio, gfp_t gfp_mask)
 
 	return b;
 }
+EXPORT_SYMBOL(bio_clone_bioset);
+
+struct bio *bio_clone(struct bio *bio, gfp_t gfp_mask)
+{
+	return bio_clone_bioset(bio, gfp_mask, fs_bio_set);
+}
 EXPORT_SYMBOL(bio_clone);
 
 struct bio *bio_clone_kmalloc(struct bio *bio, gfp_t gfp_mask)
diff --git a/include/linux/bio.h b/include/linux/bio.h
index e180f1d..fb90584 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -220,6 +220,7 @@ struct request_queue;
 extern int bio_phys_segments(struct request_queue *, struct bio *);
 
 extern void __bio_clone(struct bio *, struct bio *);
+extern struct bio *bio_clone_bioset(struct bio *, gfp_t, struct bio_set *bs);
 extern struct bio *bio_clone(struct bio *, gfp_t);
 struct bio *bio_clone_kmalloc(struct bio *, gfp_t);
 
-- 
1.7.7.3

