Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:29 +0200
Message-Id: <1398703415-17780-19-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 18/24] drbd: always implicitly close last epoch
	when idle
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

From: Lars Ellenberg <lars@linbit.com>

Once our sender thread needs to wait_for_work(),
and actually needs to schedule(), just before we do that,
we already check if it is useful to implicitly close the last epoch.

The condition was too strict: only implicitly close the epoch,
if there have been no new (write) requests at all.

The assumption was that if there were new requests, they would
always be communicated one way or another, and would send necessary
epoch separating barriers explicitly.

This is not always true, e.g. when becoming diskless,
or while explicitly starting a full resync.

The last communicated epoch could stay open for a long time,
locking down corresponding activity log extents.

It is safe to always implicitly send that last barrier, as soon as we
determin that there cannot be more requests in the last communicated
epoch, even if there have been (uncommunicated) new requests in new
epochs meanwhile.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_worker.c | 48 +++++++++++++---------------------------
 1 file changed, 15 insertions(+), 33 deletions(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 34dde10..d8f57b6 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1799,34 +1799,6 @@ void drbd_start_resync(struct drbd_device *device, enum drbd_conns side)
 	mutex_unlock(device->state_mutex);
 }
 
-/* If the resource already closed the current epoch, but we did not
- * (because we have not yet seen new requests), we should send the
- * corresponding barrier now.  Must be checked within the same spinlock
- * that is used to check for new requests. */
-static bool need_to_send_barrier(struct drbd_connection *connection)
-{
-	if (!connection->send.seen_any_write_yet)
-		return false;
-
-	/* Skip barriers that do not contain any writes.
-	 * This may happen during AHEAD mode. */
-	if (!connection->send.current_epoch_writes)
-		return false;
-
-	/* ->req_lock is held when requests are queued on
-	 * connection->sender_work, and put into ->transfer_log.
-	 * It is also held when ->current_tle_nr is increased.
-	 * So either there are already new requests queued,
-	 * and corresponding barriers will be send there.
-	 * Or nothing new is queued yet, so the difference will be 1.
-	 */
-	if (atomic_read(&connection->current_tle_nr) !=
-	    connection->send.current_epoch_nr + 1)
-		return false;
-
-	return true;
-}
-
 static bool dequeue_work_batch(struct drbd_work_queue *queue, struct list_head *work_list)
 {
 	spin_lock_irq(&queue->q_lock);
@@ -1885,12 +1857,22 @@ static void wait_for_work(struct drbd_connection *connection, struct list_head *
 			spin_unlock_irq(&connection->resource->req_lock);
 			break;
 		}
-		send_barrier = need_to_send_barrier(connection);
+
+		/* We found nothing new to do, no to-be-communicated request,
+		 * no other work item.  We may still need to close the last
+		 * epoch.  Next incoming request epoch will be connection ->
+		 * current transfer log epoch number.  If that is different
+		 * from the epoch of the last request we communicated, it is
+		 * safe to send the epoch separating barrier now.
+		 */
+		send_barrier =
+			atomic_read(&connection->current_tle_nr) !=
+			connection->send.current_epoch_nr;
 		spin_unlock_irq(&connection->resource->req_lock);
-		if (send_barrier) {
-			drbd_send_barrier(connection);
-			connection->send.current_epoch_nr++;
-		}
+
+		if (send_barrier)
+			maybe_send_barrier(connection,
+					connection->send.current_epoch_nr + 1);
 		schedule();
 		/* may be woken up for other things but new work, too,
 		 * e.g. if the current epoch got closed.
-- 
1.9.1

