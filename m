Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 27 Mar 2013 14:08:35 +0100
Message-Id: <1364389729-17559-4-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1364389729-17559-1-git-send-email-philipp.reisner@linbit.com>
References: <1364389729-17559-1-git-send-email-philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/17] drbd: abort start of resync early,
	if it raced with connection breakage
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

We've seen a spurious full resync, because a connection breakage
raced with drbd_start_resync(, C_SYNC_TARGET),
and the resulting state change request intended to start the resync
ended up looking like a local invalidate.

Fix:
Double check the state inside the lock,
and don't even request that state change,
if we had connection or IO problems.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_worker.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index f41e224..7f51f88 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1653,7 +1653,9 @@ void drbd_start_resync(struct drbd_conf *mdev, enum drbd_conns side)
 	clear_bit(B_RS_H_DONE, &mdev->flags);
 
 	write_lock_irq(&global_state_lock);
-	if (!get_ldev_if_state(mdev, D_NEGOTIATING)) {
+	/* Did some connection breakage or IO error race with us? */
+	if (mdev->state.conn < C_CONNECTED
+	|| !get_ldev_if_state(mdev, D_NEGOTIATING)) {
 		write_unlock_irq(&global_state_lock);
 		mutex_unlock(mdev->state_mutex);
 		return;
-- 
1.7.9.5

