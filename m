Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D21F110518BC
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jul 2015 10:39:39 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: nwang@suse.com
Date: Mon, 13 Jul 2015 16:38:57 +0800
Message-Id: <1436776744-3135-4-git-send-email-nwang@suse.com>
In-Reply-To: <1436776744-3135-1-git-send-email-nwang@suse.com>
References: <1436776744-3135-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	philipp.reisner@linbit.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [Patch v2 03/10] drbd: A function to zero out drbd
	backing device
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

The function can be used to zero out the whole
backing device.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org
---
 drbd/drbd_int.h    |  1 +
 drbd/drbd_worker.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drbd/drbd_int.h b/drbd/drbd_int.h
index a234228..9ecf971 100644
--- a/drbd/drbd_int.h
+++ b/drbd/drbd_int.h
@@ -1662,6 +1662,7 @@ extern void drbd_send_acks_wf(struct work_struct *ws);
 extern bool drbd_rs_c_min_rate_throttle(struct drbd_device *device);
 extern bool drbd_rs_should_slow_down(struct drbd_device *device, sector_t sector,
 		bool throttle_if_app_is_waiting);
+extern int zero_out_local_device(struct drbd_device *device);
 extern int drbd_submit_peer_request(struct drbd_device *,
 				    struct drbd_peer_request *, const unsigned,
 				    const int);
diff --git a/drbd/drbd_worker.c b/drbd/drbd_worker.c
index 2a15aeb..50564f5 100644
--- a/drbd/drbd_worker.c
+++ b/drbd/drbd_worker.c
@@ -1653,6 +1653,27 @@ void drbd_rs_controller_reset(struct drbd_device *device)
 	rcu_read_unlock();
 }
 
+/**
+ * zero_out_local_device()
+ * @device: DRBD device.
+ *
+ * Description:
+ * Zero out drbd backing device when creating new uuid.
+ *
+**/
+int zero_out_local_device(struct drbd_device *device)
+{
+	struct block_device *bdev;
+
+	bdev = device->ldev->backing_bdev;
+	if (device->ldev->known_size != drbd_get_capacity(bdev))
+		device->ldev->known_size = drbd_get_capacity(bdev);
+
+	/* zero out the backing device */
+	return blkdev_issue_zeroout(bdev, 0,
+		device->ldev->known_size, GFP_NOIO, false);
+}
+
 void start_resync_timer_fn(unsigned long data)
 {
 	struct drbd_device *device = (struct drbd_device *) data;
-- 
1.8.4.5

