Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (dialin-145-254-065-089.arcor-ip.net
	[145.254.65.89])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 7F82514358
	for <drbd-dev@lists.linbit.com>; Tue, 19 Oct 2004 12:28:57 +0200 (CEST)
Date: Tue, 19 Oct 2004 12:03:36 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [DRBD-cvs] r1600 - branches/drbd-0.7/drbd
Message-ID: <HcoFP6pnb8MI006txV+wpU0=lge@web.de>
References: <20041019091152.50E053BE6D@garcon.linbit.com>
	<200410191130.24197.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410191130.24197.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-10-19 11:30:24 +0200
\ Philipp Reisner:
> > get rid of the HERE macro
> > provide (experimental) code for decreasing latency on 2.6 kernels by
> > pushing the tcp stack
> >
> 
> Hi Lars,
> 
> Do you really think it is an good idea to put that tcp-stack pushing
> into drbd-0.7 ??

I only put it in drbd07 to ease propagation with svnp.
and so it does not get lost.

currently I go over all those small patches I sent somewhen and never
got any reaction about, and just remove them if they meanwhile are no
longer usefull, or apply them if I think they could do something good.

> - Do you know that it improves performance ? 
>   Or is it just an assumption.

I do not know.

> - Do we really want to do this with the stable code 
>   I think we should have a least one or two reports from the list,
>   that 
>     a) it does not break anything
>     b) it improves performance.

it is #if 0'ed in drbd 0.7
I think we should #if 1 it in trunk,
benchmark it, and drop it if it does not do any good.

	lge
