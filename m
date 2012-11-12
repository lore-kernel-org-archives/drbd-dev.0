Return-Path: <akpm@linux-foundation.org>
Received: from mail-ea0-f202.google.com (mail-ea0-f202.google.com
	[209.85.215.202]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9719F1055F5F
	for <drbd-dev@lists.linbit.com>; Tue, 13 Nov 2012 00:06:33 +0100 (CET)
Received: by mail-ea0-f202.google.com with SMTP id f11so204480eaa.3
	for <drbd-dev@lists.linbit.com>; Mon, 12 Nov 2012 15:06:33 -0800 (PST)
To: akinobu.mita@gmail.com, drbd-dev@lists.linbit.com,
	mm-commits@vger.kernel.org
From: akpm@linux-foundation.org
Date: Mon, 12 Nov 2012 13:09:52 -0800
Message-Id: <20121112210953.0F74A20004E@hpza10.eem.corp.google.com>
Subject: [Drbd-dev] [merged] drbd-use-copy_highpage.patch removed from -mm
	tree
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


The patch titled
     Subject: drbd: use copy_highpage
has been removed from the -mm tree.  Its filename was
     drbd-use-copy_highpage.patch

This patch was dropped because it was merged into mainline or a subsystem tree

------------------------------------------------------
From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: drbd: use copy_highpage

Use copy_highpage() to copy from one page to another.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Lars Ellenberg <drbd-dev@lists.linbit.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/block/drbd/drbd_bitmap.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff -puN drivers/block/drbd/drbd_bitmap.c~drbd-use-copy_highpage drivers/block/drbd/drbd_bitmap.c
--- a/drivers/block/drbd/drbd_bitmap.c~drbd-use-copy_highpage
+++ a/drivers/block/drbd/drbd_bitmap.c
@@ -977,13 +977,8 @@ static void bm_page_io_async(struct bm_a
 	bm_set_page_unchanged(b->bm_pages[page_nr]);
 
 	if (ctx->flags & BM_AIO_COPY_PAGES) {
-		void *src, *dest;
 		page = mempool_alloc(drbd_md_io_page_pool, __GFP_HIGHMEM|__GFP_WAIT);
-		dest = kmap_atomic(page);
-		src = kmap_atomic(b->bm_pages[page_nr]);
-		memcpy(dest, src, PAGE_SIZE);
-		kunmap_atomic(src);
-		kunmap_atomic(dest);
+		copy_highpage(page, b->bm_pages[page_nr]);
 		bm_store_page_idx(page, page_nr);
 	} else
 		page = b->bm_pages[page_nr];
_

Patches currently in -mm which might be from akinobu.mita@gmail.com are

linux-next.patch

