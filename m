Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7A53A101AC43
	for <drbd-dev@lists.linbit.com>; Wed, 24 Jul 2019 13:37:22 +0200 (CEST)
Received: by mail-wr1-f67.google.com with SMTP id f9so46563728wre.12
	for <drbd-dev@lists.linbit.com>; Wed, 24 Jul 2019 04:37:21 -0700 (PDT)
Date: Wed, 24 Jul 2019 13:37:20 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <20190724113720.gis6v2ziltmmv4zt@rck.sh>
References: <20190724034926.28755-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724034926.28755-1-baijiaju1990@gmail.com>
Cc: axboe@kernel.dk, philipp.reisner@linbit.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 2/2] block: drbd: Fix a possible null-pointer
 dereference in is_valid_state()
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

On Wed, Jul 24, 2019 at 11:49:26AM +0800, Jia-Ju Bai wrote:
> In is_valid_state(), there is an if statement on line 839 to check
> whether nc is NULL:
>     if (nc)
> 
> When nc is NULL, it is used on line 880:
>     (nc->verify_alg[0] == 0)
> 
> Thus, a possible null-pointer dereference may occur.
> 
> To fix this bug, nc is also checked on line 880.
> 
> This bug is found by a static analysis tool STCheck written by us.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/block/drbd/drbd_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
> index eeaa3b49b264..3cf477e9cf6a 100644
> --- a/drivers/block/drbd/drbd_state.c
> +++ b/drivers/block/drbd/drbd_state.c
> @@ -877,7 +877,7 @@ is_valid_state(struct drbd_device *device, union drbd_state ns)
>  		rv = SS_CONNECTED_OUTDATES;
>  
>  	else if ((ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) &&
> -		 (nc->verify_alg[0] == 0))
> +		 (nc && nc->verify_alg[0] == 0))
>  		rv = SS_NO_VERIFY_ALG;

AFAIK it is "impossible" to reach such a DRBD state without having a
valid net conf. Anyways, a check is a good idea, but the logic is wrong,
I would propose something like this:

 	else if ((ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) &&
-		 (nc->verify_alg[0] == 0))
+		 (!nc || nc->verify_alg[0] == 0))
 		rv = SS_NO_VERIFY_ALG;

Regards, rck
