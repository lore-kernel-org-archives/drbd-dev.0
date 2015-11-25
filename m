Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7E03A10562A5
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:35 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:53:55 +0100
Message-Id: <1448448851-10343-23-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 22/38] drbd: Create a dedicated workqueue for
	sending acks on the control connection
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

The intention is to reduce CPU utilization. Recent measurements
unveiled that the current performance bottleneck is CPU utilization
on the receiving node. The asender thread became CPU limited.

One of the main points is to eliminate the idr_for_each_entry() loop
from the sending acks code path.

One exception in that is sending back ping_acks. These stay
in the ack-receiver thread. Otherwise the logic becomes too
complicated for no added value.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h      |  27 ++---
 drivers/block/drbd/drbd_main.c     |  10 +-
 drivers/block/drbd/drbd_nl.c       |   4 +-
 drivers/block/drbd/drbd_protocol.h |   2 +-
 drivers/block/drbd/drbd_receiver.c | 203 +++++++++++++++++++++----------------
 drivers/block/drbd/drbd_req.c      |   2 +-
 drivers/block/drbd/drbd_worker.c   |   8 +-
 7 files changed, 141 insertions(+), 115 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index dee6297..3efaf18 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -77,13 +77,6 @@ extern int fault_devs;
 extern char usermode_helper[];
 
 
-/* I don't remember why XCPU ...
- * This is used to wake the asender,
- * and to interrupt sending the sending task
- * on disconnect.
- */
-#define DRBD_SIG SIGXCPU
-
 /* This is used to stop/restart our threads.
  * Cannot use SIGTERM nor SIGKILL, since these
  * are sent out by init on runlevel changes
@@ -647,8 +640,7 @@ extern struct fifo_buffer *fifo_alloc(int fifo_size);
 enum {
 	NET_CONGESTED,		/* The data socket is congested */
 	RESOLVE_CONFLICTS,	/* Set on one node, cleared on the peer! */
-	SEND_PING,		/* whether asender should send a ping asap */
-	SIGNAL_ASENDER,		/* whether asender wants to be interrupted */
+	SEND_PING,
 	GOT_PING_ACK,		/* set when we receive a ping_ack packet, ping_wait gets woken */
 	CONN_WD_ST_CHG_REQ,	/* A cluster wide state change on the connection is active */
 	CONN_WD_ST_CHG_OKAY,
@@ -755,6 +747,7 @@ struct drbd_connection {
 	struct drbd_thread receiver;
 	struct drbd_thread worker;
 	struct drbd_thread ack_receiver;
+	struct workqueue_struct *ack_sender;
 
 	/* cached pointers,
 	 * so we can look up the oldest pending requests more quickly.
@@ -823,6 +816,7 @@ struct drbd_peer_device {
 	struct list_head peer_devices;
 	struct drbd_device *device;
 	struct drbd_connection *connection;
+	struct work_struct send_acks_work;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_peer_dev;
 #endif
@@ -1558,6 +1552,8 @@ extern void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req);
 /* drbd_receiver.c */
 extern int drbd_receiver(struct drbd_thread *thi);
 extern int drbd_ack_receiver(struct drbd_thread *thi);
+extern void drbd_send_ping_wf(struct work_struct *ws);
+extern void drbd_send_acks_wf(struct work_struct *ws);
 extern bool drbd_rs_c_min_rate_throttle(struct drbd_device *device);
 extern bool drbd_rs_should_slow_down(struct drbd_device *device, sector_t sector,
 		bool throttle_if_app_is_waiting);
@@ -1968,16 +1964,21 @@ drbd_device_post_work(struct drbd_device *device, int work_bit)
 
 extern void drbd_flush_workqueue(struct drbd_work_queue *work_queue);
 
-static inline void wake_asender(struct drbd_connection *connection)
+/* To get the ack_receiver out of the blocking network stack,
+ * so it can change its sk_rcvtimeo from idle- to ping-timeout,
+ * and send a ping, we need to send a signal.
+ * Which signal we send is irrelevant. */
+static inline void wake_ack_receiver(struct drbd_connection *connection)
 {
-	if (test_bit(SIGNAL_ASENDER, &connection->flags))
-		force_sig(DRBD_SIG, connection->ack_receiver.task);
+	struct task_struct *task = connection->ack_receiver.task;
+	if (task && get_t_state(&connection->ack_receiver) == RUNNING)
+		force_sig(SIGXCPU, task);
 }
 
 static inline void request_ping(struct drbd_connection *connection)
 {
 	set_bit(SEND_PING, &connection->flags);
-	wake_asender(connection);
+	wake_ack_receiver(connection);
 }
 
 extern void *conn_prepare_command(struct drbd_connection *, struct drbd_socket *);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 445f2c8..938bca2 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1794,15 +1794,6 @@ int drbd_send(struct drbd_connection *connection, struct socket *sock,
 		drbd_update_congested(connection);
 	}
 	do {
-		/* STRANGE
-		 * tcp_sendmsg does _not_ use its size parameter at all ?
-		 *
-		 * -EAGAIN on timeout, -EINTR on signal.
-		 */
-/* THINK
- * do we need to block DRBD_SIG if sock == &meta.socket ??
- * otherwise wake_asender() might interrupt some send_*Ack !
- */
 		rv = kernel_sendmsg(sock, &msg, &iov, 1, size);
 		if (rv == -EAGAIN) {
 			if (we_should_drop_the_connection(connection, sock))
@@ -2821,6 +2812,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 			goto out_idr_remove_from_resource;
 		}
 		kref_get(&connection->kref);
+		INIT_WORK(&peer_device->send_acks_work, drbd_send_acks_wf);
 	}
 
 	if (init_submitter(device)) {
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 79dc3d4..f35cefb 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1258,8 +1258,8 @@ static void conn_reconfig_done(struct drbd_connection *connection)
 		connection->cstate == C_STANDALONE;
 	spin_unlock_irq(&connection->resource->req_lock);
 	if (stop_threads) {
-		/* asender is implicitly stopped by receiver
-		 * in conn_disconnect() */
+		/* ack_receiver thread and ack_sender workqueue are implicitly
+		 * stopped by receiver in conn_disconnect() */
 		drbd_thread_stop(&connection->receiver);
 		drbd_thread_stop(&connection->worker);
 	}
diff --git a/drivers/block/drbd/drbd_protocol.h b/drivers/block/drbd/drbd_protocol.h
index 2da9104a..ef92453 100644
--- a/drivers/block/drbd/drbd_protocol.h
+++ b/drivers/block/drbd/drbd_protocol.h
@@ -23,7 +23,7 @@ enum drbd_packet {
 	P_AUTH_RESPONSE	      = 0x11,
 	P_STATE_CHG_REQ	      = 0x12,
 
-	/* asender (meta socket */
+	/* (meta socket) */
 	P_PING		      = 0x13,
 	P_PING_ACK	      = 0x14,
 	P_RECV_ACK	      = 0x15, /* Used in protocol B */
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index eed4ae9..ea54341 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -215,7 +215,7 @@ static void reclaim_finished_net_peer_reqs(struct drbd_device *device,
 	}
 }
 
-static void drbd_kick_lo_and_reclaim_net(struct drbd_device *device)
+static void drbd_reclaim_net_peer_reqs(struct drbd_device *device)
 {
 	LIST_HEAD(reclaimed);
 	struct drbd_peer_request *peer_req, *t;
@@ -223,11 +223,30 @@ static void drbd_kick_lo_and_reclaim_net(struct drbd_device *device)
 	spin_lock_irq(&device->resource->req_lock);
 	reclaim_finished_net_peer_reqs(device, &reclaimed);
 	spin_unlock_irq(&device->resource->req_lock);
-
 	list_for_each_entry_safe(peer_req, t, &reclaimed, w.list)
 		drbd_free_net_peer_req(device, peer_req);
 }
 
+static void conn_reclaim_net_peer_reqs(struct drbd_connection *connection)
+{
+	struct drbd_peer_device *peer_device;
+	int vnr;
+
+	rcu_read_lock();
+	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+		struct drbd_device *device = peer_device->device;
+		if (!atomic_read(&device->pp_in_use_by_net))
+			continue;
+
+		kref_get(&device->kref);
+		rcu_read_unlock();
+		drbd_reclaim_net_peer_reqs(device);
+		kref_put(&device->kref, drbd_destroy_device);
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+}
+
 /**
  * drbd_alloc_pages() - Returns @number pages, retries forever (or until signalled)
  * @device:	DRBD device.
@@ -265,10 +284,15 @@ struct page *drbd_alloc_pages(struct drbd_peer_device *peer_device, unsigned int
 	if (atomic_read(&device->pp_in_use) < mxb)
 		page = __drbd_alloc_pages(device, number);
 
+	/* Try to keep the fast path fast, but occasionally we need
+	 * to reclaim the pages we lended to the network stack. */
+	if (page && atomic_read(&device->pp_in_use_by_net) > 512)
+		drbd_reclaim_net_peer_reqs(device);
+
 	while (page == NULL) {
 		prepare_to_wait(&drbd_pp_wait, &wait, TASK_INTERRUPTIBLE);
 
-		drbd_kick_lo_and_reclaim_net(device);
+		drbd_reclaim_net_peer_reqs(device);
 
 		if (atomic_read(&device->pp_in_use) < mxb) {
 			page = __drbd_alloc_pages(device, number);
@@ -1100,6 +1124,11 @@ randomize:
 	}
 
 	drbd_thread_start(&connection->ack_receiver);
+	connection->ack_sender = create_singlethread_workqueue("drbd_ack_sender");
+	if (!connection->ack_sender) {
+		drbd_err(connection, "Failed to create workqueue ack_sender\n");
+		return 0;
+	}
 
 	mutex_lock(&connection->resource->conf_update);
 	/* The discard_my_data flag is a single-shot modifier to the next
@@ -1746,7 +1775,7 @@ static int recv_dless_read(struct drbd_peer_device *peer_device, struct drbd_req
 }
 
 /*
- * e_end_resync_block() is called in asender context via
+ * e_end_resync_block() is called in ack_sender context via
  * drbd_finish_peer_reqs().
  */
 static int e_end_resync_block(struct drbd_work *w, int unused)
@@ -1920,7 +1949,7 @@ static void restart_conflicting_writes(struct drbd_device *device,
 }
 
 /*
- * e_end_block() is called in asender context via drbd_finish_peer_reqs().
+ * e_end_block() is called in ack_sender context via drbd_finish_peer_reqs().
  */
 static int e_end_block(struct drbd_work *w, int cancel)
 {
@@ -2211,7 +2240,7 @@ static int handle_write_conflicts(struct drbd_device *device,
 			peer_req->w.cb = superseded ? e_send_superseded :
 						   e_send_retry_write;
 			list_add_tail(&peer_req->w.list, &device->done_ee);
-			wake_asender(connection);
+			queue_work(connection->ack_sender, &peer_req->peer_device->send_acks_work);
 
 			err = -ENOENT;
 			goto out;
@@ -4050,7 +4079,7 @@ static int receive_state(struct drbd_connection *connection, struct packet_info
 	os = ns = drbd_read_state(device);
 	spin_unlock_irq(&device->resource->req_lock);
 
-	/* If some other part of the code (asender thread, timeout)
+	/* If some other part of the code (ack_receiver thread, timeout)
 	 * already decided to close the connection again,
 	 * we must not "re-establish" it here. */
 	if (os.conn <= C_TEAR_DOWN)
@@ -4655,8 +4684,12 @@ static void conn_disconnect(struct drbd_connection *connection)
 	 */
 	conn_request_state(connection, NS(conn, C_NETWORK_FAILURE), CS_HARD);
 
-	/* asender does not clean up anything. it must not interfere, either */
+	/* ack_receiver does not clean up anything. it must not interfere, either */
 	drbd_thread_stop(&connection->ack_receiver);
+	if (connection->ack_sender) {
+		destroy_workqueue(connection->ack_sender);
+		connection->ack_sender = NULL;
+	}
 	drbd_free_sock(connection);
 
 	rcu_read_lock();
@@ -5425,49 +5458,39 @@ static int got_skip(struct drbd_connection *connection, struct packet_info *pi)
 	return 0;
 }
 
-static int connection_finish_peer_reqs(struct drbd_connection *connection)
+struct meta_sock_cmd {
+	size_t pkt_size;
+	int (*fn)(struct drbd_connection *connection, struct packet_info *);
+};
+
+static void set_rcvtimeo(struct drbd_connection *connection, bool ping_timeout)
 {
-	struct drbd_peer_device *peer_device;
-	int vnr, not_empty = 0;
+	long t;
+	struct net_conf *nc;
 
-	do {
-		clear_bit(SIGNAL_ASENDER, &connection->flags);
-		flush_signals(current);
+	rcu_read_lock();
+	nc = rcu_dereference(connection->net_conf);
+	t = ping_timeout ? nc->ping_timeo : nc->ping_int;
+	rcu_read_unlock();
 
-		rcu_read_lock();
-		idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
-			struct drbd_device *device = peer_device->device;
-			kref_get(&device->kref);
-			rcu_read_unlock();
-			if (drbd_finish_peer_reqs(device)) {
-				kref_put(&device->kref, drbd_destroy_device);
-				return 1;
-			}
-			kref_put(&device->kref, drbd_destroy_device);
-			rcu_read_lock();
-		}
-		set_bit(SIGNAL_ASENDER, &connection->flags);
+	t *= HZ;
+	if (ping_timeout)
+		t /= 10;
 
-		spin_lock_irq(&connection->resource->req_lock);
-		idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
-			struct drbd_device *device = peer_device->device;
-			not_empty = !list_empty(&device->done_ee);
-			if (not_empty)
-				break;
-		}
-		spin_unlock_irq(&connection->resource->req_lock);
-		rcu_read_unlock();
-	} while (not_empty);
+	connection->meta.socket->sk->sk_rcvtimeo = t;
+}
 
-	return 0;
+static void set_ping_timeout(struct drbd_connection *connection)
+{
+	set_rcvtimeo(connection, 1);
 }
 
-struct asender_cmd {
-	size_t pkt_size;
-	int (*fn)(struct drbd_connection *connection, struct packet_info *);
-};
+static void set_idle_timeout(struct drbd_connection *connection)
+{
+	set_rcvtimeo(connection, 0);
+}
 
-static struct asender_cmd asender_tbl[] = {
+static struct meta_sock_cmd ack_receiver_tbl[] = {
 	[P_PING]	    = { 0, got_Ping },
 	[P_PING_ACK]	    = { 0, got_PingAck },
 	[P_RECV_ACK]	    = { sizeof(struct p_block_ack), got_BlockAck },
@@ -5490,61 +5513,37 @@ static struct asender_cmd asender_tbl[] = {
 int drbd_ack_receiver(struct drbd_thread *thi)
 {
 	struct drbd_connection *connection = thi->connection;
-	struct asender_cmd *cmd = NULL;
+	struct meta_sock_cmd *cmd = NULL;
 	struct packet_info pi;
+	unsigned long pre_recv_jif;
 	int rv;
 	void *buf    = connection->meta.rbuf;
 	int received = 0;
 	unsigned int header_size = drbd_header_size(connection);
 	int expect   = header_size;
 	bool ping_timeout_active = false;
-	struct net_conf *nc;
-	int ping_timeo, tcp_cork, ping_int;
 	struct sched_param param = { .sched_priority = 2 };
 
 	rv = sched_setscheduler(current, SCHED_RR, &param);
 	if (rv < 0)
-		drbd_err(connection, "drbd_asender: ERROR set priority, ret=%d\n", rv);
+		drbd_err(connection, "drbd_ack_receiver: ERROR set priority, ret=%d\n", rv);
 
 	while (get_t_state(thi) == RUNNING) {
 		drbd_thread_current_set_cpu(thi);
 
-		rcu_read_lock();
-		nc = rcu_dereference(connection->net_conf);
-		ping_timeo = nc->ping_timeo;
-		tcp_cork = nc->tcp_cork;
-		ping_int = nc->ping_int;
-		rcu_read_unlock();
+		conn_reclaim_net_peer_reqs(connection);
 
 		if (test_and_clear_bit(SEND_PING, &connection->flags)) {
 			if (drbd_send_ping(connection)) {
 				drbd_err(connection, "drbd_send_ping has failed\n");
 				goto reconnect;
 			}
-			connection->meta.socket->sk->sk_rcvtimeo = ping_timeo * HZ / 10;
+			set_ping_timeout(connection);
 			ping_timeout_active = true;
 		}
 
-		/* TODO: conditionally cork; it may hurt latency if we cork without
-		   much to send */
-		if (tcp_cork)
-			drbd_tcp_cork(connection->meta.socket);
-		if (connection_finish_peer_reqs(connection)) {
-			drbd_err(connection, "connection_finish_peer_reqs() failed\n");
-			goto reconnect;
-		}
-		/* but unconditionally uncork unless disabled */
-		if (tcp_cork)
-			drbd_tcp_uncork(connection->meta.socket);
-
-		/* short circuit, recv_msg would return EINTR anyways. */
-		if (signal_pending(current))
-			continue;
-
+		pre_recv_jif = jiffies;
 		rv = drbd_recv_short(connection->meta.socket, buf, expect-received, 0);
-		clear_bit(SIGNAL_ASENDER, &connection->flags);
-
-		flush_signals(current);
 
 		/* Note:
 		 * -EINTR	 (on meta) we got a signal
@@ -5556,7 +5555,6 @@ int drbd_ack_receiver(struct drbd_thread *thi)
 		 * rv <  expected: "woken" by signal during receive
 		 * rv == 0	 : "connection shut down by peer"
 		 */
-received_more:
 		if (likely(rv > 0)) {
 			received += rv;
 			buf	 += rv;
@@ -5578,8 +5576,7 @@ received_more:
 		} else if (rv == -EAGAIN) {
 			/* If the data socket received something meanwhile,
 			 * that is good enough: peer is still alive. */
-			if (time_after(connection->last_received,
-				jiffies - connection->meta.socket->sk->sk_rcvtimeo))
+			if (time_after(connection->last_received, pre_recv_jif))
 				continue;
 			if (ping_timeout_active) {
 				drbd_err(connection, "PingAck did not arrive in time.\n");
@@ -5588,6 +5585,10 @@ received_more:
 			set_bit(SEND_PING, &connection->flags);
 			continue;
 		} else if (rv == -EINTR) {
+			/* maybe drbd_thread_stop(): the while condition will notice.
+			 * maybe woken for send_ping: we'll send a ping above,
+			 * and change the rcvtimeo */
+			flush_signals(current);
 			continue;
 		} else {
 			drbd_err(connection, "sock_recvmsg returned %d\n", rv);
@@ -5597,8 +5598,8 @@ received_more:
 		if (received == expect && cmd == NULL) {
 			if (decode_header(connection, connection->meta.rbuf, &pi))
 				goto reconnect;
-			cmd = &asender_tbl[pi.cmd];
-			if (pi.cmd >= ARRAY_SIZE(asender_tbl) || !cmd->fn) {
+			cmd = &ack_receiver_tbl[pi.cmd];
+			if (pi.cmd >= ARRAY_SIZE(ack_receiver_tbl) || !cmd->fn) {
 				drbd_err(connection, "Unexpected meta packet %s (0x%04x)\n",
 					 cmdname(pi.cmd), pi.cmd);
 				goto disconnect;
@@ -5621,9 +5622,8 @@ received_more:
 
 			connection->last_received = jiffies;
 
-			if (cmd == &asender_tbl[P_PING_ACK]) {
-				/* restore idle timeout */
-				connection->meta.socket->sk->sk_rcvtimeo = ping_int * HZ;
+			if (cmd == &ack_receiver_tbl[P_PING_ACK]) {
+				set_idle_timeout(connection);
 				ping_timeout_active = false;
 			}
 
@@ -5632,11 +5632,6 @@ received_more:
 			expect	 = header_size;
 			cmd	 = NULL;
 		}
-		if (test_bit(SEND_PING, &connection->flags))
-			continue;
-		rv = drbd_recv_short(connection->meta.socket, buf, expect-received, MSG_DONTWAIT);
-		if (rv > 0)
-			goto received_more;
 	}
 
 	if (0) {
@@ -5648,9 +5643,41 @@ reconnect:
 disconnect:
 		conn_request_state(connection, NS(conn, C_DISCONNECTING), CS_HARD);
 	}
-	clear_bit(SIGNAL_ASENDER, &connection->flags);
 
-	drbd_info(connection, "asender terminated\n");
+	drbd_info(connection, "ack_receiver terminated\n");
 
 	return 0;
 }
+
+void drbd_send_acks_wf(struct work_struct *ws)
+{
+	struct drbd_peer_device *peer_device =
+		container_of(ws, struct drbd_peer_device, send_acks_work);
+	struct drbd_connection *connection = peer_device->connection;
+	struct drbd_device *device = peer_device->device;
+	struct net_conf *nc;
+	int tcp_cork, err;
+
+	rcu_read_lock();
+	nc = rcu_dereference(connection->net_conf);
+	tcp_cork = nc->tcp_cork;
+	rcu_read_unlock();
+
+	if (tcp_cork)
+		drbd_tcp_cork(connection->meta.socket);
+
+	err = drbd_finish_peer_reqs(device);
+	kref_put(&device->kref, drbd_destroy_device);
+	/* get is in drbd_endio_write_sec_final(). That is necessary to keep the
+	   struct work_struct send_acks_work alive, which is in the peer_device object */
+
+	if (err) {
+		conn_request_state(connection, NS(conn, C_NETWORK_FAILURE), CS_HARD);
+		return;
+	}
+
+	if (tcp_cork)
+		drbd_tcp_uncork(connection->meta.socket);
+
+	return;
+}
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 3add7c5..7907fb5 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -453,7 +453,7 @@ static void mod_rq_state(struct drbd_request *req, struct bio_and_error *m,
 		kref_get(&req->kref); /* wait for the DONE */
 
 	if (!(s & RQ_NET_SENT) && (set & RQ_NET_SENT)) {
-		/* potentially already completed in the asender thread */
+		/* potentially already completed in the ack_receiver thread */
 		if (!(s & RQ_NET_DONE)) {
 			atomic_add(req->i.size >> 9, &device->ap_in_flight);
 			set_if_null_req_not_net_done(peer_device, req);
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 8bbabe3..2f29bf3 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -113,6 +113,7 @@ void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req) __releases(l
 	unsigned long flags = 0;
 	struct drbd_peer_device *peer_device = peer_req->peer_device;
 	struct drbd_device *device = peer_device->device;
+	struct drbd_connection *connection = peer_device->connection;
 	struct drbd_interval i;
 	int do_wake;
 	u64 block_id;
@@ -145,6 +146,12 @@ void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req) __releases(l
 	 * ((peer_req->flags & (EE_WAS_ERROR|EE_IS_TRIM)) == EE_WAS_ERROR) */
 	if (peer_req->flags & EE_WAS_ERROR)
 		__drbd_chk_io_error(device, DRBD_WRITE_ERROR);
+
+	if (connection->cstate >= C_WF_REPORT_PARAMS) {
+		kref_get(&device->kref); /* put is in drbd_send_acks_wf() */
+		if (!queue_work(connection->ack_sender, &peer_device->send_acks_work))
+			kref_put(&device->kref, drbd_destroy_device);
+	}
 	spin_unlock_irqrestore(&device->resource->req_lock, flags);
 
 	if (block_id == ID_SYNCER)
@@ -156,7 +163,6 @@ void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req) __releases(l
 	if (do_al_complete_io)
 		drbd_al_complete_io(device, &i);
 
-	wake_asender(peer_device->connection);
 	put_ldev(device);
 }
 
-- 
1.9.1

