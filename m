Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 33844105646A
	for <drbd-dev@lists.linbit.com>; Mon, 20 Feb 2017 15:07:24 +0100 (CET)
Received: by mail-wm0-f45.google.com with SMTP id c85so80401210wmi.1
	for <drbd-dev@lists.linbit.com>; Mon, 20 Feb 2017 06:07:24 -0800 (PST)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	x69sm13642753wma.15.2017.02.20.06.07.22
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 Feb 2017 06:07:22 -0800 (PST)
Date: Mon, 20 Feb 2017 15:07:15 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170220140715.GN21236@soda.linbit>
References: <34e63ed3-e991-8a84-45c7-2d9682d5af86@digide.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34e63ed3-e991-8a84-45c7-2d9682d5af86@digide.net>
Subject: Re: [Drbd-dev] Avoid nested sleeping on TCP connect
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

On Mon, Feb 20, 2017 at 11:54:45AM +0100, Andreas Osterburg wrote:
> Recent Linux-kernels (since 3.19) emit a warning when using nested sleeping
> statements within kernel code. CONFIG_DEBUG_ATOMIC_SLEEP must be enabled to
> see it.
> Module drbd_transport_tcp is affected and always triggers a warning
> on first connect:
> [ 6187.934573] WARNING: CPU: 33 PID: 17430 at ../kernel/sched/core.c:7963 __might_sleep+0x76/0x80()
> [ 6187.934580] do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffff810c2dce>] prepare_to_wait_event+0x5e/0xf0

> [ 6187.934926]  [<ffffffff810a30b6>] __might_sleep+0x76/0x80
> [ 6187.934936]  [<ffffffff8160984c>] mutex_lock+0x1c/0x38
> [ 6187.934981]  [<ffffffffa05ba8f0>] dtt_wait_connect_cond+0x20/0xa0 [drbd_transport_tcp]
> [ 6187.935017]  [<ffffffffa05bb3ce>] dtt_wait_for_connect.constprop.10+0x29e/0x440 [drbd_transport_tcp]
> [ 6187.935033]  [<ffffffffa05bbde7>] dtt_connect+0x247/0x7b7 [drbd_transport_tcp]
> [ 6187.935072]  [<ffffffffa05300e1>] drbd_receiver+0x171/0x680 [drbd]

> I fixed this, the patch is attached on this mail. When it is ok, someone should apply it.

Looks almost correct (loop is missing).
I don't yet see the real problem with this particular code,
even just annotating that "this is ok" so the warning goes away
would be "legal". (sched_annotate_sleep() before mutex_lock()).

We are discussing to maybe replace the mutex_lock
by a mutex_trylock, or even by a spinlock.
Either way, real fix should be in "soon".

Thanks,

    Lars

> --- drbd/drbd_transport_tcp.c	2016-12-06 16:20:39.000000000 +0100
> +++ drbd/drbd_transport_tcp.c	2017-02-20 11:23:46.794979063 +0100
> @@ -568,6 +568,7 @@
>  	struct drbd_path *drbd_path2;
>  	struct dtt_listener *listener = container_of(drbd_listener, struct dtt_listener, listener);
>  	struct dtt_path *path = NULL;
> +	DEFINE_WAIT_FUNC(wait_connect, woken_wake_function);
>  
>  	rcu_read_lock();
>  	nc = rcu_dereference(transport->net_conf);
> @@ -582,9 +583,15 @@
>  	timeo += (prandom_u32() & 1) ? timeo / 7 : -timeo / 7; /* 28.5% random jitter */
>  
>  retry:
> -	timeo = wait_event_interruptible_timeout(listener->wait,
> -			(path = dtt_wait_connect_cond(transport)),
> -			timeo);
> +	add_wait_queue(&listener->wait, &wait_connect);
> +	path = dtt_wait_connect_cond(transport);
> +	if(!path) {
> +		wait_woken(&wait_connect, TASK_INTERRUPTIBLE, timeo);
> +		path = dtt_wait_connect_cond(transport);
> +		if(!path) timeo = 0;
> +	}
> +	remove_wait_queue(&listener->wait, &wait_connect);
> +
>  	if (timeo <= 0)
>  		return -EAGAIN;


-- 
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD® and LINBIT® are registered trademarks of LINBIT
