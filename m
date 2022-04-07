Return-Path: <colyli@suse.de>
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 501A7420352
	for <drbd-dev@lists.linbit.com>; Thu,  7 Apr 2022 07:16:20 +0200 (CEST)
Message-ID: <2aee78dd-d5b6-5444-da28-34ab2631b264@suse.de>
Date: Thu, 7 Apr 2022 13:16:12 +0800
MIME-Version: 1.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20220406060516.409838-1-hch@lst.de>
	<20220406060516.409838-24-hch@lst.de>
From: Coly Li <colyli@suse.de>
In-Reply-To: <20220406060516.409838-24-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: jfs-discussion@lists.sourceforge.net, linux-nvme@lists.infradead.org,
	virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
	dm-devel@redhat.com, target-devel@vger.kernel.org,
	linux-mtd@lists.infradead.org, drbd-dev@lists.linbit.com,
	linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
	linux-scsi@vger.kernel.org, cluster-devel@redhat.com,
	xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org,
	linux-um@lists.infradead.org, nbd@other.debian.org,
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	ceph-devel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
	linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev,
	linux-btrfs@vger.kernel.org
Subject: Re: [Drbd-dev] [PATCH 23/27] block: add a bdev_max_discard_sectors
	helper
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

On 4/6/22 2:05 PM, Christoph Hellwig wrote:
> Add a helper to query the number of sectors support per each discard bio
> based on the block device and use this helper to stop various places from
> poking into the request_queue to see if discard is supported and if so how
> much.  This mirrors what is done e.g. for write zeroes as well.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>


For the bcache part,

Acked-by: Coly Li <colyli@suse.de>


Thanks.


Coly Li



> ---
>   block/blk-core.c                    |  2 +-
>   block/blk-lib.c                     |  2 +-
>   block/ioctl.c                       |  3 +--
>   drivers/block/drbd/drbd_main.c      |  2 +-
>   drivers/block/drbd/drbd_nl.c        | 12 +++++++-----
>   drivers/block/drbd/drbd_receiver.c  |  5 ++---
>   drivers/block/loop.c                |  9 +++------
>   drivers/block/rnbd/rnbd-srv-dev.h   |  6 +-----
>   drivers/block/xen-blkback/xenbus.c  |  2 +-
>   drivers/md/bcache/request.c         |  4 ++--
>   drivers/md/bcache/super.c           |  2 +-
>   drivers/md/bcache/sysfs.c           |  2 +-
>   drivers/md/dm-cache-target.c        |  9 +--------
>   drivers/md/dm-clone-target.c        |  9 +--------
>   drivers/md/dm-io.c                  |  2 +-
>   drivers/md/dm-log-writes.c          |  3 +--
>   drivers/md/dm-raid.c                |  9 ++-------
>   drivers/md/dm-table.c               |  4 +---
>   drivers/md/dm-thin.c                |  9 +--------
>   drivers/md/dm.c                     |  2 +-
>   drivers/md/md-linear.c              |  4 ++--
>   drivers/md/raid0.c                  |  2 +-
>   drivers/md/raid1.c                  |  6 +++---
>   drivers/md/raid10.c                 |  8 ++++----
>   drivers/md/raid5-cache.c            |  2 +-
>   drivers/target/target_core_device.c |  8 +++-----
>   fs/btrfs/extent-tree.c              |  4 ++--
>   fs/btrfs/ioctl.c                    |  2 +-
>   fs/exfat/file.c                     |  2 +-
>   fs/exfat/super.c                    | 10 +++-------
>   fs/ext4/ioctl.c                     | 10 +++-------
>   fs/ext4/super.c                     | 10 +++-------
>   fs/f2fs/f2fs.h                      |  3 +--
>   fs/f2fs/segment.c                   |  6 ++----
>   fs/fat/file.c                       |  2 +-
>   fs/fat/inode.c                      | 10 +++-------
>   fs/gfs2/rgrp.c                      |  2 +-
>   fs/jbd2/journal.c                   |  7 ++-----
>   fs/jfs/ioctl.c                      |  2 +-
>   fs/jfs/super.c                      |  8 ++------
>   fs/nilfs2/ioctl.c                   |  2 +-
>   fs/ntfs3/file.c                     |  2 +-
>   fs/ntfs3/super.c                    |  2 +-
>   fs/ocfs2/ioctl.c                    |  2 +-
>   fs/xfs/xfs_discard.c                |  2 +-
>   fs/xfs/xfs_super.c                  | 12 ++++--------
>   include/linux/blkdev.h              |  5 +++++
>   mm/swapfile.c                       | 17 ++---------------
>   48 files changed, 87 insertions(+), 163 deletions(-)

[snipped]


> diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> index fdd0194f84dd0..e27f67f06a428 100644
> --- a/drivers/md/bcache/request.c
> +++ b/drivers/md/bcache/request.c
> @@ -1005,7 +1005,7 @@ static void cached_dev_write(struct cached_dev *dc, struct search *s)
>   		bio_get(s->iop.bio);
>   
>   		if (bio_op(bio) == REQ_OP_DISCARD &&
> -		    !blk_queue_discard(bdev_get_queue(dc->bdev)))
> +		    !bdev_max_discard_sectors(dc->bdev))
>   			goto insert_data;
>   
>   		/* I/O request sent to backing device */
> @@ -1115,7 +1115,7 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
>   	bio->bi_private = ddip;
>   
>   	if ((bio_op(bio) == REQ_OP_DISCARD) &&
> -	    !blk_queue_discard(bdev_get_queue(dc->bdev)))
> +	    !bdev_max_discard_sectors(dc->bdev))
>   		bio->bi_end_io(bio);
>   	else
>   		submit_bio_noacct(bio);
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index bf3de149d3c9f..296f200b2e208 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -2350,7 +2350,7 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
>   	ca->bdev->bd_holder = ca;
>   	ca->sb_disk = sb_disk;
>   
> -	if (blk_queue_discard(bdev_get_queue(bdev)))
> +	if (bdev_max_discard_sectors((bdev)))
>   		ca->discard = CACHE_DISCARD(&ca->sb);
>   
>   	ret = cache_alloc(ca);
> diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
> index d1029d71ff3bc..c6f677059214d 100644
> --- a/drivers/md/bcache/sysfs.c
> +++ b/drivers/md/bcache/sysfs.c
> @@ -1151,7 +1151,7 @@ STORE(__bch_cache)
>   	if (attr == &sysfs_discard) {
>   		bool v = strtoul_or_return(buf);
>   
> -		if (blk_queue_discard(bdev_get_queue(ca->bdev)))
> +		if (bdev_max_discard_sectors(ca->bdev))
>   			ca->discard = v;
>   
>   		if (v != CACHE_DISCARD(&ca->sb)) {


[snipped]

