Return-Path: <herve.gautier@thalesgroup.com>
Received: from thsmsgxrt11p.thalesgroup.com (thsmsgxrt11p.thalesgroup.com
	[192.54.144.134])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 9AA272E2E60F
	for <drbd-dev@lists.linbit.com>; Fri, 30 Jan 2009 17:30:14 +0100 (CET)
Received: from thsmsgirt24p.corp.thales (unknown [10.33.231.8])
	by thsmsgxrt11p.thalesgroup.com (Postfix) with ESMTP id AC616488AD2
	for <drbd-dev@lists.linbit.com>; Fri, 30 Jan 2009 17:30:13 +0100 (CET)
Received: from thsmsgiav12p.corp.thales (10.33.231.32) by
	thsmsgirt24p.corp.thales (8.5.103)
	id 498178020002B7BA for drbd-dev@lists.linbit.com;
	Fri, 30 Jan 2009 17:30:13 +0100
Received: from smtp-rgs.airsystems.thales (unknown [10.96.29.10])
	by thsmsgirt12p.corp.thales (Postfix) with ESMTP id 80921391BAE
	for <drbd-dev@lists.linbit.com>; Fri, 30 Jan 2009 17:30:13 +0100 (CET)
Received: from smtp-rgs.airsystems.thales (10.96.29.10) by
	smtp-rgs.airsystems.thales (7.3.006)
	id 498309DB0000195C for drbd-dev@lists.linbit.com;
	Fri, 30 Jan 2009 17:30:13 +0100
Received: from smtp-rgs.airsystems.thales (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 6945810781D
	for <drbd-dev@lists.linbit.com>; Fri, 30 Jan 2009 17:30:13 +0100 (CET)
Received: from [10.96.25.49] (pbts174028.bgnx.tatm.thales [10.96.25.49])
	by smtp-rgs.airsystems.thales (Postfix) with ESMTP id 5F1DA107817
	for <drbd-dev@lists.linbit.com>; Fri, 30 Jan 2009 17:30:13 +0100 (CET)
Message-ID: <49832B16.8040302@thalesgroup.com>
Date: Fri, 30 Jan 2009 17:30:14 +0100
From: =?ISO-8859-1?Q?GAUTIER_Herv=E9?= <herve.gautier@thalesgroup.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
References: <49830D03.50002@thalesgroup.com> <49832936.8040802@thalesgroup.com>
In-Reply-To: <49832936.8040802@thalesgroup.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Drbd-dev] Re: [DRBD-user] DRBD 8.2.5 to 8.3.0 upgrade with
 make	PREFIX=/usr/local/drbd
 error: symlink(/usr/local/drbd/etc/drbd.conf,
 /var/lib/drbd//drbd-minor-1.conf): No such file or directory
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


Oups, new patch to be sure of the build (rm -f drbdadm_minor_table.o=20
added) !

Sorry !

--8<----------------------------------------------
diff -Naur drbd-8.3.0/user/drbdadm_minor_table.c=20
drbd-8.3.0-debug/user/drbdadm_minor_table.c
--- drbd-8.3.0/user/drbdadm_minor_table.c       2009-01-30=20
16:19:08.000000000 +0100
+++ drbd-8.3.0-debug/user/drbdadm_minor_table.c 2009-01-30=20
16:43:32.000000000 +0100
@@ -40,7 +40,9 @@
 #include <sys/stat.h>
 #include <string.h>
=20
-#define MINOR_TABLE_DIR "/var/lib/drbd/"
+#include "drbd_prefix.h"
+
+#define MINOR_TABLE_DIR "/var/lib/drbd"
 #define MAX_MINOR 256
=20
 #define MAX_REGISTER_PATH_LEN  1024
@@ -49,7 +51,7 @@
  * it is assumed that sprintf cannot fail :-] */
 void linkname_from_minor(char *buf, int minor)
 {
-       sprintf(buf, "%s/drbd-minor-%d.conf", MINOR_TABLE_DIR, minor);
+       sprintf(buf, "%s%s/drbd-minor-%d.conf", DRBD_PREFIX,=20
MINOR_TABLE_DIR, minor);
 }
=20
 int unregister_minor(int minor)
diff -Naur drbd-8.3.0/user/Makefile drbd-8.3.0-debug/user/Makefile
--- drbd-8.3.0/user/Makefile    2008-12-01 14:35:42.000000000 +0100
+++ drbd-8.3.0-debug/user/Makefile      2009-01-30 17:26:05.000000000 +01=
00
@@ -43,7 +43,12 @@
 drbd_strings.c: ../drbd/drbd_strings.c
        cp $^ $@
=20
-drbdadm: $(drbdadm-obj)
+.PHONY: drbd_prefix.h
+drbd_prefix.h:
+       rm -f drbdadm_minor_table.o
+       echo "#define DRBD_PREFIX       \"$(PREFIX)\"" > drbd_prefix.h
+
+drbdadm: drbd_prefix.h $(drbdadm-obj)
        $(CC) -o $@ $^
=20
 # for debugging:
@@ -66,6 +71,7 @@
        $(CC) -o $@ $^
=20
 clean:
+       rm -f drbd_prefix.h
        rm -f drbdadm_scanner.c drbdmeta_scanner.c
        rm -f drbdsetup drbdadm drbdmeta drbdmeta_unfinished_rewrite *.o
        rm -f drbd_buildtag.c drbd_strings.c
--8<----------------------------------------------

--=20
Herv=E9 GAUTIER

