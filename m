Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
	[209.85.218.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 64A07421741
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2022 09:36:54 +0200 (CEST)
Received: by mail-ej1-f41.google.com with SMTP id r18so18085085eja.11
	for <drbd-dev@lists.linbit.com>; Mon, 12 Sep 2022 00:36:54 -0700 (PDT)
Message-ID: <eabdb4f6-c58e-dcb9-b886-7e244754c461@linbit.com>
Date: Mon, 12 Sep 2022 09:36:51 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Gaosheng Cui <cuigaosheng1@huawei.com>
References: <20220911092645.3218009-1-cuigaosheng1@huawei.com>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220911092645.3218009-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: axboe@kernel.dk, lars.ellenberg@linbit.com, philipp.reisner@linbit.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block/drbd: remove unused w_start_resync
	declaration
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

Am 11.09.22 um 11:26 schrieb Gaosheng Cui:
> w_start_resync has been removed since
> commit ac0acb9e39ac ("drbd: use drbd_device_post_work()
> in more places"), so remove it.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  drivers/block/drbd/drbd_int.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
> index f15f2f041596..4d661282ff41 100644
> --- a/drivers/block/drbd/drbd_int.h
> +++ b/drivers/block/drbd/drbd_int.h
> @@ -1529,7 +1529,6 @@ extern int w_send_read_req(struct drbd_work *, int);
>  extern int w_e_reissue(struct drbd_work *, int);
>  extern int w_restart_disk_io(struct drbd_work *, int);
>  extern int w_send_out_of_sync(struct drbd_work *, int);
> -extern int w_start_resync(struct drbd_work *, int);
>  
>  extern void resync_timer_fn(struct timer_list *t);
>  extern void start_resync_timer_fn(struct timer_list *t);

Thanks for the patch, looks good to me.

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
