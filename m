Return-Path: <udo1@udo.hu>
Received: from mail.udo.hu (pumukli.udo.hu [87.229.14.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 63A5C108B5EF
	for <drbd-dev@lists.linbit.com>; Fri, 12 Mar 2010 12:18:42 +0100 (CET)
Received: from localhost ([127.0.0.1] helo=[192.168.0.221])
	by mail.udo.hu with esmtpa (Exim 4.63) (envelope-from <udo1@udo.hu>)
	id 1Nq2t7-0003i2-Ps
	for drbd-dev@lists.linbit.com; Fri, 12 Mar 2010 12:18:42 +0100
Message-ID: <4B9A22DE.8090007@udo.hu>
Date: Fri, 12 Mar 2010 12:17:50 +0100
From: udo1 <udo1@udo.hu>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] OpenSuse 11.2 8.7 Kernel packages not compile
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Developers,

I have checked OpenSuSE 11.2 kernel and it has a patch from the  2.6.32 
kernel

So I have wrote a patch to the drbd 8.3.7

Please check or made a similar modifications to enable OpenSuSE 11.2 usage

--- drbd-8.3.7/drbd/drbd_wrappers.h.orig    2010-03-11 
15:40:17.000000000 +0100
+++ drbd-8.3.7/drbd/drbd_wrappers.h    2010-03-12 11:26:39.000000000 +0100
@@ -121,7 +121,7 @@
   extern BIO_ENDIO_TYPE drbd_endio_write_sec BIO_ENDIO_ARGS(struct bio 
*bio, int error);
   extern BIO_ENDIO_TYPE drbd_endio_pri BIO_ENDIO_ARGS(struct bio *bio, 
int error);

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
+#if (( LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32) ) && ( 
WITHFLIGHTPATCH != 1  ))
   #define part_inc_in_flight(A, B) part_inc_in_flight(A)
   #define part_dec_in_flight(A, B) part_dec_in_flight(A)
   #endif
--- drbd-8.3.7/drbd/Makefile.orig    2010-03-12 11:22:42.000000000 +0100
+++ drbd-8.3.7/drbd/Makefile    2010-03-12 11:59:08.000000000 +0100
@@ -30,6 +30,7 @@
   # The destination "root" directory. Meant to be overridden by
   # packaging scripts.
   DESTDIR ?= /
+WITHFLIGHTPATCH=1

   # since 2.6.16, KERNELRELEASE may be empty,
   # e.g. when building agains some (broken?) linux-header package.
@@ -48,7 +49,7 @@

     include $(DRBDSRC)/Makefile-2.6

-  override EXTRA_CFLAGS += -I$(DRBDSRC)
+  override EXTRA_CFLAGS += -I$(DRBDSRC) 
-DWITHFLIGHTPATCH=$(WITHFLIGHTPATCH)
     # remember KERNELRELEASE for install target
     # .kernelversion can be included in Makefile as well as
     # sourced from shell
--- drbd-8.3.7/configure.orig    2010-03-11 16:59:49.000000000 +0100
+++ drbd-8.3.7/configure    2010-03-12 11:30:02.000000000 +0100
@@ -3254,6 +3254,10 @@
   fi

   fi
+
+#Reset drbd/Makefile
+sed -i 's/WITHFLIGHTPATCH=1/WITHFLIGHTPATCH=0/g' drbd/Makefile
+
   case "$DISTRO" in
        gentoo)
       { $as_echo "$as_me:${as_lineno-$LINENO}: configured for Gentoo." >&5
@@ -3329,6 +3333,10 @@
       if grep -q 'VERSION = 9' /etc/SuSE-release; then
           CFLAGS="-g -O1"
       fi
+    if grep -q 'VERSION = 11.2' /etc/SuSE-release; then
+        echo configure: SuSE 11.2 detected, modifying drbd/Makefile
+        sed -i 's/WITHFLIGHTPATCH=0/WITHFLIGHTPATCH=1/g' drbd/Makefile
+    fi
       ;;
        "")
       { $as_echo "$as_me:${as_lineno-$LINENO}: WARNING: Unable to 
determine what distribution we are running on. Distribution-specific 
features will be disabled." >&5


