Return-Path: <hare@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BA3A74207D7
	for <drbd-dev@lists.linbit.com>; Fri, 20 Nov 2020 08:58:17 +0100 (CET)
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201116145809.410558-1-hch@lst.de>
	<20201116145809.410558-71-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c854459e-d124-d0fd-2159-d40ef4d6ca75@suse.de>
Date: Fri, 20 Nov 2020 08:58:15 +0100
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-71-hch@lst.de>
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
Subject: Re: [Drbd-dev] [PATCH 70/78] block: replace bd_mutex with a
	per-gendisk mutex
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

On 11/16/20 3:58 PM, Christoph Hellwig wrote:
> bd_mutex is primarily used for synchronizing the block device open and
> release path, which recurses from partitions to the whole disk device.
> The fact that we have two locks makes life unnecessarily complex due
> to lock order constrains.  Replace the two levels of locking with a
> single mutex in the gendisk structure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/genhd.c                   |  7 ++--
>   block/ioctl.c                   |  4 +-
>   block/partitions/core.c         | 22 +++++-----
>   drivers/block/loop.c            | 14 +++----
>   drivers/block/xen-blkfront.c    |  8 ++--
>   drivers/block/zram/zram_drv.c   |  4 +-
>   drivers/block/zram/zram_drv.h   |  2 +-
>   drivers/md/md.h                 |  7 +---
>   drivers/s390/block/dasd_genhd.c |  8 ++--
>   drivers/scsi/sd.c               |  4 +-
>   fs/block_dev.c                  | 71 +++++++++++++++++----------------
>   fs/btrfs/volumes.c              |  2 +-
>   fs/super.c                      |  8 ++--
>   include/linux/blk_types.h       |  1 -
>   include/linux/genhd.h           |  1 +
>   15 files changed, 80 insertions(+), 83 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
