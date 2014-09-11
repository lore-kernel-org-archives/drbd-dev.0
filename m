Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A9CA3101E071
	for <drbd-dev@lists.linbit.com>; Thu, 11 Sep 2014 14:29:15 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Date: Thu, 11 Sep 2014 14:29:09 +0200
Message-Id: <1410438553-30440-6-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1410438553-30440-1-git-send-email-philipp.reisner@linbit.com>
References: <1410438553-30440-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 5/9] drbd: Get rid of the __no_warn and
	__cond_lock macros
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

From: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>

These macros can easily be replaced with its definition.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h    | 11 ++++++-----
 drivers/block/drbd/drbd_worker.c |  9 ++++++---
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index f424dc0..9b22f8f 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -61,8 +61,6 @@
 # define __must_hold(x)
 #endif
 
-#define __no_warn(lock, stmt) do { __acquire(lock); stmt; __release(lock); } while (0)
-
 /* module parameter, defined in drbd_main.c */
 extern unsigned int minor_count;
 extern bool disable_sendpage;
@@ -2100,12 +2098,15 @@ static inline bool is_sync_state(enum drbd_conns connection_state)
 
 /**
  * get_ldev() - Increase the ref count on device->ldev. Returns 0 if there is no ldev
- * @M:		DRBD device.
+ * @_device:		DRBD device.
+ * @_min_state:		Minimum device state required for success.
  *
  * You have to call put_ldev() when finished working with device->ldev.
  */
-#define get_ldev(M) __cond_lock(local, _get_ldev_if_state(M,D_INCONSISTENT))
-#define get_ldev_if_state(M,MINS) __cond_lock(local, _get_ldev_if_state(M,MINS))
+#define get_ldev_if_state(_device, _min_state)				\
+	(_get_ldev_if_state((_device), (_min_state)) ?			\
+	 ({ __acquire(x); true; }) : false)
+#define get_ldev(_device) get_ldev_if_state(_device, D_INCONSISTENT)
 
 static inline void put_ldev(struct drbd_device *device)
 {
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 6e01e62..b20cd21 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1853,9 +1853,12 @@ static void drbd_ldev_destroy(struct drbd_device *device)
 	device->resync = NULL;
 	lc_destroy(device->act_log);
 	device->act_log = NULL;
-	__no_warn(local,
-		drbd_free_ldev(device->ldev);
-		device->ldev = NULL;);
+
+	__acquire(local);
+	drbd_free_ldev(device->ldev);
+	device->ldev = NULL;
+	__release(local);
+
 	clear_bit(GOING_DISKLESS, &device->flags);
 	wake_up(&device->misc_wait);
 }
-- 
1.9.1

