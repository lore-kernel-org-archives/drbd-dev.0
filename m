Return-Path: <andreas.osterburg@digide.net>
Received: from mx.vdsgmbh.de (mx.vdsgmbh.de [78.47.152.216])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 46CDB105646A
	for <drbd-dev@lists.linbit.com>; Mon, 20 Feb 2017 18:06:48 +0100 (CET)
Received: from [IPv6:2003:7f:4f18:4a00:6a05:caff:fe39:b4ee]
	(p2003007F4F184A006A05CAFFFE39B4EE.dip0.t-ipconnect.de
	[IPv6:2003:7f:4f18:4a00:6a05:caff:fe39:b4ee]) (authenticated bits=0)
	by mx.vdsgmbh.de (8.15.2/8.15.2/SuSE Linux 0.8) with ESMTPSA id
	v1KGwHs2026053
	(version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <drbd-dev@lists.linbit.com>; Mon, 20 Feb 2017 17:58:18 +0100
To: drbd-dev@lists.linbit.com
References: <34e63ed3-e991-8a84-45c7-2d9682d5af86@digide.net>
	<20170220140715.GN21236@soda.linbit>
From: Andreas Osterburg <andreas.osterburg@digide.net>
Message-ID: <a56aa3ed-f241-e7aa-9778-2741695c1d7f@digide.net>
Date: Mon, 20 Feb 2017 17:58:16 +0100
MIME-Version: 1.0
In-Reply-To: <20170220140715.GN21236@soda.linbit>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
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

Thanks for your investigations.
I didn't use a loop since the old behaviour was to leave the function returning -EAGAIN
on timeout or interrupt. There is just one difference: When an event from the socket occures
and no TCP-connection is established, the function leaves before the timeout elapses. It
makes no real difference to an interrupt, so I didn't handle it specially.

Thanks,

Andreas Osterburg

Am 20.02.2017 um 15:07 schrieb Lars Ellenberg:
> On Mon, Feb 20, 2017 at 11:54:45AM +0100, Andreas Osterburg wrote:
>> Recent Linux-kernels (since 3.19) emit a warning when using nested sleeping
>> statements within kernel code. CONFIG_DEBUG_ATOMIC_SLEEP must be enabled to
>> see it.
>> Module drbd_transport_tcp is affected and always triggers a warning
>> on first connect:
>> [ 6187.934573] WARNING: CPU: 33 PID: 17430 at ../kernel/sched/core.c:7963 __might_sleep+0x76/0x80()
>> [ 6187.934580] do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffff810c2dce>] prepare_to_wait_event+0x5e/0xf0
>
>> [ 6187.934926]  [<ffffffff810a30b6>] __might_sleep+0x76/0x80
>> [ 6187.934936]  [<ffffffff8160984c>] mutex_lock+0x1c/0x38
>> [ 6187.934981]  [<ffffffffa05ba8f0>] dtt_wait_connect_cond+0x20/0xa0 [drbd_transport_tcp]
>> [ 6187.935017]  [<ffffffffa05bb3ce>] dtt_wait_for_connect.constprop.10+0x29e/0x440 [drbd_transport_tcp]
>> [ 6187.935033]  [<ffffffffa05bbde7>] dtt_connect+0x247/0x7b7 [drbd_transport_tcp]
>> [ 6187.935072]  [<ffffffffa05300e1>] drbd_receiver+0x171/0x680 [drbd]
>
>> I fixed this, the patch is attached on this mail. When it is ok, someone should apply it.
>
> Looks almost correct (loop is missing).
> I don't yet see the real problem with this particular code,
> even just annotating that "this is ok" so the warning goes away
> would be "legal". (sched_annotate_sleep() before mutex_lock()).
>
> We are discussing to maybe replace the mutex_lock
> by a mutex_trylock, or even by a spinlock.
> Either way, real fix should be in "soon".
>
> Thanks,
>
>     Lars
>
>> --- drbd/drbd_transport_tcp.c	2016-12-06 16:20:39.000000000 +0100
>> +++ drbd/drbd_transport_tcp.c	2017-02-20 11:23:46.794979063 +0100
>> @@ -568,6 +568,7 @@
>>  	struct drbd_path *drbd_path2;
>>  	struct dtt_listener *listener = container_of(drbd_listener, struct dtt_listener, listener);
>>  	struct dtt_path *path = NULL;
>> +	DEFINE_WAIT_FUNC(wait_connect, woken_wake_function);
>>
>>  	rcu_read_lock();
>>  	nc = rcu_dereference(transport->net_conf);
>> @@ -582,9 +583,15 @@
>>  	timeo += (prandom_u32() & 1) ? timeo / 7 : -timeo / 7; /* 28.5% random jitter */
>>
>>  retry:
>> -	timeo = wait_event_interruptible_timeout(listener->wait,
>> -			(path = dtt_wait_connect_cond(transport)),
>> -			timeo);
>> +	add_wait_queue(&listener->wait, &wait_connect);
>> +	path = dtt_wait_connect_cond(transport);
>> +	if(!path) {
>> +		wait_woken(&wait_connect, TASK_INTERRUPTIBLE, timeo);
>> +		path = dtt_wait_connect_cond(transport);
>> +		if(!path) timeo = 0;
>> +	}
>> +	remove_wait_queue(&listener->wait, &wait_connect);
>> +
>>  	if (timeo <= 0)
>>  		return -EAGAIN;
>
>


-- 
Andreas Osterburg
IT Software GmbH & Data Security Elbe KG       Tel.: +49 (391) 509609-55
Lorenzweg 42 - Haus 3, D-39124 Magdeburg       Fax : +49 (391) 509609-56
Geschäftsführer: Jens Henning             Amtsgericht Stendal, HRA 22588
Zertifiziert nach ISO 9001:2008
