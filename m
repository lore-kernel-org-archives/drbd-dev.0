Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
	[209.85.221.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7728D420312
	for <drbd-dev@lists.linbit.com>; Mon, 27 Mar 2023 14:28:40 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id j24so8640730wrd.0
	for <drbd-dev@lists.linbit.com>; Mon, 27 Mar 2023 05:28:40 -0700 (PDT)
Message-ID: <a989f01e-79a9-44a4-3603-ba4eeeb86dea@linbit.com>
Date: Mon, 27 Mar 2023 14:28:37 +0200
MIME-Version: 1.0
To: Markus Elfring <Markus.Elfring@web.de>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
	<8d193937-532f-959f-9b84-d911984508aa@web.de>
	<941709b5-d940-42c9-5f31-7ed56e3e6151@web.de>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <941709b5-d940-42c9-5f31-7ed56e3e6151@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, cocci@inria.fr,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH resent] drbd: Fix exception handling in
 nla_put_drbd_cfg_context()
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

Am 25.03.23 um 15:07 schrieb Markus Elfring:
> Date: Fri, 17 Mar 2023 18:32:05 +0100
> 
> The label “nla_put_failure” was used to jump to another pointer check
> despite of the detail in the implementation of the function
> “nla_put_drbd_cfg_context” that it was determined already that
> the corresponding variable contained a null pointer.
> 
> * Thus return directly after a call of the function
>   “nla_nest_start_noflag” failed.
> 
> * Delete an extra pointer check which became unnecessary
>   with this refactoring.
> 
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 543cc10b4cc5c60aa9fcc62705ccfb9998bf4697 ("drbd: drbd_adm_get_status needs to show some more detail")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/block/drbd/drbd_nl.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index f49f2a5282e1..9cb947127472 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -3187,7 +3187,7 @@ static int nla_put_drbd_cfg_context(struct sk_buff *skb,
>  	struct nlattr *nla;
>  	nla = nla_nest_start_noflag(skb, DRBD_NLA_CFG_CONTEXT);
>  	if (!nla)
> -		goto nla_put_failure;
> +		return -EMSGSIZE;
>  	if (device &&
>  	    nla_put_u32(skb, T_ctx_volume, device->vnr))
>  		goto nla_put_failure;
> @@ -3205,8 +3205,7 @@ static int nla_put_drbd_cfg_context(struct sk_buff *skb,
>  	return 0;
> 
>  nla_put_failure:
> -	if (nla)
> -		nla_nest_cancel(skb, nla);
> +	nla_nest_cancel(skb, nla);
>  	return -EMSGSIZE;
>  }
> 
> --
> 2.40.0
> 

Sorry, I fail to see how this is an improvement over the status quo,
much less a "fix".

Can you identify the issue with the current code and can you explain how
your patch makes it better?

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
