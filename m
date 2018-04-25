Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 01C451057315
	for <drbd-dev@lists.linbit.com>; Wed, 25 Apr 2018 13:02:24 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id x12so4091199wmc.0
	for <drbd-dev@lists.linbit.com>; Wed, 25 Apr 2018 04:02:24 -0700 (PDT)
Date: Wed, 25 Apr 2018 12:54:36 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Message-ID: <20180425105436.5ko6imz66hfsxwk3@rck.sh>
References: <20180424131410.1603-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424131410.1603-1-luc.vanoostenryck@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drdb: fix print_st_err()'s prototype
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Apr 24, 2018 at 03:14:10PM +0200, Luc Van Oostenryck wrote:
> print_st_err() is defined with its 4th argument taking an
> 'enum drbd_state_rv' but its prototype use an int for it.
> 
> Fix this by using 'enum drbd_state_rv' in the prototype too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/block/drbd/drbd_state.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
> index ea58301d0..b2a390ba7 100644
> --- a/drivers/block/drbd/drbd_state.h
> +++ b/drivers/block/drbd/drbd_state.h
> @@ -131,7 +131,7 @@ extern enum drbd_state_rv _drbd_set_state(struct drbd_device *, union drbd_state
>  					  enum chg_state_flags,
>  					  struct completion *done);
>  extern void print_st_err(struct drbd_device *, union drbd_state,
> -			union drbd_state, int);
> +			union drbd_state, enum drbd_state_rv);
>  
>  enum drbd_state_rv
>  _conn_request_state(struct drbd_connection *connection, union drbd_state mask, union drbd_state val,
> -- 
> 2.17.0

Thanks, looks good.

Applied to our internal tree. As usual, we send it mainline bundled with
other pending changes.

Regards, rck
