Return-Path: <Bart.VanAssche@sandisk.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
	(mail-bl2on0068.outbound.protection.outlook.com [65.55.169.68])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 227331055731
	for <drbd-dev@lists.linbit.com>; Thu, 10 Sep 2015 19:43:25 +0200 (CEST)
To: <drbd-dev@lists.linbit.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <55F1BD96.7010507@sandisk.com>
Date: Thu, 10 Sep 2015 10:27:50 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] [PATCH] drbd-utils: Add support for building without
	manuals
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

When building DRBD for installation on e.g. an appliance no manuals
are needed. Hence add an option to the spec file to build the
drbd-utils RPM without manuals.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
---
 Makefile.in  | 13 +++++++++----
 drbd.spec.in | 19 ++++++++++++++++++-
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index 5365a2c..b80ac52 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -45,7 +45,9 @@ WITH_84_SUPPORT = @WITH_84_SUPPORT@
 # and not in e.g. dash. I'm too lazy to fix it to be compatible.
 SHELL=/bin/bash
 
-SUBDIRS     = user/shared user/v9 user/v84 user/v83 scripts documentation/v83 documentation/v84 documentation/v9
+TOOLS_DIRS  = user/shared user/v9 user/v84 user/v83 scripts
+DOC_DIRS    = documentation/v83 documentation/v84 documentation/v9
+SUBDIRS     = $(TOOLS_DIRS) $(DOC_DIRS)
 
 REL_VERSION := $(shell $(SED) -ne '/^AC_INIT/{s/^[^,]*, *\([^,]*\) *,.*/\1/;p;q}' configure.ac)
 ifdef FORCE
@@ -69,7 +71,7 @@ all: check-submods configure tools
 
 .PHONY: all tools doc
 tools:
-	@ set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
+	@ set -e; for i in $(TOOLS_DIRS); do $(MAKE) -C $$i ; done
 	@ echo -e "\n\tUserland tools build was successful."
 
 doc:
@@ -105,10 +107,13 @@ ifeq ($(WITH_84_SUPPORT),yes)
 	$(MAKE) -C documentation/v84 doc-clean
 endif
 
-install: install-tools
+install: install-tools install-doc
 
 install-tools:
-	@ set -e; for i in $(patsubst drbd,,$(SUBDIRS)); do $(MAKE) -C $$i install; done
+	@ set -e; for i in $(patsubst drbd,,$(TOOLS_DIRS)); do $(MAKE) -C $$i install; done
+
+install-doc:
+	@ set -e; for i in $(patsubst drbd,,$(DOC_DIRS)); do $(MAKE) -C $$i install; done
 
 .NOTPARALLEL clean:
 	@ set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean; done
diff --git a/drbd.spec.in b/drbd.spec.in
index 0271640..300698a 100644
--- a/drbd.spec.in
+++ b/drbd.spec.in
@@ -23,6 +23,7 @@
 # Conditionals
 # Invoke "rpmbuild --without <feature>" or "rpmbuild --with <feature>"
 # to disable or enable specific features
+%bcond_without manual
 %bcond_without udev
 %bcond_without pacemaker
 %bcond_with rgmanager
@@ -181,11 +182,14 @@ This packages includes the DRBD administration tools.
 %config(noreplace) %{_sysconfdir}/drbd.conf
 %dir %{_sysconfdir}/drbd.d
 %config(noreplace) %{_sysconfdir}/drbd.d/global_common.conf
+%if %{without manual}
+%else
 %{_mandir}/man8/drbd-*
 %{_mandir}/man8/drbdsetup-*
 %{_mandir}/man8/drbdadm-*
 %{_mandir}/man5/drbd.conf-*
 %{_mandir}/man8/drbdmeta-*
+%endif
 %doc scripts/drbd.conf.example
 %doc COPYING
 %doc ChangeLog
@@ -310,7 +314,10 @@ resource manager (in v1 compatibility mode).
 %{_sysconfdir}/ha.d/resource.d/drbdupper
 
 %defattr(-,root,root,-)
+%if %{without manual}
+%else
 %{_mandir}/man8/drbddisk-*
+%endif
 %endif # with heartbeat
 
 %if %{with bashcompletion}
@@ -352,11 +359,18 @@ autoconf
     %{?_tmpfilesdir:--with-tmpfilesdir=%{_tmpfilesdir}} \
     --with-initscripttype=%{initscripttype}
 make %{?_smp_mflags}
+%if %{without manual}
+%else
 make doc
+%endif
 
 %install
 rm -rf %{buildroot}
-make install DESTDIR=%{buildroot} CREATE_MAN_LINK=no
+make install-tools DESTDIR=%{buildroot} CREATE_MAN_LINK=no
+%if %{without manual}
+%else
+make install-doc DESTDIR=%{buildroot} CREATE_MAN_LINK=no
+%endif
 
 %if %{with sbinsymlinks}
 # Don't do this if you are already on a /sbin -=> /usr/sbin distro
@@ -380,10 +394,13 @@ rm -rf %{buildroot}
 %else
 chkconfig --add drbd
 %endif
+%if %{without manual}
+%else
 for f in drbd drbdadm drbdmeta drbdsetup; do
     ln -sf $f-8.4.8.gz %{_mandir}/man8/$f.8.gz
 done
 ln -sf drbd.conf-8.4.5.gz %{_mandir}/man5/drbd.conf.5.gz
+%endif
 %if %{without udev}
 for i in `seq 0 15` ; do
     test -b /dev/drbd$i || mknod -m 0660 /dev/drbd$i b 147 $i;
-- 
2.1.4

