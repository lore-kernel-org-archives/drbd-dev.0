Return-Path: <kvapss@gmail.com>
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
	[209.85.218.54])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 43DFE420632
	for <drbd-dev@lists.linbit.com>; Wed, 15 Jun 2022 16:06:51 +0200 (CEST)
Received: by mail-ej1-f54.google.com with SMTP id n10so23468442ejk.5
	for <drbd-dev@lists.linbit.com>; Wed, 15 Jun 2022 07:06:51 -0700 (PDT)
From: Andrei Kvapil <kvapss@gmail.com>
To: drbd-dev@lists.linbit.com
Date: Wed, 15 Jun 2022 16:06:20 +0200
Message-Id: <20220615140620.31630-1-kvapss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Drbd-dev] [PATCH] compat: make spaas url configurable
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

Add opportunity to override SPAAS_URL with local address in case of
building drbd in environments without external internet connectivity.
---
 Makefile                                    | 1 +
 drbd/Makefile                               | 2 ++
 drbd/drbd-kernel-compat/gen_compat_patch.sh | 7 ++++---
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 87c29518..37d7851d 100644
--- a/Makefile
+++ b/Makefile
@@ -37,6 +37,7 @@ DOCKERIMAGESTARGETS = $(addprefix dockerimage.,$(DOCKERIMAGES))
 # Use the SPAAS (spatch as a service) online service
 # Have this as make variable for distributions.
 SPAAS ?= true
+SPAAS_URL ?= https://drbd.io:2020
 
 # default for KDIR/KVER
 ifndef KVER
diff --git a/drbd/Makefile b/drbd/Makefile
index 597cf30f..089e5e3a 100644
--- a/drbd/Makefile
+++ b/drbd/Makefile
@@ -40,7 +40,9 @@ MAKEFLAGS += -rR --no-print-directory
 # Use the SPAAS (spatch as a service) online service
 # Have this as make variable for distributions.
 SPAAS ?= true
+SPAAS_URL ?= https://drbd.io:2020
 export SPAAS
+export SPAAS_URL
 
 # since 2.6.16, KERNELRELEASE may be empty,
 # e.g. when building against some (broken?) linux-header package.
diff --git a/drbd/drbd-kernel-compat/gen_compat_patch.sh b/drbd/drbd-kernel-compat/gen_compat_patch.sh
index c57b961c..b8595722 100644
--- a/drbd/drbd-kernel-compat/gen_compat_patch.sh
+++ b/drbd/drbd-kernel-compat/gen_compat_patch.sh
@@ -125,10 +125,11 @@ else
     echo "  SPAAS    $chksum"
 
     # check if SPAAS is even reachable
-    if ! curl -fsS https://drbd.io:2020/api/v1/hello; then
+    SPAAS_URL=${SPAAS_URL:-https://drbd.io:2020}
+    if ! curl -fsS $SPAAS_URL/api/v1/hello; then
         echo "  ERROR: SPAAS is not reachable! Please check if your network"
         echo "  configuration or some firewall prohibits access to "
-        echo "  https://drbd.io:2020."
+        echo "  $SPAAS_URL."
         exit 1
     fi
 
@@ -136,7 +137,7 @@ else
     rm -f $compat_patch.tmp.header $compat_patch.tmp
     if ! base64 $incdir/compat.h |
 	curl -T - -X POST -o $compat_patch.tmp -D $compat_patch.tmp.header -f \
-	    https://drbd.io:2020/api/v1/spatch/$REL_VERSION
+	    $SPAAS_URL/api/v1/spatch/$REL_VERSION
     then
 	ex=${PIPESTATUS[*]}
 	(
-- 
2.32.0 (Apple Git-132)

