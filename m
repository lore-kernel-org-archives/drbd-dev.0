Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DCF37101AC7A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Jun 2014 17:53:07 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 30 Jun 2014 17:52:52 +0200
Message-Id: <1404143587-24344-4-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1404143587-24344-1-git-send-email-philipp.reisner@linbit.com>
References: <1404143587-24344-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/18] drbd: rename drbd_free_bc() to
	drbd_free_ldev()
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

Since the member of drbd_device is called ldev

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h  | 2 +-
 drivers/block/drbd/drbd_main.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index c87bc8e..82ece1b 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -950,7 +950,7 @@ extern int drbd_send_ov_request(struct drbd_peer_device *, sector_t sector, int
 extern int drbd_send_bitmap(struct drbd_device *device);
 extern void drbd_send_sr_reply(struct drbd_peer_device *, enum drbd_state_rv retcode);
 extern void conn_send_sr_reply(struct drbd_connection *connection, enum drbd_state_rv retcode);
-extern void drbd_free_bc(struct drbd_backing_dev *ldev);
+extern void drbd_free_ldev(struct drbd_backing_dev *ldev);
 extern void drbd_device_cleanup(struct drbd_device *device);
 void drbd_print_uuids(struct drbd_device *device, const char *text);
 
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index a6af935..8e0813d 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1992,7 +1992,7 @@ void drbd_device_cleanup(struct drbd_device *device)
 		drbd_bm_cleanup(device);
 	}
 
-	drbd_free_bc(device->ldev);
+	drbd_free_ldev(device->ldev);
 	device->ldev = NULL;
 
 	clear_bit(AL_SUSPENDED, &device->flags);
@@ -2187,7 +2187,7 @@ void drbd_destroy_device(struct kref *kref)
 	if (device->this_bdev)
 		bdput(device->this_bdev);
 
-	drbd_free_bc(device->ldev);
+	drbd_free_ldev(device->ldev);
 	device->ldev = NULL;
 
 	drbd_release_all_peer_reqs(device);
@@ -2960,7 +2960,7 @@ fail:
 	return err;
 }
 
-void drbd_free_bc(struct drbd_backing_dev *ldev)
+void drbd_free_ldev(struct drbd_backing_dev *ldev)
 {
 	if (ldev == NULL)
 		return;
@@ -3533,7 +3533,7 @@ void drbd_ldev_destroy(struct drbd_device *device)
 	lc_destroy(device->act_log);
 	device->act_log = NULL;
 	__no_warn(local,
-		drbd_free_bc(device->ldev);
+		drbd_free_ldev(device->ldev);
 		device->ldev = NULL;);
 
 	clear_bit(GO_DISKLESS, &device->flags);
-- 
1.9.1

