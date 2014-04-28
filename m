Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:14 +0200
Message-Id: <1398703415-17780-4-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/24] drbd: Remove drbd_wrappers.h
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

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c   |  1 -
 drivers/block/drbd/drbd_int.h      | 35 ++++++++++++++++++++++++
 drivers/block/drbd/drbd_nl.c       |  1 -
 drivers/block/drbd/drbd_nla.c      |  1 -
 drivers/block/drbd/drbd_req.h      |  1 -
 drivers/block/drbd/drbd_wrappers.h | 54 --------------------------------------
 6 files changed, 35 insertions(+), 58 deletions(-)
 delete mode 100644 drivers/block/drbd/drbd_wrappers.h

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 90ae4ba..7e7b0e1 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -29,7 +29,6 @@
 #include <linux/drbd_limits.h>
 #include <linux/dynamic_debug.h>
 #include "drbd_int.h"
-#include "drbd_wrappers.h"
 
 
 enum al_transaction_types {
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index e7093d4..361a2e9 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1283,6 +1283,10 @@ extern void conn_try_outdate_peer_async(struct drbd_connection *connection);
 extern int drbd_khelper(struct drbd_device *device, char *cmd);
 
 /* drbd_worker.c */
+/* bi_end_io handlers */
+extern void drbd_md_io_complete(struct bio *bio, int error);
+extern void drbd_peer_request_endio(struct bio *bio, int error);
+extern void drbd_request_endio(struct bio *bio, int error);
 extern int drbd_worker(struct drbd_thread *thi);
 enum drbd_ret_code drbd_resync_after_valid(struct drbd_device *device, int o_minor);
 void drbd_resync_after_changed(struct drbd_device *device);
@@ -1401,6 +1405,37 @@ static inline void drbd_tcp_quickack(struct socket *sock)
 			(char*)&val, sizeof(val));
 }
 
+/* sets the number of 512 byte sectors of our virtual device */
+static inline void drbd_set_my_capacity(struct drbd_device *device,
+					sector_t size)
+{
+	/* set_capacity(device->this_bdev->bd_disk, size); */
+	set_capacity(device->vdisk, size);
+	device->this_bdev->bd_inode->i_size = (loff_t)size << 9;
+}
+
+/*
+ * used to submit our private bio
+ */
+static inline void drbd_generic_make_request(struct drbd_device *device,
+					     int fault_type, struct bio *bio)
+{
+	__release(local);
+	if (!bio->bi_bdev) {
+		printk(KERN_ERR "drbd%d: drbd_generic_make_request: "
+				"bio->bi_bdev == NULL\n",
+		       device_to_minor(device));
+		dump_stack();
+		bio_endio(bio, -ENODEV);
+		return;
+	}
+
+	if (drbd_insert_fault(device, fault_type))
+		bio_endio(bio, -EIO);
+	else
+		generic_make_request(bio);
+}
+
 void drbd_bump_write_ordering(struct drbd_connection *connection, enum write_ordering_e wo);
 
 /* drbd_proc.c */
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 5ccbd71..e891cb0 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -34,7 +34,6 @@
 #include "drbd_int.h"
 #include "drbd_protocol.h"
 #include "drbd_req.h"
-#include "drbd_wrappers.h"
 #include <asm/unaligned.h>
 #include <linux/drbd_limits.h>
 #include <linux/kthread.h>
diff --git a/drivers/block/drbd/drbd_nla.c b/drivers/block/drbd/drbd_nla.c
index fa672b6d..b2d4791 100644
--- a/drivers/block/drbd/drbd_nla.c
+++ b/drivers/block/drbd/drbd_nla.c
@@ -1,4 +1,3 @@
-#include "drbd_wrappers.h"
 #include <linux/kernel.h>
 #include <net/netlink.h>
 #include <linux/drbd_genl_api.h>
diff --git a/drivers/block/drbd/drbd_req.h b/drivers/block/drbd/drbd_req.h
index c684c96..07cc8e8 100644
--- a/drivers/block/drbd/drbd_req.h
+++ b/drivers/block/drbd/drbd_req.h
@@ -30,7 +30,6 @@
 #include <linux/slab.h>
 #include <linux/drbd.h>
 #include "drbd_int.h"
-#include "drbd_wrappers.h"
 
 /* The request callbacks will be called in irq context by the IDE drivers,
    and in Softirqs/Tasklets/BH context by the SCSI drivers,
diff --git a/drivers/block/drbd/drbd_wrappers.h b/drivers/block/drbd/drbd_wrappers.h
deleted file mode 100644
index 3db9eba..0000000
--- a/drivers/block/drbd/drbd_wrappers.h
+++ /dev/null
@@ -1,54 +0,0 @@
-#ifndef _DRBD_WRAPPERS_H
-#define _DRBD_WRAPPERS_H
-
-#include <linux/ctype.h>
-#include <linux/mm.h>
-#include "drbd_int.h"
-
-/* see get_sb_bdev and bd_claim */
-extern char *drbd_sec_holder;
-
-/* sets the number of 512 byte sectors of our virtual device */
-static inline void drbd_set_my_capacity(struct drbd_device *device,
-					sector_t size)
-{
-	/* set_capacity(device->this_bdev->bd_disk, size); */
-	set_capacity(device->vdisk, size);
-	device->this_bdev->bd_inode->i_size = (loff_t)size << 9;
-}
-
-#define drbd_bio_uptodate(bio) bio_flagged(bio, BIO_UPTODATE)
-
-/* bi_end_io handlers */
-extern void drbd_md_io_complete(struct bio *bio, int error);
-extern void drbd_peer_request_endio(struct bio *bio, int error);
-extern void drbd_request_endio(struct bio *bio, int error);
-
-/*
- * used to submit our private bio
- */
-static inline void drbd_generic_make_request(struct drbd_device *device,
-					     int fault_type, struct bio *bio)
-{
-	__release(local);
-	if (!bio->bi_bdev) {
-		printk(KERN_ERR "drbd%d: drbd_generic_make_request: "
-				"bio->bi_bdev == NULL\n",
-		       device_to_minor(device));
-		dump_stack();
-		bio_endio(bio, -ENODEV);
-		return;
-	}
-
-	if (drbd_insert_fault(device, fault_type))
-		bio_endio(bio, -EIO);
-	else
-		generic_make_request(bio);
-}
-
-#ifndef __CHECKER__
-# undef __cond_lock
-# define __cond_lock(x,c) (c)
-#endif
-
-#endif
-- 
1.9.1

