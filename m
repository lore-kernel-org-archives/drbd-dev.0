Return-Path: <BATV+b18bff4eac1ff4fd9b6a+6737+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id EF8464201FA
	for <drbd-dev@lists.linbit.com>; Wed,  2 Feb 2022 17:56:51 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  2 Feb 2022 17:01:08 +0100
Message-Id: <20220202160109.108149-13-hch@lst.de>
In-Reply-To: <20220202160109.108149-1-hch@lst.de>
References: <20220202160109.108149-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Pavel Begunkov <asml.silence@gmail.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 12/13] block: initialize the target bio in
	__bio_clone_fast
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

All callers of __bio_clone_fast initialize the bio first.  Move that
initialization into __bio_clone_fast instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c                 | 75 ++++++++++++++++++++-----------------
 drivers/md/bcache/request.c |  1 -
 drivers/md/md-multipath.c   |  1 -
 3 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b5840ef549164..22b18ba6bb1c5 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -726,37 +726,16 @@ void bio_put(struct bio *bio)
 }
 EXPORT_SYMBOL(bio_put);
 
-/**
- * 	__bio_clone_fast - clone a bio that shares the original bio's biovec
- * 	@bio: destination bio
- * 	@bio_src: bio to clone
- *	@gfp: allocation flags
- *
- *	Clone a &bio. Caller will own the returned bio, but not
- *	the actual data it points to. Reference count of returned
- * 	bio will be one.
- *
- * 	Caller must ensure that @bio_src is not freed before @bio.
- */
-int __bio_clone_fast(struct bio *bio, struct bio *bio_src, gfp_t gfp)
+static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 {
-	WARN_ON_ONCE(bio->bi_pool && bio->bi_max_vecs);
-
-	/*
-	 * most users will be overriding ->bi_bdev with a new target,
-	 * so we don't set nor calculate new physical/hw segment counts here
-	 */
-	bio->bi_bdev = bio_src->bi_bdev;
 	bio_set_flag(bio, BIO_CLONED);
 	if (bio_flagged(bio_src, BIO_THROTTLED))
 		bio_set_flag(bio, BIO_THROTTLED);
 	if (bio_flagged(bio_src, BIO_REMAPPED))
 		bio_set_flag(bio, BIO_REMAPPED);
-	bio->bi_opf = bio_src->bi_opf;
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_iter = bio_src->bi_iter;
-	bio->bi_io_vec = bio_src->bi_io_vec;
 
 	bio_clone_blkg_association(bio, bio_src);
 	blkcg_bio_issue_init(bio);
@@ -768,33 +747,59 @@ int __bio_clone_fast(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 		return -ENOMEM;
 	return 0;
 }
-EXPORT_SYMBOL(__bio_clone_fast);
 
 /**
- *	bio_clone_fast - clone a bio that shares the original bio's biovec
- *	@bio: bio to clone
- *	@gfp_mask: allocation priority
- *	@bs: bio_set to allocate from
+ * bio_clone_fast - clone a bio that shares the original bio's biovec
+ * @bio_src: bio to clone from
+ * @gfp: allocation priority
+ * @bs: bio_set to allocate from
+ *
+ * Allocate a new bio that is a clone of @bio_src. The caller owns the returned
+ * bio, but not the actual data it points to.
  *
- * 	Like __bio_clone_fast, only also allocates the returned bio
+ * The caller must ensure that the return bio is not freed before @bio_src.
  */
-struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
+struct bio *bio_clone_fast(struct bio *bio_src, gfp_t gfp, struct bio_set *bs)
 {
-	struct bio *b;
+	struct bio *bio;
 
-	b = bio_alloc_bioset(NULL, 0, 0, gfp_mask, bs);
-	if (!b)
+	bio = bio_alloc_bioset(bio_src->bi_bdev, 0, bio_src->bi_opf, gfp, bs);
+	if (!bio)
 		return NULL;
 
-	if (__bio_clone_fast(b, bio, gfp_mask < 0)) {
-		bio_put(b);
+	if (__bio_clone(bio, bio_src, gfp) < 0) {
+		bio_put(bio);
 		return NULL;
 	}
+	bio->bi_io_vec = bio_src->bi_io_vec;
 
-	return b;
+	return bio;
 }
 EXPORT_SYMBOL(bio_clone_fast);
 
+/**
+ * __bio_clone_fast - clone a bio that shares the original bio's biovec
+ * @bio: bio to clone into
+ * @bio_src: bio to clone from
+ * @gfp: allocation priority
+ *
+ * Initialize a new bio in caller provided memory that is a clone of @bio_src.
+ * The caller owns the returned bio, but not the actual data it points to.
+ *
+ * The caller must ensure that @bio_src is not freed before @bio.
+ */
+int __bio_clone_fast(struct bio *bio, struct bio *bio_src, gfp_t gfp)
+{
+	int ret;
+
+	bio_init(bio, bio_src->bi_bdev, bio_src->bi_io_vec, 0, bio_src->bi_opf);
+	ret = __bio_clone(bio, bio_src, gfp);
+	if (ret)
+		bio_uninit(bio);
+	return ret;
+}
+EXPORT_SYMBOL(__bio_clone_fast);
+
 const char *bio_devname(struct bio *bio, char *buf)
 {
 	return bdevname(bio->bi_bdev, buf);
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 574b02b94f1a4..d2cb853bf9173 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -685,7 +685,6 @@ static void do_bio_hook(struct search *s,
 {
 	struct bio *bio = &s->bio.bio;
 
-	bio_init(bio, NULL, NULL, 0, 0);
 	__bio_clone_fast(bio, orig_bio, GFP_NOIO);
 	/*
 	 * bi_end_io can be set separately somewhere else, e.g. the
diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
index 010c759c741ad..483a5500f83cd 100644
--- a/drivers/md/md-multipath.c
+++ b/drivers/md/md-multipath.c
@@ -121,7 +121,6 @@ static bool multipath_make_request(struct mddev *mddev, struct bio * bio)
 	}
 	multipath = conf->multipaths + mp_bh->path;
 
-	bio_init(&mp_bh->bio, NULL, NULL, 0, 0);
 	__bio_clone_fast(&mp_bh->bio, bio, GFP_NOIO);
 
 	mp_bh->bio.bi_iter.bi_sector += multipath->rdev->data_offset;
-- 
2.30.2

