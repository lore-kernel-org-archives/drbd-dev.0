Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (unknown [81.209.204.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 57FF8257A2
	for <drbd-dev@lists.linbit.com>; Mon,  9 May 2005 16:47:06 +0200 (CEST)
Date: Mon, 9 May 2005 16:46:47 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] 0.7.11 soon
Message-ID: <LVlMtS7zpHS+KhTi1IqrJxc=lge@web.de>
References: <200505091030.00455.philipp.reisner@linbit.com>
	<200505091058.42759.hug@abanet.ch>
	<200505091137.01385.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505091137.01385.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2005-05-09 11:37:01 +0200
\ Philipp Reisner:
> Am Montag, 9. Mai 2005 10:58 schrieb Philipp Hug:
> > philipp,
> >
> > if you release a new version it won't make it into sarge...
> > 0.7.10 will be in sarge and has to be supported for about 2 years ;-)
> 
> Yes, I expected this. 
> 
> The only relevant patch for Debian is the first item of the changelog:

 [ one line patch ]

> 
> Maybe you can slip it in by creating a "drbd-0.7.10-4" or something.
> But it is nothing critical at all ... as we know drbd-0.7.10 is really
> fine for most people.

hm.
maybe it is easier to NOT generate a drbd-0.7.10 package, but a drbd-0.7
paackage, so it can be updated to our 0.7.X releases without violating
any package release policies?

mean, development is in 0.8, 0.7 is in "bugfix-only-mode" anyways.
so basically when we somewhen release 0.7.14, that is equivalent to
releasing a package 0.7-somethingelse.

Right?

	Lars
