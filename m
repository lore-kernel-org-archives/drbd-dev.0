Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3ABCE10518AB
	for <drbd-dev@lists.linbit.com>; Wed, 10 Jun 2015 09:49:05 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Date: Wed, 10 Jun 2015 15:48:22 +0800
Message-Id: <1433922509-10280-4-git-send-email-nwang@suse.com>
In-Reply-To: <1433922509-10280-1-git-send-email-nwang@suse.com>
References: <1433922509-10280-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Drbd-dev] [PATCH 03/10] A function to zero out drbd backing device.
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

A function to zero out local backing device.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org

---
 drbd/drbd_int.h      |  1 +
 drbd/drbd_receiver.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drbd/drbd_int.h b/drbd/drbd_int.h
index 08d6648..9cc0ef9 100644
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
diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 5e6b149..47b8fe5 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -1594,6 +1594,27 @@ void drbd_bump_write_ordering(struct drbd_resource *resource, struct drbd_backin
 void conn_wait_active_ee_empty(struct drbd_connection *connection);
 
 /**
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
+		device->ldev->known_size , GFP_NOIO, false);
+}
+
+/**
  * drbd_submit_peer_request()
  * @device:	DRBD device.
  * @peer_req:	peer request
-- 
1.8.4.5

