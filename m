Return-Path: <heming.zhao@suse.com>
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
	[209.85.221.45])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 989B016B81E
	for <drbd-dev@lists.linbit.com>; Wed, 14 May 2025 17:04:10 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
	ffacd0b85a97d-3a0b4907a28so1029071f8f.2
	for <drbd-dev@lists.linbit.com>; Wed, 14 May 2025 08:04:10 -0700 (PDT)
From: Heming Zhao <heming.zhao@suse.com>
To: drbd-dev@lists.linbit.com
Subject: [PATCH 1/2] build: changing SUSE release file
Date: Wed, 14 May 2025 23:03:59 +0800
Message-ID: <20250514150402.15848-1-heming.zhao@suse.com>
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

