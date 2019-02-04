Return-Path: <johannes@johannesthoma.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 30FEE101AC7B
	for <drbd-dev@lists.linbit.com>; Mon,  4 Feb 2019 22:12:33 +0100 (CET)
From: Johannes Thoma <johannes@johannesthoma.com>
To: drbd-dev@lists.linbit.com
Date: Mon,  4 Feb 2019 21:59:52 +0100
Message-Id: <20190204205952.7412-1-johannes@johannesthoma.com>
Subject: [Drbd-dev] [PATCH] Make windrbd_ioctl.h usable without compat
	headers.
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

This includes:
	*) Not to use Linux kernel specific types (u32). Standard
	   C types (uint32_t) are used instead.
	*) Define length of netlink message unless defined.

Since this file is WinDRBD-only it should not break Linux builds.

Signed-off-by: Johannes Thoma <johannes@johannesthoma.com>
---
 windrbd/windrbd_ioctl.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/windrbd/windrbd_ioctl.h b/windrbd/windrbd_ioctl.h
index 0973a6be..22eb8af9 100644
--- a/windrbd/windrbd_ioctl.h
+++ b/windrbd/windrbd_ioctl.h
@@ -2,8 +2,16 @@
 #define WINDRBD_IOCTL_H
 
 #include <sys/types.h>			/* for int64_t */
-#include <linux/types.h>
+
+#ifdef __CYGWIN__
+
+#ifndef GENL_NAMSIZ
+#define GENL_NAMSIZ 16
+#endif
+
+#else
 #include <linux/netlink.h>
+#endif
 
 /* For compiling this for drbd-utils when there are no Windows headers
  * installed, we need this (taken from ReactOS): Hopefully this never
@@ -55,11 +63,11 @@ struct windrbd_ioctl_fault_injection {
 #define IOCTL_WINDRBD_INJECT_FAULTS CTL_CODE(WINDRBD_DEVICE_TYPE, 2, METHOD_BUFFERED, FILE_ANY_ACCESS)
 
 struct windrbd_ioctl_genl_portid {
-	u32 portid;
+	uint32_t portid;
 };
 
 struct windrbd_ioctl_genl_portid_and_multicast_group {
-	u32 portid;
+	uint32_t portid;
         char name[GENL_NAMSIZ];
 };
 
-- 
2.17.0

