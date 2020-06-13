Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 16B6D420427
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:58:45 +0200 (CEST)
Received: by mail-wr1-f66.google.com with SMTP id x6so12245161wrm.13
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:58:45 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	c70sm12139144wme.32.2020.06.13.02.58.43
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:58:44 -0700 (PDT)
Resent-Message-ID: <20200613095842.GX4222@soda.linbit>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2D023420235
	for <drbd-dev@lists.linbit.com>; Mon, 25 May 2020 15:23:48 +0200 (CEST)
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20200525113014.345997-1-hch@lst.de>
	<20200525113014.345997-6-hch@lst.de>
From: Coly Li <colyli@suse.de>
Message-ID: <85828157-ac53-57e8-1a27-068478ab5f5c@suse.de>
MIME-Version: 1.0
In-Reply-To: <20200525113014.345997-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-nvdimm@lists.01.org,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
	linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
	dm-devel@redhat.com, Nitin Gupta <ngupta@vflare.org>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 05/16] bcache: use bio_{start,end}_io_acct
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
Date: Sat, 13 Jun 2020 10:19:48 -0000

On 2020/5/25 19:30, Christoph Hellwig wrote:
> Switch bcache to use the nicer bio accounting helpers, and call the
> routines where we also sample the start time to give coherent accounting
> results.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Coly Li <colyli@suse.de>


Coly Li

> ---
>  drivers/md/bcache/request.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> index 77d1a26975174..22b483527176b 100644
> --- a/drivers/md/bcache/request.c
> +++ b/drivers/md/bcache/request.c
> @@ -668,9 +668,7 @@ static void backing_request_endio(struct bio *bio)
>  static void bio_complete(struct search *s)
>  {
>  	if (s->orig_bio) {
> -		generic_end_io_acct(s->d->disk->queue, bio_op(s->orig_bio),
> -				    &s->d->disk->part0, s->start_time);
> -
> +		bio_end_io_acct(s->orig_bio, s->start_time);
>  		trace_bcache_request_end(s->d, s->orig_bio);
>  		s->orig_bio->bi_status = s->iop.status;
>  		bio_endio(s->orig_bio);
> @@ -730,7 +728,7 @@ static inline struct search *search_alloc(struct bio *bio,
>  	s->recoverable		= 1;
>  	s->write		= op_is_write(bio_op(bio));
>  	s->read_dirty_data	= 0;
> -	s->start_time		= jiffies;
> +	s->start_time		= bio_start_io_acct(bio);
>  
>  	s->iop.c		= d->c;
>  	s->iop.bio		= NULL;
> @@ -1082,8 +1080,7 @@ static void detached_dev_end_io(struct bio *bio)
>  	bio->bi_end_io = ddip->bi_end_io;
>  	bio->bi_private = ddip->bi_private;
>  
> -	generic_end_io_acct(ddip->d->disk->queue, bio_op(bio),
> -			    &ddip->d->disk->part0, ddip->start_time);
> +	bio_end_io_acct(bio, ddip->start_time);
>  
>  	if (bio->bi_status) {
>  		struct cached_dev *dc = container_of(ddip->d,
> @@ -1108,7 +1105,7 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio)
>  	 */
>  	ddip = kzalloc(sizeof(struct detached_dev_io_private), GFP_NOIO);
>  	ddip->d = d;
> -	ddip->start_time = jiffies;
> +	ddip->start_time = bio_start_io_acct(bio);
>  	ddip->bi_end_io = bio->bi_end_io;
>  	ddip->bi_private = bio->bi_private;
>  	bio->bi_end_io = detached_dev_end_io;
> @@ -1190,11 +1187,6 @@ blk_qc_t cached_dev_make_request(struct request_queue *q, struct bio *bio)
>  		}
>  	}
>  
> -	generic_start_io_acct(q,
> -			      bio_op(bio),
> -			      bio_sectors(bio),
> -			      &d->disk->part0);
> -
>  	bio_set_dev(bio, dc->bdev);
>  	bio->bi_iter.bi_sector += dc->sb.data_offset;
>  
> @@ -1311,8 +1303,6 @@ blk_qc_t flash_dev_make_request(struct request_queue *q, struct bio *bio)
>  		return BLK_QC_T_NONE;
>  	}
>  
> -	generic_start_io_acct(q, bio_op(bio), bio_sectors(bio), &d->disk->part0);
> -
>  	s = search_alloc(bio, d);
>  	cl = &s->cl;
>  	bio = &s->bio.bio;
> 

