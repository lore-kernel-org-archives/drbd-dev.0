Return-Path: <colyli@fnnas.com>
Received: from va-2-40.ptr.blmpb.com (va-2-40.ptr.blmpb.com [209.127.231.40])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 557D1162807
	for <drbd-dev@lists.linbit.com>;
	Thu,  5 Mar 2026 15:57:41 +0100 (CET)
Message-Id: <aamTA2F84tiDbmF3@studio.local>
Mime-Version: 1.0
References: <20260304190424.291743-1-agruenba@redhat.com>
	<20260304190424.291743-5-agruenba@redhat.com>
In-Reply-To: <20260304190424.291743-5-agruenba@redhat.com>
Subject: Re: [PATCH 4/4] bio: use bio_io_error more often
Date: Thu, 5 Mar 2026 22:32:13 +0800
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
From: "Coly Li" <colyli@fnnas.com>
To: "Andreas Gruenbacher" <agruenba@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
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

On Wed, Mar 04, 2026 at 08:04:09PM +0800, Andreas Gruenbacher wrote:
> Instead of setting bio->bi_status to BLK_STS_IOERR and calling
> bio_endio(bio), use the shorthand bio_io_error(bio).
> 
> Created with Coccinelle using the following semantic patch:
> 
> @@
> struct bio *bio;
> @@
> - bio->bi_status = BLK_STS_IOERR;
> - bio_endio(bio);
> + bio_io_error(bio);
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/fops.c                  | 3 +--
>  drivers/block/drbd/drbd_int.h | 3 +--
>  drivers/md/bcache/bcache.h    | 3 +--
>  drivers/md/bcache/request.c   | 6 ++----
>  drivers/md/dm-mpath.c         | 3 +--
>  drivers/md/dm-writecache.c    | 3 +--
>  fs/f2fs/segment.c             | 3 +--
>  7 files changed, 8 insertions(+), 16 deletions(-)
> 

[snipped]

>  
> diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
> index ec9ff9715081..e0c9d9eef0a0 100644
> --- a/drivers/md/bcache/bcache.h
> +++ b/drivers/md/bcache/bcache.h
> @@ -947,8 +947,7 @@ static inline void closure_bio_submit(struct cache_set *c,
>  {
>  	closure_get(cl);
>  	if (unlikely(test_bit(CACHE_SET_IO_DISABLE, &c->flags))) {
> -		bio->bi_status = BLK_STS_IOERR;
> -		bio_endio(bio);
> +		bio_io_error(bio);
>  		return;
>  	}
>  	submit_bio_noacct(bio);
> diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> index 3fa3b13a410f..0f6fa0a2920b 100644
> --- a/drivers/md/bcache/request.c
> +++ b/drivers/md/bcache/request.c
> @@ -1178,8 +1178,7 @@ void cached_dev_submit_bio(struct bio *bio)
>  
>  	if (unlikely((d->c && test_bit(CACHE_SET_IO_DISABLE, &d->c->flags)) ||
>  		     dc->io_disable)) {
> -		bio->bi_status = BLK_STS_IOERR;
> -		bio_endio(bio);
> +		bio_io_error(bio);
>  		return;
>  	}
>  
> @@ -1283,8 +1282,7 @@ void flash_dev_submit_bio(struct bio *bio)
>  	struct bcache_device *d = bio->bi_bdev->bd_disk->private_data;
>  
>  	if (unlikely(d->c && test_bit(CACHE_SET_IO_DISABLE, &d->c->flags))) {
> -		bio->bi_status = BLK_STS_IOERR;
> -		bio_endio(bio);
> +		bio_io_error(bio);
>  		return;
>  	}
>  

For bcache part, I feel current hard code is explict and clear.
The bio_io_error() wrapper is not so directly understood. This is just
my opinion, not a strong objection. 

Thanks.

Coly Li


[snipped]
