Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
	[209.85.218.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E2182420622
	for <drbd-dev@lists.linbit.com>; Thu,  1 Apr 2021 15:01:22 +0200 (CEST)
Received: by mail-ej1-f46.google.com with SMTP id a7so2766134ejs.3
	for <drbd-dev@lists.linbit.com>; Thu, 01 Apr 2021 06:01:22 -0700 (PDT)
To: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
References: <20210401115753.3684-1-lyl2019@mail.ustc.edu.cn>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <cb0f43e4-bfde-ac77-5153-f2f3cbed0172@linbit.com>
Date: Thu, 1 Apr 2021 15:01:20 +0200
MIME-Version: 1.0
In-Reply-To: <20210401115753.3684-1-lyl2019@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: axboe@kernel.dk, philipp.reisner@linbit.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: Fix a use after free in
 get_initial_state
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

On 4/1/21 1:57 PM, Lv Yunlong wrote:
> In get_initial_state, it calls notify_initial_state_done(skb,..) if
> cb->args[5]==1. I see that if genlmsg_put() failed in
> notify_initial_state_done(), the skb will be freed by nlmsg_free(skb).
> Then get_initial_state will goto out and the freed skb will be used by
> return value skb->len.
> 
> My patch lets skb_len = skb->len and return the skb_len to avoid the uaf.
> 
> Fixes: a29728463b254 ("drbd: Backport the "events2" command")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>   drivers/block/drbd/drbd_nl.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index bf7de4c7b96c..474f84675d0a 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -4905,6 +4905,7 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
>   	struct drbd_state_change *state_change = (struct drbd_state_change *)cb->args[0];
>   	unsigned int seq = cb->args[2];
>   	unsigned int n;
> +	unsigned int skb_len = skb->len;
>   	enum drbd_notification_type flags = 0;
>   
>   	/* There is no need for taking notification_mutex here: it doesn't
> @@ -4915,7 +4916,7 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
>   	cb->args[5]--;
>   	if (cb->args[5] == 1) {
>   		notify_initial_state_done(skb, seq);
> -		goto out;
> +		return skb_len;
>   	}
>   	n = cb->args[4]++;
>   	if (cb->args[4] < cb->args[3])
> 

Thanks for the patch!

I think the problem goes even further: skb can also be freed in the 
notify_*_state_change -> notify_*_state calls below.

Also, at the point where we save skb->len into skb_len, skb is not 
initialized yet. Maybe it makes more sense to not return a length in the 
first place here, but an error code instead.

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
