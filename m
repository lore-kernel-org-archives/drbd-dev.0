Return-Path: <johannes@johannesthoma.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2E943101AC7B
	for <drbd-dev@lists.linbit.com>; Mon,  4 Feb 2019 22:00:20 +0100 (CET)
From: Johannes Thoma <johannes@johannesthoma.com>
To: drbd-dev@lists.linbit.com
Date: Mon,  4 Feb 2019 22:00:14 +0100
Message-Id: <20190204210015.7457-1-johannes@johannesthoma.com>
Subject: [Drbd-dev] [PATCH 1/2] WinDRBD compat headers: might also be
	defined in windrbd_ioctl.h
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

We made windrbd_ioctl.h usable outside drbd-utils: Hence we define
GENL_NAMSIZ where it does not exist. Check in the compat headers
if it is defined already.

This commit only touches WinDRBD specific headers and hence should
not break Linux builds.

Signed-off-by: Johannes Thoma <johannes@johannesthoma.com>
---
 drbd-headers                                | 2 +-
 user/windrbd-compat-headers/linux/netlink.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drbd-headers b/drbd-headers
index b5db4408..da78b84c 160000
--- a/drbd-headers
+++ b/drbd-headers
@@ -1 +1 @@
-Subproject commit b5db4408c02da6ad65e72edd7b254fd6c5ac3dd4
+Subproject commit da78b84ccdd438c21c44c2332040d31f37a77a76
diff --git a/user/windrbd-compat-headers/linux/netlink.h b/user/windrbd-compat-headers/linux/netlink.h
index 0ce1d255..98ec271d 100644
--- a/user/windrbd-compat-headers/linux/netlink.h
+++ b/user/windrbd-compat-headers/linux/netlink.h
@@ -121,7 +121,10 @@ struct nlattr
 /////////////////////////////////////////////////////////////
 // Genetlink.h
 /////////////////////////////////////////////////////////////
+
+#ifndef GENL_NAMSIZ
 #define GENL_NAMSIZ			    16      /* length of family name */
+#endif
 
 struct genlmsghdr
 {
-- 
2.17.0

