Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B30ED10518B6
	for <drbd-dev@lists.linbit.com>; Thu, 30 Jul 2015 13:22:06 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 30 Jul 2015 13:21:38 +0200
Message-Id: <1438255314-14877-4-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
References: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/19] drbd: Get rid of some first_peer_device()
	calls
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

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index c097909..e594391 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1379,7 +1379,7 @@ int drbd_submit_peer_request(struct drbd_device *device,
 	if (peer_req->flags & EE_IS_TRIM_USE_ZEROOUT) {
 		/* wait for all pending IO completions, before we start
 		 * zeroing things out. */
-		conn_wait_active_ee_empty(first_peer_device(device)->connection);
+		conn_wait_active_ee_empty(peer_req->peer_device->connection);
 		/* add it to the active list now,
 		 * so we can find it to present it in debugfs */
 		peer_req->submit_jif = jiffies;
@@ -1965,7 +1965,7 @@ static int e_end_block(struct drbd_work *w, int cancel)
 	} else
 		D_ASSERT(device, drbd_interval_empty(&peer_req->i));
 
-	drbd_may_finish_epoch(first_peer_device(device)->connection, peer_req->epoch, EV_PUT + (cancel ? EV_CLEANUP : 0));
+	drbd_may_finish_epoch(peer_device->connection, peer_req->epoch, EV_PUT + (cancel ? EV_CLEANUP : 0));
 
 	return err;
 }
@@ -2097,7 +2097,7 @@ static int wait_for_and_update_peer_seq(struct drbd_peer_device *peer_device, co
 		}
 
 		rcu_read_lock();
-		tp = rcu_dereference(first_peer_device(device)->connection->net_conf)->two_primaries;
+		tp = rcu_dereference(peer_device->connection->net_conf)->two_primaries;
 		rcu_read_unlock();
 
 		if (!tp)
@@ -2363,7 +2363,7 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 	if (dp_flags & DP_SEND_RECEIVE_ACK) {
 		/* I really don't like it that the receiver thread
 		 * sends on the msock, but anyways */
-		drbd_send_ack(first_peer_device(device), P_RECV_ACK, peer_req);
+		drbd_send_ack(peer_device, P_RECV_ACK, peer_req);
 	}
 
 	if (tp) {
-- 
1.9.1

