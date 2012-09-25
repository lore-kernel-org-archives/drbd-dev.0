Return-Path: <akpm@linux-foundation.org>
Received: from mail-yx0-f202.google.com (mail-yx0-f202.google.com
	[209.85.213.202]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 02F20103B4D5
	for <drbd-dev@lists.linbit.com>; Tue, 25 Sep 2012 22:03:57 +0200 (CEST)
Received: by yenr11 with SMTP id r11so545263yen.3
	for <drbd-dev@lists.linbit.com>; Tue, 25 Sep 2012 13:03:56 -0700 (PDT)
To: mm-commits@vger.kernel.org
From: akpm@linux-foundation.org
Date: Tue, 25 Sep 2012 12:33:22 -0700
Message-Id: <20120925193322.8E6521E0043@wpzn4.hot.corp.google.com>
Cc: akinobu.mita@gmail.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] + drbd-use-copy_highpage.patch added to -mm tree
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
has been added to the -mm tree.  Its filename is
     drbd-use-copy_highpage.patch

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/SubmitChecklist when testing your code ***

The -mm tree is included into linux-next and is updated
there every 3-4 working days

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
cciss-cleanup-bitops-usage.patch
cciss-use-check_signature.patch
drbd-use-copy_highpage.patch

