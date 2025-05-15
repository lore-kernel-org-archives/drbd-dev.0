Return-Path: <heming.zhao@suse.com>
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
	[209.85.221.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C0F5A16B84C
	for <drbd-dev@lists.linbit.com>; Thu, 15 May 2025 04:48:26 +0200 (CEST)
Received: by mail-wr1-f43.google.com with SMTP id
	ffacd0b85a97d-3a0b3f62d1aso61182f8f.1
	for <drbd-dev@lists.linbit.com>; Wed, 14 May 2025 19:48:26 -0700 (PDT)
From: Heming Zhao <heming.zhao@suse.com>
To: drbd-dev@lists.linbit.com
Subject: [PATCH v2 1/2] build: changing SUSE release file
Date: Thu, 15 May 2025 10:48:14 +0800
Message-ID: <20250515024817.25717-2-heming.zhao@suse.com>
In-Reply-To: <20250515024817.25717-1-heming.zhao@suse.com>
References: <20250515024817.25717-1-heming.zhao@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: zzhou@suse.com
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

This commit changes /etc/SuSe-release to /etc/os-release.
The SuSe-release file disappeared a long time ago.

Signed-off-by: Heming Zhao <heming.zhao@suse.com>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 282fdf1584e3..883fe3e5cdb3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -402,7 +402,7 @@ else
    if test -z $DISTRO; then
       AC_CHECK_FILE(/etc/redhat-release, [DISTRO="redhat"])
       AC_CHECK_FILE(/etc/debian_version, [DISTRO="debian"])
-      AC_CHECK_FILE(/etc/SuSE-release, [DISTRO="suse"])
+      AC_CHECK_FILE(/etc/os-release, [DISTRO="suse"])
    fi
    case "$DISTRO" in
         redhat)
@@ -439,7 +439,7 @@ else
 	    # RPM_REQ_HEARTBEAT="Requires: heartbeat"
 
 	    # Unfortunately gcc on SLES9 is broken with -O2. Works with -O1
-	    if grep -q 'VERSION = 9' /etc/SuSE-release; then
+	    if grep -q 'VERSION = 9' /etc/os-release; then
 		    CFLAGS="-g -O1"
 	    fi
 	    ;;
-- 
2.43.0

