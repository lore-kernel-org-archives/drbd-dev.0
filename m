Return-Path: <dsterba@suse.cz>
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 742A1421016
	for <drbd-dev@lists.linbit.com>; Thu,  7 Apr 2022 17:30:59 +0200 (CEST)
Date: Thu, 7 Apr 2022 17:26:56 +0200
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20220407152656.GM15609@twin.jikos.cz>
References: <20220406060516.409838-1-hch@lst.de>
	<20220406060516.409838-27-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406060516.409838-27-hch@lst.de>
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
Subject: Re: [Drbd-dev] [PATCH 26/27] block: uncouple REQ_OP_SECURE_ERASE
 from REQ_OP_DISCARD
Reply-To: dsterba@suse.cz
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

On Wed, Apr 06, 2022 at 08:05:15AM +0200, Christoph Hellwig wrote:
> Secure erase is a very different operation from discard in that it is
> a data integrity operation vs hint.  Fully split the limits and helper
> infrastructure to make the separation more clear.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c                    |  2 +-
>  block/blk-lib.c                     | 64 ++++++++++++++++++++---------
>  block/blk-mq-debugfs.c              |  1 -
>  block/blk-settings.c                | 16 +++++++-
>  block/fops.c                        |  2 +-
>  block/ioctl.c                       | 43 +++++++++++++++----
>  drivers/block/drbd/drbd_receiver.c  |  5 ++-
>  drivers/block/rnbd/rnbd-clt.c       |  4 +-
>  drivers/block/rnbd/rnbd-srv-dev.h   |  2 +-
>  drivers/block/xen-blkback/blkback.c | 15 +++----
>  drivers/block/xen-blkback/xenbus.c  |  5 +--
>  drivers/block/xen-blkfront.c        |  5 ++-
>  drivers/md/bcache/alloc.c           |  2 +-
>  drivers/md/dm-table.c               |  8 ++--
>  drivers/md/dm-thin.c                |  4 +-
>  drivers/md/md.c                     |  2 +-
>  drivers/md/raid5-cache.c            |  6 +--
>  drivers/mmc/core/queue.c            |  2 +-
>  drivers/nvme/target/io-cmd-bdev.c   |  2 +-
>  drivers/target/target_core_file.c   |  2 +-
>  drivers/target/target_core_iblock.c |  2 +-

For

>  fs/btrfs/extent-tree.c              |  4 +-

Acked-by: David Sterba <dsterba@suse.com>
