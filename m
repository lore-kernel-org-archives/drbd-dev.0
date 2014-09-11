Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4C6CE101E077
	for <drbd-dev@lists.linbit.com>; Thu, 11 Sep 2014 14:29:16 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Date: Thu, 11 Sep 2014 14:29:12 +0200
Message-Id: <1410438553-30440-9-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1410438553-30440-1-git-send-email-philipp.reisner@linbit.com>
References: <1410438553-30440-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 8/9] drbd: reduce lock contention in drbd_worker
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

The worker may now dequeue work items in batches.
This should reduce lock contention during busy periods.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_worker.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 3ed2d87..d2d1f97 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -2026,8 +2026,6 @@ static void wait_for_work(struct drbd_connection *connection, struct list_head *
 		prepare_to_wait(&connection->sender_work.q_wait, &wait, TASK_INTERRUPTIBLE);
 		spin_lock_irq(&connection->resource->req_lock);
 		spin_lock(&connection->sender_work.q_lock);	/* FIXME get rid of this one? */
-		/* dequeue single item only,
-		 * we still use drbd_queue_work_front() in some places */
 		if (!list_empty(&connection->sender_work.q))
 			list_splice_tail_init(&connection->sender_work.q, work_list);
 		spin_unlock(&connection->sender_work.q_lock);	/* FIXME get rid of this one? */
@@ -2114,7 +2112,7 @@ int drbd_worker(struct drbd_thread *thi)
 		if (get_t_state(thi) != RUNNING)
 			break;
 
-		while (!list_empty(&work_list)) {
+		if (!list_empty(&work_list)) {
 			w = list_first_entry(&work_list, struct drbd_work, list);
 			list_del_init(&w->list);
 			update_worker_timing_details(connection, w->cb);
@@ -2130,13 +2128,13 @@ int drbd_worker(struct drbd_thread *thi)
 			update_worker_timing_details(connection, do_unqueued_work);
 			do_unqueued_work(connection);
 		}
-		while (!list_empty(&work_list)) {
+		if (!list_empty(&work_list)) {
 			w = list_first_entry(&work_list, struct drbd_work, list);
 			list_del_init(&w->list);
 			update_worker_timing_details(connection, w->cb);
 			w->cb(w, 1);
-		}
-		dequeue_work_batch(&connection->sender_work, &work_list);
+		} else
+			dequeue_work_batch(&connection->sender_work, &work_list);
 	} while (!list_empty(&work_list) || test_bit(DEVICE_WORK_PENDING, &connection->flags));
 
 	rcu_read_lock();
-- 
1.9.1

