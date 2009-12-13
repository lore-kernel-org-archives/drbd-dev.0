Return-Path: <lars.ellenberg@linbit.com>
Received: from racke.rauchzart (p548CC653.dip.t-dialin.net [84.140.198.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPSA id 3AF4E1086412
	for <drbd-dev@lists.linbit.com>; Sun, 13 Dec 2009 22:23:34 +0100 (CET)
Resent-Message-ID: <20091213212332.GA3768@racke>
From: Huang Weiyi <weiyi.huang@gmail.com>
To: drbd-dev@lists.linbit.com
Date: Sun, 13 Dec 2009 22:05:03 +0800
Message-Id: <1260713103-5908-1-git-send-email-weiyi.huang@gmail.com>
Cc: Huang Weiyi <weiyi.huang@gmail.com>, drbd-user@lists.linbit.com
Subject: [Drbd-dev] [PATCH 1/6] drbd: remove unused #include
	<linux/version.h>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Remove unused #include <linux/version.h>('s) in
  drivers/block/drbd/drbd_main.c
  drivers/block/drbd/drbd_receiver.c
  drivers/block/drbd/drbd_worker.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 drivers/block/drbd/drbd_main.c     |    1 -
 drivers/block/drbd/drbd_receiver.c |    1 -
 drivers/block/drbd/drbd_worker.c   |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 157d1e4..c4e56ae 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -27,7 +27,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/drbd.h>
 #include <asm/uaccess.h>
 #include <asm/types.h>
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index c548f24..259c135 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -28,7 +28,6 @@
 #include <asm/uaccess.h>
 #include <net/sock.h>
 
-#include <linux/version.h>
 #include <linux/drbd.h>
 #include <linux/fs.h>
 #include <linux/file.h>
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index ed8796f..523b88b 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -24,7 +24,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/drbd.h>
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
-- 
1.6.1.3

