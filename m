Return-Path: <lars.ellenberg@linbit.com>
Date: Thu, 13 Jan 2011 16:28:39 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Or Gerlitz <ogerlitz@voltaire.com>
Message-ID: <20110113152839.GE25975@barkeeper1-xen.linbit>
References: <Pine.LNX.4.64.1101131124380.19218@zuben.voltaire.com>
	<Pine.LNX.4.64.1101131625400.3887@zuben.voltaire.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1101131625400.3887@zuben.voltaire.com>
Cc: Jens Axboe <jaxboe@fusionio.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2] drbd: clean reference to old kernels
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Jan 13, 2011 at 04:27:01PM +0200, Or Gerlitz wrote:
> drop ifdef which is relevant to 2.6.28 and below
> 
> Signed-off-by: Or Gerlitz <ogerlitz@voltaire.com>
> ---

Thanks for spotting and fixing this.

	Lars

> changes from v1:
> 	the call now collapsed into a single line
> 
> diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
> index 11a75d3..6496b32 100644
> --- a/drivers/block/drbd/drbd_req.c
> +++ b/drivers/block/drbd/drbd_req.c
> @@ -1073,11 +1073,7 @@ int drbd_make_request_26(struct request_queue *q, struct bio *bio)
>  		const int sps = 1 << HT_SHIFT; /* sectors per slot */
>  		const int mask = sps - 1;
>  		const sector_t first_sectors = sps - (sect & mask);
> -		bp = bio_split(bio,
> -#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
> -				bio_split_pool,
> -#endif
> -				first_sectors);
> +		bp = bio_split(bio, first_sectors);
> 
>  		/* we need to get a "reference count" (ap_bio_cnt)
>  		 * to avoid races with the disconnect/reconnect/suspend code.

