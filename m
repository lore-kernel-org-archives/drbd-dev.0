Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4D2A31056480
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jun 2016 16:09:28 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 13 Jun 2016 16:09:17 +0200
Message-Id: <1465826958-19398-30-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1465826958-19398-1-git-send-email-philipp.reisner@linbit.com>
References: <1465826958-19398-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 29/30] drbd: al_write_transaction: skip
	re-scanning of bitmap page pointer array
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

For larger devices, the array of bitmap page pointers can grow very
large (8000 pointers per TB of storage).

For each activity log transaction, we need to flush the associated
bitmap pages to stable storage. Currently, we just "mark" the respective
pages while setting up the transaction, then tell the bitmap code to
write out all marked pages, but skip unchanged pages.

But one such transaction can affect only a small number of bitmap pages,
there is no need to scan the full array of several (ten-)thousand
page pointers to find the few marked ones.

Instead, remember the index numbers of the few affected pages,
and later only re-check those to skip duplicates and unchanged ones.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c |  2 ++
 drivers/block/drbd/drbd_bitmap.c | 66 +++++++++++++++++++++++++++++++---------
 drivers/block/drbd/drbd_int.h    |  1 +
 3 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 99a2b92..8305615 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -339,6 +339,8 @@ static int __al_write_transaction(struct drbd_device *device, struct al_transact
 
 	i = 0;
 
+	drbd_bm_reset_al_hints(device);
+
 	/* Even though no one can start to change this list
 	 * once we set the LC_LOCKED -- from drbd_al_begin_io(),
 	 * lc_try_lock_for_transaction() --, someone may still
diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 801b8f3..b1c2a57 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -96,6 +96,13 @@ struct drbd_bitmap {
 	struct page **bm_pages;
 	spinlock_t bm_lock;
 
+	/* exclusively to be used by __al_write_transaction(),
+	 * drbd_bm_mark_for_writeout() and
+	 * and drbd_bm_write_hinted() -> bm_rw() called from there.
+	 */
+	unsigned int n_bitmap_hints;
+	unsigned int al_bitmap_hints[AL_UPDATES_PER_TRANSACTION];
+
 	/* see LIMITATIONS: above */
 
 	unsigned long bm_set;       /* nr of set bits; THINK maybe atomic_t? */
@@ -242,6 +249,11 @@ static void bm_set_page_need_writeout(struct page *page)
 	set_bit(BM_PAGE_NEED_WRITEOUT, &page_private(page));
 }
 
+void drbd_bm_reset_al_hints(struct drbd_device *device)
+{
+	device->bitmap->n_bitmap_hints = 0;
+}
+
 /**
  * drbd_bm_mark_for_writeout() - mark a page with a "hint" to be considered for writeout
  * @device:	DRBD device.
@@ -253,6 +265,7 @@ static void bm_set_page_need_writeout(struct page *page)
  */
 void drbd_bm_mark_for_writeout(struct drbd_device *device, int page_nr)
 {
+	struct drbd_bitmap *b = device->bitmap;
 	struct page *page;
 	if (page_nr >= device->bitmap->bm_number_of_pages) {
 		drbd_warn(device, "BAD: page_nr: %u, number_of_pages: %u\n",
@@ -260,7 +273,9 @@ void drbd_bm_mark_for_writeout(struct drbd_device *device, int page_nr)
 		return;
 	}
 	page = device->bitmap->bm_pages[page_nr];
-	set_bit(BM_PAGE_HINT_WRITEOUT, &page_private(page));
+	BUG_ON(b->n_bitmap_hints >= ARRAY_SIZE(b->al_bitmap_hints));
+	if (!test_and_set_bit(BM_PAGE_HINT_WRITEOUT, &page_private(page)))
+		b->al_bitmap_hints[b->n_bitmap_hints++] = page_nr;
 }
 
 static int bm_test_page_unchanged(struct page *page)
@@ -1030,7 +1045,7 @@ static int bm_rw(struct drbd_device *device, const unsigned int flags, unsigned
 {
 	struct drbd_bm_aio_ctx *ctx;
 	struct drbd_bitmap *b = device->bitmap;
-	int num_pages, i, count = 0;
+	unsigned int num_pages, i, count = 0;
 	unsigned long now;
 	char ppb[10];
 	int err = 0;
@@ -1078,16 +1093,37 @@ static int bm_rw(struct drbd_device *device, const unsigned int flags, unsigned
 	now = jiffies;
 
 	/* let the layers below us try to merge these bios... */
-	for (i = 0; i < num_pages; i++) {
-		/* ignore completely unchanged pages */
-		if (lazy_writeout_upper_idx && i == lazy_writeout_upper_idx)
-			break;
-		if (!(flags & BM_AIO_READ)) {
-			if ((flags & BM_AIO_WRITE_HINTED) &&
-			    !test_and_clear_bit(BM_PAGE_HINT_WRITEOUT,
-				    &page_private(b->bm_pages[i])))
-				continue;
 
+	if (flags & BM_AIO_READ) {
+		for (i = 0; i < num_pages; i++) {
+			atomic_inc(&ctx->in_flight);
+			bm_page_io_async(ctx, i);
+			++count;
+			cond_resched();
+		}
+	} else if (flags & BM_AIO_WRITE_HINTED) {
+		/* ASSERT: BM_AIO_WRITE_ALL_PAGES is not set. */
+		unsigned int hint;
+		for (hint = 0; hint < b->n_bitmap_hints; hint++) {
+			i = b->al_bitmap_hints[hint];
+			if (i >= num_pages) /* == -1U: no hint here. */
+				continue;
+			/* Several AL-extents may point to the same page. */
+			if (!test_and_clear_bit(BM_PAGE_HINT_WRITEOUT,
+			    &page_private(b->bm_pages[i])))
+				continue;
+			/* Has it even changed? */
+			if (bm_test_page_unchanged(b->bm_pages[i]))
+				continue;
+			atomic_inc(&ctx->in_flight);
+			bm_page_io_async(ctx, i);
+			++count;
+		}
+	} else {
+		for (i = 0; i < num_pages; i++) {
+			/* ignore completely unchanged pages */
+			if (lazy_writeout_upper_idx && i == lazy_writeout_upper_idx)
+				break;
 			if (!(flags & BM_AIO_WRITE_ALL_PAGES) &&
 			    bm_test_page_unchanged(b->bm_pages[i])) {
 				dynamic_drbd_dbg(device, "skipped bm write for idx %u\n", i);
@@ -1100,11 +1136,11 @@ static int bm_rw(struct drbd_device *device, const unsigned int flags, unsigned
 				dynamic_drbd_dbg(device, "skipped bm lazy write for idx %u\n", i);
 				continue;
 			}
+			atomic_inc(&ctx->in_flight);
+			bm_page_io_async(ctx, i);
+			++count;
+			cond_resched();
 		}
-		atomic_inc(&ctx->in_flight);
-		bm_page_io_async(ctx, i);
-		++count;
-		cond_resched();
 	}
 
 	/*
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index acb1462..c83393c 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1378,6 +1378,7 @@ extern int  drbd_bm_e_weight(struct drbd_device *device, unsigned long enr);
 extern int  drbd_bm_read(struct drbd_device *device) __must_hold(local);
 extern void drbd_bm_mark_for_writeout(struct drbd_device *device, int page_nr);
 extern int  drbd_bm_write(struct drbd_device *device) __must_hold(local);
+extern void drbd_bm_reset_al_hints(struct drbd_device *device) __must_hold(local);
 extern int  drbd_bm_write_hinted(struct drbd_device *device) __must_hold(local);
 extern int  drbd_bm_write_lazy(struct drbd_device *device, unsigned upper_idx) __must_hold(local);
 extern int drbd_bm_write_all(struct drbd_device *device) __must_hold(local);
-- 
2.7.4

