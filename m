Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E7D2010556D9
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jul 2015 10:39:54 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: nwang@suse.com
Date: Mon, 13 Jul 2015 16:39:00 +0800
Message-Id: <1436776744-3135-7-git-send-email-nwang@suse.com>
In-Reply-To: <1436776744-3135-1-git-send-email-nwang@suse.com>
References: <1436776744-3135-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	philipp.reisner@linbit.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [Patch v2 06/10] drbd: Wapper for zeroing out device by
	worker
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

Wapper functions for drbd_device_post_work to start
zeroing out device. Change state when both node
finish zeroing.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org
---
 drbd/drbd_int.h    |  2 ++
 drbd/drbd_worker.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/drbd/drbd_int.h b/drbd/drbd_int.h
index f43f957..dd680a9 100644
--- a/drbd/drbd_int.h
+++ b/drbd/drbd_int.h
@@ -1670,6 +1670,8 @@ extern bool drbd_rs_c_min_rate_throttle(struct drbd_device *device);
 extern bool drbd_rs_should_slow_down(struct drbd_device *device, sector_t sector,
 		bool throttle_if_app_is_waiting);
 extern int zero_out_local_device(struct drbd_device *device);
+extern void require_zero_out_local_device(struct drbd_device *device);
+extern void receive_zero_out_local_device(struct drbd_device *device);
 extern int drbd_submit_peer_request(struct drbd_device *,
 				    struct drbd_peer_request *, const unsigned,
 				    const int);
diff --git a/drbd/drbd_worker.c b/drbd/drbd_worker.c
index 50564f5..293aa27 100644
--- a/drbd/drbd_worker.c
+++ b/drbd/drbd_worker.c
@@ -1674,6 +1674,69 @@ int zero_out_local_device(struct drbd_device *device)
 		device->ldev->known_size, GFP_NOIO, false);
 }
 
+/**
+ * require_zero_out_local_device()
+ * @device: DRBD device.
+ *
+ * Description:
+ * Start to zero out local device. Update
+ * status if peer node (secondary) finished
+ * zeroing.
+ *
+**/
+void require_zero_out_local_device(struct drbd_device *device)
+{
+	int zero_out_err = 0;
+
+	zero_out_err = zero_out_local_device(device);
+
+	if (zero_out_err) {
+		drbd_err(device, "Failed to zero out local device\n");
+		set_bit(ZERO_FAIL, &device->flags);
+		drbd_chk_io_error(device, 1, DRBD_WRITE_ERROR);
+	} else {
+		drbd_info(device, "Finished zero out local device.\n");
+
+		if (test_and_clear_bit(ZERO_DONE, &device->flags)) {
+			spin_lock_irq(&device->resource->req_lock);
+			_drbd_set_state(_NS2(device, disk, D_UP_TO_DATE,
+				pdsk, D_UP_TO_DATE), CS_VERBOSE, NULL);
+			spin_unlock_irq(&device->resource->req_lock);
+			drbd_send_zero_out_finish(first_peer_device(device));
+		} else if (test_and_clear_bit(ZERO_FAIL, &device->flags)) {
+			drbd_info(device, "Peer device has already failed on zero out\n");
+		} else {
+			/* waiting for peer device finished */
+			set_bit(ZERO_DONE, &device->flags);
+		}
+	}
+}
+
+/**
+ * receive_zero_out_local_device()
+ * @device: DRBD device.
+ *
+ * Description:
+ * Start to zero out local device.
+ * Notify peer node the zeroing result.
+ *
+**/
+void receive_zero_out_local_device(struct drbd_device *device)
+{
+	int zero_out_err = 0;
+	struct drbd_peer_device *const peer_device = first_peer_device(device);
+
+	zero_out_err = zero_out_local_device(device);
+	if (zero_out_err) {
+		drbd_err(device, "Failed to zero out local device\n");
+		drbd_send_zero_out_fail(peer_device);
+		drbd_chk_io_error(device, 1, DRBD_WRITE_ERROR);
+	} else {
+		drbd_info(device, "Finished zero out local device.\n");
+		drbd_send_zero_out_ok(peer_device);
+	}
+}
+
 void start_resync_timer_fn(unsigned long data)
 {
 	struct drbd_device *device = (struct drbd_device *) data;
-- 
1.8.4.5

