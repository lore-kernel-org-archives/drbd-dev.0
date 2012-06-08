Return-Path: <lars.ellenberg@linbit.com>
Date: Fri, 8 Jun 2012 20:50:08 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20120608185008.GC8030@soda.linbit>
References: <20120608123128.GA18293@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120608123128.GA18293@elgon.mountain>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com, Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [DRBD-user] [patch -resend] drbd: fix
	resync_dump_detail() output
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Jun 08, 2012 at 03:31:28PM +0300, Dan Carpenter wrote:
> The tests here aren't correct.  It should be doing a shift before doing
> the bitwise AND.  (bme->flags & BME_NO_WRITES) is always false and
> (bme->flags & BME_LOCKED) checks for BME_NO_WRITES instead of checking
> for locked.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Ack.

> ---
> I sent this to the drbd-user list in March, but never recieved a
> response.

Sorry, seems to have been lost :-(

	Lars

> diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
> index 2959cdf..ffe1ee4 100644
> --- a/drivers/block/drbd/drbd_proc.c
> +++ b/drivers/block/drbd/drbd_proc.c
> @@ -187,8 +187,10 @@ static void resync_dump_detail(struct seq_file *seq, struct lc_element *e)
>  	struct bm_extent *bme = lc_entry(e, struct bm_extent, lce);
>  
>  	seq_printf(seq, "%5d %s %s\n", bme->rs_left,
> -		   bme->flags & BME_NO_WRITES ? "NO_WRITES" : "---------",
> -		   bme->flags & BME_LOCKED ? "LOCKED" : "------"
> +		   test_bit(BME_NO_WRITES, &bme->flags) ?
> +			"NO_WRITES" : "---------",
> +		   test_bit(BME_LOCKED, &bme->flags) ?
> +			"LOCKED" : "------"
>  		   );
>  }

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com
