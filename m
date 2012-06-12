Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E29FF1013809
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jun 2012 14:25:06 +0200 (CEST)
Date: Tue, 12 Jun 2012 14:25:06 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20120612122506.GF4069@soda.linbit>
References: <20120612074310.GC15060@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120612074310.GC15060@elgon.mountain>
Cc: kernel-janitors@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [patch] drbd: potential integer overflow in
 receive_SyncParam()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Jun 12, 2012 at 10:43:11AM +0300, Dan Carpenter wrote:
> I believe this comes from the network so there is a risk of integer
> overflow on 32 bit.  Using kcalloc() is a little cleaner as well.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index ea4836e..1e27876 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -2902,7 +2902,7 @@ static int receive_SyncParam(struct drbd_conf *mdev, enum drbd_packets cmd, unsi
>  
>  			fifo_size = (mdev->sync_conf.c_plan_ahead * 10 * SLEEP_TIME) / HZ;
>  			if (fifo_size != mdev->rs_plan_s.size && fifo_size > 0) {
> -				rs_plan_s   = kzalloc(sizeof(int) * fifo_size, GFP_KERNEL);
> +				rs_plan_s = kcalloc(fifo_size, sizeof(int), GFP_KERNEL);
>  				if (!rs_plan_s) {
>  					dev_err(DEV, "kmalloc of fifo_buffer failed");
>  					goto disconnect;

sync_conf.c_plan_ahead is capped at 300 by drbdsetup.
But yes, since this is not enforced in kernel code,
your fix is correct.


	Lars
