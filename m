Return-Path: <fsimonce@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E1DCC10556C4
	for <drbd-dev@lists.linbit.com>; Tue, 13 Sep 2011 10:49:27 +0200 (CEST)
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8D8nPN8020297
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <drbd-dev@lists.linbit.com>; Tue, 13 Sep 2011 04:49:25 -0400
From: Federico Simoncelli <fsimonce@redhat.com>
To: drbd-dev@lists.linbit.com
Date: Tue, 13 Sep 2011 08:48:59 +0000
Message-Id: <1315903740-3442-1-git-send-email-fsimonce@redhat.com>
Subject: [Drbd-dev] [drbd][PATCH 1/2] build: escape CC environment variable
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This will allow to set CC to multiple commands; useful if you want to
use ccache: export CC="ccache gcc"
---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index e3ab808..724b03f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -130,7 +130,7 @@ AC_PATH_PROG(DPKG_BUILDPACKAGE, dpkg-buildpackage)
 AC_PATH_PROG(UDEVADM, udevadm, [false], [/sbin$PATH_SEPARATOR$PATH])
 AC_PATH_PROG(UDEVINFO, udevinfo, [false], [/sbin$PATH_SEPARATOR$PATH])
 
-if test -z $CC; then
+if test -z "$CC"; then
    if test "$WITH_UTILS" = "yes"; then
       AC_MSG_ERROR([Cannot build utils without a C compiler, either install a compiler or pass the --without-utils option.])
    fi 
-- 
1.7.1

