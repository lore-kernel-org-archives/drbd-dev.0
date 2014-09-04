Return-Path: <imrep.amz@gmail.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 06288101AC75
	for <drbd-dev@lists.linbit.com>; Thu,  4 Sep 2014 21:59:56 +0200 (CEST)
Received: by mail-wi0-f169.google.com with SMTP id n3so8134507wiv.2
	for <drbd-dev@lists.linbit.com>; Thu, 04 Sep 2014 12:59:55 -0700 (PDT)
From: Imre Palik <imrep.amz@gmail.com>
To: drbd-dev@lists.linbit.com
Date: Thu,  4 Sep 2014 21:59:09 +0200
Message-Id: <1409860749-13458-1-git-send-email-imrep.amz@gmail.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>, "Palik, Imre" <imrep@amazon.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Matt Wilson <msw@amazon.com>, linux-kernel@vger.kernel.org
Subject: [Drbd-dev] [PATCH v2] drbd: fix throttling on newly created DM
	backing devices
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

From: "Palik, Imre" <imrep@amazon.de>

If the drbd backing device is a new device mapper device (e.g., a
dm-linear mapping of an existing block device that contains data), the
counters are initially 0 even though the device contains useful
data. This causes throttling until something accesses the drbd device
or the backing device.

The patch disables throttling, as long as only resync is responsible
for disk activity on a freshly created device.

Reported-by: Mikhail Sugakov <msugakov@amazon.de>
Cc: Matt Wilson <msw@amazon.com>
Signed-off-by: Imre Palik <imrep@amazon.de>
---
 drivers/block/drbd/drbd_main.c     |    3 ++-
 drivers/block/drbd/drbd_receiver.c |    3 ++-
 drivers/block/drbd/drbd_state.c    |    2 +-
 drivers/block/drbd/drbd_worker.c   |    2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 9b465bb..f4e3944 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1966,6 +1966,7 @@ void drbd_init_set_defaults(struct drbd_device *device)
 	device->resync_wenr = LC_FREE;
 	device->peer_max_bio_size = DRBD_MAX_BIO_SIZE_SAFE;
 	device->local_max_bio_size = DRBD_MAX_BIO_SIZE_SAFE;
+	device->rs_last_events = -1;
 }
 
 void drbd_device_cleanup(struct drbd_device *device)
@@ -1985,7 +1986,7 @@ void drbd_device_cleanup(struct drbd_device *device)
 	device->rs_start     =
 	device->rs_total     =
 	device->rs_failed    = 0;
-	device->rs_last_events = 0;
+	device->rs_last_events = -1;
 	device->rs_last_sect_ev = 0;
 	for (i = 0; i < DRBD_SYNC_MARKS; i++) {
 		device->rs_mark_left[i] = 0;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 9342b8d..d33355c 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2482,7 +2482,8 @@ bool drbd_rs_c_min_rate_throttle(struct drbd_device *device)
 			atomic_read(&device->rs_sect_ev);
 
 	if (atomic_read(&device->ap_actlog_cnt)
-	    || !device->rs_last_events || curr_events - device->rs_last_events > 64) {
+		|| device->rs_last_events < 0
+		|| curr_events - device->rs_last_events > 64) {
 		unsigned long rs_left;
 		int i;
 
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index c35c0f0..8789f8a 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1072,7 +1072,7 @@ __drbd_set_state(struct drbd_device *device, union drbd_state ns,
 
 		set_ov_position(device, ns.conn);
 		device->rs_start = now;
-		device->rs_last_events = 0;
+		device->rs_last_events = -1;
 		device->rs_last_sect_ev = 0;
 		device->ov_last_oos_size = 0;
 		device->ov_last_oos_start = 0;
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 50776b3..e2db4e4 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1743,7 +1743,7 @@ void drbd_start_resync(struct drbd_device *device, enum drbd_conns side)
 		device->rs_failed    = 0;
 		device->rs_paused    = 0;
 		device->rs_same_csum = 0;
-		device->rs_last_events = 0;
+		device->rs_last_events = -1;
 		device->rs_last_sect_ev = 0;
 		device->rs_total     = tw;
 		device->rs_start     = now;
-- 
1.7.9.5

