Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f182.google.com (mail-wr0-f182.google.com
	[209.85.128.182]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1B32C1056320
	for <drbd-dev@lists.linbit.com>; Fri, 24 Mar 2017 15:27:45 +0100 (CET)
Received: by mail-wr0-f182.google.com with SMTP id u108so2831089wrb.3
	for <drbd-dev@lists.linbit.com>; Fri, 24 Mar 2017 07:27:45 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	m14sm3104928wrb.22.2017.03.24.07.27.43
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 Mar 2017 07:27:44 -0700 (PDT)
Resent-Message-ID: <20170324142739.GO1138@soda.linbit>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
	[209.85.192.196]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 670081056320
	for <drbd-dev@lists.linbit.com>; Fri, 24 Mar 2017 15:22:41 +0100 (CET)
Received: by mail-pf0-f196.google.com with SMTP id r137so642829pfr.3
	for <drbd-dev@lists.linbit.com>; Fri, 24 Mar 2017 07:22:41 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Fri, 24 Mar 2017 22:15:11 +0800
Message-Id: <88d743591c2bd5e0c46009f7ec33fa326bf2db5e.1490341364.git.geliangtang@gmail.com>
In-Reply-To: <4841d2c2936addc27a2e774041d04ec16885ba03.1490341208.git.geliangtang@gmail.com>
References: <4841d2c2936addc27a2e774041d04ec16885ba03.1490341208.git.geliangtang@gmail.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: use setup_timer
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

Use setup_timer() instead of init_timer() to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/block/drbd/drbd_main.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 92c60cb..09846fc 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2011,18 +2011,14 @@ void drbd_init_set_defaults(struct drbd_device *device)
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
+		    (unsigned long)device);
+	setup_timer(&device->md_sync_timer, md_sync_timer_fn,
+		    (unsigned long)device);
+	setup_timer(&device->start_resync_timer, start_resync_timer_fn,
+		    (unsigned long)device);
+	setup_timer(&device->request_timer, request_timer_fn,
+		    (unsigned long)device);
 
 	init_waitqueue_head(&device->misc_wait);
 	init_waitqueue_head(&device->state_wait);
-- 
2.9.3

