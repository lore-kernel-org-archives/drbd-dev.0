Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
	[209.85.208.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 52AF3420471
	for <drbd-dev@lists.linbit.com>; Wed, 22 Jun 2022 22:57:34 +0200 (CEST)
Received: by mail-ed1-f43.google.com with SMTP id z19so8783527edb.11
	for <drbd-dev@lists.linbit.com>; Wed, 22 Jun 2022 13:57:34 -0700 (PDT)
Message-ID: <0308c92a-0e10-35a4-928b-8f715a7bae44@linbit.com>
Date: Wed, 22 Jun 2022 22:57:32 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Jiang Jian <jiangjian@cdjrlc.com>
References: <20220622155220.8704-1-jiangjian@cdjrlc.com>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220622155220.8704-1-jiangjian@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block: drbd: drbd_state: Fix typo in comments
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

Am 22.06.22 um 17:52 schrieb Jiang Jian:
> Replace 'is' with 'it'
> 
> file: drivers/block/drbd/drbd_state.c
> line: 1900
> 
> * But is is still not save to dreference ldev here, since
> 
> changed to:
> 
> * But it is still not save to dreference ldev here, since
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/block/drbd/drbd_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
> index 3f7bf9f2d874..99927c44f0c3 100644
> --- a/drivers/block/drbd/drbd_state.c
> +++ b/drivers/block/drbd/drbd_state.c
> @@ -1897,7 +1897,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
>  		int was_io_error = 0;
>  		/* corresponding get_ldev was in _drbd_set_state, to serialize
>  		 * our cleanup here with the transition to D_DISKLESS.
> -		 * But is is still not save to dreference ldev here, since
> +		 * But it is still not save to dreference ldev here, since
>  		 * we might come from an failed Attach before ldev was set. */
>  		if (device->ldev) {
>  			rcu_read_lock();

I agree with James here, I do not think this provides much value.

In fact, the *same* line you are changing contains two more spelling
mistakes ("save" and "dreference").

My opinion is that trivial patches like this are fine as a starting
point for new contributors, which is why I acked the previous patch from
you guys. However, if we start getting two of these every week it just
adds more maintenance burden than it's worth.

So thanks for the contribution, but it's a NAK from me.

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
