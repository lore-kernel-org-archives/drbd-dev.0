Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu,  8 Sep 2011 14:45:37 +0200
Message-Id: <1315485937-18989-17-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315485937-18989-1-git-send-email-philipp.reisner@linbit.com>
References: <1315485937-18989-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 16/16] drbd: improvements to activate/deactivate
	multiple activity log extents
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Recent commit drbd: get rid of bio_split, allow bios of "arbitrary" size
had a reference count leak: it only deactivated the first of several
activity log extents for intervals crossing extent boundaries.

This commit generalizes on bios spanning multiple activity log extents
in drbd_al_begin_io, and adds the necessary loop around lc_put in
drbd_al_complete_io as well.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c |   46 +++++++++++++++++++-------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 1e3ddd7..7eacc03 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -209,20 +209,16 @@ void drbd_al_begin_io(struct drbd_conf *mdev, struct drbd_interval *i)
 {
 	/* for bios crossing activity log extent boundaries,
 	 * we may need to activate two extents in one go */
-	unsigned int enr[2];
-	struct lc_element *al_ext[2] = { NULL, NULL };
-	struct update_al_work al_work;
+	unsigned first = i->sector >> (AL_EXTENT_SHIFT-9);
+	unsigned last = (i->sector + (i->size >> 9) - 1) >> (AL_EXTENT_SHIFT-9);
+	unsigned enr;
 
 	D_ASSERT(atomic_read(&mdev->local_cnt) > 0);
 
-	enr[0] = i->sector >> (AL_EXTENT_SHIFT-9);
-	enr[1] = (i->sector + (i->size >> 9) - 1) >> (AL_EXTENT_SHIFT-9);
-	wait_event(mdev->al_wait, (al_ext[0] = _al_get(mdev, enr[0])));
-	if (enr[0] != enr[1])
-		wait_event(mdev->al_wait, (al_ext[1] = _al_get(mdev, enr[1])));
+	for (enr = first; enr <= last; enr++)
+		wait_event(mdev->al_wait, _al_get(mdev, enr) != NULL);
 
-	if (al_ext[0]->lc_number != enr[0] ||
-	    (al_ext[1] && al_ext[1]->lc_number != enr[1])) {
+	if (mdev->act_log->pending_changes) {
 		/* drbd_al_write_transaction(mdev,al_ext,enr);
 		 * recurses into generic_make_request(), which
 		 * disallows recursion, bios being serialized on the
@@ -239,8 +235,8 @@ void drbd_al_begin_io(struct drbd_conf *mdev, struct drbd_interval *i)
 
 		/* Double check: it may have been committed by someone else,
 		 * while we have been waiting for the lock. */
-		if (al_ext[0]->lc_number != enr[0] ||
-		    (al_ext[1] && al_ext[1]->lc_number != enr[1])) {
+		if (mdev->act_log->pending_changes) {
+			struct update_al_work al_work;
 			init_completion(&al_work.event);
 			al_work.w.cb = w_al_write_transaction;
 			al_work.w.mdev = mdev;
@@ -264,24 +260,28 @@ void drbd_al_begin_io(struct drbd_conf *mdev, struct drbd_interval *i)
 
 void drbd_al_complete_io(struct drbd_conf *mdev, struct drbd_interval *i)
 {
-	unsigned int enr = (i->sector >> (AL_EXTENT_SHIFT-9));
+	/* for bios crossing activity log extent boundaries,
+	 * we may need to activate two extents in one go */
+	unsigned first = i->sector >> (AL_EXTENT_SHIFT-9);
+	unsigned last = (i->sector + (i->size >> 9) - 1) >> (AL_EXTENT_SHIFT-9);
+	unsigned enr;
 	struct lc_element *extent;
 	unsigned long flags;
+	bool wake = false;
 
 	spin_lock_irqsave(&mdev->al_lock, flags);
 
-	extent = lc_find(mdev->act_log, enr);
-
-	if (!extent) {
-		spin_unlock_irqrestore(&mdev->al_lock, flags);
-		dev_err(DEV, "al_complete_io() called on inactive extent %u\n", enr);
-		return;
+	for (enr = first; enr <= last; enr++) {
+		extent = lc_find(mdev->act_log, enr);
+		if (!extent) {
+			dev_err(DEV, "al_complete_io() called on inactive extent %u\n", enr);
+			continue;
+		}
+		if (lc_put(mdev->act_log, extent) == 0)
+			wake = true;
 	}
-
-	if (lc_put(mdev->act_log, extent) == 0)
-		wake_up(&mdev->al_wait);
-
 	spin_unlock_irqrestore(&mdev->al_lock, flags);
+	wake_up(&mdev->al_wait);
 }
 
 #if (PAGE_SHIFT + 3) < (AL_EXTENT_SHIFT - BM_BLOCK_SHIFT)
-- 
1.7.4.1

