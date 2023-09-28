Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
	[209.85.221.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 85F67426843
	for <drbd-dev@lists.linbit.com>; Thu, 28 Sep 2023 11:39:00 +0200 (CEST)
Received: by mail-wr1-f43.google.com with SMTP id
	ffacd0b85a97d-3226b8de467so10837681f8f.3
	for <drbd-dev@lists.linbit.com>; Thu, 28 Sep 2023 02:39:00 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 28 Sep 2023 11:38:48 +0200
Message-ID: <20230928093852.676786-2-christoph.boehmwalder@linbit.com>
In-Reply-To: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
References: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Lars Ellenberg <lars@linbit.com>, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 1/5] drbd: Rename per-connection "worker" thread
	to "sender"
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Originally-from: Andreas Gruenbacher <agruen@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Makefile                    |  2 +-
 drivers/block/drbd/drbd_int.h                  | 10 +++++-----
 drivers/block/drbd/drbd_main.c                 | 16 ++++++++--------
 drivers/block/drbd/drbd_nl.c                   | 16 ++++++++--------
 drivers/block/drbd/drbd_req.c                  |  4 +++-
 .../drbd/{drbd_worker.c => drbd_sender.c}      | 18 +++++++++---------
 drivers/block/drbd/drbd_state.c                | 10 +++++-----
 7 files changed, 39 insertions(+), 37 deletions(-)
 rename drivers/block/drbd/{drbd_worker.c => drbd_sender.c} (99%)

diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index 67a8b352a1d5..cddece877b25 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 drbd-y := drbd_buildtag.o drbd_bitmap.o drbd_proc.o
-drbd-y += drbd_worker.o drbd_receiver.o drbd_req.o drbd_actlog.o
+drbd-y += drbd_sender.o drbd_receiver.o drbd_req.o drbd_actlog.o
 drbd-y += drbd_main.o drbd_strings.o drbd_nl.o
 drbd-y += drbd_interval.o drbd_state.o
 drbd-y += drbd_nla.o
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index a30a5ed811be..a53e63af23f1 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -665,7 +665,7 @@ struct drbd_connection {
 	/* empty member on older kernels without blk_start_plug() */
 	struct blk_plug receiver_plug;
 	struct drbd_thread receiver;
-	struct drbd_thread worker;
+	struct drbd_thread sender;
 	struct drbd_thread ack_receiver;
 	struct workqueue_struct *ack_sender;
 
@@ -1075,7 +1075,7 @@ extern int drbd_bitmap_io(struct drbd_device *device,
 		int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
 		char *why, enum bm_flag flags,
 		struct drbd_peer_device *peer_device);
-extern int drbd_bitmap_io_from_worker(struct drbd_device *device,
+extern int drbd_bitmap_io_from_sender(struct drbd_device *device,
 		int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
 		char *why, enum bm_flag flags,
 		struct drbd_peer_device *peer_device);
@@ -1422,12 +1422,12 @@ extern void conn_try_outdate_peer_async(struct drbd_connection *connection);
 extern enum drbd_peer_state conn_khelper(struct drbd_connection *connection, char *cmd);
 extern int drbd_khelper(struct drbd_device *device, char *cmd);
 
-/* drbd_worker.c */
+/* drbd_sender.c */
 /* bi_end_io handlers */
 extern void drbd_md_endio(struct bio *bio);
 extern void drbd_peer_request_endio(struct bio *bio);
 extern void drbd_request_endio(struct bio *bio);
-extern int drbd_worker(struct drbd_thread *thi);
+extern int drbd_sender(struct drbd_thread *thi);
 enum drbd_ret_code drbd_resync_after_valid(struct drbd_device *device, int o_minor);
 void drbd_resync_after_changed(struct drbd_device *device);
 extern void drbd_start_resync(struct drbd_device *device, enum drbd_conns side);
@@ -1912,7 +1912,7 @@ static inline void drbd_thread_restart_nowait(struct drbd_thread *thi)
  *  w_send_barrier
  *  _req_mod(req, QUEUE_FOR_NET_WRITE or QUEUE_FOR_NET_READ);
  *    it is much easier and equally valid to count what we queue for the
- *    worker, even before it actually was queued or send.
+ *    sender, even before it actually was queued or send.
  *    (drbd_make_request_common; recovery path on read io-error)
  * decreased:
  *  got_BarrierAck (respective tl_clear, tl_clear_barrier)
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 6bc86106c7b2..a14c1e9ee327 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -279,7 +279,7 @@ void tl_restart(struct drbd_connection *connection, enum drbd_req_event what)
  *
  * This is called after the connection to the peer was lost. The storage covered
  * by the requests on the transfer gets marked as our of sync. Called from the
- * receiver thread and the worker thread.
+ * receiver thread and the sender thread.
  */
 void tl_clear(struct drbd_connection *connection)
 {
@@ -2533,7 +2533,7 @@ int set_resource_options(struct drbd_resource *resource, struct res_opts *res_op
 		for_each_connection_rcu(connection, resource) {
 			connection->receiver.reset_cpu_mask = 1;
 			connection->ack_receiver.reset_cpu_mask = 1;
-			connection->worker.reset_cpu_mask = 1;
+			connection->sender.reset_cpu_mask = 1;
 		}
 	}
 	err = 0;
@@ -2619,8 +2619,8 @@ struct drbd_connection *conn_create(const char *name, struct res_opts *res_opts)
 
 	drbd_thread_init(resource, &connection->receiver, drbd_receiver, "receiver");
 	connection->receiver.connection = connection;
-	drbd_thread_init(resource, &connection->worker, drbd_worker, "worker");
-	connection->worker.connection = connection;
+	drbd_thread_init(resource, &connection->sender, drbd_sender, "sender");
+	connection->sender.connection = connection;
 	drbd_thread_init(resource, &connection->ack_receiver, drbd_ack_receiver, "ack_recv");
 	connection->ack_receiver.connection = connection;
 
@@ -3497,7 +3497,7 @@ static int w_bitmap_io(struct drbd_work *w, int unused)
  *
  * While IO on the bitmap happens we freeze application IO thus we ensure
  * that drbd_set_out_of_sync() can not be called. This function MAY ONLY be
- * called from worker context. It MUST NOT be used while a previous such
+ * called from sender context. It MUST NOT be used while a previous such
  * work is still pending!
  *
  * Its worker function encloses the call of io_fn() by get_ldev() and
@@ -3509,7 +3509,7 @@ void drbd_queue_bitmap_io(struct drbd_device *device,
 			  char *why, enum bm_flag flags,
 			  struct drbd_peer_device *peer_device)
 {
-	D_ASSERT(device, current == peer_device->connection->worker.task);
+	D_ASSERT(device, current == peer_device->connection->sender.task);
 
 	D_ASSERT(device, !test_bit(BITMAP_IO_QUEUED, &device->flags));
 	D_ASSERT(device, !test_bit(BITMAP_IO, &device->flags));
@@ -3544,7 +3544,7 @@ void drbd_queue_bitmap_io(struct drbd_device *device,
  * @flags:	Bitmap flags
  *
  * freezes application IO while that the actual IO operations runs. This
- * functions MAY NOT be called from worker context.
+ * functions MAY NOT be called from sender context.
  */
 int drbd_bitmap_io(struct drbd_device *device,
 		int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
@@ -3555,7 +3555,7 @@ int drbd_bitmap_io(struct drbd_device *device,
 	const bool do_suspend_io = flags & (BM_DONT_CLEAR|BM_DONT_SET|BM_DONT_TEST);
 	int rv;
 
-	D_ASSERT(device, current != first_peer_device(device)->connection->worker.task);
+	D_ASSERT(device, current != first_peer_device(device)->connection->sender.task);
 
 	if (do_suspend_io)
 		drbd_suspend_io(device);
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index d3538bd83fb3..a5844819d1c3 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -365,7 +365,7 @@ int drbd_khelper(struct drbd_device *device, char *cmd)
 	struct sib_info sib;
 	int ret;
 
-	if (current == connection->worker.task)
+	if (current == connection->sender.task)
 		set_bit(CALLBACK_PENDING, &connection->flags);
 
 	snprintf(mb, 14, "minor-%d", device_to_minor(device));
@@ -394,7 +394,7 @@ int drbd_khelper(struct drbd_device *device, char *cmd)
 	drbd_bcast_event(device, &sib);
 	notify_helper(NOTIFY_RESPONSE, device, connection, cmd, ret);
 
-	if (current == connection->worker.task)
+	if (current == connection->sender.task)
 		clear_bit(CALLBACK_PENDING, &connection->flags);
 
 	if (ret < 0) /* Ignore any ERRNOs we got. */
@@ -1349,14 +1349,14 @@ void drbd_reconsider_queue_parameters(struct drbd_device *device, struct drbd_ba
 	drbd_setup_queue_param(device, bdev, new, o);
 }
 
-/* Starts the worker thread */
+/* Starts the sender thread */
 static void conn_reconfig_start(struct drbd_connection *connection)
 {
-	drbd_thread_start(&connection->worker);
+	drbd_thread_start(&connection->sender);
 	drbd_flush_workqueue(&connection->sender_work);
 }
 
-/* if still unconfigured, stops worker again. */
+/* if still unconfigured, stops sender again. */
 static void conn_reconfig_done(struct drbd_connection *connection)
 {
 	bool stop_threads;
@@ -1368,7 +1368,7 @@ static void conn_reconfig_done(struct drbd_connection *connection)
 		/* ack_receiver thread and ack_sender workqueue are implicitly
 		 * stopped by receiver in conn_disconnect() */
 		drbd_thread_stop(&connection->receiver);
-		drbd_thread_stop(&connection->worker);
+		drbd_thread_stop(&connection->sender);
 	}
 }
 
@@ -4362,7 +4362,7 @@ static enum drbd_ret_code adm_del_minor(struct drbd_device *device)
 		/* If the state engine hasn't stopped the sender thread yet, we
 		 * need to flush the sender work queue before generating the
 		 * DESTROY events here. */
-		if (get_t_state(&connection->worker) == RUNNING)
+		if (get_t_state(&connection->sender) == RUNNING)
 			drbd_flush_workqueue(&connection->sender_work);
 
 		mutex_lock(&notification_mutex);
@@ -4424,7 +4424,7 @@ static int adm_del_resource(struct drbd_resource *resource)
 	/* Make sure all threads have actually stopped: state handling only
 	 * does drbd_thread_stop_nowait(). */
 	list_for_each_entry(connection, &resource->connections, connections)
-		drbd_thread_stop(&connection->worker);
+		drbd_thread_stop(&connection->sender);
 	synchronize_rcu();
 	drbd_free_resource(resource);
 	return NO_ERROR;
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 380e6584a4ee..cd56fd0f3b06 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -202,6 +202,7 @@ void drbd_req_complete(struct drbd_request *req, struct bio_and_error *m)
 	 *	not yet completed by the local io subsystem
 	 * these flags may get cleared in any order by
 	 *	the worker,
+	 *	the sender,
 	 *	the receiver,
 	 *	the bio_endio completion callbacks.
 	 */
@@ -717,7 +718,8 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 	case SEND_CANCELED:
 	case SEND_FAILED:
 		/* real cleanup will be done from tl_clear.  just update flags
-		 * so it is no longer marked as on the worker queue */
+		 * so it is no longer marked as on the sender queue
+		 */
 		mod_rq_state(req, m, RQ_NET_QUEUED, 0);
 		break;
 
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_sender.c
similarity index 99%
rename from drivers/block/drbd/drbd_worker.c
rename to drivers/block/drbd/drbd_sender.c
index 4352a50fbb3f..fcc8a43efdca 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_sender.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
-   drbd_worker.c
+   drbd_sender.c
 
    This file is part of DRBD by Philipp Reisner and Lars Ellenberg.
 
@@ -865,7 +865,7 @@ int drbd_resync_finished(struct drbd_peer_device *peer_device)
 	 * resync LRU would be wrong. */
 	if (drbd_rs_del_all(device)) {
 		/* In case this is not possible now, most probably because
-		 * there are P_RS_DATA_REPLY Packets lingering on the worker's
+		 * there are P_RS_DATA_REPLY Packets lingering on the sender's
 		 * queue (or even the read operations for those packets
 		 * is not finished by now).   Retry in 100ms. */
 
@@ -1587,7 +1587,7 @@ static bool drbd_pause_after(struct drbd_device *device)
  * drbd_resume_next() - Resume resync on all devices that may resync now
  * @device:	DRBD device.
  *
- * Called from process context only (admin command and worker).
+ * Called from process context only (admin command and sender).
  */
 static bool drbd_resume_next(struct drbd_device *device)
 {
@@ -1783,8 +1783,8 @@ void drbd_start_resync(struct drbd_device *device, enum drbd_conns side)
 		}
 	}
 
-	if (current == connection->worker.task) {
-		/* The worker should not sleep waiting for state_mutex,
+	if (current == connection->sender.task) {
+		/* The sender should not sleep waiting for state_mutex,
 		   that can take long */
 		if (!mutex_trylock(device->state_mutex)) {
 			set_bit(B_RS_H_DONE, &device->flags);
@@ -1977,7 +1977,7 @@ static void go_diskless(struct drbd_device *device)
 		 * while we detach.
 		 * Any modifications would not be expected anymore, though.
 		 */
-		if (drbd_bitmap_io_from_worker(device, drbd_bm_write,
+		if (drbd_bitmap_io_from_sender(device, drbd_bm_write,
 					"detach", BM_LOCKED_TEST_ALLOWED, peer_device)) {
 			if (test_bit(WAS_READ_ERROR, &device->flags)) {
 				drbd_md_set_flag(device, MDF_FULL_SYNC);
@@ -2142,7 +2142,7 @@ static void wait_for_work(struct drbd_connection *connection, struct list_head *
 			break;
 
 		/* drbd_send() may have called flush_signals() */
-		if (get_t_state(&connection->worker) != RUNNING)
+		if (get_t_state(&connection->sender) != RUNNING)
 			break;
 
 		schedule();
@@ -2167,7 +2167,7 @@ static void wait_for_work(struct drbd_connection *connection, struct list_head *
 	mutex_unlock(&connection->data.mutex);
 }
 
-int drbd_worker(struct drbd_thread *thi)
+int drbd_sender(struct drbd_thread *thi)
 {
 	struct drbd_connection *connection = thi->connection;
 	struct drbd_work *w = NULL;
@@ -2191,7 +2191,7 @@ int drbd_worker(struct drbd_thread *thi)
 		if (signal_pending(current)) {
 			flush_signals(current);
 			if (get_t_state(thi) == RUNNING) {
-				drbd_warn(connection, "Worker got an unexpected signal\n");
+				drbd_warn(connection, "Sender got an unexpected signal\n");
 				continue;
 			}
 			break;
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 287a8d1d3f70..c623769abc1a 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -622,7 +622,7 @@ drbd_req_state(struct drbd_device *device, union drbd_state mask,
 	spin_unlock_irqrestore(&device->resource->req_lock, flags);
 
 	if (f & CS_WAIT_COMPLETE && rv == SS_SUCCESS) {
-		D_ASSERT(device, current != first_peer_device(device)->connection->worker.task);
+		D_ASSERT(device, current != first_peer_device(device)->connection->sender.task);
 		wait_for_completion(&done);
 	}
 
@@ -1519,14 +1519,14 @@ static void abw_start_sync(struct drbd_device *device, int rv)
 	}
 }
 
-int drbd_bitmap_io_from_worker(struct drbd_device *device,
+int drbd_bitmap_io_from_sender(struct drbd_device *device,
 		int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
 		char *why, enum bm_flag flags,
 		struct drbd_peer_device *peer_device)
 {
 	int rv;
 
-	D_ASSERT(device, current == first_peer_device(device)->connection->worker.task);
+	D_ASSERT(device, current == first_peer_device(device)->connection->sender.task);
 
 	/* open coded non-blocking drbd_suspend_io(device); */
 	atomic_inc(&device->suspend_cnt);
@@ -1841,7 +1841,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 			/* We may still be Primary ourselves.
 			 * No harm done if the bitmap still changes,
 			 * redirtied pages will follow later. */
-			drbd_bitmap_io_from_worker(device, &drbd_bm_write,
+			drbd_bitmap_io_from_sender(device, &drbd_bm_write,
 				"demote diskless peer", BM_LOCKED_SET_ALLOWED, peer_device);
 		put_ldev(device);
 	}
@@ -1853,7 +1853,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 		device->state.conn <= C_CONNECTED && get_ldev(device)) {
 		/* No changes to the bitmap expected this time, so assert that,
 		 * even though no harm was done if it did change. */
-		drbd_bitmap_io_from_worker(device, &drbd_bm_write,
+		drbd_bitmap_io_from_sender(device, &drbd_bm_write,
 				"demote", BM_LOCKED_TEST_ALLOWED, peer_device);
 		put_ldev(device);
 	}
-- 
2.41.0

