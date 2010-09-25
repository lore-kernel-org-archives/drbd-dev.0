Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 081B11088BF7
	for <drbd-dev@lists.linbit.com>; Sat, 25 Sep 2010 13:11:25 +0200 (CEST)
Resent-Message-ID: <20100925111125.GD12409@barkeeper1-xen.linbit>
Message-ID: <4C9DD673.1060403@gmail.com>
Date: Sat, 25 Sep 2010 13:01:07 +0200
From: Deftunix <deftunix@gmail.com>
MIME-Version: 1.0
To: drbd-user@lists.linbit.com
Content-Type: multipart/mixed; boundary="------------010309020308070306040809"
Subject: [Drbd-dev] DRBD 8.3.7 user/Makefile.in patch
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.
--------------010309020308070306040809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

i've found a little problem when installing drbd 8.3.7 from
source. It installs binary only related to $(DESTDIR) disregarding
$(sbindir).

Kind regards,

	-- deftunix

--------------010309020308070306040809
Content-Type: text/plain;
 name="user_Makefile.in.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="user_Makefile.in.patch"

--- drbd-8.3.7/user/Makefile.in.orig    2010-01-13 17:04:50.000000000 +0100
+++ drbd-8.3.7/user/Makefile.in         2010-09-25 12:26:17.963038793 +0200
@@ -98,23 +98,24 @@ distclean: clean
 
 install:
 ifeq ($(WITH_UTILS),yes)
-       install -d $(DESTDIR)/sbin/
+       install -d $(DESTDIR)$(sbindir)
        install -d $(DESTDIR)$(localstatedir)/lib/drbd
        install -d $(DESTDIR)$(localstatedir)/lock
        if getent group haclient > /dev/null 2> /dev/null ; then        \
-               install -g haclient -m 4750 drbdsetup $(DESTDIR)/sbin/ ;        \
-               install -g haclient -m 4750 drbdmeta $(DESTDIR)/sbin/ ; \
-               install -m 755 drbdadm $(DESTDIR)/sbin/ ;               \
+               install -g haclient -m 4750 drbdsetup $(DESTDIR)$(sbindir)/ ;   \
+               install -g haclient -m 4750 drbdmeta $(DESTDIR)$(sbindir)/ ;    \
+               install -m 755 drbdadm $(DESTDIR)$(sbindir)/ ;          \
        else                                                            \
-               install -m 755 drbdsetup $(DESTDIR)/sbin/ ;             \
-               install -m 755 drbdmeta $(DESTDIR)/sbin/ ;              \
-               install -m 755 drbdadm $(DESTDIR)/sbin/ ;               \
+               install -m 755 drbdsetup $(DESTDIR)$(sbindir)/ ;                \
+               install -m 755 drbdmeta $(DESTDIR)$(sbindir)/ ;         \
+               install -m 755 drbdadm $(DESTDIR)$(sbindir)/ ;          \
        fi
 endif
 
 uninstall:
-       rm -f $(DESTDIR)/sbin/drbdsetup
-       rm -f $(DESTDIR)/sbin/drbdadm
+       rm -f $(DESTDIR)$(sbindir)/drbdsetup
+       rm -f $(DESTDIR)$(sbindir)/drbdmeta
+       rm -f $(DESTDIR)$(sbindir)/drbdadm
 
 spell:
        for f in drbdadm_adjust.c drbdadm_main.c drbdadm_parser.c drbdadm_usage_cnt.c drbdmeta.c drbdsetup.c drbdtool_common.c; do \

--------------010309020308070306040809--
