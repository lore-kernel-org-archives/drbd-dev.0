Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  3 Oct 2011 22:58:27 +0200
Message-Id: <1317675513-12745-5-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317675513-12745-1-git-send-email-philipp.reisner@linbit.com>
References: <1317675513-12745-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 04/10] drbd: move comment about stopping the
	receiver thread to where it belongs
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

When the last volume of a replication group is unconfigured,
the worker thread exits. To not interfere with cleanup
of other threads, before the the last cleanups run,
we need to make sure the receiver has already exited.

The commend explaining that clearly belongs above
drbd_thread_stop(&tconn->receiver), not in the cleanup loop below.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_worker.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index c54c191..4e14133 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1746,12 +1746,13 @@ int drbd_worker(struct drbd_thread *thi)
 	 */
 	spin_unlock_irq(&tconn->data.work.q_lock);
 
+	/* _drbd_set_state only uses stop_nowait.
+	 * wait here for the exiting receiver. */
 	drbd_thread_stop(&tconn->receiver);
+
 	down_read(&drbd_cfg_rwsem);
 	idr_for_each_entry(&tconn->volumes, mdev, vnr) {
 		D_ASSERT(mdev->state.disk == D_DISKLESS && mdev->state.conn == C_STANDALONE);
-		/* _drbd_set_state only uses stop_nowait.
-		 * wait here for the exiting receiver. */
 		drbd_mdev_cleanup(mdev);
 	}
 	up_read(&drbd_cfg_rwsem);
-- 
1.7.4.1

