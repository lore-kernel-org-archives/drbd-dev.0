Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 20A391012A92
	for <drbd-dev@lists.linbit.com>; Tue, 25 Sep 2012 14:14:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 0F28B1B413D
	for <drbd-dev@lists.linbit.com>; Tue, 25 Sep 2012 14:14:33 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SoXhYHuONmBl for <drbd-dev@lists.linbit.com>;
	Tue, 25 Sep 2012 14:14:32 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id E564A1B40FB
	for <drbd-dev@lists.linbit.com>; Tue, 25 Sep 2012 14:14:32 +0200 (CEST)
Resent-Message-ID: <20120925121430.GG8143@soda.linbit>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E478A1019A68
	for <drbd-dev@lists.linbit.com>; Tue, 25 Sep 2012 14:04:30 +0200 (CEST)
Received: by padbi1 with SMTP id bi1so2328954pad.27
	for <drbd-dev@lists.linbit.com>; Tue, 25 Sep 2012 05:04:28 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Date: Tue, 25 Sep 2012 20:57:01 +0900
Message-Id: <1348574222-3512-1-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <n>
References: <n>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: use copy_highpage
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Use copy_highpage() to copy from one page to another.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: drbd-dev@lists.linbit.com
---
 drivers/block/drbd/drbd_bitmap.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index d4d3c81..ec7f76c 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -975,13 +975,8 @@ static void bm_page_io_async(struct bm_aio_ctx *ctx, int page_nr, int rw) __must
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
-- 
1.7.11.4

