Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 08D521056456
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 14:08:27 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 25 Apr 2016 14:07:41 +0200
Message-Id: <1461586077-11581-15-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
References: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 14/30] drbd: allow larger max_discard_sectors
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Make sure we have at least 67 (> AL_UPDATES_PER_TRANSACTION)
al-extents available, and allow up to half of that to be
discarded in one bio.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c | 2 +-
 drivers/block/drbd/drbd_int.h    | 8 ++++----
 include/linux/drbd_limits.h      | 3 +--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 10459a1..1664762 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -256,7 +256,7 @@ bool drbd_al_begin_io_fastpath(struct drbd_device *device, struct drbd_interval
 	unsigned first = i->sector >> (AL_EXTENT_SHIFT-9);
 	unsigned last = i->size == 0 ? first : (i->sector + (i->size >> 9) - 1) >> (AL_EXTENT_SHIFT-9);
 
-	D_ASSERT(device, (unsigned)(last - first) <= 1);
+	D_ASSERT(device, first <= last);
 	D_ASSERT(device, atomic_read(&device->local_cnt) > 0);
 
 	/* FIXME figure out a fast path for bios crossing AL extent boundaries */
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index d818e7d..d82e531 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1347,10 +1347,10 @@ struct bm_extent {
 #define DRBD_MAX_SIZE_H80_PACKET (1U << 15) /* Header 80 only allows packets up to 32KiB data */
 #define DRBD_MAX_BIO_SIZE_P95    (1U << 17) /* Protocol 95 to 99 allows bios up to 128KiB */
 
-/* For now, don't allow more than one activity log extent worth of data
- * to be discarded in one go. We may need to rework drbd_al_begin_io()
- * to allow for even larger discard ranges */
-#define DRBD_MAX_DISCARD_SIZE	AL_EXTENT_SIZE
+/* For now, don't allow more than half of what we can "activate" in one
+ * activity log transaction to be discarded in one go. We may need to rework
+ * drbd_al_begin_io() to allow for even larger discard ranges */
+#define DRBD_MAX_DISCARD_SIZE	(AL_UPDATES_PER_TRANSACTION/2*AL_EXTENT_SIZE)
 #define DRBD_MAX_DISCARD_SECTORS (DRBD_MAX_DISCARD_SIZE >> 9)
 
 extern int  drbd_bm_init(struct drbd_device *device);
diff --git a/include/linux/drbd_limits.h b/include/linux/drbd_limits.h
index a351c40..ddac684 100644
--- a/include/linux/drbd_limits.h
+++ b/include/linux/drbd_limits.h
@@ -126,8 +126,7 @@
 #define DRBD_RESYNC_RATE_DEF 250
 #define DRBD_RESYNC_RATE_SCALE 'k'  /* kilobytes */
 
-  /* less than 7 would hit performance unnecessarily. */
-#define DRBD_AL_EXTENTS_MIN  7
+#define DRBD_AL_EXTENTS_MIN  67
   /* we use u16 as "slot number", (u16)~0 is "FREE".
    * If you use >= 292 kB on-disk ring buffer,
    * this is the maximum you can use: */
-- 
1.9.1

