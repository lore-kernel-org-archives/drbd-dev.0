Return-Path: <Bart.VanAssche@sandisk.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
	(mail-bl2on0069.outbound.protection.outlook.com [65.55.169.69])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B7C391056444
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jun 2016 19:59:45 +0200 (CEST)
To: "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <28ca5937-746a-731a-9b7b-84d7b12cbba3@sandisk.com>
Date: Mon, 13 Jun 2016 19:29:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] [PATCH for drbd-utils] drbd.spec.in: Make DRBD
 activation during startup optional
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

If DRBD resources are controlled by Pacemaker the startup script
must *not* be run during boot. Hence make it possible to leave
out activation of DRBD during boot.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
---
 configure.ac        |  4 ++--
 drbd.spec.in        | 11 ++++++++---
 scripts/Makefile.in |  8 ++++----
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index 05a73d0..fa008d1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -162,7 +162,7 @@ AC_SUBST(udevrulesdir)
 
 AC_ARG_WITH([initscripttype],
 	    [AS_HELP_STRING([--with-initscripttype=INIT_SCRIPT_TYPE],
-			    [Type of init script to install (sysv|systemd|both). [auto]])
+			    [Type of init script to install (sysv|systemd|both|none). [auto]])
 	    ])
 case "$with_initscripttype" in
 	"")
@@ -171,7 +171,7 @@ case "$with_initscripttype" in
 		else
 			initscripttype=sysv
 		fi ;;
-	sysv|systemd|both)
+	sysv|systemd|both|none)
 		initscripttype=$with_initscripttype ;;
 	*)
 		AC_MSG_ERROR([Illegal value -$with_initscripttype- for option --with-initscripttype]) ;;
diff --git a/drbd.spec.in b/drbd.spec.in
index df7e34c..923c225 100644
--- a/drbd.spec.in
+++ b/drbd.spec.in
@@ -125,8 +125,10 @@ Provides: drbd-utils = 8.3.16
 Conflicts: drbd < 8.3.6
 # These exist in centos extras:
 Conflicts: drbd82 drbd83
+%if %{initscripttype} == "sysv"
 @RPM_REQ_CHKCONFIG_POST@
 @RPM_REQ_CHKCONFIG_PREUN@
+%endif
 
 %description utils
 DRBD mirrors a block device over the network to another machine.
@@ -158,7 +160,8 @@ This packages includes the DRBD administration tools.
 %{_unitdir}/drbd.service
 %{_tmpfilesdir}/drbd.conf
 /lib/drbd/drbd
-%else
+%endif
+%if %{initscripttype} == "sysv"
 %{_initddir}/drbd
 %endif
 %{_sbindir}/drbd-overview
@@ -384,7 +387,8 @@ rm -rf %{buildroot}
 %post utils
 %if %{initscripttype} == "systemd"
 %systemd_post drbd.service
-%else
+%endif
+%if %{initscripttype} == "sysv"
 chkconfig --add drbd
 %endif
 %if %{without manual}
@@ -407,7 +411,8 @@ done
 rm -f %{_mandir}/man5/drbd.conf.5.gz
 %if %{initscripttype} == "systemd"
 %systemd_preun drbd.service
-%else
+%endif
+%if %{initscripttype} == "sysv"
 if [ $1 -eq 0 ]; then
         %{_initrddir}/drbd stop >/dev/null 2>&1
         /sbin/chkconfig --del drbd
diff --git a/scripts/Makefile.in b/scripts/Makefile.in
index e5ebf5d..8759ad5 100644
--- a/scripts/Makefile.in
+++ b/scripts/Makefile.in
@@ -58,12 +58,12 @@ install: install-utils install-udev install-xen install-heartbeat install-pacema
 
 install-utils:
 	install -d $(DESTDIR)$(LIBDIR)
-ifneq ($(initscripttype),systemd)	# "sysv" or "both"
+ifeq ($(subst both,sysv,$(initscripttype)),sysv)
 	install -d $(DESTDIR)$(INITDIR)
 	install -m 755 drbd $(DESTDIR)$(INITDIR)/
 endif
 # yes, debian apparently allows installing both types from the same package
-ifneq ($(initscripttype),sysv)		# "systemd" or "both"
+ifeq ($(subst both,systemd,$(initscripttype)),systemd)
 	install -d $(DESTDIR)$(systemdunitdir)
 	install -m 755 drbd.service $(DESTDIR)$(systemdunitdir)/
 	install -d $(DESTDIR)/lib/drbd/
@@ -153,10 +153,10 @@ clean:
 distclean: clean
 
 uninstall:
-ifneq ($(initscripttype),systemd)	# "sysv" or "both"
+ifeq ($(subst both,sysv,$(initscripttype)),sysv)
 	rm -f $(DESTDIR)$(INITDIR)/drbd
 endif
-ifneq ($(initscripttype),sysv)		# "systemd" or "both"
+ifeq ($(subst both,systemd,$(initscripttype)),systemd)
 	rm -f $(DESTDIR)$(systemdunitdir)/drbd.service
 endif
 	rm -f $(DESTDIR)$(sysconfdir)/ha.d/resource.d/drbddisk
-- 
2.8.4

