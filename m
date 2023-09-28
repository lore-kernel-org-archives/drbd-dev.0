Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
	[209.85.128.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 847DA426844
	for <drbd-dev@lists.linbit.com>; Thu, 28 Sep 2023 11:39:01 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
	5b1f17b1804b1-4054f790190so117108055e9.2
	for <drbd-dev@lists.linbit.com>; Thu, 28 Sep 2023 02:39:01 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 28 Sep 2023 11:38:49 +0200
Message-ID: <20230928093852.676786-3-christoph.boehmwalder@linbit.com>
In-Reply-To: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
References: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Lars Ellenberg <lars@linbit.com>, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 2/5] drbd: Add new per-resource "worker" thread
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

Out-of-tree fixes folded in:
- drbd: allow to dequeue batches of work at a time (partial backport)
- drbd: Keep "worker" alive while resource exists
- Flush the work queue before stopping the worker thread

Originally-from: Andreas Gruenbacher <agruen@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_int.h    |  4 +++
 drivers/block/drbd/drbd_main.c   |  5 ++++
 drivers/block/drbd/drbd_nl.c     |  2 +-
 drivers/block/drbd/drbd_sender.c | 46 ++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index a53e63af23f1..fe7e93a4dfa6 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -603,6 +603,9 @@ struct drbd_resource {
 	enum write_ordering_e write_ordering;
 
 	cpumask_var_t cpu_mask;
+
+	struct drbd_work_queue work;
+	struct drbd_thread worker;
 };
 
 struct drbd_thread_timing_details
@@ -1428,6 +1431,7 @@ extern void drbd_md_endio(struct bio *bio);
 extern void drbd_peer_request_endio(struct bio *bio);
 extern void drbd_request_endio(struct bio *bio);
 extern int drbd_sender(struct drbd_thread *thi);
+extern int drbd_worker(struct drbd_thread *thi);
 enum drbd_ret_code drbd_resync_after_valid(struct drbd_device *device, int o_minor);
 void drbd_resync_after_changed(struct drbd_device *device);
 extern void drbd_start_resync(struct drbd_device *device, enum drbd_conns side);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index a14c1e9ee327..bb5de1e1ca9f 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2329,6 +2329,8 @@ void drbd_free_resource(struct drbd_resource *resource)
 {
 	struct drbd_connection *connection, *tmp;
 
+	drbd_flush_workqueue(&resource->work);
+	drbd_thread_stop(&resource->worker);
 	for_each_connection_safe(connection, tmp, resource) {
 		list_del(&connection->connections);
 		drbd_debugfs_connection_cleanup(connection);
@@ -2564,6 +2566,9 @@ struct drbd_resource *drbd_create_resource(const char *name)
 	mutex_init(&resource->conf_update);
 	mutex_init(&resource->adm_mutex);
 	spin_lock_init(&resource->req_lock);
+	drbd_init_workqueue(&resource->work);
+	drbd_thread_init(resource, &resource->worker, drbd_worker, "worker");
+	drbd_thread_start(&resource->worker);
 	drbd_debugfs_resource_add(resource);
 	return resource;
 
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index a5844819d1c3..9d9ced46f968 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1900,7 +1900,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	 */
 	wait_event(device->misc_wait, !atomic_read(&device->ap_pending_cnt) || drbd_suspended(device));
 	/* and for any other previously queued work */
-	drbd_flush_workqueue(&connection->sender_work);
+	drbd_flush_workqueue(&device->resource->work);
 
 	rv = _drbd_request_state(device, NS(disk, D_ATTACHING), CS_VERBOSE);
 	retcode = (enum drbd_ret_code)rv;
diff --git a/drivers/block/drbd/drbd_sender.c b/drivers/block/drbd/drbd_sender.c
index fcc8a43efdca..0c482d45a52a 100644
--- a/drivers/block/drbd/drbd_sender.c
+++ b/drivers/block/drbd/drbd_sender.c
@@ -2239,3 +2239,49 @@ int drbd_sender(struct drbd_thread *thi)
 
 	return 0;
 }
+
+int drbd_worker(struct drbd_thread *thi)
+{
+	LIST_HEAD(work_list);
+	struct drbd_resource *resource = thi->resource;
+	struct drbd_work *w;
+
+	while (get_t_state(thi) == RUNNING) {
+		drbd_thread_current_set_cpu(thi);
+
+		if (list_empty(&work_list)) {
+			wait_event_interruptible(resource->work.q_wait,
+				dequeue_work_batch(&resource->work, &work_list));
+		}
+
+		if (signal_pending(current)) {
+			flush_signals(current);
+			if (get_t_state(thi) == RUNNING) {
+				drbd_warn(resource, "Worker got an unexpected signal\n");
+				continue;
+			}
+			break;
+		}
+
+		if (get_t_state(thi) != RUNNING)
+			break;
+
+
+		while (!list_empty(&work_list)) {
+			w = list_first_entry(&work_list, struct drbd_work, list);
+			list_del_init(&w->list);
+			w->cb(w, 0);
+		}
+	}
+
+	do {
+		while (!list_empty(&work_list)) {
+			w = list_first_entry(&work_list, struct drbd_work, list);
+			list_del_init(&w->list);
+			w->cb(w, 1);
+		}
+		dequeue_work_batch(&resource->work, &work_list);
+	} while (!list_empty(&work_list));
+
+	return 0;
+}
-- 
2.41.0

