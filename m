Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2FB541058022
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 23:31:27 +0200 (CEST)
Received: by mail-wm0-f50.google.com with SMTP id z132so4534890wmg.1
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 14:31:27 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 24 Aug 2017 23:23:00 +0200
Message-Id: <1503609794-13233-4-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
References: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/17] drbd: add explicit plugging when
	submitting batches
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

When submitting batches of requests which had been queued on the
submitter thread, typically because they needed to wait for an
activity log transactions, use explicit plugging to help potential
merging of requests in the backend io-scheduler.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 85e05ee..2c82330 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1292,6 +1292,7 @@ static void drbd_unplug(struct blk_plug_cb *cb, bool from_schedule)
 	struct drbd_resource *resource = plug->cb.data;
 	struct drbd_request *req = plug->most_recent_req;
 
+	kfree(cb);
 	if (!req)
 		return;
 
@@ -1301,8 +1302,8 @@ static void drbd_unplug(struct blk_plug_cb *cb, bool from_schedule)
 	req->rq_state |= RQ_UNPLUG;
 	/* but also queue a generic unplug */
 	drbd_queue_unplug(req->device);
-	spin_unlock_irq(&resource->req_lock);
 	kref_put(&req->kref, drbd_req_destroy);
+	spin_unlock_irq(&resource->req_lock);
 }
 
 static struct drbd_plug_cb* drbd_check_plugged(struct drbd_resource *resource)
@@ -1343,8 +1344,6 @@ static void drbd_send_and_submit(struct drbd_device *device, struct drbd_request
 	bool no_remote = false;
 	bool submit_private_bio = false;
 
-	struct drbd_plug_cb *plug = drbd_check_plugged(resource);
-
 	spin_lock_irq(&resource->req_lock);
 	if (rw == WRITE) {
 		/* This may temporarily give up the req_lock,
@@ -1409,8 +1408,11 @@ static void drbd_send_and_submit(struct drbd_device *device, struct drbd_request
 			no_remote = true;
 	}
 
-	if (plug != NULL && no_remote == false)
-		drbd_update_plug(plug, req);
+	if (no_remote == false) {
+		struct drbd_plug_cb *plug = drbd_check_plugged(resource);
+		if (plug)
+			drbd_update_plug(plug, req);
+	}
 
 	/* If it took the fast path in drbd_request_prepare, add it here.
 	 * The slow path has added it already. */
@@ -1460,7 +1462,10 @@ void __drbd_make_request(struct drbd_device *device, struct bio *bio, unsigned l
 
 static void submit_fast_path(struct drbd_device *device, struct list_head *incoming)
 {
+	struct blk_plug plug;
 	struct drbd_request *req, *tmp;
+
+	blk_start_plug(&plug);
 	list_for_each_entry_safe(req, tmp, incoming, tl_requests) {
 		const int rw = bio_data_dir(req->master_bio);
 
@@ -1478,6 +1483,7 @@ static void submit_fast_path(struct drbd_device *device, struct list_head *incom
 		list_del_init(&req->tl_requests);
 		drbd_send_and_submit(device, req);
 	}
+	blk_finish_plug(&plug);
 }
 
 static bool prepare_al_transaction_nonblock(struct drbd_device *device,
@@ -1507,10 +1513,12 @@ static bool prepare_al_transaction_nonblock(struct drbd_device *device,
 	return !list_empty(pending);
 }
 
-void send_and_submit_pending(struct drbd_device *device, struct list_head *pending)
+static void send_and_submit_pending(struct drbd_device *device, struct list_head *pending)
 {
+	struct blk_plug plug;
 	struct drbd_request *req;
 
+	blk_start_plug(&plug);
 	while ((req = list_first_entry_or_null(pending, struct drbd_request, tl_requests))) {
 		req->rq_state |= RQ_IN_ACT_LOG;
 		req->in_actlog_jif = jiffies;
@@ -1518,6 +1526,7 @@ void send_and_submit_pending(struct drbd_device *device, struct list_head *pendi
 		list_del_init(&req->tl_requests);
 		drbd_send_and_submit(device, req);
 	}
+	blk_finish_plug(&plug);
 }
 
 void do_submit(struct work_struct *ws)
-- 
2.7.4

