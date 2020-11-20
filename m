Return-Path: <hare@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6CAEF420666
	for <drbd-dev@lists.linbit.com>; Fri, 20 Nov 2020 08:26:23 +0100 (CET)
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201116145809.410558-1-hch@lst.de>
	<20201116145809.410558-56-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <75f4c397-ac03-2c5f-d620-0e619ad78fe8@suse.de>
Date: Fri, 20 Nov 2020 08:26:22 +0100
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-56-hch@lst.de>
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
Subject: Re: [Drbd-dev] [PATCH 55/78] block: change the hash used for
 looking up block devices
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
> Adding the minor to the major creates tons of pointless conflicts. Just
> use the dev_t itself, which is 32-bits and thus is guaranteed to fit
> into ino_t.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/block_dev.c | 26 ++------------------------
>   1 file changed, 2 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index d8664f5c1ff669..29db12c3bb501c 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -870,35 +870,12 @@ void __init bdev_cache_init(void)
>   	blockdev_superblock = bd_mnt->mnt_sb;   /* For writeback */
>   }
>   
> -/*
> - * Most likely _very_ bad one - but then it's hardly critical for small
> - * /dev and can be fixed when somebody will need really large one.
> - * Keep in mind that it will be fed through icache hash function too.
> - */
> -static inline unsigned long hash(dev_t dev)
> -{
> -	return MAJOR(dev)+MINOR(dev);
> -}
> -
> -static int bdev_test(struct inode *inode, void *data)
> -{
> -	return BDEV_I(inode)->bdev.bd_dev == *(dev_t *)data;
> -}
> -
> -static int bdev_set(struct inode *inode, void *data)
> -{
> -	BDEV_I(inode)->bdev.bd_dev = *(dev_t *)data;
> -	return 0;
> -}
> -
>   static struct block_device *bdget(dev_t dev)
>   {
>   	struct block_device *bdev;
>   	struct inode *inode;
>   
> -	inode = iget5_locked(blockdev_superblock, hash(dev),
> -			bdev_test, bdev_set, &dev);
> -
> +	inode = iget_locked(blockdev_superblock, dev);
>   	if (!inode)
>   		return NULL;
>   
> @@ -910,6 +887,7 @@ static struct block_device *bdget(dev_t dev)
>   		bdev->bd_super = NULL;
>   		bdev->bd_inode = inode;
>   		bdev->bd_part_count = 0;
> +		bdev->bd_dev = dev;
>   		inode->i_mode = S_IFBLK;
>   		inode->i_rdev = dev;
>   		inode->i_bdev = bdev;
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
