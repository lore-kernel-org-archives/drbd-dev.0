Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 4A85C2D99862
	for <drbd-dev@lists.linbit.com>; Tue, 12 Sep 2006 10:47:29 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Tue, 12 Sep 2006 10:47:29 +0200
References: <342BAC0A5467384983B586A6B0B37671038B01A4@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B37671038B01A4@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200609121047.29326.philipp.reisner@linbit.com>
Subject: [Drbd-dev] Re: FW: [DRBD-cvs] svn commit by phil - r2404 - in
	trunk: drbd/linux user -* Another micro fix to
	drbd/linux/connector.h, to make
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag, 11. September 2006 22:26 schrieben Sie:
> Hi Phillipp,
>
> Since taking this change, I can no longer build the user directory -- I
> should say that we build using KDIR on a system that is different from the
> config of the target system we run on and with the current Makefile, I am
> getting errors related to netlink like this:
>
> gcc -g -O2 -c -W -Wall -I../drbd   -c -o drbdsetup.o drbdsetup.c
> In file included from drbdsetup.c:51:
> /usr/include/linux/netlink.h:22: error: syntax error before "__u32"
> /usr/include/linux/netlink.h:28: error: syntax error before "__u32"
> /usr/include/linux/netlink.h:30: error: syntax error before "nlmsg_flags"
> /usr/include/linux/netlink.h:31: error: syntax error before "nlmsg_seq"
> /usr/include/linux/netlink.h:32: error: syntax error before "nlmsg_pid"
> /usr/include/linux/netlink.h:82: error: field `msg' has incomplete type
> drbdsetup.c: In function `create_tag_list':
> drbdsetup.c:428: error: invalid application of `sizeof' to incomplete type
> `nlmsghdr' drbdsetup.c:431: error: invalid application of `sizeof' to
> incomplete type `nlmsghdr' drbdsetup.c: In function `generic_config_cmd':
>
> This worked before you removed the -I$(KDIR) from CFLAGS -- I'm thinking
> you need to keep this to support cross-compiling DRBD... it certainly wor=
ks
> for me when I add that line back into the makefile...

Hmmm, __u32 gets defined in my /usr/include/asm-i386/types.h and the
nlmsg things get defined in my /usr/include/linux/netlink.h .

I have used debian and ubuntu systems so far.

What distribution are you using ?
What is the content of  /usr/include/linux/netlink.h=20
and /usr/include/asm/types.h on your distri ?

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=C3=B6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
