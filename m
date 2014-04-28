Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:12 +0200
Message-Id: <1398703415-17780-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/24] drbd: Break a deadlock while concurrent
	fencing and establishing a connection
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

When we need to outdate the peer while being promoted to primary,
and the connection gets established at the same time, we deadlock
in drbd_try_outdate_peer() when trying to clear the susp_fen
bit.

Fix this by setting the STATE_SENT bit while holding the mutex.

Using drbd_change_state(.. , CS_HARD, ..) which does not block
until STATE_SENT is cleared, is only for clearness. It does
not contribute anything to the fix.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 68e3992..125c9e8 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1026,24 +1026,27 @@ randomize:
 	if (drbd_send_protocol(connection) == -EOPNOTSUPP)
 		return -1;
 
+	/* Prevent a race between resync-handshake and
+	 * being promoted to Primary.
+	 *
+	 * Grab and release the state mutex, so we know that any current
+	 * drbd_set_role() is finished, and any incoming drbd_set_role
+	 * will see the STATE_SENT flag, and wait for it to be cleared.
+	 */
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
+		mutex_lock(peer_device->device->state_mutex);
+
 	set_bit(STATE_SENT, &connection->flags);
 
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
+		mutex_unlock(peer_device->device->state_mutex);
+
 	rcu_read_lock();
 	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
 		struct drbd_device *device = peer_device->device;
 		kref_get(&device->kref);
 		rcu_read_unlock();
 
-		/* Prevent a race between resync-handshake and
-		 * being promoted to Primary.
-		 *
-		 * Grab and release the state mutex, so we know that any current
-		 * drbd_set_role() is finished, and any incoming drbd_set_role
-		 * will see the STATE_SENT flag, and wait for it to be cleared.
-		 */
-		mutex_lock(device->state_mutex);
-		mutex_unlock(device->state_mutex);
-
 		if (discard_my_data)
 			set_bit(DISCARD_MY_DATA, &device->flags);
 		else
-- 
1.9.1

