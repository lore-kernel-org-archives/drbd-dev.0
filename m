Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E2C251058017
	for <drbd-dev@lists.linbit.com>; Fri,  3 Nov 2017 10:36:45 +0100 (CET)
Received: by mail-wm0-f66.google.com with SMTP id y83so179130wmc.4
	for <drbd-dev@lists.linbit.com>; Fri, 03 Nov 2017 02:36:45 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	u138sm2650685wmd.17.2017.11.03.02.36.44
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 Nov 2017 02:36:44 -0700 (PDT)
Resent-Message-ID: <20171103093643.GA3795@soda.linbit>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 701261058017
	for <drbd-dev@lists.linbit.com>; Fri,  3 Nov 2017 00:20:18 +0100 (CET)
Received: by mail-pg0-f68.google.com with SMTP id l24so915925pgu.11
	for <drbd-dev@lists.linbit.com>; Thu, 02 Nov 2017 16:20:18 -0700 (PDT)
Date: Thu, 2 Nov 2017 16:14:10 -0700
From: Kees Cook <keescook@chromium.org>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20171102231410.GA100294@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: Convert timers to use timer_setup()
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

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
FYI, this requires -rc3's timer_setup() API. If that's not available, I can
carry this in the timers tree with you Ack/Review. Thanks!
---
 drivers/block/drbd/drbd_int.h      |  4 ++--
 drivers/block/drbd/drbd_main.c     | 18 +++++++-----------
 drivers/block/drbd/drbd_receiver.c |  2 +-
 drivers/block/drbd/drbd_req.c      |  4 ++--
 drivers/block/drbd/drbd_req.h      |  2 +-
 drivers/block/drbd/drbd_worker.c   |  8 ++++----
 6 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 7e8589ce631c..06ecee1b528e 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1551,8 +1551,8 @@ extern int w_restart_disk_io(struct drbd_work *, int);
 extern int w_send_out_of_sync(struct drbd_work *, int);
 extern int w_start_resync(struct drbd_work *, int);
 
-extern void resync_timer_fn(unsigned long data);
-extern void start_resync_timer_fn(unsigned long data);
+extern void resync_timer_fn(struct timer_list *t);
+extern void start_resync_timer_fn(struct timer_list *t);
 
 extern void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req);
 
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 8cb3791898ae..4b4697a1f963 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -64,7 +64,7 @@
 static DEFINE_MUTEX(drbd_main_mutex);
 static int drbd_open(struct block_device *bdev, fmode_t mode);
 static void drbd_release(struct gendisk *gd, fmode_t mode);
-static void md_sync_timer_fn(unsigned long data);
+static void md_sync_timer_fn(struct timer_list *t);
 static int w_bitmap_io(struct drbd_work *w, int unused);
 
 MODULE_AUTHOR("Philipp Reisner <phil@linbit.com>, "
@@ -2023,14 +2023,10 @@ void drbd_init_set_defaults(struct drbd_device *device)
 	device->unplug_work.cb  = w_send_write_hint;
 	device->bm_io_work.w.cb = w_bitmap_io;
 
-	setup_timer(&device->resync_timer, resync_timer_fn,
-			(unsigned long)device);
-	setup_timer(&device->md_sync_timer, md_sync_timer_fn,
-			(unsigned long)device);
-	setup_timer(&device->start_resync_timer, start_resync_timer_fn,
-			(unsigned long)device);
-	setup_timer(&device->request_timer, request_timer_fn,
-			(unsigned long)device);
+	timer_setup(&device->resync_timer, resync_timer_fn, 0);
+	timer_setup(&device->md_sync_timer, md_sync_timer_fn, 0);
+	timer_setup(&device->start_resync_timer, start_resync_timer_fn, 0);
+	timer_setup(&device->request_timer, request_timer_fn, 0);
 
 	init_waitqueue_head(&device->misc_wait);
 	init_waitqueue_head(&device->state_wait);
@@ -3721,9 +3717,9 @@ int drbd_md_test_flag(struct drbd_backing_dev *bdev, int flag)
 	return (bdev->md.flags & flag) != 0;
 }
 
-static void md_sync_timer_fn(unsigned long data)
+static void md_sync_timer_fn(struct timer_list *t)
 {
-	struct drbd_device *device = (struct drbd_device *) data;
+	struct drbd_device *device = from_timer(device, t, md_sync_timer);
 	drbd_device_post_work(device, MD_SYNC);
 }
 
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 796eaf347dc0..cb2fa63f6bc0 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -5056,7 +5056,7 @@ static int drbd_disconnected(struct drbd_peer_device *peer_device)
 	wake_up(&device->misc_wait);
 
 	del_timer_sync(&device->resync_timer);
-	resync_timer_fn((unsigned long)device);
+	resync_timer_fn(&device->resync_timer);
 
 	/* wait for all w_e_end_data_req, w_e_end_rsdata_req, w_send_barrier,
 	 * w_make_resync_request etc. which may still be on the worker queue
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index de8566e55334..a500e738d929 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1714,9 +1714,9 @@ static bool net_timeout_reached(struct drbd_request *net_req,
  * to expire twice (worst case) to become effective. Good enough.
  */
 
-void request_timer_fn(unsigned long data)
+void request_timer_fn(struct timer_list *t)
 {
-	struct drbd_device *device = (struct drbd_device *) data;
+	struct drbd_device *device = from_timer(device, t, request_timer);
 	struct drbd_connection *connection = first_peer_device(device)->connection;
 	struct drbd_request *req_read, *req_write, *req_peer; /* oldest request */
 	struct net_conf *nc;
diff --git a/drivers/block/drbd/drbd_req.h b/drivers/block/drbd/drbd_req.h
index a2254f825601..cb97b3b30962 100644
--- a/drivers/block/drbd/drbd_req.h
+++ b/drivers/block/drbd/drbd_req.h
@@ -294,7 +294,7 @@ extern int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 		struct bio_and_error *m);
 extern void complete_master_bio(struct drbd_device *device,
 		struct bio_and_error *m);
-extern void request_timer_fn(unsigned long data);
+extern void request_timer_fn(struct timer_list *t);
 extern void tl_restart(struct drbd_connection *connection, enum drbd_req_event what);
 extern void _tl_restart(struct drbd_connection *connection, enum drbd_req_event what);
 extern void tl_abort_disk_io(struct drbd_device *device);
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 03471b3fce86..1476cb3439f4 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -457,9 +457,9 @@ int w_resync_timer(struct drbd_work *w, int cancel)
 	return 0;
 }
 
-void resync_timer_fn(unsigned long data)
+void resync_timer_fn(struct timer_list *t)
 {
-	struct drbd_device *device = (struct drbd_device *) data;
+	struct drbd_device *device = from_timer(device, t, resync_timer);
 
 	drbd_queue_work_if_unqueued(
 		&first_peer_device(device)->connection->sender_work,
@@ -1705,9 +1705,9 @@ void drbd_rs_controller_reset(struct drbd_device *device)
 	rcu_read_unlock();
 }
 
-void start_resync_timer_fn(unsigned long data)
+void start_resync_timer_fn(struct timer_list *t)
 {
-	struct drbd_device *device = (struct drbd_device *) data;
+	struct drbd_device *device = from_timer(device, t, start_resync_timer);
 	drbd_device_post_work(device, RS_START);
 }
 
-- 
2.7.4


-- 
Kees Cook
Pixel Security
