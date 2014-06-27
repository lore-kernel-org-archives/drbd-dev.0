Return-Path: <lwang@suse.com>
Received: from victor.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 210E0101AC79
	for <drbd-dev@lists.linbit.com>; Fri, 27 Jun 2014 11:18:41 +0200 (CEST)
From: Liuhua Wang <lwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Fri, 27 Jun 2014 17:16:08 +0800
Message-Id: <1403860568-11553-1-git-send-email-lwang@suse.com>
Subject: [Drbd-dev] [PATCH 1/1] fix drbd.rules to avoid start drbd fail
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

  fix drbd.rules by removing NAME and adding a SYMLINK to kernel node for
  the reason that when drbd configuration has a device name different from
  kernel node, device name will not be created since renaming a kernel node
  fails. So start drbd by pacemaker will fail.

Signed-off-by: Liuhua Wang <lwang@suse.com>
---
 scripts/drbd.rules | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/drbd.rules b/scripts/drbd.rules
index dbdfdba..3c967f0 100644
--- a/scripts/drbd.rules
+++ b/scripts/drbd.rules
@@ -12,4 +12,6 @@
 # having it as one single line avoids those problems.
 #
 # DO NOT WRAP THIS LINE
-SUBSYSTEM=="block", KERNEL=="drbd*", IMPORT{program}="/usr/sbin/drbdadm sh-udev minor-%m", NAME="$env{DEVICE}", SYMLINK="$env{SYMLINK}"
+SUBSYSTEM=="block", KERNEL=="drbd*", IMPORT{program}="/usr/sbin/drbdadm sh-udev minor-%m", SYMLINK="$env{SYMLINK}"
+TEST!="$env{DEVICE}", SYMLINK+="$env{DEVICE}"
+
-- 
1.9.0

