Return-Path: <imrep.amz@gmail.com>
Received: from mail-we0-f174.google.com (mail-we0-f174.google.com
	[74.125.82.174]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E9106101AC7E
	for <drbd-dev@lists.linbit.com>; Wed,  3 Sep 2014 15:33:11 +0200 (CEST)
Received: by mail-we0-f174.google.com with SMTP id u57so8559016wes.5
	for <drbd-dev@lists.linbit.com>; Wed, 03 Sep 2014 06:33:10 -0700 (PDT)
From: Imre Palik <imrep.amz@gmail.com>
To: drbd-dev@lists.linbit.com
Date: Wed,  3 Sep 2014 15:02:36 +0200
Message-Id: <1409749356-5450-1-git-send-email-imrep.amz@gmail.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>, "Palik, Imre" <imrep@amazon.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Matt Wilson <msw@amazon.com>, linux-kernel@vger.kernel.org
Subject: [Drbd-dev] [PATCH] drbd: fix throttling on newly created DM backing
	devices
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
 drivers/block/drbd/drbd_receiver.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 9342b8d..511d2eb 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2482,7 +2482,8 @@ bool drbd_rs_c_min_rate_throttle(struct drbd_device *device)
 			atomic_read(&device->rs_sect_ev);
 
 	if (atomic_read(&device->ap_actlog_cnt)
-	    || !device->rs_last_events || curr_events - device->rs_last_events > 64) {
+		|| (curr_events && (!device->rs_last_events
+					|| curr_events - device->rs_last_events > 64))) {
 		unsigned long rs_left;
 		int i;
 
-- 
1.7.9.5

