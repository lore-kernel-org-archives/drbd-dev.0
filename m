Return-Path: <muvarov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1E8AA2E2F9B7
	for <drbd-dev@lists.linbit.com>; Wed, 14 Mar 2007 18:14:11 +0100 (CET)
Received: from [192.168.1.132] (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 0B7708810
	for <drbd-dev@lists.linbit.com>; Wed, 14 Mar 2007 21:14:11 +0400 (SAMT)
Message-ID: <45F82D67.2030105@ru.mvista.com>
Date: Wed, 14 Mar 2007 20:14:15 +0300
From: Maxim Uvarov <muvarov@ru.mvista.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] drbd-8.0.1 add dependencies to Kconfig
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello all,

I have suggestion to add dependencies on CRYPTO and CONNECTOR to the
drbr patches
to avoid compilation errors due to wrong configuration.
What do you think about it? Patches for drbd-8.0.1 are bellow:

Best regards,
Max Uvarov.


--- drbd/Kconfig        2006-11-20 23:05:03.000000000 +0300
+++ drbd/Kconfig_new    2007-03-13 19:42:12.000000000 +0300
@@ -5,6 +5,9 @@
        tristate "DRBD Distributed replicated block device support"
        select INET
        select PROC_FS
+       select CRYPTO
+       select CRYPTO_HMAC
+       select CONNECTOR
        ---help---
          Drbd is a block device which is designed to build high
availability
          clusters.  This is done by mirroring a whole block device via (a



--- drbd/Makefile-2.6   2007-01-16 23:07:55.000000000 +0300
+++ drbd/Makefile-2.6_new       2007-03-13 19:44:27.000000000 +0300
@@ -4,8 +4,4 @@
                drbd_worker.o drbd_receiver.o drbd_req.o drbd_actlog.o \
                lru_cache.o drbd_main.o drbd_strings.o drbd_nl.o

-ifndef CONFIG_CONNECTOR
-       drbd-objs += connector.o cn_queue.o
-endif
-
obj-$(CONFIG_BLK_DEV_DRBD)     += drbd.o

