Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (0122700014.0.fullrate.dk [95.166.99.235])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C1F3D105A7B0
	for <drbd-dev@lists.linbit.com>; Thu, 22 Apr 2010 14:27:20 +0200 (CEST)
Date: Thu, 22 Apr 2010 14:27:19 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Dan Carpenter <error27@gmail.com>
Message-ID: <20100422122719.GH27497@kernel.dk>
References: <20100422095641.GR29647@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100422095641.GR29647@bicker>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	kernel-janitors@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [patch] drbd: fix memory leak
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Apr 22 2010, Dan Carpenter wrote:
> We leak memory if "--dry-run" is not supported by the peer.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 67e0fc5..93d1f9b 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -1695,6 +1695,7 @@ int drbd_send_protocol(struct drbd_conf *mdev)
>  			cf |= CF_DRY_RUN;
>  		else {
>  			dev_err(DEV, "--dry-run is not supported by peer");
> +			kfree(p);
>  			return 0;
>  		}
>  	}

Yep, that's a leak. I have applied it for 2.6.34.

-- 
Jens Axboe

