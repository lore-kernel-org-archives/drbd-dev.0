Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri,  7 Oct 2011 13:27:40 +0200
Message-Id: <1317986865-3706-8-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317986865-3706-1-git-send-email-philipp.reisner@linbit.com>
References: <1317986865-3706-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 07/12] drbd: skip spurious wait_event in
	drbd_al_begin_io
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Activity log transaction writes are serialized on a bit lock.
If several CPUs race to write an AL transaction,
those that did not get the lock the first time
may continue as soon as there are no more pending transactions.

The do not need to all grab the lock in turn,
just to realize that the AL is clean already,
and they have nothing to do.

This also closes a potential deadlock with drbd_adm_disk_opts.
Once it got the AL bit lock, it knows there are no pending transactions,
the AL is clean, and it should be safe to wait for all element references
to drop to zero.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 933404e..aeb483d 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -212,13 +212,22 @@ void drbd_al_begin_io(struct drbd_conf *mdev, struct drbd_interval *i)
 	unsigned first = i->sector >> (AL_EXTENT_SHIFT-9);
 	unsigned last = (i->sector + (i->size >> 9) - 1) >> (AL_EXTENT_SHIFT-9);
 	unsigned enr;
+	bool locked = false;
+
 
 	D_ASSERT(atomic_read(&mdev->local_cnt) > 0);
 
 	for (enr = first; enr <= last; enr++)
 		wait_event(mdev->al_wait, _al_get(mdev, enr) != NULL);
 
-	if (mdev->act_log->pending_changes) {
+	/* Serialize multiple transactions.
+	 * This uses test_and_set_bit, memory barrier is implicit.
+	 */
+	wait_event(mdev->al_wait,
+			mdev->act_log->pending_changes == 0 ||
+			(locked = lc_try_lock_for_transaction(mdev->act_log)));
+
+	if (locked) {
 		/* drbd_al_write_transaction(mdev,al_ext,enr);
 		 * recurses into generic_make_request(), which
 		 * disallows recursion, bios being serialized on the
@@ -226,13 +235,6 @@ void drbd_al_begin_io(struct drbd_conf *mdev, struct drbd_interval *i)
 		 * we have to delegate updates to the activity log
 		 * to the worker thread. */
 
-		/* Serialize multiple transactions.
-		 * This uses test_and_set_bit, memory barrier is implicit.
-		 * Optimization potential:
-		 * first check for transaction number > old transaction number,
-		 * so not all waiters have to lock/unlock.  */
-		wait_event(mdev->al_wait, lc_try_lock_for_transaction(mdev->act_log));
-
 		/* Double check: it may have been committed by someone else,
 		 * while we have been waiting for the lock. */
 		if (mdev->act_log->pending_changes) {
-- 
1.7.4.1

