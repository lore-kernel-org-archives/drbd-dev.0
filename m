Return-Path: <m@sys4.de>
Received: from mail.sys4.de (mail.sys4.de [194.126.158.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 22460101E063
	for <drbd-dev@lists.linbit.com>; Tue, 23 Sep 2014 20:14:22 +0200 (CEST)
Received: from localhost (ip2505fba1.dynamic.kabel-deutschland.de
	[37.5.251.161])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.sys4.de (Postfix) with ESMTPSA id 3j2Vz20Msfz6V
	for <drbd-dev@lists.linbit.com>; Tue, 23 Sep 2014 20:14:22 +0200 (CEST)
Date: Tue, 23 Sep 2014 20:14:21 +0200
From: Marc Schiffbauer <m@sys4.de>
To: drbd-dev@lists.linbit.com
Message-ID: <20140923181421.GB32597@schiffbauer.net>
References: <20140919094909.GA21578@schiffbauer.net>
	<20140919144805.GS13125@soda.linbit>
	<20140919151653.GH21578@schiffbauer.net>
	<20140923110348.GA19076@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20140923110348.GA19076@soda.linbit>
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

* Lars Ellenberg schrieb am 23.09.14 um 13:03 Uhr:
>On Fri, Sep 19, 2014 at 05:16:53PM +0200, Marc Schiffbauer wrote:
>> * Lars Ellenberg schrieb am 19.09.14 um 16:48 Uhr:
>> >On Fri, Sep 19, 2014 at 11:49:09AM +0200, Marc Schiffbauer wrote:
>> >>Hi,
>> >>
>> >
>> >If you resolve that to a code line,
>> >I may be able to figure out what PAX is talking about.
>> >
>> >But from this stack trace alone, I have absolutely no idea what PAX
>> >is trying to say, which refcount could possibly be meant there,
>> >let alone why it could possibly overflow or.
>> >
>> >Ah, ok. Looking at [1], "PaX Team" says:
>> >.---
>> >| after having looked at the drbd code a bit i think this could be a
>> >| real bug in drbd but only upstream can tell for sure so you'll have to
>> >| contact them. you can show them the following that i figured out so far:
>> >|
>> >| the refcount overflow was detected in
>> >| drivers/block/drbd/drbd_bitmap.c:bm_page_io_async at the
>> >|
>> >| atomic_add(len >> 9, &mdev->rs_sect_ev)
>> >
>> >Well, yes, why would it not overflow.
>> >It is *not* a refcount.
>> >It is an atomic counter.
>> >It is meant to overflow.


Another question PaX-Team is asking:

what about rs_sect_in?


Thanks


-- 
[*] sys4 AG

http://sys4.de, +49 (89) 30 90 46 64
Franziskanerstraße 15, 81669 München

Sitz der Gesellschaft: München, Amtsgericht München: HRB 199263
Vorstand: Patrick Ben Koetter, Marc Schiffbauer
Aufsichtsratsvorsitzender: Florian Kirstein
