Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:26 +0200
Message-Id: <1398703415-17780-16-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 15/24] drbd: fix a race between start_resync and
	send_and_submit
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

In the drbd make request function, specifically in
drbd_send_and_submit(), we decide whether we want to send the actual
write request, or only a "set this block out of sync" information.

We do so based on the current connection state, while holding the req_lock.
The connection state is not supposed to change while holding the req_lock.

But in drbd_start_resync, we did change that state anyways,
while only holding the global_state_lock, which is enough to change
sync-after dependencies (paused vs active resync), but
not good enough to change the connection state.

Fix: in drbd_start_resync, first grab the req_lock to serialize with
drbd_send_and_submit(), before grabbing the global_state_lock
to be able to evaluate the sync-after dependencies.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_worker.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 26338be..34dde10 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1686,11 +1686,15 @@ void drbd_start_resync(struct drbd_device *device, enum drbd_conns side)
 	}
 	clear_bit(B_RS_H_DONE, &device->flags);
 
-	write_lock_irq(&global_state_lock);
+	/* req_lock: serialize with drbd_send_and_submit() and others
+	 * global_state_lock: for stable sync-after dependencies */
+	spin_lock_irq(&device->resource->req_lock);
+	write_lock(&global_state_lock);
 	/* Did some connection breakage or IO error race with us? */
 	if (device->state.conn < C_CONNECTED
 	|| !get_ldev_if_state(device, D_NEGOTIATING)) {
-		write_unlock_irq(&global_state_lock);
+		write_unlock(&global_state_lock);
+		spin_unlock_irq(&device->resource->req_lock);
 		mutex_unlock(device->state_mutex);
 		return;
 	}
@@ -1730,7 +1734,8 @@ void drbd_start_resync(struct drbd_device *device, enum drbd_conns side)
 		}
 		_drbd_pause_after(device);
 	}
-	write_unlock_irq(&global_state_lock);
+	write_unlock(&global_state_lock);
+	spin_unlock_irq(&device->resource->req_lock);
 
 	if (r == SS_SUCCESS) {
 		/* reset rs_last_bcast when a resync or verify is started,
-- 
1.9.1

