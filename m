Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D00A01058024
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 23:31:52 +0200 (CEST)
Received: by mail-wm0-f44.google.com with SMTP id b189so4753278wmd.0
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 14:31:52 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 24 Aug 2017 23:23:06 +0200
Message-Id: <1503609794-13233-10-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
References: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/17] drbd: Use setup_timer() instead of
	init_timer() to simplify the code.
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

From: Geliang Tang <geliangtang@gmail.com>

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Roland Kammerer <roland.kammerer@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 11f3852..056d9ab 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2023,18 +2023,14 @@ void drbd_init_set_defaults(struct drbd_device *device)
 	device->unplug_work.cb  = w_send_write_hint;
 	device->bm_io_work.w.cb = w_bitmap_io;
 
-	init_timer(&device->resync_timer);
-	init_timer(&device->md_sync_timer);
-	init_timer(&device->start_resync_timer);
-	init_timer(&device->request_timer);
-	device->resync_timer.function = resync_timer_fn;
-	device->resync_timer.data = (unsigned long) device;
-	device->md_sync_timer.function = md_sync_timer_fn;
-	device->md_sync_timer.data = (unsigned long) device;
-	device->start_resync_timer.function = start_resync_timer_fn;
-	device->start_resync_timer.data = (unsigned long) device;
-	device->request_timer.function = request_timer_fn;
-	device->request_timer.data = (unsigned long) device;
+	setup_timer(&device->resync_timer, resync_timer_fn,
+			(unsigned long)device);
+	setup_timer(&device->md_sync_timer, md_sync_timer_fn,
+			(unsigned long)device);
+	setup_timer(&device->start_resync_timer, start_resync_timer_fn,
+			(unsigned long)device);
+	setup_timer(&device->request_timer, request_timer_fn,
+			(unsigned long)device);
 
 	init_waitqueue_head(&device->misc_wait);
 	init_waitqueue_head(&device->state_wait);
-- 
2.7.4

