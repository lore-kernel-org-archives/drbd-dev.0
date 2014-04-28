Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:31 +0200
Message-Id: <1398703415-17780-21-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 20/24] drbd: evaluate disk and network timeout on
	different requests
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

Just because it is the oldest not yet completed request
does not make it the oldest request waiting for disk.
Or waiting for the peer.

And we completely missed already completed requests
that would still hold references to activity log extents,
waiting only for the barrier ack.

Find two oldest not yet completely processed requests,
one that is still waiting for local completion,
and one that is still waiting for some response from the peer.
These may or may not be the same request object.

Then separately apply the network and disk timeouts, respectively.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_req.c | 47 ++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 99411bf..09803d0 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1353,23 +1353,35 @@ int drbd_merge_bvec(struct request_queue *q, struct bvec_merge_data *bvm, struct
 	return limit;
 }
 
-static struct drbd_request *find_oldest_request(struct drbd_connection *connection)
+static void find_oldest_requests(
+		struct drbd_connection *connection,
+		struct drbd_device *device,
+		struct drbd_request **oldest_req_waiting_for_peer,
+		struct drbd_request **oldest_req_waiting_for_disk)
 {
-	/* Walk the transfer log,
-	 * and find the oldest not yet completed request */
 	struct drbd_request *r;
+	*oldest_req_waiting_for_peer = NULL;
+	*oldest_req_waiting_for_disk = NULL;
 	list_for_each_entry(r, &connection->transfer_log, tl_requests) {
-		if (atomic_read(&r->completion_ref))
-			return r;
+		const unsigned s = r->rq_state;
+		if (!*oldest_req_waiting_for_peer
+		&& ((s & RQ_NET_MASK) && !(s & RQ_NET_DONE)))
+			*oldest_req_waiting_for_peer = r;
+
+		if (!*oldest_req_waiting_for_disk
+		&& (s & RQ_LOCAL_PENDING) && r->device == device)
+			*oldest_req_waiting_for_disk = r;
+
+		if (*oldest_req_waiting_for_peer && *oldest_req_waiting_for_disk)
+			break;
 	}
-	return NULL;
 }
 
 void request_timer_fn(unsigned long data)
 {
 	struct drbd_device *device = (struct drbd_device *) data;
 	struct drbd_connection *connection = first_peer_device(device)->connection;
-	struct drbd_request *req; /* oldest request */
+	struct drbd_request *req_disk, *req_peer; /* oldest request */
 	struct net_conf *nc;
 	unsigned long ent = 0, dt = 0, et, nt; /* effective timeout = ko_count * timeout */
 	unsigned long now;
@@ -1393,8 +1405,8 @@ void request_timer_fn(unsigned long data)
 	now = jiffies;
 
 	spin_lock_irq(&device->resource->req_lock);
-	req = find_oldest_request(connection);
-	if (!req) {
+	find_oldest_requests(connection, device, &req_peer, &req_disk);
+	if (req_peer == NULL && req_disk == NULL) {
 		spin_unlock_irq(&device->resource->req_lock);
 		mod_timer(&device->request_timer, now + et);
 		return;
@@ -1416,19 +1428,26 @@ void request_timer_fn(unsigned long data)
 	 * ~198 days with 250 HZ, we have a window where the timeout would need
 	 * to expire twice (worst case) to become effective. Good enough.
 	 */
-	if (ent && req->rq_state & RQ_NET_PENDING &&
-		 time_after(now, req->start_time + ent) &&
+	if (ent && req_peer &&
+		 time_after(now, req_peer->start_time + ent) &&
 		!time_in_range(now, connection->last_reconnect_jif, connection->last_reconnect_jif + ent)) {
 		drbd_warn(device, "Remote failed to finish a request within ko-count * timeout\n");
 		_drbd_set_state(_NS(device, conn, C_TIMEOUT), CS_VERBOSE | CS_HARD, NULL);
 	}
-	if (dt && req->rq_state & RQ_LOCAL_PENDING && req->device == device &&
-		 time_after(now, req->start_time + dt) &&
+	if (dt && req_disk &&
+		 time_after(now, req_disk->start_time + dt) &&
 		!time_in_range(now, device->last_reattach_jif, device->last_reattach_jif + dt)) {
 		drbd_warn(device, "Local backing device failed to meet the disk-timeout\n");
 		__drbd_chk_io_error(device, DRBD_FORCE_DETACH);
 	}
-	nt = (time_after(now, req->start_time + et) ? now : req->start_time) + et;
+
+	/* Reschedule timer for the nearest not already expired timeout.
+	 * Fallback to now + min(effective network timeout, disk timeout). */
+	ent = (ent && req_peer && time_before(now, req_peer->start_time + ent))
+		? req_peer->start_time + ent : now + et;
+	dt = (dt && req_disk && time_before(now, req_disk->start_time + dt))
+		? req_disk->start_time + dt : now + et;
+	nt = time_before(ent, dt) ? ent : dt;
 	spin_unlock_irq(&connection->resource->req_lock);
 	mod_timer(&device->request_timer, nt);
 }
-- 
1.9.1

