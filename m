Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C97A51056304
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:38 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:54:08 +0100
Message-Id: <1448448851-10343-36-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 35/38] drbd: make suspend_io() / resume_io() must
	be thread and recursion safe
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

Avoid to prematurely resume application IO: don't set/clear a single
bit, but inc/dec an atomic counter.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h   | 4 ++--
 drivers/block/drbd/drbd_nl.c    | 8 +++++---
 drivers/block/drbd/drbd_state.c | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index a262653..df3d89d 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -500,7 +500,6 @@ enum {
 
 	MD_NO_FUA,		/* Users wants us to not use FUA/FLUSH on meta data dev */
 
-	SUSPEND_IO,		/* suspend application io */
 	BITMAP_IO,		/* suspend application io;
 				   once no more io in flight, start bitmap io */
 	BITMAP_IO_QUEUED,       /* Started bitmap IO */
@@ -880,6 +879,7 @@ struct drbd_device {
 	atomic_t rs_pending_cnt; /* RS request/data packets on the wire */
 	atomic_t unacked_cnt;	 /* Need to send replies for */
 	atomic_t local_cnt;	 /* Waiting for local completion */
+	atomic_t suspend_cnt;
 
 	/* Interval tree of pending local requests */
 	struct rb_root read_requests;
@@ -2263,7 +2263,7 @@ static inline bool may_inc_ap_bio(struct drbd_device *device)
 
 	if (drbd_suspended(device))
 		return false;
-	if (test_bit(SUSPEND_IO, &device->flags))
+	if (atomic_read(&device->suspend_cnt))
 		return false;
 
 	/* to avoid potential deadlock or bitmap corruption,
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 6137789..c7cd3df 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -865,9 +865,11 @@ char *ppsize(char *buf, unsigned long long size)
  * and can be long lived.
  * This changes an device->flag, is triggered by drbd internals,
  * and should be short-lived. */
+/* It needs to be a counter, since multiple threads might
+   independently suspend and resume IO. */
 void drbd_suspend_io(struct drbd_device *device)
 {
-	set_bit(SUSPEND_IO, &device->flags);
+	atomic_inc(&device->suspend_cnt);
 	if (drbd_suspended(device))
 		return;
 	wait_event(device->misc_wait, !atomic_read(&device->ap_bio_cnt));
@@ -875,8 +877,8 @@ void drbd_suspend_io(struct drbd_device *device)
 
 void drbd_resume_io(struct drbd_device *device)
 {
-	clear_bit(SUSPEND_IO, &device->flags);
-	wake_up(&device->misc_wait);
+	if (atomic_dec_and_test(&device->suspend_cnt))
+		wake_up(&device->misc_wait);
 }
 
 /**
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index f022e99..5a7ef78 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1484,7 +1484,7 @@ int drbd_bitmap_io_from_worker(struct drbd_device *device,
 	D_ASSERT(device, current == first_peer_device(device)->connection->worker.task);
 
 	/* open coded non-blocking drbd_suspend_io(device); */
-	set_bit(SUSPEND_IO, &device->flags);
+	atomic_inc(&device->suspend_cnt);
 
 	drbd_bm_lock(device, why, flags);
 	rv = io_fn(device);
-- 
1.9.1

