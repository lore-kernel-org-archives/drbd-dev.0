Return-Path: <m@sys4.de>
Received: from mail.sys4.de (mail.sys4.de [194.126.158.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 05344101AC7F
	for <drbd-dev@lists.linbit.com>; Fri, 19 Sep 2014 17:16:54 +0200 (CEST)
Received: from localhost (port-19100.pppoe.wtnet.de [46.59.136.61])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.sys4.de (Postfix) with ESMTPSA id 3hzzD56Z4Vz6d
	for <drbd-dev@lists.linbit.com>; Fri, 19 Sep 2014 17:16:53 +0200 (CEST)
Date: Fri, 19 Sep 2014 17:16:53 +0200
From: Marc Schiffbauer <m@sys4.de>
To: drbd-dev@lists.linbit.com
Message-ID: <20140919151653.GH21578@schiffbauer.net>
References: <20140919094909.GA21578@schiffbauer.net>
	<20140919144805.GS13125@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20140919144805.GS13125@soda.linbit>
Subject: Re: [Drbd-dev] drbd 8.4.3: refcounter overflow on re-sync
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

* Lars Ellenberg schrieb am 19.09.14 um 16:48 Uhr:
>On Fri, Sep 19, 2014 at 11:49:09AM +0200, Marc Schiffbauer wrote:
>> Hi,
>>
>
>If you resolve that to a code line,
>I may be able to figure out what PAX is talking about.
>
>But from this stack trace alone, I have absolutely no idea what PAX
>is trying to say, which refcount could possibly be meant there,
>let alone why it could possibly overflow or.
>
>Ah, ok. Looking at [1], "PaX Team" says:
>.---
>| after having looked at the drbd code a bit i think this could be a
>| real bug in drbd but only upstream can tell for sure so you'll have to
>| contact them. you can show them the following that i figured out so far:
>|
>| the refcount overflow was detected in
>| drivers/block/drbd/drbd_bitmap.c:bm_page_io_async at the
>|
>| atomic_add(len >> 9, &mdev->rs_sect_ev)
>
>Well, yes, why would it not overflow.
>It is *not* a refcount.
>It is an atomic counter.
>It is meant to overflow.

Ok, then I can report this back and it should be fixed in PaX as a 
false postive. Thanks for clarifying this.


>
>| statement. rs_sect_ev is an atomic_t in struct drbd_conf declared in
>| drivers/block/drbd/drbd_int.h (i'll note here that i think the
>| rs_sect_in field is simiarly affected by this problem).
>|
>| based on the code, these two fields don't look like refcounts, nor are
>| they free-running counters or statistics either (the usual cases for
>| false positives). instead they're some sector counts that get reset on
>| certain events (the details of which i can't tell as i don't know the
>| drbd code). therefore my feeling is that these counts are not supposed
>| to overflow as they'd otherwise lead to incorrect calculations in
>| drbd_rs_should_slow_down and drbd_rs_controller (the latter reads
>| rs_sect_in into an unsigned int btw, this is mixing up signed/unsigned
>| integers, that can't be good...).
>
>But yes, it *is* a "free running counter".
>For IO that has to be accounted to the resyncer.
>They are reset whenever a new resync starts.
>
>Apparently you are syncing more than 2*41 byte.
>That's ok.  Others do too.
>Having a lot of storage is no reason to drop the connection.

ack


>
>| so what happened to you is that somehow rs_sect_ev reached 2G (that
>| corresponds to about 1TB of traffic between two counter resets or
>| 'events') and the signed overflow detection triggered on it (if that's
>| too unrealistic traffic for drbd then there was some other problem
>| calculating the sector counts that resulted in some big enough value to
>| trigger a signed overflow, though at the moment of the overflow 'len'
>| had a value of 8 only). in any case it looks that an atomic_t is not
>| enough to store real life sector counts and will have to be enlarged
>| probably (or the counters will have to be reset more frequently).
>`---
>
>It is perfectly ok for rs_sect_ev to overflow, it is meant to overflow.
>It is used in some signed modulo 32bit calculation only.
>
>> [63999.116913]  [<ffffffffa006f617>] ? drbd_thread_setup+0x4e/0x117 [drbd]
>> [63999.116917]  [<ffffffffa006f5c9>] ? conn_destroy+0x86/0x86 [drbd]
>> [63999.116922]  [<ffffffff8107fbfc>] ? kthread+0xd5/0xdd
>> [63999.116924]  [<ffffffff8107fb27>] ? kthread_worker_fn+0xf9/0xf9
>> [63999.116929]  [<ffffffff81535f74>] ? ret_from_fork+0x74/0xa0
>> [63999.116930]  [<ffffffff8107fb27>] ? kthread_worker_fn+0xf9/0xf9
>> [63999.116931] Code: 48 89 de 4c 89 ff e8 c3 80 00 00 85 c0 0f 85 b2 00 00 00 8b 54 24 1c f0 41 01 97 d0 04 00 00 71 0a f0 41 29 97 d0 04 00 00 cd 04 <bb> 03 00 00 00 f0 41 ff 87 24 02 00 00 71 0a f0 41 ff 8f 24 02
>>
>>
>> and drbd itself says:
>>
>> [63999.116965] block drbd0: drbd_alloc_pages interrupted!
>
>Um, I'd guess it does say some things before that, too.
>Also, the other node will likely have something to say.
>
>Can you give some more context?
>
>Interrupted by whom?

by the PAX-System in the Kernel to protect the system becaus ethis 
*might* be an evil overflow.


>Is PAX delivering some signal?
>Which?

I don't know, sorry :-/

>Why would it do that?

see above

>If so, stop it :-)

OK ;)

If you are still interested inmore context because you think there 
might be something wrong in the drbd code, then I can boot the 
previous kernel with PAX_REFCOUNT enabled to reproduce the proplem 
again.

But it would be some effort to do zhis again, so I want to be sure 
its of any use for you now that it is clear that this must be a 
false positive.


Thanks
-Marc

-- 
[*] sys4 AG

http://sys4.de, +49 (89) 30 90 46 64
Franziskanerstraße 15, 81669 München

Sitz der Gesellschaft: München, Amtsgericht München: HRB 199263
Vorstand: Patrick Ben Koetter, Marc Schiffbauer
Aufsichtsratsvorsitzender: Florian Kirstein
