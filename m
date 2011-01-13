Return-Path: <JAxboe@fusionio.com>
Received: from mx1.fusionio.com (mx1.fusionio.com [64.244.102.30])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5780F1057AB3
	for <drbd-dev@lists.linbit.com>; Thu, 13 Jan 2011 14:56:59 +0100 (CET)
Message-ID: <4D2F04AE.8010007@fusionio.com>
Date: Thu, 13 Jan 2011 14:57:02 +0100
From: Jens Axboe <jaxboe@fusionio.com>
MIME-Version: 1.0
To: Or Gerlitz <ogerlitz@voltaire.com>
References: <Pine.LNX.4.64.1101131124380.19218@zuben.voltaire.com>
In-Reply-To: <Pine.LNX.4.64.1101131124380.19218@zuben.voltaire.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] drbd: clean reference to old kernels
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2011-01-13 10:34, Or Gerlitz wrote:
> drop code present under #ifdef which is relevant to 2.6.28 and below
> 
> Signed-off-by: Or Gerlitz <ogerlitz@voltaire.com>
> 
> ---
> 
> Philipp, I haven't noted if/where the drbd updates for 2.6.38 were posted,
> have them? do you typically post the pull request to LKML or there's a lower
> volume mailing list where this can be tracked?
> 
> diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
> index 11a75d3..85f6cf6 100644
> --- a/drivers/block/drbd/drbd_req.c
> +++ b/drivers/block/drbd/drbd_req.c
> @@ -1074,9 +1074,6 @@ int drbd_make_request_26(struct request_queue *q, struct bio *bio)
>  		const int mask = sps - 1;
>  		const sector_t first_sectors = sps - (sect & mask);
>  		bp = bio_split(bio,
> -#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
> -				bio_split_pool,
> -#endif
>  				first_sectors);
> 
>  		/* we need to get a "reference count" (ap_bio_cnt)

Thanks, that should die. Preferably the line could now be collapsed into
a single line as well.

-- 
Jens Axboe

