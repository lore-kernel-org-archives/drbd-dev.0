Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DCC63100EC11
	for <drbd-dev@lists.linbit.com>; Tue,  4 Aug 2015 14:56:57 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue,  4 Aug 2015 14:56:25 +0200
Message-Id: <1438693003-17554-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1438693003-17554-1-git-send-email-philipp.reisner@linbit.com>
References: <1438693003-17554-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/19] drbd: Rename asender to ack_receiver
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
index cb5fb68..3d5f3c0 100644
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
@@ -1558,7 +1558,7 @@ extern void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req);
 
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
index 81a8679..3f7371d 100644
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
index d4c61af..5521465 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1098,7 +1098,7 @@ randomize:
 		return 0;
 	}
 
-	drbd_thread_start(&connection->asender);
+	drbd_thread_start(&connection->ack_receiver);
 
 	mutex_lock(&connection->resource->conf_update);
 	/* The discard_my_data flag is a single-shot modifier to the next
@@ -4655,7 +4655,7 @@ static void conn_disconnect(struct drbd_connection *connection)
 	conn_request_state(connection, NS(conn, C_NETWORK_FAILURE), CS_HARD);
 
 	/* asender does not clean up anything. it must not interfere, either */
-	drbd_thread_stop(&connection->asender);
+	drbd_thread_stop(&connection->ack_receiver);
 	drbd_free_sock(connection);
 
 	rcu_read_lock();
@@ -5486,7 +5486,7 @@ static struct asender_cmd asender_tbl[] = {
 	[P_RETRY_WRITE]	    = { sizeof(struct p_block_ack), got_BlockAck },
 };
 
-int drbd_asender(struct drbd_thread *thi)
+int drbd_ack_receiver(struct drbd_thread *thi)
 {
 	struct drbd_connection *connection = thi->connection;
 	struct asender_cmd *cmd = NULL;
-- 
1.9.1

