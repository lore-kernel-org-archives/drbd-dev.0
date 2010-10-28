Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: axboe@kernel.dk
Date: Thu, 28 Oct 2010 10:22:48 +0200
References: <201010271943.o9RJh9cY013845@imap1.linux-foundation.org>
In-Reply-To: <201010271943.o9RJh9cY013845@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201010281022.48856.philipp.reisner@linbit.com>
Cc: nikai@nikai.net, akpm@linux-foundation.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [patch 4/4] drivers/block/drbd/drbd_main.c: fix
	error path
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Jens,

The patch is obviously correct.
Should I pick it up (and send you a pull req (later))? 
Are you going to pick it up directly?

Best,
 Phil

> From: Nicolas Kaiser <nikai@nikai.net>
> 
> Failure to create drbd_ee_mempool appears not to get checked.  Looks like
> a copy-and-paste problem to me.
> 
> Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
> Cc: Lars Ellenberg <drbd-dev@lists.linbit.com>
> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/block/drbd/drbd_main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN
> drivers/block/drbd/drbd_main.c~drivers-block-drbd-drbd_mainc-fix-error-pat
> h drivers/block/drbd/drbd_main.c ---
> a/drivers/block/drbd/drbd_main.c~drivers-block-drbd-drbd_mainc-fix-error-p
> ath +++ a/drivers/block/drbd/drbd_main.c
> @@ -2982,7 +2982,7 @@ static int drbd_create_mempools(void)
> 
>  	drbd_ee_mempool = mempool_create(number,
>  		mempool_alloc_slab, mempool_free_slab, drbd_ee_cache);
> -	if (drbd_request_mempool == NULL)
> +	if (drbd_ee_mempool == NULL)
>  		goto Enomem;
> 
>  	/* drbd's page pool */
> _


-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
