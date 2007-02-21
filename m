Return-Path: <brederlo@informatik.uni-tuebingen.de>
Received: from mx1.informatik.uni-tuebingen.de
	(mx1.Informatik.Uni-Tuebingen.De [134.2.12.5])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 370D62E05E9A
	for <drbd-dev@lists.linbit.com>; Wed, 21 Feb 2007 08:06:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mx1.informatik.uni-tuebingen.de (Postfix) with ESMTP id 70870349B
	for <drbd-dev@lists.linbit.com>; Wed, 21 Feb 2007 08:06:16 +0100 (MET)
Received: from mx1.informatik.uni-tuebingen.de ([127.0.0.1])
	by localhost (mx1.informatik.uni-tuebingen.de [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id FlZAkPxdYqXK for <drbd-dev@lists.linbit.com>;
	Wed, 21 Feb 2007 08:06:16 +0100 (MET)
Received: from localhost.localdomain (ssh1 [134.2.13.191])
	by mx1.informatik.uni-tuebingen.de (Postfix) with ESMTP id 7DAA73485
	for <drbd-dev@lists.linbit.com>; Wed, 21 Feb 2007 08:06:15 +0100 (MET)
Received: from mrvn by localhost.localdomain with local (Exim 4.63)
	(envelope-from <brederlo@informatik.uni-tuebingen.de>)
	id 1HJlYI-0003KR-Je
	for drbd-dev@lists.linbit.com; Wed, 21 Feb 2007 08:06:10 +0100
From: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd 8.0.0 over IP over infiniband crashes
References: <874ppnhgq3.fsf@informatik.uni-tuebingen.de>
	<87hctj1fy5.fsf@informatik.uni-tuebingen.de>
	<20070220115542.GC7742@soda.linbit>
Date: Wed, 21 Feb 2007 08:06:10 +0100
In-Reply-To: <20070220115542.GC7742@soda.linbit> (Lars Ellenberg's message of
	"Tue, 20 Feb 2007 12:55:42 +0100")
Message-ID: <87fy90vvkt.fsf@informatik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Lars Ellenberg <Lars.Ellenberg@linbit.com> writes:

> / 2007-02-18 19:25:06 +0100
> \ Goswin von Brederlow:
>> Ok,
>> 
>> here we go. I got it to crash again after 3 days of running bonnie
>> (mostly on ext3). This time the crash was while testing reiserfs on
>> the drbd devices and it is only an oops. Before it crashed when
>> syncing the drbd itself and I had to reset.
>> 
>> Does this look drbd related at all or just reiserfs screwing up?
>
> reiser seems to think it runs on "dm-3";
> do you use drbd as PV?

Yes. 6 drbd as PVs with a LV with 6 stripes on it.

> anyways, I don't see anything drbd related in that kernel log.
> more something about reiserfs not behaving during memory pressure
> (within xen; this may or may not be relevant).

The system has 4G and nothing running on it so that shouldn't
happen. Unless there is a leak in the kernel.

> I read it like: reiser tries to delete something, which for some reason
> is not where it is expected (may be in memory data corruption, may be
> some bad timing and race in reiserfs, may be a logic bug somewhere),
> then tries to allocate an error buffer, which it does not get for some
> reason; but it then dereferences that buffer pointer anyways. boom.

I would have expected some bluesmoke messages on bad memory.

> it may still be drbd related in the sense that drbd may add to the
> memory pressure... but nothing we can fix in drbd.

MfG
        Goswin
