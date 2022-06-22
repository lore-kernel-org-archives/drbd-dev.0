Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
	[209.85.218.44])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2E3E4420471
	for <drbd-dev@lists.linbit.com>; Wed, 22 Jun 2022 22:50:03 +0200 (CEST)
Received: by mail-ej1-f44.google.com with SMTP id sb34so7733302ejc.11
	for <drbd-dev@lists.linbit.com>; Wed, 22 Jun 2022 13:50:03 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 22 Jun 2022 22:49:32 +0200
Message-Id: <20220622204932.196830-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: bm_page_async_io: fix spurious bitmap "IO
	error" on large volumes
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

We usually do all our bitmap IO in units of PAGE_SIZE.

With very small or oddly sized external meta data, or with
PAGE_SIZE != 4k, it can happen that our last on-disk bitmap page
is not fully PAGE_SIZE aligned, so we may need to adjust the size
of the IO.

We used to do that with
  min_t(unsigned int, PAGE_SIZE,
	last_allowed_sector - current_offset);
And for just the right diff, (unsigned int)(diff) will result in 0.

A bio of length 0 will correctly be rejected with an IO error
(and some scary WARN_ON_ONCE()) by the scsi layer.

Do the calculation properly.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_bitmap.c | 49 +++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 9e060e49b3f8..bd2133ef6e0a 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -974,25 +974,58 @@ static void drbd_bm_endio(struct bio *bio)
 	}
 }
 
+/* For the layout, see comment above drbd_md_set_sector_offsets(). */
+static inline sector_t drbd_md_last_bitmap_sector(struct drbd_backing_dev *bdev)
+{
+	switch (bdev->md.meta_dev_idx) {
+	case DRBD_MD_INDEX_INTERNAL:
+	case DRBD_MD_INDEX_FLEX_INT:
+		return bdev->md.md_offset + bdev->md.al_offset -1;
+	case DRBD_MD_INDEX_FLEX_EXT:
+	default:
+		return bdev->md.md_offset + bdev->md.md_size_sect -1;
+	}
+}
+
 static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_hold(local)
 {
 	struct drbd_device *device = ctx->device;
 	unsigned int op = (ctx->flags & BM_AIO_READ) ? REQ_OP_READ : REQ_OP_WRITE;
-	struct bio *bio = bio_alloc_bioset(device->ldev->md_bdev, 1, op,
-					   GFP_NOIO, &drbd_md_io_bio_set);
 	struct drbd_bitmap *b = device->bitmap;
+	struct bio *bio;
 	struct page *page;
+	sector_t last_bm_sect;
+	sector_t first_bm_sect;
+	sector_t on_disk_sector;
 	unsigned int len;
 
-	sector_t on_disk_sector =
-		device->ldev->md.md_offset + device->ldev->md.bm_offset;
-	on_disk_sector += ((sector_t)page_nr) << (PAGE_SHIFT-9);
+	first_bm_sect = device->ldev->md.md_offset + device->ldev->md.bm_offset;
+	on_disk_sector = first_bm_sect + (((sector_t)page_nr) << (PAGE_SHIFT-SECTOR_SHIFT));
 
 	/* this might happen with very small
 	 * flexible external meta data device,
 	 * or with PAGE_SIZE > 4k */
-	len = min_t(unsigned int, PAGE_SIZE,
-		(drbd_md_last_sector(device->ldev) - on_disk_sector + 1)<<9);
+	last_bm_sect = drbd_md_last_bitmap_sector(device->ldev);
+	if (first_bm_sect <= on_disk_sector && last_bm_sect >= on_disk_sector) {
+		sector_t len_sect = last_bm_sect - on_disk_sector + 1;
+		if (len_sect < PAGE_SIZE/SECTOR_SIZE)
+			len = (unsigned int)len_sect*SECTOR_SIZE;
+		else
+			len = PAGE_SIZE;
+	} else {
+		if (__ratelimit(&drbd_ratelimit_state)) {
+			drbd_err(device, "Invalid offset during on-disk bitmap access: "
+				 "page idx %u, sector %llu\n", page_nr, on_disk_sector);
+		}
+		ctx->error = -EIO;
+		bm_set_page_io_err(b->bm_pages[page_nr]);
+		if (atomic_dec_and_test(&ctx->in_flight)) {
+			ctx->done = 1;
+			wake_up(&device->misc_wait);
+			kref_put(&ctx->kref, &drbd_bm_aio_ctx_destroy);
+		}
+		return;
+	}
 
 	/* serialize IO on this page */
 	bm_page_lock_io(device, page_nr);
@@ -1007,6 +1040,8 @@ static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_ho
 		bm_store_page_idx(page, page_nr);
 	} else
 		page = b->bm_pages[page_nr];
+	bio = bio_alloc_bioset(device->ldev->md_bdev, 1, op, GFP_NOIO,
+			&drbd_md_io_bio_set);
 	bio->bi_iter.bi_sector = on_disk_sector;
 	/* bio_add_page of a single page to an empty bio will always succeed,
 	 * according to api.  Do we want to assert that? */
-- 
2.36.1

