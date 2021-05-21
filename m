Return-Path: <colyli@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6C966420207
	for <drbd-dev@lists.linbit.com>; Fri, 21 May 2021 08:33:36 +0200 (CEST)
To: Christoph Hellwig <hch@lst.de>
References: <20210521055116.1053587-1-hch@lst.de>
	<20210521055116.1053587-13-hch@lst.de>
From: Coly Li <colyli@suse.de>
Message-ID: <d4f1c005-2ce0-51b5-c861-431f0ffb3dcf@suse.de>
Date: Fri, 21 May 2021 14:15:32 +0800
MIME-Version: 1.0
In-Reply-To: <20210521055116.1053587-13-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: nvdimm@lists.linux.dev, Ulf Hansson <ulf.hansson@linaro.org>,
	Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Matias Bjorling <mb@lightnvm.io>, Nitin Gupta <ngupta@vflare.org>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-xtensa@linux-xtensa.org,
	Alex Dubov <oakad@yahoo.com>, Heiko Carstens <hca@linux.ibm.com>,
	linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org, Philip Kelleher <pjk1939@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>, linux-mmc@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, Jim Paris <jim@jtan.com>,
	Minchan Kim <minchan@kernel.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [Drbd-dev] [PATCH 12/26] bcache: convert to
	blk_alloc_disk/blk_cleanup_disk
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

On 5/21/21 1:51 PM, Christoph Hellwig wrote:
> Convert the bcache driver to use the blk_alloc_disk and blk_cleanup_disk
> helpers to simplify gendisk and request_queue allocation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/md/bcache/super.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index bea8c4429ae8..185246a0d855 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -890,13 +890,9 @@ static void bcache_device_free(struct bcache_device *d)
>  		if (disk_added)
>  			del_gendisk(disk);
>  
> -		if (disk->queue)
> -			blk_cleanup_queue(disk->queue);
> -
> +		blk_cleanup_disk(disk);
>  		ida_simple_remove(&bcache_device_idx,
>  				  first_minor_to_idx(disk->first_minor));
> -		if (disk_added)
> -			put_disk(disk);

The  above 2 lines are added on purpose to prevent an refcount
underflow. It is from commit 86da9f736740 ("bcache: fix refcount
underflow in bcache_device_free()").

Maybe add a parameter to blk_cleanup_disk() or checking (disk->flags &
GENHD_FL_UP) inside blk_cleanup_disk() ?

Coly Li


>  	}
>  
>  	bioset_exit(&d->bio_split);
> @@ -946,7 +942,7 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
>  			BIOSET_NEED_BVECS|BIOSET_NEED_RESCUER))
>  		goto err;
>  
> -	d->disk = alloc_disk(BCACHE_MINORS);
> +	d->disk = blk_alloc_disk(NUMA_NO_NODE);
>  	if (!d->disk)
>  		goto err;
>  
> @@ -955,14 +951,11 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
>  
>  	d->disk->major		= bcache_major;
>  	d->disk->first_minor	= idx_to_first_minor(idx);
> +	d->disk->minors		= BCACHE_MINORS;
>  	d->disk->fops		= ops;
>  	d->disk->private_data	= d;
>  
> -	q = blk_alloc_queue(NUMA_NO_NODE);
> -	if (!q)
> -		return -ENOMEM;
> -
> -	d->disk->queue			= q;
> +	q = d->disk->queue;
>  	q->limits.max_hw_sectors	= UINT_MAX;
>  	q->limits.max_sectors		= UINT_MAX;
>  	q->limits.max_segment_size	= UINT_MAX;
> 

The rested looks fine to me.

Thanks.

Coly Li
