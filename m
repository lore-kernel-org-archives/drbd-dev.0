Return-Path: <imrep.amz@gmail.com>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
	[209.85.212.178]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C3832101AC75
	for <drbd-dev@lists.linbit.com>; Fri,  5 Sep 2014 20:41:33 +0200 (CEST)
Received: by mail-wi0-f178.google.com with SMTP id r20so239126wiv.5
	for <drbd-dev@lists.linbit.com>; Fri, 05 Sep 2014 11:41:32 -0700 (PDT)
From: Imre Palik <imrep.amz@gmail.com>
To: drbd-dev@lists.linbit.com
Date: Fri,  5 Sep 2014 20:41:18 +0200
Message-Id: <1409942478-29135-1-git-send-email-imrep.amz@gmail.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>, "Palik, Imre" <imrep@amazon.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Matt Wilson <msw@amazon.com>, linux-kernel@vger.kernel.org
Subject: [Drbd-dev] [PATCH v3] drbd: fix throttling on newly created DM
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
 drivers/block/drbd/drbd_int.h      |    4 ++--
 drivers/block/drbd/drbd_receiver.c |   10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 1a00001..298b1dc 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -960,8 +960,8 @@ struct drbd_device {
 	atomic_t rs_sect_in; /* for incoming resync data rate, SyncTarget */
 	atomic_t rs_sect_ev; /* for submitted resync data rate, both */
 	int rs_last_sect_ev; /* counter to compare with */
-	int rs_last_events;  /* counter of read or write "events" (unit sectors)
-			      * on the lower level device when we last looked. */
+	unsigned int rs_last_events;  /* counter of read or write "events" (unit sectors)
+				       * on the lower level device when we last looked. */
 	int c_sync_rate; /* current resync rate after syncer throttle magic */
 	struct fifo_buffer *rs_plan_s; /* correction values of resync planer (RCU, connection->conn_update) */
 	int rs_in_flight; /* resync sectors in flight (to proxy, in proxy and from proxy) */
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 9342b8d..147c917 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2467,7 +2467,7 @@ bool drbd_rs_c_min_rate_throttle(struct drbd_device *device)
 	struct gendisk *disk = device->ldev->backing_bdev->bd_contains->bd_disk;
 	unsigned long db, dt, dbdt;
 	unsigned int c_min_rate;
-	int curr_events;
+	unsigned int curr_events;
 
 	rcu_read_lock();
 	c_min_rate = rcu_dereference(device->ldev->disk_conf)->c_min_rate;
@@ -2477,12 +2477,12 @@ bool drbd_rs_c_min_rate_throttle(struct drbd_device *device)
 	if (c_min_rate == 0)
 		return false;
 
-	curr_events = (int)part_stat_read(&disk->part0, sectors[0]) +
-		      (int)part_stat_read(&disk->part0, sectors[1]) -
-			atomic_read(&device->rs_sect_ev);
+	curr_events = (unsigned int)part_stat_read(&disk->part0, sectors[0]) +
+		      (unsigned int)part_stat_read(&disk->part0, sectors[1]) -
+		(unsigned int)atomic_read(&device->rs_sect_ev);
 
 	if (atomic_read(&device->ap_actlog_cnt)
-	    || !device->rs_last_events || curr_events - device->rs_last_events > 64) {
+		|| curr_events - device->rs_last_events > 64) {
 		unsigned long rs_left;
 		int i;
 
-- 
1.7.9.5

