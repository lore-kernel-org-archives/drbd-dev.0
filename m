Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
	[209.85.218.53])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E1A76420FBB
	for <drbd-dev@lists.linbit.com>; Wed,  6 Apr 2022 11:09:25 +0200 (CEST)
Received: by mail-ej1-f53.google.com with SMTP id dr20so2892553ejc.6
	for <drbd-dev@lists.linbit.com>; Wed, 06 Apr 2022 02:09:25 -0700 (PDT)
Message-ID: <d2626d2f-d348-49a1-e36b-a3eb598ac327@linbit.com>
Date: Wed, 6 Apr 2022 11:09:23 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20220406060516.409838-1-hch@lst.de>
	<20220406060516.409838-5-hch@lst.de>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220406060516.409838-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 04/27] drbd: remove assign_p_sizes_qlim
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
> Fold each branch into its only caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/drbd/drbd_main.c | 50 ++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 9676a1d214bc5..74b1b2424efff 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -903,31 +903,6 @@ void drbd_gen_and_send_sync_uuid(struct drbd_peer_device *peer_device)
>  	}
>  }
>  
> -/* communicated if (agreed_features & DRBD_FF_WSAME) */
> -static void
> -assign_p_sizes_qlim(struct drbd_device *device, struct p_sizes *p,
> -					struct request_queue *q)
> -{
> -	if (q) {
> -		p->qlim->physical_block_size = cpu_to_be32(queue_physical_block_size(q));
> -		p->qlim->logical_block_size = cpu_to_be32(queue_logical_block_size(q));
> -		p->qlim->alignment_offset = cpu_to_be32(queue_alignment_offset(q));
> -		p->qlim->io_min = cpu_to_be32(queue_io_min(q));
> -		p->qlim->io_opt = cpu_to_be32(queue_io_opt(q));
> -		p->qlim->discard_enabled = blk_queue_discard(q);
> -		p->qlim->write_same_capable = 0;
> -	} else {
> -		q = device->rq_queue;
> -		p->qlim->physical_block_size = cpu_to_be32(queue_physical_block_size(q));
> -		p->qlim->logical_block_size = cpu_to_be32(queue_logical_block_size(q));
> -		p->qlim->alignment_offset = 0;
> -		p->qlim->io_min = cpu_to_be32(queue_io_min(q));
> -		p->qlim->io_opt = cpu_to_be32(queue_io_opt(q));
> -		p->qlim->discard_enabled = 0;
> -		p->qlim->write_same_capable = 0;
> -	}
> -}
> -
>  int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enum dds_flags flags)
>  {
>  	struct drbd_device *device = peer_device->device;
> @@ -957,14 +932,35 @@ int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enu
>  		q_order_type = drbd_queue_order_type(device);
>  		max_bio_size = queue_max_hw_sectors(q) << 9;
>  		max_bio_size = min(max_bio_size, DRBD_MAX_BIO_SIZE);
> -		assign_p_sizes_qlim(device, p, q);
> +		p->qlim->physical_block_size =
> +			cpu_to_be32(queue_physical_block_size(q));
> +		p->qlim->logical_block_size =
> +			cpu_to_be32(queue_logical_block_size(q));
> +		p->qlim->alignment_offset =
> +			cpu_to_be32(queue_alignment_offset(q));
> +		p->qlim->io_min = cpu_to_be32(queue_io_min(q));
> +		p->qlim->io_opt = cpu_to_be32(queue_io_opt(q));
> +		p->qlim->discard_enabled = blk_queue_discard(q);
> +		p->qlim->write_same_capable =
> +			!!q->limits.max_write_same_sectors;

queue_limits.max_write_same_sectors was removed in 73bd66d9c834, so this
does not compile. It's removed in the next patch, so the big picture is
fine, just this one commit is broken.

>  		put_ldev(device);
>  	} else {
> +		struct request_queue *q = device->rq_queue;
> +
> +		p->qlim->physical_block_size =
> +			cpu_to_be32(queue_physical_block_size(q));
> +		p->qlim->logical_block_size =
> +			cpu_to_be32(queue_logical_block_size(q));
> +		p->qlim->alignment_offset = 0;
> +		p->qlim->io_min = cpu_to_be32(queue_io_min(q));
> +		p->qlim->io_opt = cpu_to_be32(queue_io_opt(q));
> +		p->qlim->discard_enabled = 0;
> +		p->qlim->write_same_capable = 0;
> +
>  		d_size = 0;
>  		u_size = 0;
>  		q_order_type = QUEUE_ORDERED_NONE;
>  		max_bio_size = DRBD_MAX_BIO_SIZE; /* ... multiple BIOs per peer_request */
> -		assign_p_sizes_qlim(device, p, NULL);
>  	}
>  
>  	if (peer_device->connection->agreed_pro_version <= 94)
