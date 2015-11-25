Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5D2A510562A3
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:35 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:53:54 +0100
Message-Id: <1448448851-10343-22-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 21/38] drbd: Rename asender to ack_receiver
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

This prepares the next patch where the sending on the meta (or
control) socket is moved to a dedicated workqueue.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h      |  6 +++---
 drivers/block/drbd/drbd_main.c     | 10 +++++-----
 drivers/block/drbd/drbd_receiver.c |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 1d00f2e..dee6297 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -754,7 +754,7 @@ struct drbd_connection {
 	unsigned long last_reconnect_jif;
 	struct drbd_thread receiver;
 	struct drbd_thread worker;
-	struct drbd_thread asender;
+	struct drbd_thread ack_receiver;
 
 	/* cached pointers,
 	 * so we can look up the oldest pending requests more quickly.
@@ -1557,7 +1557,7 @@ extern void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req);
 
 /* drbd_receiver.c */
 extern int drbd_receiver(struct drbd_thread *thi);
-extern int drbd_asender(struct drbd_thread *thi);
+extern int drbd_ack_receiver(struct drbd_thread *thi);
 extern bool drbd_rs_c_min_rate_throttle(struct drbd_device *device);
 extern bool drbd_rs_should_slow_down(struct drbd_device *device, sector_t sector,
 		bool throttle_if_app_is_waiting);
@@ -1971,7 +1971,7 @@ extern void drbd_flush_workqueue(struct drbd_work_queue *work_queue);
 static inline void wake_asender(struct drbd_connection *connection)
 {
 	if (test_bit(SIGNAL_ASENDER, &connection->flags))
-		force_sig(DRBD_SIG, connection->asender.task);
+		force_sig(DRBD_SIG, connection->ack_receiver.task);
 }
 
 static inline void request_ping(struct drbd_connection *connection)
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index f66294d..445f2c8 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1436,8 +1436,8 @@ static int we_should_drop_the_connection(struct drbd_connection *connection, str
 	/* long elapsed = (long)(jiffies - device->last_received); */
 
 	drop_it =   connection->meta.socket == sock
-		|| !connection->asender.task
-		|| get_t_state(&connection->asender) != RUNNING
+		|| !connection->ack_receiver.task
+		|| get_t_state(&connection->ack_receiver) != RUNNING
 		|| connection->cstate < C_WF_REPORT_PARAMS;
 
 	if (drop_it)
@@ -2564,7 +2564,7 @@ int set_resource_options(struct drbd_resource *resource, struct res_opts *res_op
 		cpumask_copy(resource->cpu_mask, new_cpu_mask);
 		for_each_connection_rcu(connection, resource) {
 			connection->receiver.reset_cpu_mask = 1;
-			connection->asender.reset_cpu_mask = 1;
+			connection->ack_receiver.reset_cpu_mask = 1;
 			connection->worker.reset_cpu_mask = 1;
 		}
 	}
@@ -2653,8 +2653,8 @@ struct drbd_connection *conn_create(const char *name, struct res_opts *res_opts)
 	connection->receiver.connection = connection;
 	drbd_thread_init(resource, &connection->worker, drbd_worker, "worker");
 	connection->worker.connection = connection;
-	drbd_thread_init(resource, &connection->asender, drbd_asender, "asender");
-	connection->asender.connection = connection;
+	drbd_thread_init(resource, &connection->ack_receiver, drbd_ack_receiver, "ack_recv");
+	connection->ack_receiver.connection = connection;
 
 	kref_init(&connection->kref);
 
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 61b73c7..eed4ae9 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1099,7 +1099,7 @@ randomize:
 		return 0;
 	}
 
-	drbd_thread_start(&connection->asender);
+	drbd_thread_start(&connection->ack_receiver);
 
 	mutex_lock(&connection->resource->conf_update);
 	/* The discard_my_data flag is a single-shot modifier to the next
@@ -4656,7 +4656,7 @@ static void conn_disconnect(struct drbd_connection *connection)
 	conn_request_state(connection, NS(conn, C_NETWORK_FAILURE), CS_HARD);
 
 	/* asender does not clean up anything. it must not interfere, either */
-	drbd_thread_stop(&connection->asender);
+	drbd_thread_stop(&connection->ack_receiver);
 	drbd_free_sock(connection);
 
 	rcu_read_lock();
@@ -5487,7 +5487,7 @@ static struct asender_cmd asender_tbl[] = {
 	[P_RETRY_WRITE]	    = { sizeof(struct p_block_ack), got_BlockAck },
 };
 
-int drbd_asender(struct drbd_thread *thi)
+int drbd_ack_receiver(struct drbd_thread *thi)
 {
 	struct drbd_connection *connection = thi->connection;
 	struct asender_cmd *cmd = NULL;
-- 
1.9.1

