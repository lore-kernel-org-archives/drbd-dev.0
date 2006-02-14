Return-Path: <joe.ammond@edwardjones.com>
Received: from nspapmdf-2.edwardjones.com (nspamail-rs.edwardjones.com
	[167.80.244.199])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 0863A16479
	for <drbd-dev@lists.linbit.com>; Tue, 14 Feb 2006 22:09:16 +0100 (CET)
Received: from [192.168.186.47] by nspapmdf-2.edwardjones.com
	(PMDF V6.2-X17 #30672)
	with ESMTP id <0IUP00JQZ43BQJ@nspapmdf-2.edwardjones.com> for
	drbd-dev@lists.linbit.com; Tue, 14 Feb 2006 15:09:11 -0600 (CST)
From: Joe Ammond <joe.ammond@edwardjones.com>
To: drbd-dev@lists.linbit.com
Message-id: <1139951315.8507.26.camel@localhost.localdomain>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8BIT
Subject: [Drbd-dev] DRBD svn and 2.6.16
Reply-To: joe.ammond@edwardjones.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>
Date: Tue, 14 Feb 2006 21:09:17 -0000

I've been using the latest SVN code of DRBD under Xen-unstable
for the past couple of months with good results. However, the
Xen tree recently switched kernels to 2.6.16-rc2, which appears
to have introduced incompatibilities with DRBD. When compiling,
drbd_receiver.c fails:


[root@rc-xen0-04 drbd]# make 
    Calling toplevel makefile of kernel source tree, which I believe is
in
    KDIR=/lib/modules/2.6.16-rc2-xen/build

make -C /lib/modules/2.6.16-rc2-xen/build SUBDIRS=/root/drbd/trunk/drbd
modules
make[1]: Entering directory `/xen/xen-unstable.hg/linux-2.6.16-rc2-xen'
  CC [M]  /root/drbd/trunk/drbd/drbd_buildtag.o
  CC [M]  /root/drbd/trunk/drbd/drbd_receiver.o
/root/drbd/trunk/drbd/drbd_receiver.c: In function
‘drbd_setup_order_type’:
/root/drbd/trunk/drbd/drbd_receiver.c:1793: error: ‘QUEUE_ORDERED_FLUSH’
undeclared (first use in this function)
/root/drbd/trunk/drbd/drbd_receiver.c:1793: error: (Each undeclared
identifier is reported only once
/root/drbd/trunk/drbd/drbd_receiver.c:1793: error: for each function it
appears in.)
/root/drbd/trunk/drbd/drbd_receiver.c:1793: error: array index in
initializer not of integer type
/root/drbd/trunk/drbd/drbd_receiver.c:1793: error: (near initialization
for ‘order_txt’)
/root/drbd/trunk/drbd/drbd_receiver.c:1814: error: too few arguments to
function ‘blk_queue_ordered’
/root/drbd/trunk/drbd/drbd_receiver.c: In function
‘warn_if_differ_considerably’:
/root/drbd/trunk/drbd/drbd_receiver.c:1822: warning: ISO C90 forbids
mixed declarations and code
make[2]: *** [/root/drbd/trunk/drbd/drbd_receiver.o] Error 1
make[1]: *** [_module_/root/drbd/trunk/drbd] Error 2
make[1]: Leaving directory `/xen/xen-unstable.hg/linux-2.6.16-rc2-xen'
make: *** [kbuild] Error 2

From the little debugging I've done, it appears to be related
to the I/O barriers changes. Before I dig into the code, are
there any patches already to support this?


ja.
-- 
Joe Ammond                                  joe.ammond@edwardjones.com
   

