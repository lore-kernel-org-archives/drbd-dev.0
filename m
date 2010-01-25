Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Mon, 25 Jan 2010 18:14:36 +0100
References: <20100123124522.GA3061@bicker>
In-Reply-To: <20100123124522.GA3061@bicker>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201001251814.37009.philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>, kernel-janitors@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [Drbd-dev] [patch] drbd: null dereference bug
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Samstag, 23. Januar 2010 13:45:22 schrieb Dan Carpenter:
> epoch is always NULL here.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> This patch has only been compile tested.  Sorry.  :/
> 
> --- orig/drivers/block/drbd/drbd_receiver.c	2010-01-23 10:53:13.000000000
>  +0300 +++ devel/drivers/block/drbd/drbd_receiver.c	2010-01-23
>  10:54:19.000000000 +0300 @@ -1224,7 +1224,7 @@ static int
>  receive_Barrier(struct drbd_c
>  	epoch = kmalloc(sizeof(struct drbd_epoch), GFP_NOIO);
>  	if (!epoch) {
>  		dev_warn(DEV, "Allocation of an epoch failed, slowing down\n");
> -		issue_flush = !test_and_set_bit(DE_BARRIER_IN_NEXT_EPOCH_ISSUED, &epoch->flags);
> +		issue_flush = !test_and_set_bit(DE_BARRIER_IN_NEXT_EPOCH_ISSUED, &mdev->current_epoch->flags);
>  		drbd_wait_ee_list_empty(mdev, &mdev->active_ee);
>  		if (issue_flush) {
>  			rv = drbd_flush_after_epoch(mdev, mdev->current_epoch);
>

The patch is correct. It is going upstream though the DRBD tree.
See:
http://git.drbd.org/?p=linux-2.6-drbd.git;a=commit;h=d3db7b485ad7c467a61279d6a8ef51a3c83352df

-Phil
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
