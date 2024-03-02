Return-Path: <yoann.congal@smile.fr>
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
	[209.85.128.54])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3BBD2420641
	for <drbd-dev@lists.linbit.com>; Sat,  2 Mar 2024 16:47:14 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
	5b1f17b1804b1-412d503f34dso3664595e9.3
	for <drbd-dev@lists.linbit.com>; Sat, 02 Mar 2024 07:47:14 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: drbd-dev@lists.linbit.com
Subject: [PATCH] configure.ac: Add an option to disable host udev version
	checks
Date: Sat,  2 Mar 2024 16:41:30 +0100
Message-Id: <20240302154129.683863-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

In cross-compilation environment, the build host might have an outdated
udev or no udev at all. But the user may still want to build with the
enabled udev rule (for its udev-enabled target).

This patch adds a "--disable-udevchecks" option the disable build host
udev version check at configure-time and unconditionally install the
enabled udev rule. Without this new option, the behavior stays the same
(checks enabled).

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
As a side note, this host udev check triggered a non-reproducility
noticed by the Openembedded/Yocto project[0]. The first build may have been done
on a udev-incompatible host, the second on a compatible one resulting in
a disabled then enabled udev rule.
[0]: https://autobuilder.yocto.io/pub/repro-fail-openembedded/meta-networking/oe-reproducible-20240224-_r8qnlae/packages/diff-html/#reproducibleA-tmp---reproducibleA-tmp-deploy---reproducibleA-tmp-deploy-ipk---reproducibleA-tmp-deploy-ipk-core-------reproducibleA-tmp-deploy-ipk-core-----drbd-utils_-.--.--r-_core----.ipk---data.tar.zst---data.tar---file-list
---
 configure.ac | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index f1d69ea3..4c56d33b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -71,6 +71,11 @@ AC_ARG_WITH([udev],
 	[AS_HELP_STRING([--with-udev],
 			[Enable udev integration])],
 	[WITH_UDEV=$withval])
+AC_ARG_ENABLE([udevchecks],
+	[AS_HELP_STRING([--disable-udevchecks],
+			[Disable host udev version checks])],
+	[],
+	[enable_udevchecks=yes])
 AC_ARG_WITH([xen],
 	[AS_HELP_STRING([--with-xen],
 			[Enable Xen integration])],
@@ -315,7 +320,7 @@ if test -z $GIT; then
    AC_MSG_WARN(Cannot update buildtag without git. You may safely ignore this warning when building from a tarball.)
 fi
 
-if test $UDEVADM = false && test $UDEVINFO = false; then
+if test "x$enable_udevchecks" != "xno" && test $UDEVADM = false && test $UDEVINFO = false; then
    if test "$WITH_UDEV" = "yes"; then
      AC_MSG_WARN([udev support enabled, but neither udevadm nor udevinfo found on this system.])
    fi
@@ -423,7 +428,7 @@ else
     test -z $INITDIR && INITDIR="$sysconfdir/init.d"
 
     dnl Our udev rules file is known to work only with udev >= 85
-    if test "$WITH_UDEV" = "yes"; then
+    if test "x$enable_udevchecks" != "xno" && test "$WITH_UDEV" = "yes"; then
        udev_version=$( set -- $($UDEVADM version); echo $1 )
        if test -z "$udev_version"; then
 	    udev_version=$( set -- $($UDEVINFO -V); echo $3 )
-- 
2.39.2

