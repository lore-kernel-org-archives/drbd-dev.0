Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4BF1E1055F43
	for <drbd-dev@lists.linbit.com>; Thu, 30 Jul 2015 13:22:09 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 30 Jul 2015 13:21:52 +0200
Message-Id: <1438255314-14877-18-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
References: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 17/19] drbd: improve network timeout detection
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

Don't blame the peer for being unresponsive,
if we did not even ask the question yet.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h    |   2 +
 drivers/block/drbd/drbd_req.c    | 123 ++++++++++++++++++++++++++++++---------
 drivers/block/drbd/drbd_worker.c |   2 +
 3 files changed, 100 insertions(+), 27 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 816afad..cb5fb68 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -773,6 +773,8 @@ struct drbd_connection {
 	struct drbd_thread_timing_details r_timing_details[DRBD_THREAD_DETAILS_HIST];
 
 	struct {
+		unsigned long last_sent_barrier_jif;
+
 		/* whether this sender thread
 		 * has processed a single write yet. */
 		bool seen_any_write_yet;
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 26c194d..3c8ade7 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1561,6 +1561,78 @@ int drbd_merge_bvec(struct request_queue *q, struct bvec_merge_data *bvm, struct
 	return limit;
 }
 
+static bool net_timeout_reached(struct drbd_request *net_req,
+		struct drbd_connection *connection,
+		unsigned long now, unsigned long ent,
+		unsigned int ko_count, unsigned int timeout)
+{
+	struct drbd_device *device = net_req->device;
+
+	if (!time_after(now, net_req->pre_send_jif + ent))
+		return false;
+
+	if (time_in_range(now, connection->last_reconnect_jif, connection->last_reconnect_jif + ent))
+		return false;
+
+	if (net_req->rq_state & RQ_NET_PENDING) {
+		drbd_warn(device, "Remote failed to finish a request within %ums > ko-count (%u) * timeout (%u * 0.1s)\n",
+			jiffies_to_msecs(now - net_req->pre_send_jif), ko_count, timeout);
+		return true;
+	}
+
+	/* We received an ACK already (or are using protocol A),
+	 * but are waiting for the epoch closing barrier ack.
+	 * Check if we sent the barrier already.  We should not blame the peer
+	 * for being unresponsive, if we did not even ask it yet. */
+	if (net_req->epoch == connection->send.current_epoch_nr) {
+		drbd_warn(device,
+			"We did not send a P_BARRIER for %ums > ko-count (%u) * timeout (%u * 0.1s); drbd kernel thread blocked?\n",
+			jiffies_to_msecs(now - net_req->pre_send_jif), ko_count, timeout);
+		return false;
+	}
+
+	/* Worst case: we may have been blocked for whatever reason, then
+	 * suddenly are able to send a lot of requests (and epoch separating
+	 * barriers) in quick succession.
+	 * The timestamp of the net_req may be much too old and not correspond
+	 * to the sending time of the relevant unack'ed barrier packet, so
+	 * would trigger a spurious timeout.  The latest barrier packet may
+	 * have a too recent timestamp to trigger the timeout, potentially miss
+	 * a timeout.  Right now we don't have a place to conveniently store
+	 * these timestamps.
+	 * But in this particular situation, the application requests are still
+	 * completed to upper layers, DRBD should still "feel" responsive.
+	 * No need yet to kill this connection, it may still recover.
+	 * If not, eventually we will have queued enough into the network for
+	 * us to block. From that point of view, the timestamp of the last sent
+	 * barrier packet is relevant enough.
+	 */
+	if (time_after(now, connection->send.last_sent_barrier_jif + ent)) {
+		drbd_warn(device, "Remote failed to answer a P_BARRIER (sent at %lu jif; now=%lu jif) within %ums > ko-count (%u) * timeout (%u * 0.1s)\n",
+			connection->send.last_sent_barrier_jif, now,
+			jiffies_to_msecs(now - connection->send.last_sent_barrier_jif), ko_count, timeout);
+		return true;
+	}
+	return false;
+}
+
+/* A request is considered timed out, if
+ * - we have some effective timeout from the configuration,
+ *   with some state restrictions applied,
+ * - the oldest request is waiting for a response from the network
+ *   resp. the local disk,
+ * - the oldest request is in fact older than the effective timeout,
+ * - the connection was established (resp. disk was attached)
+ *   for longer than the timeout already.
+ * Note that for 32bit jiffies and very stable connections/disks,
+ * we may have a wrap around, which is catched by
+ *   !time_in_range(now, last_..._jif, last_..._jif + timeout).
+ *
+ * Side effect: once per 32bit wrap-around interval, which means every
+ * ~198 days with 250 HZ, we have a window where the timeout would need
+ * to expire twice (worst case) to become effective. Good enough.
+ */
+
 void request_timer_fn(unsigned long data)
 {
 	struct drbd_device *device = (struct drbd_device *) data;
@@ -1570,11 +1642,14 @@ void request_timer_fn(unsigned long data)
 	unsigned long oldest_submit_jif;
 	unsigned long ent = 0, dt = 0, et, nt; /* effective timeout = ko_count * timeout */
 	unsigned long now;
+	unsigned int ko_count = 0, timeout = 0;
 
 	rcu_read_lock();
 	nc = rcu_dereference(connection->net_conf);
-	if (nc && device->state.conn >= C_WF_REPORT_PARAMS)
-		ent = nc->timeout * HZ/10 * nc->ko_count;
+	if (nc && device->state.conn >= C_WF_REPORT_PARAMS) {
+		ko_count = nc->ko_count;
+		timeout = nc->timeout;
+	}
 
 	if (get_ldev(device)) { /* implicit state.disk >= D_INCONSISTENT */
 		dt = rcu_dereference(device->ldev->disk_conf)->disk_timeout * HZ / 10;
@@ -1582,6 +1657,8 @@ void request_timer_fn(unsigned long data)
 	}
 	rcu_read_unlock();
 
+
+	ent = timeout * HZ/10 * ko_count;
 	et = min_not_zero(dt, ent);
 
 	if (!et)
@@ -1593,11 +1670,22 @@ void request_timer_fn(unsigned long data)
 	spin_lock_irq(&device->resource->req_lock);
 	req_read = list_first_entry_or_null(&device->pending_completion[0], struct drbd_request, req_pending_local);
 	req_write = list_first_entry_or_null(&device->pending_completion[1], struct drbd_request, req_pending_local);
-	req_peer = connection->req_not_net_done;
+
 	/* maybe the oldest request waiting for the peer is in fact still
-	 * blocking in tcp sendmsg */
-	if (!req_peer && connection->req_next && connection->req_next->pre_send_jif)
-		req_peer = connection->req_next;
+	 * blocking in tcp sendmsg.  That's ok, though, that's handled via the
+	 * socket send timeout, requesting a ping, and bumping ko-count in
+	 * we_should_drop_the_connection().
+	 */
+
+	/* check the oldest request we did successfully sent,
+	 * but which is still waiting for an ACK. */
+	req_peer = connection->req_ack_pending;
+
+	/* if we don't have such request (e.g. protocoll A)
+	 * check the oldest requests which is still waiting on its epoch
+	 * closing barrier ack. */
+	if (!req_peer)
+		req_peer = connection->req_not_net_done;
 
 	/* evaluate the oldest peer request only in one timer! */
 	if (req_peer && req_peer->device != device)
@@ -1614,28 +1702,9 @@ void request_timer_fn(unsigned long data)
 		: req_write ? req_write->pre_submit_jif
 		: req_read ? req_read->pre_submit_jif : now;
 
-	/* The request is considered timed out, if
-	 * - we have some effective timeout from the configuration,
-	 *   with above state restrictions applied,
-	 * - the oldest request is waiting for a response from the network
-	 *   resp. the local disk,
-	 * - the oldest request is in fact older than the effective timeout,
-	 * - the connection was established (resp. disk was attached)
-	 *   for longer than the timeout already.
-	 * Note that for 32bit jiffies and very stable connections/disks,
-	 * we may have a wrap around, which is catched by
-	 *   !time_in_range(now, last_..._jif, last_..._jif + timeout).
-	 *
-	 * Side effect: once per 32bit wrap-around interval, which means every
-	 * ~198 days with 250 HZ, we have a window where the timeout would need
-	 * to expire twice (worst case) to become effective. Good enough.
-	 */
-	if (ent && req_peer &&
-		 time_after(now, req_peer->pre_send_jif + ent) &&
-		!time_in_range(now, connection->last_reconnect_jif, connection->last_reconnect_jif + ent)) {
-		drbd_warn(device, "Remote failed to finish a request within ko-count * timeout\n");
+	if (ent && req_peer && net_timeout_reached(req_peer, connection, now, ent, ko_count, timeout))
 		_conn_request_state(connection, NS(conn, C_TIMEOUT), CS_VERBOSE | CS_HARD);
-	}
+
 	if (dt && oldest_submit_jif != now &&
 		 time_after(now, oldest_submit_jif + dt) &&
 		!time_in_range(now, device->last_reattach_jif, device->last_reattach_jif + dt)) {
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 93777b1..02fad6c 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1312,6 +1312,7 @@ static int drbd_send_barrier(struct drbd_connection *connection)
 	p->barrier = connection->send.current_epoch_nr;
 	p->pad = 0;
 	connection->send.current_epoch_writes = 0;
+	connection->send.last_sent_barrier_jif = jiffies;
 
 	return conn_send_command(connection, sock, P_BARRIER, sizeof(*p), NULL, 0);
 }
@@ -1336,6 +1337,7 @@ static void re_init_if_first_write(struct drbd_connection *connection, unsigned
 		connection->send.seen_any_write_yet = true;
 		connection->send.current_epoch_nr = epoch;
 		connection->send.current_epoch_writes = 0;
+		connection->send.last_sent_barrier_jif = jiffies;
 	}
 }
 
-- 
1.9.1

