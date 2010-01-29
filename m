Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 839E7106DFEC
	for <drbd-dev@lists.linbit.com>; Mon,  1 Feb 2010 11:00:52 +0100 (CET)
Resent-Message-ID: <20100201100052.GA13031@soda.linbit>
Message-Id: <20100129203613.703416262@linutronix.de>
Date: Fri, 29 Jan 2010 20:39:07 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
References: <20100129203549.526478432@linutronix.de>
Content-Disposition: inline; filename=drivers-block-drbd-use-mutex.patch
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [patch 09/10] block: drbd: Convert semaphore to mutex
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

The bm_change semaphore is semantically a mutex. Convert it to a real
mutex.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Lars Ellenberg <drbd-dev@lists.linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: drbd-user@lists.linbit.com

---
 drivers/block/drbd/drbd_bitmap.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6-tip/drivers/block/drbd/drbd_bitmap.c
===================================================================
--- linux-2.6-tip.orig/drivers/block/drbd/drbd_bitmap.c
+++ linux-2.6-tip/drivers/block/drbd/drbd_bitmap.c
@@ -66,7 +66,7 @@ struct drbd_bitmap {
 	size_t   bm_words;
 	size_t   bm_number_of_pages;
 	sector_t bm_dev_capacity;
-	struct semaphore bm_change; /* serializes resize operations */
+	struct mutex bm_change; /* serializes resize operations */
 
 	atomic_t bm_async_io;
 	wait_queue_head_t bm_io_wait;
@@ -114,7 +114,7 @@ void drbd_bm_lock(struct drbd_conf *mdev
 		return;
 	}
 
-	trylock_failed = down_trylock(&b->bm_change);
+	trylock_failed = !mutex_trylock(&b->bm_change);
 
 	if (trylock_failed) {
 		dev_warn(DEV, "%s going to '%s' but bitmap already locked for '%s' by %s\n",
@@ -125,7 +125,7 @@ void drbd_bm_lock(struct drbd_conf *mdev
 		    b->bm_task == mdev->receiver.task ? "receiver" :
 		    b->bm_task == mdev->asender.task  ? "asender"  :
 		    b->bm_task == mdev->worker.task   ? "worker"   : "?");
-		down(&b->bm_change);
+		mutex_lock(&b->bm_change);
 	}
 	if (__test_and_set_bit(BM_LOCKED, &b->bm_flags))
 		dev_err(DEV, "FIXME bitmap already locked in bm_lock\n");
@@ -147,7 +147,7 @@ void drbd_bm_unlock(struct drbd_conf *md
 
 	b->bm_why  = NULL;
 	b->bm_task = NULL;
-	up(&b->bm_change);
+	mutex_unlock(&b->bm_change);
 }
 
 /* word offset to long pointer */
@@ -295,7 +295,7 @@ int drbd_bm_init(struct drbd_conf *mdev)
 	if (!b)
 		return -ENOMEM;
 	spin_lock_init(&b->bm_lock);
-	init_MUTEX(&b->bm_change);
+	mutex_init(&b->bm_change);
 	init_waitqueue_head(&b->bm_io_wait);
 
 	mdev->bitmap = b;


