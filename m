Return-Path: <minchan.kim@gmail.com>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D06DC420118
	for <drbd-dev@lists.linbit.com>; Thu, 26 Nov 2020 02:11:12 +0100 (CET)
Received: by mail-pg1-f195.google.com with SMTP id 81so302176pgf.0
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2020 17:11:12 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Wed, 25 Nov 2020 17:11:07 -0800
From: Minchan Kim <minchan@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20201126011107.GA57352@google.com>
References: <20201116145809.410558-1-hch@lst.de>
	<20201116145809.410558-61-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116145809.410558-61-hch@lst.de>
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
	ceph-devel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Subject: Re: [Drbd-dev] [PATCH 60/78] zram: remove the claim mechanism
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

On Mon, Nov 16, 2020 at 03:57:51PM +0100, Christoph Hellwig wrote:
> The zram claim mechanism was added to ensure no new opens come in
> during teardown.  But the proper way to archive that is to call
> del_gendisk first, which takes care of all that.  Once del_gendisk
> is called in the right place, the reset side can also be simplified
> as no I/O can be outstanding on a block device that is not open.

It would be great if it makes the mess simple. Let me have a question
Please see below.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/zram/zram_drv.c | 76 ++++++++++-------------------------
>  1 file changed, 21 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 6d15d51cee2b7e..3641434a9b154d 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1756,64 +1756,33 @@ static ssize_t disksize_store(struct device *dev,
>  static ssize_t reset_store(struct device *dev,
>  		struct device_attribute *attr, const char *buf, size_t len)
>  {
> -	int ret;
> -	unsigned short do_reset;
> -	struct zram *zram;
> +	struct zram *zram = dev_to_zram(dev);
>  	struct block_device *bdev;
> +	unsigned short do_reset;
> +	int ret = 0;
>  
>  	ret = kstrtou16(buf, 10, &do_reset);
>  	if (ret)
>  		return ret;
> -
>  	if (!do_reset)
>  		return -EINVAL;
>  
> -	zram = dev_to_zram(dev);
>  	bdev = bdget_disk(zram->disk, 0);
>  	if (!bdev)
>  		return -ENOMEM;
>  
>  	mutex_lock(&bdev->bd_mutex);
> -	/* Do not reset an active device or claimed device */
> -	if (bdev->bd_openers || zram->claim) {
> -		mutex_unlock(&bdev->bd_mutex);
> -		bdput(bdev);
> -		return -EBUSY;
> -	}
> -
> -	/* From now on, anyone can't open /dev/zram[0-9] */
> -	zram->claim = true;
> +	if (bdev->bd_openers)
> +		ret = -EBUSY;
> +	else
> +		zram_reset_device(zram);
>  	mutex_unlock(&bdev->bd_mutex);
> -
> -	/* Make sure all the pending I/O are finished */
> -	fsync_bdev(bdev);
> -	zram_reset_device(zram);
>  	bdput(bdev);
>  
> -	mutex_lock(&bdev->bd_mutex);
> -	zram->claim = false;
> -	mutex_unlock(&bdev->bd_mutex);
> -
> -	return len;
> -}
> -
> -static int zram_open(struct block_device *bdev, fmode_t mode)
> -{
> -	int ret = 0;
> -	struct zram *zram;
> -
> -	WARN_ON(!mutex_is_locked(&bdev->bd_mutex));
> -
> -	zram = bdev->bd_disk->private_data;
> -	/* zram was claimed to reset so open request fails */
> -	if (zram->claim)
> -		ret = -EBUSY;
> -
> -	return ret;
> +	return ret ? ret : len;
>  }
>  
>  static const struct block_device_operations zram_devops = {
> -	.open = zram_open,
>  	.submit_bio = zram_submit_bio,
>  	.swap_slot_free_notify = zram_slot_free_notify,
>  	.rw_page = zram_rw_page,
> @@ -1821,7 +1790,6 @@ static const struct block_device_operations zram_devops = {
>  };
>  
>  static const struct block_device_operations zram_wb_devops = {
> -	.open = zram_open,
>  	.submit_bio = zram_submit_bio,
>  	.swap_slot_free_notify = zram_slot_free_notify,
>  	.owner = THIS_MODULE
> @@ -1972,34 +1940,32 @@ static int zram_add(void)
>  	return ret;
>  }
>  
> -static int zram_remove(struct zram *zram)
> +static bool zram_busy(struct zram *zram)
>  {
>  	struct block_device *bdev;
> +	bool busy = false;
>  
>  	bdev = bdget_disk(zram->disk, 0);
> -	if (!bdev)
> -		return -ENOMEM;
> -
> -	mutex_lock(&bdev->bd_mutex);
> -	if (bdev->bd_openers || zram->claim) {
> -		mutex_unlock(&bdev->bd_mutex);
> +	if (bdev) {
> +		if (bdev->bd_openers)
> +			busy = true;
>  		bdput(bdev);
> -		return -EBUSY;
>  	}
>  
> -	zram->claim = true;
> -	mutex_unlock(&bdev->bd_mutex);
> +	return busy;
> +}
>  
> -	zram_debugfs_unregister(zram);
> +static int zram_remove(struct zram *zram)
> +{
> +	if (zram_busy(zram))
> +		return -EBUSY;
>  
> -	/* Make sure all the pending I/O are finished */
> -	fsync_bdev(bdev);
> +	del_gendisk(zram->disk);
> +	zram_debugfs_unregister(zram);
>  	zram_reset_device(zram);
> -	bdput(bdev);
>  
>  	pr_info("Removed device: %s\n", zram->disk->disk_name);
>  
> -	del_gendisk(zram->disk);
>  	blk_cleanup_queue(zram->disk->queue);
>  	put_disk(zram->disk);
>  	kfree(zram);
> -- 
> 2.29.2
> 

With this patch, how deal with the race?

CPU 1                                     CPU 2

hot_remove_store
  zram_remove
    zram_busy
      return -EBUSY
                                         open /dev/zram0
    del_gendisk
    zram_reset and destroy

