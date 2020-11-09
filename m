Return-Path: <mst@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [63.128.21.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 06D804207B7
	for <drbd-dev@lists.linbit.com>; Mon,  9 Nov 2020 12:36:28 +0100 (CET)
Received: by mail-wr1-f71.google.com with SMTP id p16so1573222wrx.4
	for <drbd-dev@lists.linbit.com>; Mon, 09 Nov 2020 03:30:20 -0800 (PST)
Date: Mon, 9 Nov 2020 06:30:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20201109063004-mutt-send-email-mst@kernel.org>
References: <20201106190337.1973127-1-hch@lst.de>
	<20201106190337.1973127-24-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20201106190337.1973127-24-hch@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
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
	Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Subject: Re: [Drbd-dev] [PATCH 23/24] virtio-blk: remove a spurious call to
 revalidate_disk_size
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

On Fri, Nov 06, 2020 at 08:03:35PM +0100, Christoph Hellwig wrote:
> revalidate_disk_size just updates the block device size from the disk
> size.  Thus calling it from revalidate_disk_size doesn't actually do
> anything.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/block/virtio_blk.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 3e812b4c32e669..145606dc52db1e 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -598,7 +598,6 @@ static void virtblk_update_cache_mode(struct virtio_device *vdev)
>  	struct virtio_blk *vblk = vdev->priv;
>  
>  	blk_queue_write_cache(vblk->disk->queue, writeback, false);
> -	revalidate_disk_size(vblk->disk, true);
>  }
>  
>  static const char *const virtblk_cache_types[] = {
> -- 
> 2.28.0

