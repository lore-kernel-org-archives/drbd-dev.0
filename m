Return-Path: <helmut@wollmersdorfer.at>
Received: from viefep14-int.chello.at (viefep14-int.chello.at [213.46.255.13])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id D607314324
	for <drbd-dev@lists.linbit.com>; Wed,  6 Oct 2004 11:32:47 +0200 (CEST)
Received: from wollmersdorfer.at ([212.186.65.148]) by viefep14-int.chello.at
	(InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
	id <20041006093242.OYHG15384.viefep14-int.chello.at@wollmersdorfer.at>
	for <drbd-dev@lists.linbit.com>; Wed, 6 Oct 2004 11:32:42 +0200
Message-ID: <4163BBBA.5050304@wollmersdorfer.at>
Date: Wed, 06 Oct 2004 11:32:42 +0200
From: Helmut Wollmersdorfer <helmut@wollmersdorfer.at>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] 0.7.5 release tomorrow...
References: <200409291054.13765.philipp.reisner@linbit.com>	<200409301410.21550.philipp.reisner@linbit.com>	<022301c4a704$b2dca950$532210ac@morpheus>	<416315AF.80004@wollmersdorfer.at>
	<060901c4ab75$7752e0a0$532210ac@morpheus>
In-Reply-To: <060901c4ab75$7752e0a0$532210ac@morpheus>
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

Philipp Hug wrote:

> Shouldn't drbd_buildtag.c be included in the release tarball?

I used svn checkout.

> If not, I'll add the workaround to the debian packaging...

Thx in advance. Maybe the easier way to support debian packaging from 
svn would be, to provide something like "make buildtag".

>> xp2400:/home/helmut# mv 
>> /lib/modules/2.4.26/kernel/drivers/block/drbd.o 
>> /lib/modules/2.4.26-1-386/kernel/drivers/block/drbd.o

> How did you build the kernel module? module-assistant? make-kpkg?

make-kpkg
I never used module-assistant.

> anyway: looks like a bug... I'll fix it..

Seems so. Take a look into pcmcia-modules, how this problem is solved there.

Helmut Wollmersdorfer

