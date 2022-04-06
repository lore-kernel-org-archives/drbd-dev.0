Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
	[209.85.208.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1508D420FBB
	for <drbd-dev@lists.linbit.com>; Wed,  6 Apr 2022 11:32:11 +0200 (CEST)
Received: by mail-ed1-f43.google.com with SMTP id p23so1872079edi.8
	for <drbd-dev@lists.linbit.com>; Wed, 06 Apr 2022 02:32:11 -0700 (PDT)
Message-ID: <b6d79d64-dbea-4fbf-be91-d80bd3b9cd22@linbit.com>
Date: Wed, 6 Apr 2022 11:32:09 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20220406060516.409838-1-hch@lst.de>
	<20220406060516.409838-17-hch@lst.de>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220406060516.409838-17-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 16/27] drbd: use bdev_alignment_offset
 instead of queue_alignment_offset
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

Am 06.04.22 um 08:05 schrieb Christoph Hellwig:
> The bdev version does the right thing for partitions, so use that.
> 
> Fixes: 9104d31a759f ("drbd: introduce WRITE_SAME support")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/drbd/drbd_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index d20d84ee7a88e..9d43aadde19ad 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -939,7 +939,7 @@ int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enu
>  		p->qlim->logical_block_size =
>  			cpu_to_be32(bdev_logical_block_size(bdev));
>  		p->qlim->alignment_offset =
> -			cpu_to_be32(queue_alignment_offset(q));
> +			cpu_to_be32(bdev_alignment_offset(bdev));
>  		p->qlim->io_min = cpu_to_be32(bdev_io_min(bdev));
>  		p->qlim->io_opt = cpu_to_be32(bdev_io_opt(bdev));
>  		p->qlim->discard_enabled = blk_queue_discard(q);

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
