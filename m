Return-Path: <jack@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AC6FB420DE3
	for <drbd-dev@lists.linbit.com>; Thu, 17 Sep 2020 11:56:07 +0200 (CEST)
Date: Thu, 17 Sep 2020 11:55:07 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20200917095507.GJ7347@quack2.suse.cz>
References: <20200910144833.742260-1-hch@lst.de>
	<20200910144833.742260-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910144833.742260-4-hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>, Minchan Kim <minchan@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	linux-mtd@lists.infradead.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 03/12] drbd: remove RB_CONGESTED_REMOTE
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

On Thu 10-09-20 16:48:23, Christoph Hellwig wrote:
> This case isn't ever used.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Are you sure it's never used? As far as I'm reading drdb code the contents
of the disk_conf structure seems to be received through netlink (that code
is really a macro hell) and so read_balancing attribute passed to
remote_due_to_read_balancing() can have any value userspace passed to it.

								Honza

> ---
>  drivers/block/drbd/drbd_req.c | 4 ----
>  include/linux/drbd.h          | 1 -
>  2 files changed, 5 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
> index 5c975af9c15fb8..481bc34fcf386a 100644
> --- a/drivers/block/drbd/drbd_req.c
> +++ b/drivers/block/drbd/drbd_req.c
> @@ -901,13 +901,9 @@ static bool drbd_may_do_local_read(struct drbd_device *device, sector_t sector,
>  static bool remote_due_to_read_balancing(struct drbd_device *device, sector_t sector,
>  		enum drbd_read_balancing rbm)
>  {
> -	struct backing_dev_info *bdi;
>  	int stripe_shift;
>  
>  	switch (rbm) {
> -	case RB_CONGESTED_REMOTE:
> -		bdi = device->ldev->backing_bdev->bd_disk->queue->backing_dev_info;
> -		return bdi_read_congested(bdi);
>  	case RB_LEAST_PENDING:
>  		return atomic_read(&device->local_cnt) >
>  			atomic_read(&device->ap_pending_cnt) + atomic_read(&device->rs_pending_cnt);
> diff --git a/include/linux/drbd.h b/include/linux/drbd.h
> index 5755537b51b114..6a8286132751df 100644
> --- a/include/linux/drbd.h
> +++ b/include/linux/drbd.h
> @@ -94,7 +94,6 @@ enum drbd_read_balancing {
>  	RB_PREFER_REMOTE,
>  	RB_ROUND_ROBIN,
>  	RB_LEAST_PENDING,
> -	RB_CONGESTED_REMOTE,
>  	RB_32K_STRIPING,
>  	RB_64K_STRIPING,
>  	RB_128K_STRIPING,
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
