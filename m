Return-Path: <philipp@hug.cx>
Received: from dandelion.nextdomain.net (unknown [62.2.150.10])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 2810714351
	for <drbd-dev@lists.linbit.com>; Wed, 29 Sep 2004 23:40:46 +0200 (CEST)
From: Philipp Hug <philipp@hug.cx>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] 0.7.5 release tomorrow...
Date: Wed, 29 Sep 2004 23:40:41 +0200
References: <200409291054.13765.philipp.reisner@linbit.com>
In-Reply-To: <200409291054.13765.philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZvyWBpww14Ctdy7"
Message-Id: <200409292340.41861.philipp@hug.cx>
Cc: , Reisner@dandelion.nextdomain.net, Philipp@dandelion.nextdomain.net,
	David Krovich <philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_ZvyWBpww14Ctdy7
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Philipp,

Can you please apply this patch to the debian directory or can you give me 
write access to the ./debian/ directory? There are a bunch of renames, 
add/removes in the diff, so it might be easier if I do it myself..
I did change the binary package names to drbd0.7 and drbd0.7-source...
David, do you have some more changes?


Philipp

--Boundary-00=_ZvyWBpww14Ctdy7
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="drbd-debian.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="drbd-debian.diff"

Index: control
===================================================================
--- control	(revision 1573)
+++ control	(working copy)
@@ -6,10 +6,12 @@
 Build-Depends: debhelper (>= 4), debconf-utils, sp, docbook-utils, bison, flex
 Standards-Version: 3.6.1
 
-Package: drbd
+Package: drbd0.7
 Architecture: any
 Section: misc
 Depends: debconf, ${misc:Depends}
+Conflicts: drbd (<< 0.7)
+Provides: drbd
 Suggests: heartbeat
 Description: RAID 1 over tcp/ip for Linux utilities
  Drbd is a block device which is designed to build high availability
@@ -24,10 +26,12 @@
  .
  Homepage: http://www.drbd.org
 
-Package: drbd-source
+Package: drbd0.7-source
 Architecture: all
 Section: misc
 Depends: module-assistant
+Conflicts: drbd-source (<< 0.7)
+Provides: drbd-source
 Recommends:  dpkg-dev, kernel-package, debhelper (>= 4), debconf-utils
 Description: RAID 1 over tcp/ip for Linux module source
  Drbd is a block device which is designed to build high availability
Index: drbd.install
===================================================================
--- drbd.install	(revision 1573)
+++ drbd.install	(working copy)
@@ -1,5 +0,0 @@
-user/drbdsetup sbin
-user/drbdadm sbin
-scripts/drbd etc/init.d
-scripts/drbddisk etc/ha.d/resource.d
-scripts/drbd.conf etc
Index: control.modules
===================================================================
--- control.modules	(revision 1573)
+++ control.modules	(working copy)
@@ -1,37 +0,0 @@
-Source: drbd
-Section: ha
-Priority: extra
-Maintainer: David Krovich <dkrovich@csee.wvu.edu>
-Build-Depends: debhelper (>= 4), kernel-source, cpio, debconf-utils
-Description: RAID 1 over tcp/ip for Linux
- Drbd is a block device which is designed to build high availability
- clusters by providing a virtual shared device which keeps disks in nodes
- synchronised using TCP/IP. This simulates RAID 1 but avoiding the 
- use of uncommon hardware (shared SCSI buses or Fibre Channel). 
- It is currently limited to fail-over HA clusters.
- .
- This package contains the programs that will control the 
- drbd kernel module provided in drbd-source. You will need a clustering
- service (such as heartbeat) to fully implement it.
- .
- Homepage: http://www.drbd.org
-
-Package: drbd-module-#KVERS#
-Architecture: any
-Recommends:  dpkg-dev, kernel-package, debhelper (>= 4), debconf-utils, drbd
-Description: RAID 1 over tcp/ip for Linux kernel module.
- This package provides the kernel module for linux kernel #KVERS#
- You have to install the drbd package to be able to use it
- .
- Drbd is a block device which is designed to build high availability
- clusters by providing a virtual shared device which keeps disks in nodes
- synchronised using TCP/IP. This simulates RAID 1 but avoiding the 
- use of uncommon hardware (shared SCSI buses or Fibre Channel). 
- It is currently limited to fail-over HA clusters.
- .
- This package contains the programs that will control the 
- drbd kernel module provided in drbd-source. You will need a clustering
- service (such as heartbeat) to fully implement it.
- .
- Homepage: http://www.drbd.org
-
Index: drbd.postrm
===================================================================
--- drbd.postrm	(revision 1573)
+++ drbd.postrm	(working copy)
@@ -1,6 +0,0 @@
-#!/bin/sh
-
-if [ "$1" = "purge" ] ; then
-	update-rc.d drbd remove >/dev/null
-fi
-#DEBHELPER#
Index: drbd.docs
===================================================================
--- drbd.docs	(revision 1573)
+++ drbd.docs	(working copy)
@@ -1 +0,0 @@
-documentation/NFS-Server-README.txt
Index: conffiles
===================================================================
--- conffiles	(revision 1573)
+++ conffiles	(working copy)
@@ -1,3 +0,0 @@
-/etc/init.d/drbd
-/etc/drbd.conf
-/etc/ha.d/resource.d/drbddisk
Index: drbd-source.dirs
===================================================================
--- drbd-source.dirs	(revision 1573)
+++ drbd-source.dirs	(working copy)
@@ -1,5 +0,0 @@
-usr/src/modules/drbd/debian
-usr/src/modules/drbd/drbd
-
-
-
Index: control.in.MODULE
===================================================================
--- control.in.MODULE	(revision 1573)
+++ control.in.MODULE	(working copy)
@@ -1,23 +0,0 @@
-Source: drbd
-Section: misc
-Priority: extra
-Maintainer: David Krovich <dkrovich@csee.wvu.edu>
-Build-Depends: debhelper (>= 4), debconf-utils, sp, docbook-utils, kernel-source
-Standards-Version: 3.5.10
-
-Package: drbd-modules-(KERNEL_VERSION)
-Architecture: all
-Section: misc
-Recommends:  dpkg-dev, kernel-package, debhelper (>= 4), debconf-utils
-Description: RAID 1 over tcp/ip for Linux module source
- Drbd is a block device which is designed to build high availability
- clusters by providing a virtual shared device which keeps disks in nodes
- synchronised using TCP/IP. This simulates RAID 1 but avoiding the 
- use of uncommon hardware (shared SCSI buses or Fibre Channel). 
- It is currently limited to fail-over HA clusters.
- .
- This package contains the programs that will control the 
- drbd kernel module provided in drbd-source. You will need a clustering
- service (such as heartbeat) to fully implement it.
- .
- Homepage: http://www.drbd.org
Index: rules.MODULE
===================================================================
--- rules.MODULE	(revision 1573)
+++ rules.MODULE	(working copy)
@@ -1,133 +0,0 @@
-#!/usr/bin/make -f
-# Sample debian/rules that uses debhelper. 
-# GNU copyright 1997 by Joey Hess.
-#
-# This version is for a hypothetical package that builds an
-# architecture-dependant package, as well as an architecture-independent
-# package.
-
-# Uncomment this to turn on verbose mode. 
-#export DH_VERBOSE=1
-
-baseepoch=$(shell expr $(KDREV) : '\([0-9]*\):.*' 2>/dev/null )
-ifneq ($(baseepoch),)
-EPOCH=$(baseepoch):
-endif
-
-REV=$(shell expr $(KDREV) : '[0-9]*:\(.*\)' 2>/dev/null)
-ifeq ($(REV),)
-REV=$(KDREV)
-endif
-
-ARCH=$(shell dpkg --print-architecture)
-PKG_VERSION=$(EPOCH)$(VERSION)+$(REV)
-
-VERSION=$(shell dpkg-parsechangelog | grep ^Version: | cut -d ' ' -f 2)
-
-CHFILE=$(KSRC)/../drbd-source-$(KVERS)_$(PKG_VERSION)_$(ARCH).changes
-
-SMPFLAG=$(shell grep -q '^CONFIG_SMP=y' $(KSRC)/.config && echo "-D__SMP__")
-
-# the main-revision of the kernel
-MAINREV=$(shell echo -n $${KVERS:2:1})
-
-MODNAME=$(shell if [ "$(MAINREV)" -gt "4" ] ;  then \
-		echo -n "drbd.ko"; \
-	else \
-		echo -n "drbd.o"; \
-	fi)
-
-
-
-# This target verifies that we've got the needed variables passed to us.
-# If the user is using make-kpkg (like he should), it won't be a problem.
-# But - some may have a funny preference of using debian/rules directly,
-# so here it is. It's ripped from the lm-sensors rules file, so if I ever
-# meet you, David Z Maze, I'll buy you a beer. :-)
-check:
-	@if [ -z "$(KSRC)" ] ; then \
-		echo "I need KSRC! Please set it on the command line." >&2; \
-		exit 1; \
-	elif [ ! -d "$(KSRC)/include" ] ; then \
-		echo "KRSC is set to $(KRSC), but it does not have a include/" >&2; \
-		echo "subdirectory! Please fix this." >&2; \
-		exit 1; \
-	elif [ -z "$(KVERS)" ] ; then \
-		echo "KVERS is unset, please set it at the command line." >&2; \
-		exit 1; \
-	fi
-
-# This target cleans the source tree and the debian/ subdir. Also moves the
-# original debian/control template back to it's original position (thus
-# overwriting the generated one.
-clean:
-	dh_testdir
-	dh_testroot
-	dh_clean
-
-	sed 's/(KERNEL_VERSION)/dummy/g' debian/control.in > debian/control
-
-	cd drbd && $(MAKE) INCLUDE=-I$(KSRC)/include KERNVER=$(KVERS) KDIR=$(KSRC) clean
-
-# This target builds the kernel module.
-build: build-stamp
-build-stamp: check clean
-	dh_testdir
-	dh_testroot
-
-	cd drbd && $(MAKE)  DRBDSRC=`pwd` SUBDIRS=`pwd` KDIR=$(KSRC)
-
-	touch build-stamp
-
-# This target installs the module to the temporary install directory.
-install: build
-	dh_testdir
-	dh_testroot
-#	install -m 644 -D drbd/$(MODNAME) debian/drbd-modules-$(KVERS)/lib/modules/$(KVERS)/misc/$(MODNAME)
-
-# To conform with Debian policy.
-binary: binary-arch binary-indep
-
-# Generate a control file, and build the Debian package.
-binary-arch: check install
-
-	dh_testdir
-	dh_testroot
-
-	sed 's/(KERNEL_VERSION)/$(KVERS)/g' debian/control.in > \
-		debian/control
-	dh_installdirs lib/modules/$(KVERS)/misc
-	dh_install -m644 drbd/$(MODNAME) lib/modules/$(KVERS)/kernel/drivers/block
-	dh_installdocs
-	dh_installmodules
-	dh_installchangelogs
-	dh_gencontrol -- -v$(PKG_VERSION)
-	dh_fixperms
-	dh_compress
-	dh_installdeb
-	dh_md5sums
-	dh_builddeb --destdir=$(KSRC)/..
-
-# No architecture-independent files to build.
-binary-indep:
-
-kdist_image:
-	$(ROOT_CMD) $(MAKE) $(MFLAGS) -f debian/rules binary
-	$(ROOT_CMD) $(MAKE) $(MFLAGS) -f debian/rules clean
-
-kdist:
-	$(ROOT_CMD) $(MAKE) $(MFLAGS) -f debian/rules clean
-	$(ROOT_CMD) $(MAKE) $(MFLAGS) -f debian/rules binary
-	dpkg-genchanges -b -e"$(KMAINT) <$(KEMAIL)>" -u"$(KSRC)/.." > $(CHFILE)
-	$(ROOT_CMD) $(MAKE) $(MFLAGS) -f debian/rules clean
-
-kdist_configure:
-	# Nothing to do when configured.
-
-kdist_clean:
-	$(ROOT_CMD) $(MAKE) $(MFLAGS) -f debian/rules clean
-
-#compatibility with the old package
-binary-modules: kdist
-
-.PHONY: check clean build install binary binary-arch binary-indep kdist_image kdist kdist_configure kdist_clean binary-modules
Index: compat
===================================================================
--- compat	(revision 0)
+++ compat	(revision 0)
@@ -0,0 +1 @@
+4
Index: Makefile.modules
===================================================================
--- Makefile.modules	(revision 1573)
+++ Makefile.modules	(working copy)
@@ -1,6 +0,0 @@
-all:
-	make -C drbd all
-
-clean:
-	make -C drbd clean
-
Index: changelog
===================================================================
--- changelog	(revision 1573)
+++ changelog	(working copy)
@@ -1,12 +1,12 @@
-drbd (0.7.4-2) unstable; urgency=low
+drbd (0.7.5-1) unstable; urgency=low
 
   * Added bison, flex to Build-Depends
   * Call 'make clean' in drbd directory
   * Upgraded to debian-policy 3.6.1
   * Rewritten debian/rules using module-assistant
+  * Change binary package name to drbd0.7
   * Added myself as Uploader
 
-
  -- Philipp Hug <debian@hug.cx>  Tue, 14 Sep 2004 23:25:12 +0200
 
 drbd (0.7.4-1) unstable; urgency=low
Index: rules
===================================================================
--- rules	(revision 1573)
+++ rules	(working copy)
@@ -17,7 +17,6 @@
 -include $(MA_DIR)/include/generic.make
 -include $(MA_DIR)/include/common-rules.make
 
-
 CFLAGS = -Wall -g
 
 ifneq (,$(findstring noopt,$(DEB_BUILD_OPTIONS)))
@@ -98,24 +97,24 @@
 	dh_installdirs -i
 
 
-	cp -a drbd/* debian/drbd-source/usr/src/modules/drbd/drbd
-	cp Makefile debian/drbd-source/usr/src/modules/drbd
-	cp drbd/linux/drbd_config.h debian/drbd-source/usr/src/modules/drbd
-	mkdir debian/drbd-source/usr/src/modules/drbd/scripts/
-	cp -a scripts/adjust_drbd_config_h.sh debian/drbd-source/usr/src/modules/drbd/scripts/
+	cp -a drbd/* debian/drbd0.7-source/usr/src/modules/drbd/drbd
+	cp Makefile debian/drbd0.7-source/usr/src/modules/drbd
+	cp drbd/linux/drbd_config.h debian/drbd0.7-source/usr/src/modules/drbd
+	mkdir debian/drbd0.7-source/usr/src/modules/drbd/scripts/
+	cp -a scripts/adjust_drbd_config_h.sh debian/drbd0.7-source/usr/src/modules/drbd/scripts/
 
 	# install driver source
-	#cp -a drbd debian/drbd-source/usr/src/modules/drbd/
-	#mkdir debian/drbd-source/usr/src/modules/drbd/scripts/
-	#cp -a scripts/adjust_drbd_config_h.sh debian/drbd-source/usr/src/modules/drbd/scripts/
-	#ln -s drbd debian/drbd-source/usr/src/modules/drbd/Linux-2.4
-	#ln -s drbd debian/drbd-source/usr/src/modules/drbd/Linux-2.6
+	#cp -a drbd debian/drbd0.7-source/usr/src/modules/drbd/
+	#mkdir debian/drbd0.7-source/usr/src/modules/drbd/scripts/
+	#cp -a scripts/adjust_drbd_config_h.sh debian/drbd0.7-source/usr/src/modules/drbd/scripts/
+	#ln -s drbd debian/drbd0.7-source/usr/src/modules/drbd/Linux-2.4
+	#ln -s drbd debian/drbd0.7-source/usr/src/modules/drbd/Linux-2.6
 
 	# install debian/ files
-	cd debian ; cp changelog control compat *.modules.in rules copyright drbd-source/usr/src/modules/drbd/debian
+	cd debian ; cp changelog control compat *.modules.in rules copyright drbd0.7-source/usr/src/modules/drbd/debian
 
 	# tar the stuff
-	cd debian/drbd-source/usr/src/ ; tar pzfvc drbd.tar.gz modules ; rm -rf modules
+	cd debian/drbd0.7-source/usr/src/ ; tar pzfvc drbd0.7.tar.gz modules ; rm -rf modules
 
 	dh_install -i
 
@@ -125,10 +124,6 @@
 	dh_clean -k -s 
 	dh_installdirs -s
 
-	# Add here commands to install the arch part of the package into 
-	# debian/tmp.
-	#$(MAKE) install DESTDIR=$(CURDIR)/debian/drbd
-
 	dh_install -s
 # Must not depend on anything. This is to be called by
 # binary-arch/binary-indep
Index: drbd.postinst
===================================================================
--- drbd.postinst	(revision 1573)
+++ drbd.postinst	(working copy)
@@ -1,14 +0,0 @@
-#!/bin/sh
-
-if [ -x "/etc/init.d/drbd" ]; then
-	update-rc.d drbd defaults 70 8 >/dev/null
-fi
-
-# Make sure /dev/nb[0-7] devices exist
-# cd /dev; for a in `seq 0 7`; do MAKEDEV nb$a; done
-
-for i in `seq 0 15` ; do 
-    test -b /dev/drbd$i || mknod -m 0660 /dev/drbd$i b 147 $i; 
-done
-
-#DEBHELPER#
Index: drbd.prerm
===================================================================
--- drbd.prerm	(revision 1573)
+++ drbd.prerm	(working copy)
@@ -1,6 +0,0 @@
-#!/bin/sh
-
-if [ -x "/etc/init.d/drbd" ]; then
-	/etc/init.d/drbd stop
-fi
-#DEBHELPER#
Index: drbd.manpages
===================================================================
--- drbd.manpages	(revision 1573)
+++ drbd.manpages	(working copy)
@@ -1,5 +0,0 @@
-documentation/drbd.8
-documentation/drbd.conf.5
-documentation/drbdsetup.8
-documentation/drbdadm.8
-
Index: drbd.dirs
===================================================================
--- drbd.dirs	(revision 1573)
+++ drbd.dirs	(working copy)
@@ -1,4 +0,0 @@
-usr/bin
-etc
-etc/init.d
-etc/ha.d/resource.d

--Boundary-00=_ZvyWBpww14Ctdy7--
