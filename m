Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr0-f175.google.com (mail-wr0-f175.google.com
	[209.85.128.175])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 39B891056320
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 14:44:47 +0200 (CEST)
Received: by mail-wr0-f175.google.com with SMTP id w11so58053250wrc.3
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 05:44:47 -0700 (PDT)
Date: Thu, 30 Mar 2017 14:44:41 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170330124440.GJ49684@rck.sh>
References: <4841d2c2936addc27a2e774041d04ec16885ba03.1490341208.git.geliangtang@gmail.com>
	<88d743591c2bd5e0c46009f7ec33fa326bf2db5e.1490341364.git.geliangtang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88d743591c2bd5e0c46009f7ec33fa326bf2db5e.1490341364.git.geliangtang@gmail.com>
Subject: Re: [Drbd-dev] [PATCH] drbd: use setup_timer
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

On Fri, Mar 24, 2017 at 10:15:11PM +0800, Geliang Tang wrote:
> Use setup_timer() instead of init_timer() to simplify the code.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  drivers/block/drbd/drbd_main.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 92c60cb..09846fc 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -2011,18 +2011,14 @@ void drbd_init_set_defaults(struct drbd_device *device)
>  	device->unplug_work.cb  = w_send_write_hint;
>  	device->bm_io_work.w.cb = w_bitmap_io;
>  
> -	init_timer(&device->resync_timer);
> -	init_timer(&device->md_sync_timer);
> -	init_timer(&device->start_resync_timer);
> -	init_timer(&device->request_timer);
> -	device->resync_timer.function = resync_timer_fn;
> -	device->resync_timer.data = (unsigned long) device;
> -	device->md_sync_timer.function = md_sync_timer_fn;
> -	device->md_sync_timer.data = (unsigned long) device;
> -	device->start_resync_timer.function = start_resync_timer_fn;
> -	device->start_resync_timer.data = (unsigned long) device;
> -	device->request_timer.function = request_timer_fn;
> -	device->request_timer.data = (unsigned long) device;
> +	setup_timer(&device->resync_timer, resync_timer_fn,
> +		    (unsigned long)device);
> +	setup_timer(&device->md_sync_timer, md_sync_timer_fn,
> +		    (unsigned long)device);
> +	setup_timer(&device->start_resync_timer, start_resync_timer_fn,
> +		    (unsigned long)device);
> +	setup_timer(&device->request_timer, request_timer_fn,
> +		    (unsigned long)device);
>  
>  	init_waitqueue_head(&device->misc_wait);
>  	init_waitqueue_head(&device->state_wait);

Hi Geliang,

I commited that to our out-of-tree code, so it will take some time till
it lands in some upstream merge-window, but eventually it will get
mainline.

Thanks, rck
