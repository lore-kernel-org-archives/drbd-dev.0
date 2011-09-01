Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu,  1 Sep 2011 14:48:52 +0200
Message-Id: <1314881345-6420-6-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314881345-6420-1-git-send-email-philipp.reisner@linbit.com>
References: <1314881345-6420-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/18] drbd: introduce a bio_set to allocate
	housekeeping bios from
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Don't rely on availability of bios from the global fs_bio_set,
we should use our own bio_set for meta data IO.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c   |    2 +-
 drivers/block/drbd/drbd_bitmap.c   |    3 +--
 drivers/block/drbd/drbd_int.h      |    6 ++++++
 drivers/block/drbd/drbd_main.c     |   28 ++++++++++++++++++++++++++++
 drivers/block/drbd/drbd_receiver.c |    6 +++++-
 5 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 55f5a7a..9ab6365 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -125,7 +125,7 @@ static int _drbd_md_sync_page_io(struct drbd_conf *mdev,
 		rw |= REQ_FUA | REQ_FLUSH;
 	rw |= REQ_SYNC;
 
-	bio = bio_alloc(GFP_NOIO, 1);
+	bio = bio_alloc_drbd(GFP_NOIO);
 	bio->bi_bdev = bdev->md_bdev;
 	bio->bi_sector = sector;
 	ok = (bio_add_page(bio, page, size, 0) == size);
diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 412ca94..a1d72db 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -968,8 +968,7 @@ static void bm_async_io_complete(struct bio *bio, int error)
 
 static void bm_page_io_async(struct bm_aio_ctx *ctx, int page_nr, int rw) __must_hold(local)
 {
-	/* we are process context. we always get a bio */
-	struct bio *bio = bio_alloc(GFP_KERNEL, 1);
+	struct bio *bio = bio_alloc_drbd(GFP_KERNEL);
 	struct drbd_conf *mdev = ctx->mdev;
 	struct drbd_bitmap *b = mdev->bitmap;
 	struct page *page;
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 4debab7..5d90b9d 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1489,6 +1489,12 @@ extern wait_queue_head_t drbd_pp_wait;
 #define DRBD_MIN_POOL_PAGES	128
 extern mempool_t *drbd_md_io_page_pool;
 
+/* We also need to make sure we get a bio
+ * when we need it for housekeeping purposes */
+extern struct bio_set *drbd_md_io_bio_set;
+/* to allocate from that set */
+extern struct bio *bio_alloc_drbd(gfp_t gfp_mask);
+
 extern rwlock_t global_state_lock;
 
 extern int conn_lowest_minor(struct drbd_tconn *tconn);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index cb1636c..26bcd13 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -130,6 +130,7 @@ struct kmem_cache *drbd_al_ext_cache;	/* activity log extents */
 mempool_t *drbd_request_mempool;
 mempool_t *drbd_ee_mempool;
 mempool_t *drbd_md_io_page_pool;
+struct bio_set *drbd_md_io_bio_set;
 
 /* I do not use a standard mempool, because:
    1) I want to hand out the pre-allocated objects first.
@@ -150,6 +151,25 @@ static const struct block_device_operations drbd_ops = {
 	.release = drbd_release,
 };
 
+static void bio_destructor_drbd(struct bio *bio)
+{
+	bio_free(bio, drbd_md_io_bio_set);
+}
+
+struct bio *bio_alloc_drbd(gfp_t gfp_mask)
+{
+	struct bio *bio;
+
+	if (!drbd_md_io_bio_set)
+		return bio_alloc(gfp_mask, 1);
+
+	bio = bio_alloc_bioset(gfp_mask, 1, drbd_md_io_bio_set);
+	if (!bio)
+		return NULL;
+	bio->bi_destructor = bio_destructor_drbd;
+	return bio;
+}
+
 #ifdef __CHECKER__
 /* When checking with sparse, and this is an inline function, sparse will
    give tons of false positives. When this is a real functions sparse works.
@@ -1953,6 +1973,8 @@ static void drbd_destroy_mempools(void)
 
 	/* D_ASSERT(atomic_read(&drbd_pp_vacant)==0); */
 
+	if (drbd_md_io_bio_set)
+		bioset_free(drbd_md_io_bio_set);
 	if (drbd_md_io_page_pool)
 		mempool_destroy(drbd_md_io_page_pool);
 	if (drbd_ee_mempool)
@@ -1968,6 +1990,7 @@ static void drbd_destroy_mempools(void)
 	if (drbd_al_ext_cache)
 		kmem_cache_destroy(drbd_al_ext_cache);
 
+	drbd_md_io_bio_set   = NULL;
 	drbd_md_io_page_pool = NULL;
 	drbd_ee_mempool      = NULL;
 	drbd_request_mempool = NULL;
@@ -1993,6 +2016,7 @@ static int drbd_create_mempools(void)
 	drbd_al_ext_cache    = NULL;
 	drbd_pp_pool         = NULL;
 	drbd_md_io_page_pool = NULL;
+	drbd_md_io_bio_set   = NULL;
 
 	/* caches */
 	drbd_request_cache = kmem_cache_create(
@@ -2016,6 +2040,10 @@ static int drbd_create_mempools(void)
 		goto Enomem;
 
 	/* mempools */
+	drbd_md_io_bio_set = bioset_create(DRBD_MIN_POOL_PAGES, 0);
+	if (drbd_md_io_bio_set == NULL)
+		goto Enomem;
+
 	drbd_md_io_page_pool = mempool_create_page_pool(DRBD_MIN_POOL_PAGES, 0);
 	if (drbd_md_io_page_pool == NULL)
 		goto Enomem;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 64f658b..12b1533 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1127,7 +1127,11 @@ int drbd_submit_peer_request(struct drbd_conf *mdev,
 	/* In most cases, we will only need one bio.  But in case the lower
 	 * level restrictions happen to be different at this offset on this
 	 * side than those of the sending peer, we may need to submit the
-	 * request in more than one bio. */
+	 * request in more than one bio.
+	 *
+	 * Plain bio_alloc is good enough here, this is no DRBD internally
+	 * generated bio, but a bio allocated on behalf of the peer.
+	 */
 next_bio:
 	bio = bio_alloc(GFP_NOIO, nr_pages);
 	if (!bio) {
-- 
1.7.4.1

