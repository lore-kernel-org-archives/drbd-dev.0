Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C3193105570E
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BD60B4448B0
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:46 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id PDzx4WzwrUh5 for <drbd-dev@lists.linbit.com>;
	Thu,  7 May 2015 11:35:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 8668B449119
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:46 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id q5-1BZ9rFcSq for <drbd-dev@lists.linbit.com>;
	Thu,  7 May 2015 11:35:46 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id D38AF4448B0
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:45 +0200 (CEST)
Resent-Message-ID: <20150507093545.GA18767@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B65EB100EBF0
	for <drbd-dev@lists.linbit.com>; Wed,  6 May 2015 21:00:47 +0200 (CEST)
From: Denys Vlasenko <dvlasenk@redhat.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Date: Wed,  6 May 2015 21:00:21 +0200
Message-Id: <1430938821-6390-1-git-send-email-dvlasenk@redhat.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>,
	Andreas Gruenbacher <agruen@linbit.com>,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: deinline __drbd_chk_io_error_()
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

The function compiles to 552 bytes of machine code.
On x86 allyesconfig build it has 8 callsites.
Deinlining it shrinks kernel by more than 1k:

    text     data      bss       dec     hex filename
82433898 22255384 20627456 125316738 7782e82 vmlinux.before
82432426 22255384 20627456 125315266 77828c2 vmlinux

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
CC: Andreas Gruenbacher <agruen@linbit.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: Jens Axboe <axboe@fb.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org
---
 drivers/block/drbd/drbd_int.h  | 55 ++----------------------------------------
 drivers/block/drbd/drbd_main.c | 55 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 53 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index b905e98..74a7afd 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1727,60 +1727,9 @@ enum drbd_force_detach_flags {
 };
 
 #define __drbd_chk_io_error(m,f) __drbd_chk_io_error_(m,f, __func__)
-static inline void __drbd_chk_io_error_(struct drbd_device *device,
+void __drbd_chk_io_error_(struct drbd_device *device,
 		enum drbd_force_detach_flags df,
-		const char *where)
-{
-	enum drbd_io_error_p ep;
-
-	rcu_read_lock();
-	ep = rcu_dereference(device->ldev->disk_conf)->on_io_error;
-	rcu_read_unlock();
-	switch (ep) {
-	case EP_PASS_ON: /* FIXME would this be better named "Ignore"? */
-		if (df == DRBD_READ_ERROR || df == DRBD_WRITE_ERROR) {
-			if (__ratelimit(&drbd_ratelimit_state))
-				drbd_err(device, "Local IO failed in %s.\n", where);
-			if (device->state.disk > D_INCONSISTENT)
-				_drbd_set_state(_NS(device, disk, D_INCONSISTENT), CS_HARD, NULL);
-			break;
-		}
-		/* NOTE fall through for DRBD_META_IO_ERROR or DRBD_FORCE_DETACH */
-	case EP_DETACH:
-	case EP_CALL_HELPER:
-		/* Remember whether we saw a READ or WRITE error.
-		 *
-		 * Recovery of the affected area for WRITE failure is covered
-		 * by the activity log.
-		 * READ errors may fall outside that area though. Certain READ
-		 * errors can be "healed" by writing good data to the affected
-		 * blocks, which triggers block re-allocation in lower layers.
-		 *
-		 * If we can not write the bitmap after a READ error,
-		 * we may need to trigger a full sync (see w_go_diskless()).
-		 *
-		 * Force-detach is not really an IO error, but rather a
-		 * desperate measure to try to deal with a completely
-		 * unresponsive lower level IO stack.
-		 * Still it should be treated as a WRITE error.
-		 *
-		 * Meta IO error is always WRITE error:
-		 * we read meta data only once during attach,
-		 * which will fail in case of errors.
-		 */
-		set_bit(WAS_IO_ERROR, &device->flags);
-		if (df == DRBD_READ_ERROR)
-			set_bit(WAS_READ_ERROR, &device->flags);
-		if (df == DRBD_FORCE_DETACH)
-			set_bit(FORCE_DETACH, &device->flags);
-		if (device->state.disk > D_FAILED) {
-			_drbd_set_state(_NS(device, disk, D_FAILED), CS_HARD, NULL);
-			drbd_err(device,
-				"Local IO failed in %s. Detaching...\n", where);
-		}
-		break;
-	}
-}
+		const char *where);
 
 /**
  * drbd_chk_io_error: Handle the on_io_error setting, should be called from all io completion handlers
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 1fc8342..10f27e6 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -146,6 +146,61 @@ static const struct block_device_operations drbd_ops = {
 	.release = drbd_release,
 };
 
+void __drbd_chk_io_error_(struct drbd_device *device,
+		enum drbd_force_detach_flags df,
+		const char *where)
+{
+	enum drbd_io_error_p ep;
+
+	rcu_read_lock();
+	ep = rcu_dereference(device->ldev->disk_conf)->on_io_error;
+	rcu_read_unlock();
+	switch (ep) {
+	case EP_PASS_ON: /* FIXME would this be better named "Ignore"? */
+		if (df == DRBD_READ_ERROR || df == DRBD_WRITE_ERROR) {
+			if (__ratelimit(&drbd_ratelimit_state))
+				drbd_err(device, "Local IO failed in %s.\n", where);
+			if (device->state.disk > D_INCONSISTENT)
+				_drbd_set_state(_NS(device, disk, D_INCONSISTENT), CS_HARD, NULL);
+			break;
+		}
+		/* NOTE fall through for DRBD_META_IO_ERROR or DRBD_FORCE_DETACH */
+	case EP_DETACH:
+	case EP_CALL_HELPER:
+		/* Remember whether we saw a READ or WRITE error.
+		 *
+		 * Recovery of the affected area for WRITE failure is covered
+		 * by the activity log.
+		 * READ errors may fall outside that area though. Certain READ
+		 * errors can be "healed" by writing good data to the affected
+		 * blocks, which triggers block re-allocation in lower layers.
+		 *
+		 * If we can not write the bitmap after a READ error,
+		 * we may need to trigger a full sync (see w_go_diskless()).
+		 *
+		 * Force-detach is not really an IO error, but rather a
+		 * desperate measure to try to deal with a completely
+		 * unresponsive lower level IO stack.
+		 * Still it should be treated as a WRITE error.
+		 *
+		 * Meta IO error is always WRITE error:
+		 * we read meta data only once during attach,
+		 * which will fail in case of errors.
+		 */
+		set_bit(WAS_IO_ERROR, &device->flags);
+		if (df == DRBD_READ_ERROR)
+			set_bit(WAS_READ_ERROR, &device->flags);
+		if (df == DRBD_FORCE_DETACH)
+			set_bit(FORCE_DETACH, &device->flags);
+		if (device->state.disk > D_FAILED) {
+			_drbd_set_state(_NS(device, disk, D_FAILED), CS_HARD, NULL);
+			drbd_err(device,
+				"Local IO failed in %s. Detaching...\n", where);
+		}
+		break;
+	}
+}
+
 struct bio *bio_alloc_drbd(gfp_t gfp_mask)
 {
 	struct bio *bio;
-- 
1.8.1.4

