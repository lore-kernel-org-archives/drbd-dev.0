Return-Path: <herve.gautier@thalesgroup.com>
Received: from thsmsgxrt13p.thalesgroup.com (thsmsgxrt13p.thalesgroup.com
	[192.54.144.136])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id F1FCA2E2E60F
	for <drbd-dev@lists.linbit.com>; Fri, 30 Jan 2009 17:27:38 +0100 (CET)
Message-ID: <49832936.8040802@thalesgroup.com>
Date: Fri, 30 Jan 2009 17:22:14 +0100
From: =?ISO-8859-1?Q?GAUTIER_Herv=E9?= <herve.gautier@thalesgroup.com>
MIME-Version: 1.0
To: drbd-user@lists.linbit.com, drbd-dev@lists.linbit.com
References: <49830D03.50002@thalesgroup.com>
In-Reply-To: <49830D03.50002@thalesgroup.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Drbd-dev] Re: [DRBD-user] DRBD 8.2.5 to 8.3.0 upgrade with make
 PREFIX=/usr/local/drbd error: symlink(/usr/local/drbd/etc/drbd.conf,
 /var/lib/drbd//drbd-minor-1.conf): No such file or directory
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


Hi again,

Well, I don't know what is this /var/lib/drbd directory, but here is a=20
patch in order to take in account the "make PREFIX=3D" command

Tell me if it is OK for you.

And so, last question, what is the aim of this directory ? I have seen=20
drbdadm create symbolic link to the configuration file, but why ?


--8<-------------------------------------------------
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
+++ drbd-8.3.0-debug/user/Makefile      2009-01-30 17:12:25.000000000 +01=
00
@@ -43,7 +43,11 @@
 drbd_strings.c: ../drbd/drbd_strings.c
        cp $^ $@
=20
-drbdadm: $(drbdadm-obj)
+.PHONY: drbd_prefix.h
+drbd_prefix.h:
+       echo "#define DRBD_PREFIX       \"$(PREFIX)\"" > drbd_prefix.h
+
+drbdadm: drbd_prefix.h $(drbdadm-obj)
        $(CC) -o $@ $^
=20
 # for debugging:
@@ -66,6 +70,7 @@
        $(CC) -o $@ $^
=20
 clean:
+       rm -f drbd_prefix.h
        rm -f drbdadm_scanner.c drbdmeta_scanner.c
        rm -f drbdsetup drbdadm drbdmeta drbdmeta_unfinished_rewrite *.o
        rm -f drbd_buildtag.c drbd_strings.c
--8<-------------------------------------------------



GAUTIER Herv=E9 a =E9crit :
>
> Hi !
>
> On a test machine, DRBD 8.2.5 was running, built from source with=20
> "make all && make install"
> Configuration file is /usr/local/drbd-8.2.5/etc/drbd.conf
> DRBD module is /lib/modules/`uname -r`/kernel/drivers/block/drbd.ko
> User DRBD tools drbd{adm|meta|setup}are in /sbin
> I have got a symbolic link /usr/local/drbd -> /usr/local/drbd-8.2.5
>
> Then I stop DRBD, put the 8.3.0 source in /usr/local/drbd-8.3.0 and=20
> replace the symbolic link /usr/local/drbd -> /usr/local/drbd-8.2.5=20
> with /usr/local/drbd -> /usr/local/drbd-8.3.0
> I have built DRBD 8.3.0 from source with "make PREFIX=3D/usr/local/drbd=
=20
> all && make PREFIX=3D/usr/local/drbd install".
> Configuration file is in /usr/local/drbd-8.3.0/etc/drbd.conf (same as=20
> before)
> DRBD module is /usr/local/drbd-8.3.0/lib/modules/`uname=20
> -r`/kernel/drivers/block/drbd.ko
> User DRBD tools drbd{adm|meta|setup}are in /usr/local/drbd-8.3.0/sbin
> At the installation I can see a new empty directory:=20
> /usr/local/drbd-8.3.0/var/lib/drbd
>
> What is this new directory ?
>
> Old module is always installed in /lib/modules/`uname=20
> -r`/kernel/drivers/block/drbd.ko but not used. Now I use insmod=20
> /usr/local/drbd-8.3.0/lib/modules/`uname=20
> -r`/kernel/drivers/block/drbd.ko and /proc/drbd show me 8.3.0
> PATH=3D/usr/local/drbd/sbin:$PATH in order to get first the new user to=
ols
>
> Starting DRBD 8.3.0, using the resource defined under the 8.2.5=20
> version, all is OK, but when I issue the following commands, I have got=
:
>
> --8<-------------------------------------------------
> # lsmod | grep drbd
> # drbdadm -c /usr/local/drbd/etc/drbd.conf dstate drbd_resource1
> Consistent/DUnknown
> # insmod /usr/local/drbd/lib/modules/`uname=20
> -r`/kernel/drivers/block/drbd.ko
> # lsmod | grep drbd
> drbd                  238516  0
> # drbdadm -c /usr/local/drbd/etc/drbd.conf dstate drbd_resource1
> Consistent/DUnknown
> # drbdadm -c /usr/local/drbd/etc/drbd.conf up drbd_resource1
> symlink(/usr/local/drbd-8.3.0/etc/drbd.conf,=20
> /var/lib/drbd//drbd-minor-0.conf): No such file or directory
> symlink(/usr/local/drbd-8.3.0/etc/drbd.conf,=20
> /var/lib/drbd//drbd-minor-0.conf): No such file or directory
> symlink(/usr/local/drbd-8.3.0/etc/drbd.conf,=20
> /var/lib/drbd//drbd-minor-0.conf): No such file or directory
> # drbdadm -c /usr/local/drbd/etc/drbd.conf dstate drbd_resource1
> UpToDate/DUnknown
> symlink(/usr/local/drbd-8.3.0/etc/drbd.conf,=20
> /var/lib/drbd//drbd-minor-0.conf): No such file or directory
> # drbdadm -c /usr/local/drbd/etc/drbd.conf cstate drbd_resource1
> WFConnection
> symlink(/usr/local/drbd-8.3.0/etc/drbd.conf,=20
> /var/lib/drbd//drbd-minor-0.conf): No such file or directory
> # drbdadm -c /usr/local/drbd/etc/drbd.conf role drbd_resource1
> Secondary/Unknown
> symlink(/usr/local/drbd-8.3.0/etc/drbd.conf,=20
> /var/lib/drbd//drbd-minor-0.conf): No such file or directory
> --8<-------------------------------------------------
>
> So, I think my symbolic link /usr/local/drbd -> /usr/local/drbd-8.3.0=20
> is the problem, but I don't understand why ?
>
> I can't find any information about this new var/lib/drbd directory.
> Thank in advance for any clue.
>
> If it can help, here is my /usr/local/drbd/drbd.conf
>
> --8<-------------------------------------------------
> global {
>   usage-count no;
> }
>
> common {
>   net {
>      after-sb-0pri discard-older-primary;
>      after-sb-1pri discard-secondary;
>      after-sb-2pri disconnect;
>   }
>   syncer {
>      rate 31M;
>   }
> }
>
> resource drbd_resource1 {
>   protocol C;
>
>   syncer {
>      verify-alg crc32c;
>   }
>
>   disk {
>      on-io-error detach;
>   }
>
>   on rh4-1 {
>      device    /dev/drbd0;
>      disk      /dev/cciss/c0d1;
>      address   192.168.11.104:7789;
>      meta-disk internal;
>   }
>   on rh4-2 {
>      device    /dev/drbd0;
>      disk      /dev/cciss/c0d1;
>      address   192.168.11.105:7789;
>      meta-disk internal;
>   }
> }
> --8<-------------------------------------------------
>
>
>

--=20
Herv=E9

