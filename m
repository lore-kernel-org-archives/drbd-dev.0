Return-Path: <lists@aj.net-lab.net>
Received: from mx1.net-lab.net (ns1.net-lab.net [80.69.32.3])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id C93862E0378E
	for <drbd-dev@lists.linbit.com>; Fri,  9 Mar 2007 23:16:22 +0100 (CET)
Received: from localhost (mx1 [80.69.32.18])
	by mx1.net-lab.net (Postfix) with ESMTP id 4CD621CBA6633
	for <drbd-dev@lists.linbit.com>; Fri,  9 Mar 2007 23:16:17 +0100 (CET)
Received: from mx1.net-lab.net ([80.69.32.18])
	by localhost (mx1.net-lab.net [80.69.32.18]) (amavisd-new, port 10024)
	with ESMTP id cO9TtN4KHH1b for <drbd-dev@lists.linbit.com>;
	Fri,  9 Mar 2007 23:16:15 +0100 (CET)
Received: from [192.168.1.49] (adsl-dynamic-242-6.deep.ch [217.71.242.6])
	by mx1.net-lab.net (Postfix) with ESMTP id 966A81CBA6627
	for <drbd-dev@lists.linbit.com>; Fri,  9 Mar 2007 23:16:15 +0100 (CET)
Message-ID: <45F1DCB7.3020303@aj.net-lab.net>
Date: Fri, 09 Mar 2007 23:16:23 +0100
From: Andreas John <lists@aj.net-lab.net>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] make KDIR=... kernel-patch fails
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello,
I try to patch drbd into the kernel. IIRC this is not longer possible
since late 0.7.x released (>=.22 ??).

Currently even on 8.0.0 and 8.0.1 the helper scrips fails on a 2.6.20.1:

----
buildbox-etch:/usr/src/linux-vserver/linux-2.6.20.1/drbd-8.0.1# make
KDIR=/usr/src/linux-vserver/linux-2.6.20.1 kernel-patch
make -C drbd drbd_buildtag.c
make[1]: Entering directory
`/usr/src/linux-vserver/linux-2.6.20.1/drbd-8.0.1/drbd'
make[1]: Leaving directory
`/usr/src/linux-vserver/linux-2.6.20.1/drbd-8.0.1/drbd'
set -o errexit; \
        kbase=$(basename /usr/src/linux-vserver/linux-2.6.20.1); \
        d=patch-$kbase-drbd-8.0.1; \
        test -e $d && cp -fav --backup=numbered $d $d; \
        bash scripts/patch-kernel /usr/src/linux-vserver/linux-2.6.20.1
. > $d
rm: cannot remove `linux-2.6.20.1-drbd/drivers/block/drbd/mempool*': No
such file or directory
make: *** [kernel-patch] Error 1
-----

I can supress the error by patching two lines in the
scripts/patch-kernel script:


-------
--- scripts/patch-kernel.sav    2007-02-25 16:25:42.000000000 +0100
+++ scripts/patch-kernel        2007-02-25 16:26:02.000000000 +0100
@@ -100,9 +100,10 @@
 cp -a $DRBD/drbd/Makefile-2.$KDIR_PATCHLEVEL  $DRBD_SUB/Makefile

 # remove some backports
-test "$KDIR_PATCHLEVEL" = 6 && rm $DRBD_SUB/mempool*
+# remove some backports
+test "$KDIR_PATCHLEVEL" = 6 && if [ -e $DRBD_SUB/mempool* ]; then rm
$DRBD_SUB/mempool*; fi
 grep "HLIST_HEAD_INIT" $KERNEL/include/linux/list.h >/dev/null &&
-       rm $DRBD_SUB/hlist.h
+        if [ -e $DRBD_SUB/hlist.h ]; then rm $DRBD_SUB/hlist.h; fi

 # disable __arch_um__ to_virt() hack
 sed -e 's/^#ifdef __arch_um__/#if 0/' \
---------

The generated patch applies fine, but when compiling the kernel with
drdb as module, the compile runs fails. I assume some part of the patch
is missing.

Kernel Hacking is out-of-scope of my skills, so I simply report here
what I found out.

rgds,
Andreas



