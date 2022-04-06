Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
	[209.85.218.53])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0C111420FBE
	for <drbd-dev@lists.linbit.com>; Wed,  6 Apr 2022 11:20:40 +0200 (CEST)
Received: by mail-ej1-f53.google.com with SMTP id dr20so2948941ejc.6
	for <drbd-dev@lists.linbit.com>; Wed, 06 Apr 2022 02:20:40 -0700 (PDT)
Message-ID: <012329f8-01db-7b17-0f64-2d63e86afc75@linbit.com>
Date: Wed, 6 Apr 2022 11:20:38 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20220406060516.409838-1-hch@lst.de>
	<20220406060516.409838-6-hch@lst.de>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220406060516.409838-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 05/27] drbd: use bdev based limit helpers in
 drbd_send_sizes
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

Am 06.04.22 um 08:04 schrieb Christoph Hellwig:
> Use the bdev based limits helpers where they exist.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/drbd/drbd_main.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 74b1b2424efff..d20d84ee7a88e 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -924,7 +924,9 @@ int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enu
>  
>  	memset(p, 0, packet_size);
>  	if (get_ldev_if_state(device, D_NEGOTIATING)) {
> -		struct request_queue *q = bdev_get_queue(device->ldev->backing_bdev);
> +		struct block_device *bdev = device->ldev->backing_bdev;
> +		struct request_queue *q = bdev_get_queue(bdev);
> +
>  		d_size = drbd_get_max_capacity(device->ldev);
>  		rcu_read_lock();
>  		u_size = rcu_dereference(device->ldev->disk_conf)->disk_size;
> @@ -933,16 +935,15 @@ int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enu
>  		max_bio_size = queue_max_hw_sectors(q) << 9;
>  		max_bio_size = min(max_bio_size, DRBD_MAX_BIO_SIZE);
>  		p->qlim->physical_block_size =
> -			cpu_to_be32(queue_physical_block_size(q));
> +			cpu_to_be32(bdev_physical_block_size(bdev));
>  		p->qlim->logical_block_size =
> -			cpu_to_be32(queue_logical_block_size(q));
> +			cpu_to_be32(bdev_logical_block_size(bdev));
>  		p->qlim->alignment_offset =
>  			cpu_to_be32(queue_alignment_offset(q));
> -		p->qlim->io_min = cpu_to_be32(queue_io_min(q));
> -		p->qlim->io_opt = cpu_to_be32(queue_io_opt(q));
> +		p->qlim->io_min = cpu_to_be32(bdev_io_min(bdev));
> +		p->qlim->io_opt = cpu_to_be32(bdev_io_opt(bdev));
>  		p->qlim->discard_enabled = blk_queue_discard(q);
> -		p->qlim->write_same_capable =
> -			!!q->limits.max_write_same_sectors;
> +		p->qlim->write_same_capable = 0;
>  		put_ldev(device);
>  	} else {
>  		struct request_queue *q = device->rq_queue;

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
