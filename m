Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (1Cust246.tnt13.ber2.deu.da.uu.net [149.225.240.246])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id BCF6A142F2
	for <drbd-dev@lists.linbit.com>; Tue,  3 Aug 2004 10:59:48 +0200 (CEST)
Date: Tue, 3 Aug 2004 11:00:01 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Release Date for 0.7.2   2004-08-06 ?
Message-ID: <aSGM8xSzsGxSKckTkCa1RS8=lge@web.de>
References: <200408030953.38946.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408030953.38946.philipp.reisner@linbit.com>
Sender: drbd-dev-admin@lists.linbit.com
Errors-To: drbd-dev-admin@lists.linbit.com
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev/>

/ 2004-08-03 09:53:38 +0200
\ Philipp Reisner:
> Friday... ?

me don't have a thing. as long as no one complains
or I have a nightmare, (the moon is full, you know),
nothing will change.

well, one suggestion though.
format ChangeLog so it is suitable for inclusion in drbd.spec,
(plus date and author), and include it there.

bugfixes go into ChangeLog as they are fixed and committed,
not with the cumulative changelog with the next release.
which would be as of now the log message of my last commits:

<!> drbdadm adjust needs to wait for "drbdsetup show" to die before it calls
    drbdsetup again, or we have a race with the ioctl failing because of the
    zombie still holding an open reference on the drbd device!  and, just in
    case, add an explicit close on the drbd device in drbdsetup, too.
 -  fix for debian: missing KDIR=$(KSRC) [by Bernd Schultze]
 -  some comments, string constants, whitespace fixes
 -  make kernel-patch updates drbd_buildtag.c just before the patch is generated

<!> io_errors on READA are always passed on
 -  fixed the resync status overflow in drbd_resync_finished,
    added missig changelog item for it
 -  account for sync paused state in syncer statistics
 -  added dependencies for drbd_buildtag.c in drbd/Makefile
 -  copy'n'paste error in printk error reporting

mach ich mal morgen oder so.

	lge
