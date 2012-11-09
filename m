Return-Path: <akpm@linux-foundation.org>
Received: from mail-ye0-f202.google.com (mail-ye0-f202.google.com
	[209.85.213.202]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 595081019A78
	for <drbd-dev@lists.linbit.com>; Fri,  9 Nov 2012 01:20:28 +0100 (CET)
Received: by mail-ye0-f202.google.com with SMTP id r11so393722yen.3
	for <drbd-dev@lists.linbit.com>; Thu, 08 Nov 2012 16:20:27 -0800 (PST)
To: axboe@kernel.dk
From: akpm@linux-foundation.org
Date: Thu, 08 Nov 2012 16:12:31 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20121109001231.98243100047@wpzn3.hot.corp.google.com>
Cc: akpm@linux-foundation.org, akinobu.mita@gmail.com,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [patch 6/6] drbd: use copy_highpage
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

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
