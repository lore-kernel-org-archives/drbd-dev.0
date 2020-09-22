Return-Path: <jack@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C5CEC420AEE
	for <drbd-dev@lists.linbit.com>; Tue, 22 Sep 2020 10:45:32 +0200 (CEST)
Date: Tue, 22 Sep 2020 10:44:31 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20200922084431.GA16464@quack2.suse.cz>
References: <20200921080734.452759-1-hch@lst.de>
	<20200921080734.452759-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921080734.452759-4-hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>, Justin Sanders <justin@coraid.com>,
	Minchan Kim <minchan@kernel.org>, Richard Weinberger <richard@nod.at>,
	linux-bcache@vger.kernel.org, Coly Li <colyli@suse.de>,
	linux-block@vger.kernel.org, Song Liu <song@kernel.org>,
	dm-devel@redhat.com, linux-mtd@lists.infradead.org,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 03/13] bcache: inherit the optimal I/O size
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

On Mon 21-09-20 10:07:24, Christoph Hellwig wrote:
> Inherit the optimal I/O size setting just like the readahead window,
> as any reason to do larger I/O does not apply to just readahead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/md/bcache/super.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 1bbdc410ee3c51..48113005ed86ad 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1430,6 +1430,8 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
>  	dc->disk.disk->queue->backing_dev_info->ra_pages =
>  		max(dc->disk.disk->queue->backing_dev_info->ra_pages,
>  		    q->backing_dev_info->ra_pages);
> +	blk_queue_io_opt(dc->disk.disk->queue,
> +		max(queue_io_opt(dc->disk.disk->queue), queue_io_opt(q)));
>  
>  	atomic_set(&dc->io_errors, 0);
>  	dc->io_disable = false;
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
