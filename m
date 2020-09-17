Return-Path: <jack@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D2F98420DE4
	for <drbd-dev@lists.linbit.com>; Thu, 17 Sep 2020 11:46:15 +0200 (CEST)
Date: Thu, 17 Sep 2020 11:46:15 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20200917094615.GI7347@quack2.suse.cz>
References: <20200910144833.742260-1-hch@lst.de>
	<20200910144833.742260-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910144833.742260-3-hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>, Minchan Kim <minchan@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 02/12] drbd: remove dead code in
	device_to_statistics
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

On Thu 10-09-20 16:48:22, Christoph Hellwig wrote:
> Ever since the switch to blk-mq, a lower device not used for VM
> writeback will not be marked congested, so the check will never
> trigger.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/drbd/drbd_nl.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index 43c8ae4d9fca81..aaff5bde391506 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -3370,7 +3370,6 @@ static void device_to_statistics(struct device_statistics *s,
>  	if (get_ldev(device)) {
>  		struct drbd_md *md = &device->ldev->md;
>  		u64 *history_uuids = (u64 *)s->history_uuids;
> -		struct request_queue *q;
>  		int n;
>  
>  		spin_lock_irq(&md->uuid_lock);
> @@ -3384,11 +3383,6 @@ static void device_to_statistics(struct device_statistics *s,
>  		spin_unlock_irq(&md->uuid_lock);
>  
>  		s->dev_disk_flags = md->flags;
> -		q = bdev_get_queue(device->ldev->backing_bdev);
> -		s->dev_lower_blocked =
> -			bdi_congested(q->backing_dev_info,
> -				      (1 << WB_async_congested) |
> -				      (1 << WB_sync_congested));
>  		put_ldev(device);
>  	}
>  	s->dev_size = drbd_get_capacity(device->this_bdev);
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
