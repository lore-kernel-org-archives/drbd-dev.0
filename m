Return-Path: <michael.d.labriola@gmail.com>
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
	[209.85.222.195])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AB68D420629
	for <drbd-dev@lists.linbit.com>; Sun, 13 Dec 2020 06:07:22 +0100 (CET)
Received: by mail-qk1-f195.google.com with SMTP id 1so12709191qka.0
	for <drbd-dev@lists.linbit.com>; Sat, 12 Dec 2020 21:07:22 -0800 (PST)
From: Michael D Labriola <michael.d.labriola@gmail.com>
To: drbd-dev@lists.linbit.com
Date: Sun, 13 Dec 2020 00:06:59 -0500
Message-Id: <20201213050704.997-4-michael.d.labriola@gmail.com>
In-Reply-To: <20201213050704.997-1-michael.d.labriola@gmail.com>
References: <20201213050704.997-1-michael.d.labriola@gmail.com>
Subject: [Drbd-dev] [PATCH 3/8] drbd: don't include vermagic.h
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

Compilation fails because "This header can be included from kernel/module.c
or *.mod.c only".  Leaving it out seems to work just fine.

Signed-off-by: Michael D Labriola <michael.d.labriola@gmail.com>
---
 drbd/drbd_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index 98a94a16..fe1a0b31 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -16,7 +16,6 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
-#include <linux/vermagic.h>
 #include <linux/jiffies.h>
 #include <linux/drbd.h>
 #include <linux/uaccess.h>
-- 
2.17.1

