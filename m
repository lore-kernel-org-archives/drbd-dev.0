Return-Path: <helmut@wollmersdorfer.at>
Received: from viefep12-int.chello.at (viefep12-int.chello.at [213.46.255.25])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 763681432C
	for <drbd-dev@lists.linbit.com>; Wed,  6 Oct 2004 15:48:59 +0200 (CEST)
Received: from wollmersdorfer.at ([212.186.65.148]) by viefep12-int.chello.at
	(InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
	id <20041006134858.LCMD18525.viefep12-int.chello.at@wollmersdorfer.at>
	for <drbd-dev@lists.linbit.com>; Wed, 6 Oct 2004 15:48:58 +0200
Message-ID: <4163F7CA.5020506@wollmersdorfer.at>
Date: Wed, 06 Oct 2004 15:48:58 +0200
From: Helmut Wollmersdorfer <helmut@wollmersdorfer.at>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] 0.7.5 release tomorrow...
References: <200409291054.13765.philipp.reisner@linbit.com>	<200409301410.21550.philipp.reisner@linbit.com>	<022301c4a704$b2dca950$532210ac@morpheus>	<416315AF.80004@wollmersdorfer.at>	<060901c4ab75$7752e0a0$532210ac@morpheus>
	<q98FJxwJDKO3+3Oay6d0FPQ=lge@web.de>
In-Reply-To: <q98FJxwJDKO3+3Oay6d0FPQ=lge@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Lars Ellenberg wrote:
> / 2004-10-06 09:24:07 +0200
> \ Philipp Hug:

> now, if I do

> svn co http://svn.drbd.org/drbd/branches/drbd-0.7
> cd drbd-0.7
> make tarball

Aha. Needs to be included in debian packaging HOWTO.

> tar tvzf drbd-0.7.5.tar.gz | grep buildtag
> drbd/drbd_buildtag.c

> # aha. is it missing from the debian thing only?

Only if you try to follow the current debian packaging wiki.

> mkdir tmp
> cd tmp
> tar xvzf ../drbd-0.7.5.tar.gz
> cd drbd-0.7.5
> cd user && make

> # does work, too.

Obviously;-)
That's a developer test of the makefile, but not an acceptance test (or 
sanity check) of drbd-0.7.5/debian.

An ideal installation test should be:
- a fresh instance of $Distri $Version $Kernel $Kernel-Variant
- setup $Package preconditions according to $Package documentation
- a fresh instance $Package download
   use_cases[SVN current | SVN $Version | $Version.tar.gz | ...]
- follow installation instructions
- check post conditions (=expected result)
- report differences between expected and actual behaviour
   (expected and/or actual can be wrong)

Anybody can imagine the exploding number of test cases.
I only did Debian Sarge pre_RC2 [2.4.26-1-386|2.6.8-1-386] [SVN 0.7.5].

>>>xp2400:/home/helmut# mv /lib/modules/2.4.26/kernel/drivers/block/drbd.o 
>>>/lib/modules/2.4.26-1-386/kernel/drivers/block/drbd.o

>>How did you build the kernel module? module-assistant? make-kpkg?
>>anyway: looks like a bug... I'll fix it..

> drbd gets its kernel release (where to install) from the kernel
> makefile itself (which should know...). debian knows better?

Debian can know, but drbd/debian/control does wrong, i.e. Phil has to 
find out the appropriate debhelper (or whatsoever) function.

Helmut Wollmersdorfer
