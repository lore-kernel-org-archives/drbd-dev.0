Return-Path: <hare@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 431444207B0
	for <drbd-dev@lists.linbit.com>; Fri, 20 Nov 2020 08:43:03 +0100 (CET)
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201116145809.410558-1-hch@lst.de>
	<20201116145809.410558-66-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <310bff8b-dbda-609a-a392-619733b86bd1@suse.de>
Date: Fri, 20 Nov 2020 08:43:01 +0100
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-66-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
	xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
	linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Subject: Re: [Drbd-dev] [PATCH 65/78] dm: remove the block_device reference
 in struct mapped_device
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

On 11/16/20 3:57 PM, Christoph Hellwig wrote:
> Get rid of the long-lasting struct block_device reference in
> struct mapped_device.  The only remaining user is the freeze code,
> where we can trivially look up the block device at freeze time
> and release the reference at thaw time.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/md/dm-core.h |  2 --
>   drivers/md/dm.c      | 22 +++++++++++-----------
>   2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
> index d522093cb39dda..b1b400ed76fe90 100644
> --- a/drivers/md/dm-core.h
> +++ b/drivers/md/dm-core.h
> @@ -107,8 +107,6 @@ struct mapped_device {
>   	/* kobject and completion */
>   	struct dm_kobject_holder kobj_holder;
>   
> -	struct block_device *bdev;
> -
>   	struct dm_stats stats;
>   
>   	/* for blk-mq request-based DM support */
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 6d7eb72d41f9ea..c789ffea2badde 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1744,11 +1744,6 @@ static void cleanup_mapped_device(struct mapped_device *md)
>   
>   	cleanup_srcu_struct(&md->io_barrier);
>   
> -	if (md->bdev) {
> -		bdput(md->bdev);
> -		md->bdev = NULL;
> -	}
> -
>   	mutex_destroy(&md->suspend_lock);
>   	mutex_destroy(&md->type_lock);
>   	mutex_destroy(&md->table_devices_lock);
> @@ -1840,10 +1835,6 @@ static struct mapped_device *alloc_dev(int minor)
>   	if (!md->wq)
>   		goto bad;
>   
> -	md->bdev = bdget_disk(md->disk, 0);
> -	if (!md->bdev)
> -		goto bad;
> -
>   	dm_stats_init(&md->stats);
>   
>   	/* Populate the mapping, nobody knows we exist yet */
> @@ -2384,12 +2375,17 @@ struct dm_table *dm_swap_table(struct mapped_device *md, struct dm_table *table)
>    */
>   static int lock_fs(struct mapped_device *md)
>   {
> +	struct block_device *bdev;
>   	int r;
>   
>   	WARN_ON(md->frozen_sb);
>   
> -	md->frozen_sb = freeze_bdev(md->bdev);
> +	bdev = bdget_disk(md->disk, 0);
> +	if (!bdev)
> +		return -ENOMEM;
> +	md->frozen_sb = freeze_bdev(bdev);
>   	if (IS_ERR(md->frozen_sb)) {
> +		bdput(bdev);
>   		r = PTR_ERR(md->frozen_sb);
>   		md->frozen_sb = NULL;
>   		return r;
> @@ -2402,10 +2398,14 @@ static int lock_fs(struct mapped_device *md)
>   
>   static void unlock_fs(struct mapped_device *md)
>   {
> +	struct block_device *bdev;
> +
>   	if (!test_bit(DMF_FROZEN, &md->flags))
>   		return;
>   
> -	thaw_bdev(md->bdev, md->frozen_sb);
> +	bdev = md->frozen_sb->s_bdev;
> +	thaw_bdev(bdev, md->frozen_sb);
> +	bdput(bdev);
>   	md->frozen_sb = NULL;
>   	clear_bit(DMF_FROZEN, &md->flags);
>   }
> 
Yay. Just what I need for the blk-interposer code, where the ->bdev
pointer is really getting in the way.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
