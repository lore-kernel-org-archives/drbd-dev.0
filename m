Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id CE6FC1055F60
	for <drbd-dev@lists.linbit.com>; Tue,  4 Aug 2015 14:57:00 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue,  4 Aug 2015 14:56:41 +0200
Message-Id: <1438693003-17554-18-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1438693003-17554-1-git-send-email-philipp.reisner@linbit.com>
References: <1438693003-17554-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 17/19] drbd: avoid potential deadlock during
	handshake
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

During handshake communication, we also reconsider our device size,
using drbd_determine_dev_size(). Just in case we need to change the
offsets or layout of our on-disk metadata, we lock out application
and other meta data IO, and wait for the activity log to be "idle"
(no more referenced extents).

If this handshake happens just after a connection loss, with a fencing
policy of "resource-and-stonith", we have frozen IO.

If, additionally, the activity log was "starving" (too many incoming
random writes at that point in time), it won't become idle, ever,
because of the frozen IO, and this would be a lockup of the receiver
thread, and consquentially of DRBD.

Previous logic (re-)initialized with a special "empty" transaction
block, which required the activity log to fully drain first.

Instead, write out some standard activity log transactions.
Using lc_try_lock_for_transaction() instead of lc_try_lock() does not
care about pending activity log references, avoiding the potential
deadlock.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c | 19 +++++++++++--------
 drivers/block/drbd/drbd_int.h    |  2 +-
 drivers/block/drbd/drbd_nl.c     | 33 +++++++++++++++++++--------------
 3 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index f83dcca..5c3f35b 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -614,21 +614,24 @@ void drbd_al_shrink(struct drbd_device *device)
 	wake_up(&device->al_wait);
 }
 
-int drbd_initialize_al(struct drbd_device *device, void *buffer)
+int drbd_al_initialize(struct drbd_device *device, void *buffer)
 {
 	struct al_transaction_on_disk *al = buffer;
 	struct drbd_md *md = &device->ldev->md;
-	sector_t al_base = md->md_offset + md->al_offset;
 	int al_size_4k = md->al_stripes * md->al_stripe_size_4k;
 	int i;
 
-	memset(al, 0, 4096);
-	al->magic = cpu_to_be32(DRBD_AL_MAGIC);
-	al->transaction_type = cpu_to_be16(AL_TR_INITIALIZED);
-	al->crc32c = cpu_to_be32(crc32c(0, al, 4096));
+	__al_write_transaction(device, al);
+	/* There may or may not have been a pending transaction. */
+	spin_lock_irq(&device->al_lock);
+	lc_committed(device->act_log);
+	spin_unlock_irq(&device->al_lock);
 
-	for (i = 0; i < al_size_4k; i++) {
-		int err = drbd_md_sync_page_io(device, device->ldev, al_base + i * 8, WRITE);
+	/* The rest of the transactions will have an empty "updates" list, and
+	 * are written out only to provide the context, and to initialize the
+	 * on-disk ring buffer. */
+	for (i = 1; i < al_size_4k; i++) {
+		int err = __al_write_transaction(device, al);
 		if (err)
 			return err;
 	}
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 349b147..9f1ff2b 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1667,7 +1667,7 @@ extern int __drbd_change_sync(struct drbd_device *device, sector_t sector, int s
 #define drbd_rs_failed_io(device, sector, size) \
 	__drbd_change_sync(device, sector, size, RECORD_RS_FAILED)
 extern void drbd_al_shrink(struct drbd_device *device);
-extern int drbd_initialize_al(struct drbd_device *, void *);
+extern int drbd_al_initialize(struct drbd_device *, void *);
 
 /* drbd_nl.c */
 /* state info broadcast */
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 06ef824..8650906 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -903,15 +903,14 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 	int md_moved, la_size_changed;
 	enum determine_dev_size rv = DS_UNCHANGED;
 
-	/* race:
-	 * application request passes inc_ap_bio,
-	 * but then cannot get an AL-reference.
-	 * this function later may wait on ap_bio_cnt == 0. -> deadlock.
+	/* We may change the on-disk offsets of our meta data below.  Lock out
+	 * anything that may cause meta data IO, to avoid acting on incomplete
+	 * layout changes or scribbling over meta data that is in the process
+	 * of being moved.
 	 *
-	 * to avoid that:
-	 * Suspend IO right here.
-	 * still lock the act_log to not trigger ASSERTs there.
-	 */
+	 * Move is not exactly correct, btw, currently we have all our meta
+	 * data in core memory, to "move" it we just write it all out, there
+	 * are no reads. */
 	drbd_suspend_io(device);
 	buffer = drbd_md_get_buffer(device, __func__); /* Lock meta-data IO */
 	if (!buffer) {
@@ -919,9 +918,6 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 		return DS_ERROR;
 	}
 
-	/* no wait necessary anymore, actually we could assert that */
-	wait_event(device->al_wait, lc_try_lock(device->act_log));
-
 	prev_first_sect = drbd_md_first_sector(device->ldev);
 	prev_size = device->ldev->md.md_size_sect;
 	la_size_sect = device->ldev->md.la_size_sect;
@@ -997,20 +993,29 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 		 * Clear the timer, to avoid scary "timer expired!" messages,
 		 * "Superblock" is written out at least twice below, anyways. */
 		del_timer(&device->md_sync_timer);
-		drbd_al_shrink(device); /* All extents inactive. */
 
+		/* We won't change the "al-extents" setting, we just may need
+		 * to move the on-disk location of the activity log ringbuffer.
+		 * Lock for transaction is good enough, it may well be "dirty"
+		 * or even "starving". */
+		wait_event(device->al_wait, lc_try_lock_for_transaction(device->act_log));
+
+		/* mark current on-disk bitmap and activity log as unreliable */
 		prev_flags = md->flags;
-		md->flags &= ~MDF_PRIMARY_IND;
+		md->flags |= MDF_FULL_SYNC | MDF_AL_DISABLED;
 		drbd_md_write(device, buffer);
 
+		drbd_al_initialize(device, buffer);
+
 		drbd_info(device, "Writing the whole bitmap, %s\n",
 			 la_size_changed && md_moved ? "size changed and md moved" :
 			 la_size_changed ? "size changed" : "md moved");
 		/* next line implicitly does drbd_suspend_io()+drbd_resume_io() */
 		drbd_bitmap_io(device, md_moved ? &drbd_bm_write_all : &drbd_bm_write,
 			       "size changed", BM_LOCKED_MASK);
-		drbd_initialize_al(device, buffer);
 
+		/* on-disk bitmap and activity log is authoritative again
+		 * (unless there was an IO error meanwhile...) */
 		md->flags = prev_flags;
 		drbd_md_write(device, buffer);
 
-- 
1.9.1

