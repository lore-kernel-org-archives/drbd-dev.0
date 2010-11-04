Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6AEB11059634
	for <drbd-dev@lists.linbit.com>; Thu,  4 Nov 2010 16:39:12 +0100 (CET)
Resent-Message-ID: <20101104153912.GI14148@barkeeper1-xen.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BCF061059382
	for <drbd-dev@lists.linbit.com>; Thu,  4 Nov 2010 16:08:07 +0100 (CET)
Date: Thu, 4 Nov 2010 11:06:58 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: device-mapper development <dm-devel@redhat.com>
Message-ID: <20101104150657.GB32504@redhat.com>
References: <1288628129-12811-1-git-send-email-tj@kernel.org>
	<1288628129-12811-4-git-send-email-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1288628129-12811-4-git-send-email-tj@kernel.org>
Cc: jack@suse.cz, leochen@broadcom.com, neilb@suse.de,
	heiko.carstens@de.ibm.com, adilger.kernel@dilger.ca,
	konishi.ryusuke@lab.ntt.co.jp, shaggy@linux.vnet.ibm.com,
	drbd-dev@lists.linbit.com, joel.becker@oracle.com,
	hch@infradead.org, aelder@sgi.com, mfasheh@suse.com,
	joern@logfs.org, reiserfs-devel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, viro@zeniv.linux.org.uk,
	swhiteho@redhat.com, chris.mason@oracle.com, axboe@kernel.dk,
	tytso@mit.edu, sbranden@broadcom.com, petero2@telia.com,
	linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
	akpm@linux-foundation.org
Subject: Re: [Drbd-dev] [PATCH 3/5] block: simplify holder symlink handling
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Nov 01 2010 at 12:15pm -0400,
Tejun Heo <tj@kernel.org> wrote:

> Code to manage symlinks in /sys/block/*/{holders|slaves} are overly
> complex with multiple holder considerations, redundant extra
> references to all involved kobjects, unused generic kobject holder
> support and unnecessary mixup with bd_claim/release functionalities.
> 
> Strip it down to what's necessary (single gendisk holder) and make it
> use a separate interface.  This is a step for cleaning up
> bd_claim/release.  This patch makes dm-table slightly more complex but
> it will be simplified again with further changes.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Neil Brown <neilb@suse.de>
> Cc: dm-devel@redhat.com

Acked-by: Mike Snitzer <snitzer@redhat.com>

> ---
>  drivers/md/dm-table.c |   23 +++-
>  drivers/md/md.c       |    4 +-
>  fs/block_dev.c        |  322 +++++++------------------------------------------
>  include/linux/fs.h    |   16 ++-
>  4 files changed, 74 insertions(+), 291 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 90267f8..2c876ff 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -328,12 +328,22 @@ static int open_dev(struct dm_dev_internal *d, dev_t dev,
>  	bdev = open_by_devnum(dev, d->dm_dev.mode);
>  	if (IS_ERR(bdev))
>  		return PTR_ERR(bdev);
> -	r = bd_claim_by_disk(bdev, _claim_ptr, dm_disk(md));
> -	if (r)
> +
> +	r = bd_claim(bdev, _claim_ptr);
> +	if (r) {
>  		blkdev_put(bdev, d->dm_dev.mode);
> -	else
> -		d->dm_dev.bdev = bdev;
> -	return r;
> +		return r;
> +	}
> +
> +	r = bd_link_disk_holder(bdev, dm_disk(md));
> +	if (r) {
> +		bd_release(bdev);
> +		blkdev_put(bdev, d->dm_dev.mode);
> +		return r;
> +	}
> +
> +	d->dm_dev.bdev = bdev;
> +	return 0;
>  }
>  
>  /*
> @@ -344,7 +354,8 @@ static void close_dev(struct dm_dev_internal *d, struct mapped_device *md)
>  	if (!d->dm_dev.bdev)
>  		return;
>  
> -	bd_release_from_disk(d->dm_dev.bdev, dm_disk(md));
> +	bd_unlink_disk_holder(d->dm_dev.bdev);
> +	bd_release(d->dm_dev.bdev);
>  	blkdev_put(d->dm_dev.bdev, d->dm_dev.mode);
>  	d->dm_dev.bdev = NULL;
>  }
