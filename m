Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C5D941055F44
	for <drbd-dev@lists.linbit.com>; Fri,  9 Nov 2012 10:24:08 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: akpm@linux-foundation.org
Date: Fri, 09 Nov 2012 10:24:08 +0100
Message-ID: <2422446.NXjlELuTI5@fat-tyre>
In-Reply-To: <20121109001231.98243100047@wpzn3.hot.corp.google.com>
References: <20121109001231.98243100047@wpzn3.hot.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: axboe@kernel.dk, akinobu.mita@gmail.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [patch 6/6] drbd: use copy_highpage
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Thanks, I will put it in my tree today.

Best,
 Phil
> From: Akinobu Mita <akinobu.mita@gmail.com>
> Subject: drbd: use copy_highpage
> 
> Use copy_highpage() to copy from one page to another.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Lars Ellenberg <drbd-dev@lists.linbit.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/block/drbd/drbd_bitmap.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff -puN drivers/block/drbd/drbd_bitmap.c~drbd-use-copy_highpage
> drivers/block/drbd/drbd_bitmap.c ---
> a/drivers/block/drbd/drbd_bitmap.c~drbd-use-copy_highpage
> +++ a/drivers/block/drbd/drbd_bitmap.c
> @@ -977,13 +977,8 @@ static void bm_page_io_async(struct bm_a
>  	bm_set_page_unchanged(b->bm_pages[page_nr]);
> 
>  	if (ctx->flags & BM_AIO_COPY_PAGES) {
> -		void *src, *dest;
>  		page = mempool_alloc(drbd_md_io_page_pool, __GFP_HIGHMEM|__GFP_WAIT);
> -		dest = kmap_atomic(page);
> -		src = kmap_atomic(b->bm_pages[page_nr]);
> -		memcpy(dest, src, PAGE_SIZE);
> -		kunmap_atomic(src);
> -		kunmap_atomic(dest);
> +		copy_highpage(page, b->bm_pages[page_nr]);
>  		bm_store_page_idx(page, page_nr);
>  	} else
>  		page = b->bm_pages[page_nr];
> _
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev
