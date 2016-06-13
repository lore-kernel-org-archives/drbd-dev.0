Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9BDDA1056473
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 00:26:47 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Tue, 14 Jun 2016 00:26:30 +0200
Message-Id: <1465856799-2151-22-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <575ECD32.2080700@fb.com>
References: <575ECD32.2080700@fb.com>
In-Reply-To: <575ECD32.2080700@fb.com>
References: <575ECD32.2080700@fb.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 21/30] drbd: report sizes if rejecting too small
	peer disk
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

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index cb80fb4..367b8e9 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3952,6 +3952,7 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 	device->p_size = p_size;
 
 	if (get_ldev(device)) {
+		sector_t new_size, cur_size;
 		rcu_read_lock();
 		my_usize = rcu_dereference(device->ldev->disk_conf)->disk_size;
 		rcu_read_unlock();
@@ -3968,11 +3969,13 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 
 		/* Never shrink a device with usable data during connect.
 		   But allow online shrinking if we are connected. */
-		if (drbd_new_dev_size(device, device->ldev, p_usize, 0) <
-		    drbd_get_capacity(device->this_bdev) &&
+		new_size = drbd_new_dev_size(device, device->ldev, p_usize, 0);
+		cur_size = drbd_get_capacity(device->this_bdev);
+		if (new_size < cur_size &&
 		    device->state.disk >= D_OUTDATED &&
 		    device->state.conn < C_CONNECTED) {
-			drbd_err(device, "The peer's disk size is too small!\n");
+			drbd_err(device, "The peer's disk size is too small! (%llu < %llu sectors)\n",
+					(unsigned long long)new_size, (unsigned long long)cur_size);
 			conn_request_state(peer_device->connection, NS(conn, C_DISCONNECTING), CS_HARD);
 			put_ldev(device);
 			return -EIO;
-- 
2.7.4

