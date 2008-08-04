Return-Path: <syrius.ml@no-log.org>
Received: from postfix2-g20.free.fr (postfix2-g20.free.fr [212.27.60.43])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 4FA5E2E3A53E
	for <drbd-dev@lists.linbit.com>; Mon,  4 Aug 2008 20:38:52 +0200 (CEST)
Received: from smtp8-g19.free.fr (smtp8-g19.free.fr [212.27.42.65])
	by postfix2-g20.free.fr (Postfix) with ESMTP id 42D7428A7046
	for <drbd-dev@lists.linbit.com>; Mon,  4 Aug 2008 18:36:53 +0200 (CEST)
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id C620832A90A
	for <drbd-dev@lists.linbit.com>; Mon,  4 Aug 2008 20:37:01 +0200 (CEST)
Received: from f.smtp.localhost (amm80-1-82-246-72-218.fbx.proxad.net
	[82.246.72.218])
	by smtp8-g19.free.fr (Postfix) with ESMTP id B2F3432A848
	for <drbd-dev@lists.linbit.com>; Mon,  4 Aug 2008 20:37:00 +0200 (CEST)
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] too small timeout in drbdsetup
References: <87hcastmig.87fxqctmig@87ej5wtmig.message.id>
From: syrius.ml@no-log.org
Message-ID: <87y73cochw.87wsiwochw@87vdygochw.message.id>
Date: Mon, 04 Aug 2008 20:37:00 +0200
In-Reply-To: <87hcastmig.87fxqctmig@87ej5wtmig.message.id> (syrius ml's
	message of "Mon\, 14 Jul 2008 19\:24\:30 +0200")
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

syrius.ml@no-log.org writes:

> Hi,
>
> as previously reported here
> http://thread.gmane.org/gmane.linux.kernel.drbd.devel/330 I also get
> the error message.
>
> looking at
> http://git.drbd.org/?p=drbd-8.0.git;a=blob;f=user/drbdsetup.c;h=0bca7c1c773bcbd1c2ed6781062396ed15e77e9c;hb=HEAD#l1919
> and
> http://git.drbd.org/?p=drbd-8.2.git;a=blob;f=user/drbdsetup.c;h=3868f1a18f4cda80cad5b0b05aa6f2348755dedd;hb=HEAD
>
> it seems the timeout is still too low (at least for me)
>
> I've fixed my problem by increasing the timeout to 5s.
>
> to reproduce the bug i was doing several drbdsetup disk one after the other
> in a script.
>
> (in fact the bug was first triggered by heartbeat drbd ocf script)
>
> Was do you thing would be the best change to make ?
> increase the timeout ?
> why not using NL_TIME (12000) as other drbd_calls ?


Sorry to insist, 8.0.13 is on its way and you haven't answered about
this subject.
A lot of people have to make the change by hand and recompile,
distributions might add their own patch before releasing. Anyway what
do you think about this ?

TIA

-- 
