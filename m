Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu,  1 Sep 2011 14:48:51 +0200
Message-Id: <1314881345-6420-5-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314881345-6420-1-git-send-email-philipp.reisner@linbit.com>
References: <1314881345-6420-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 04/18] drbd: use the newly introduced page pool
	for bitmap IO
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_bitmap.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 2fc3dfa..412ca94 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -957,9 +957,8 @@ static void bm_async_io_complete(struct bio *bio, int error)
 
 	bm_page_unlock_io(mdev, idx);
 
-	/* FIXME give back to page pool */
 	if (ctx->flags & BM_AIO_COPY_PAGES)
-		put_page(bio->bi_io_vec[0].bv_page);
+		mempool_free(bio->bi_io_vec[0].bv_page, drbd_md_io_page_pool);
 
 	bio_put(bio);
 
@@ -993,10 +992,8 @@ static void bm_page_io_async(struct bm_aio_ctx *ctx, int page_nr, int rw) __must
 	bm_set_page_unchanged(b->bm_pages[page_nr]);
 
 	if (ctx->flags & BM_AIO_COPY_PAGES) {
-		/* FIXME alloc_page is good enough for now, but actually needs
-		 * to use pre-allocated page pool */
 		void *src, *dest;
-		page = alloc_page(__GFP_HIGHMEM|__GFP_WAIT);
+		page = mempool_alloc(drbd_md_io_page_pool, __GFP_HIGHMEM|__GFP_WAIT);
 		dest = kmap_atomic(page, KM_USER0);
 		src = kmap_atomic(b->bm_pages[page_nr], KM_USER1);
 		memcpy(dest, src, PAGE_SIZE);
@@ -1008,6 +1005,8 @@ static void bm_page_io_async(struct bm_aio_ctx *ctx, int page_nr, int rw) __must
 
 	bio->bi_bdev = mdev->ldev->md_bdev;
 	bio->bi_sector = on_disk_sector;
+	/* bio_add_page of a single page to an empty bio will always succeed,
+	 * according to api.  Do we want to assert that? */
 	bio_add_page(bio, page, len, 0);
 	bio->bi_private = ctx;
 	bio->bi_end_io = bm_async_io_complete;
-- 
1.7.4.1

