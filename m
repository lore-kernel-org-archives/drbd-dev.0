Return-Path: <lars.ellenberg@linbit.com>
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Date: Thu, 20 Dec 2018 17:23:34 +0100
Message-Id: <20181220162344.8430-8-lars.ellenberg@linbit.com>
In-Reply-To: <20181220162344.8430-1-lars.ellenberg@linbit.com>
References: <20181220162344.8430-1-lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 07/17] drbd: attach on connected diskless peer
	must not shrink a consistent device
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

If we would reject a new handshake, if the peer had attached first,
and then connected, we should force disconnect if the peer first connects,
and only then attaches.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 0a9f3c65f70a..85e3d846a23a 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4014,12 +4014,13 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 		if (device->state.conn == C_WF_REPORT_PARAMS)
 			p_usize = min_not_zero(my_usize, p_usize);
 
-		/* Never shrink a device with usable data during connect.
-		   But allow online shrinking if we are connected. */
+		/* Never shrink a device with usable data during connect,
+		 * or "attach" on the peer.
+		 * But allow online shrinking if we are connected. */
 		new_size = drbd_new_dev_size(device, device->ldev, p_usize, 0);
 		if (new_size < cur_size &&
 		    device->state.disk >= D_OUTDATED &&
-		    device->state.conn < C_CONNECTED) {
+		    (device->state.conn < C_CONNECTED || device->state.pdsk == D_DISKLESS)) {
 			drbd_err(device, "The peer's disk size is too small! (%llu < %llu sectors)\n",
 					(unsigned long long)new_size, (unsigned long long)cur_size);
 			conn_request_state(peer_device->connection, NS(conn, C_DISCONNECTING), CS_HARD);
@@ -4047,8 +4048,8 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 			synchronize_rcu();
 			kfree(old_disk_conf);
 
-			drbd_info(device, "Peer sets u_size to %lu sectors\n",
-				 (unsigned long)my_usize);
+			drbd_info(device, "Peer sets u_size to %lu sectors (old: %lu)\n",
+				 (unsigned long)p_usize, (unsigned long)my_usize);
 		}
 
 		put_ldev(device);
-- 
2.17.1

