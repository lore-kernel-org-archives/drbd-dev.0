Return-Path: <philipp@hug.cx>
Received: from postman.abacus.ch (postman.abacus.ch [193.246.101.142])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 8508214322
	for <drbd-dev@lists.linbit.com>; Wed,  6 Oct 2004 09:24:31 +0200 (CEST)
Message-ID: <060901c4ab75$7752e0a0$532210ac@morpheus>
From: "Philipp Hug" <philipp@hug.cx>
To: "Helmut Wollmersdorfer" <helmut@wollmersdorfer.at>,
	<drbd-dev@lists.linbit.com>
References: <200409291054.13765.philipp.reisner@linbit.com>	<200409301410.21550.philipp.reisner@linbit.com>
	<022301c4a704$b2dca950$532210ac@morpheus>
	<416315AF.80004@wollmersdorfer.at>
Subject: Re: [Drbd-dev] 0.7.5 release tomorrow...
Date: Wed, 6 Oct 2004 09:24:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> [...]
> cd user && /usr/bin/make
> make[1]: Entering directory `/home/helmut/drbd-0.7.5/user'
> gcc -c -Wall -I../drbd   -c -o drbdsetup.o drbdsetup.c
> make[1]: *** No rule to make target `../drbd/drbd_buildtag.o', needed by 
> `drbdsetup'.  Stop.
> make[1]: Leaving directory `/home/helmut/drbd-0.7.5/user'
> make: *** [build-arch-stamp] Error 2
> 
> After
>    make install-tools
> as workaround it builds .debs and works the usual debian way.
Shouldn't drbd_buildtag.c be included in the release tarball?
If not, I'll add the workaround to the debian packaging...

> Next item:
> Whatever the reason is, the following is necessary with current packaging
> 
> xp2400:/home/helmut# mv /lib/modules/2.4.26/kernel/drivers/block/drbd.o 
> /lib/modules/2.4.26-1-386/kernel/drivers/block/drbd.o

How did you build the kernel module? module-assistant? make-kpkg?
anyway: looks like a bug... I'll fix it..

philipp
