Return-Path: <jack@suse.cz>
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A0C6542036A
	for <drbd-dev@lists.linbit.com>; Tue,  4 Jul 2023 14:28:45 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-block@vger.kernel.org>
Date: Tue,  4 Jul 2023 14:21:32 +0200
Message-Id: <20230704122224.16257-5-jack@suse.cz>
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>
Subject: [Drbd-dev] [PATCH 05/32] drdb: Convert to use
	blkdev_get_handle_by_path()
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Convert drdb to use blkdev_get_handle_by_path().

CC: drbd-dev@lists.linbit.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/drbd/drbd_int.h |  2 ++
 drivers/block/drbd/drbd_nl.c  | 65 +++++++++++++++++------------------
 2 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index a30a5ed811be..f017e917612b 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -524,7 +524,9 @@ struct drbd_md {
 
 struct drbd_backing_dev {
 	struct block_device *backing_bdev;
+	struct bdev_handle *backing_bdev_handle;
 	struct block_device *md_bdev;
+	struct bdev_handle *md_bdev_handle;
 	struct drbd_md md;
 	struct disk_conf *disk_conf; /* RCU, for updates: resource->conf_update */
 	sector_t known_size; /* last known size of that backing device */
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index cddae6f4b00f..4a436a428e12 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -82,7 +82,7 @@ static atomic_t notify_genl_seq = ATOMIC_INIT(2); /* two. */
 
 DEFINE_MUTEX(notification_mutex);
 
-/* used blkdev_get_by_path, to claim our meta data device(s) */
+/* used blkdev_get_handle_by_path, to claim our meta data device(s) */
 static char *drbd_m_holder = "Hands off! this is DRBD's meta data device.";
 
 static void drbd_adm_send_reply(struct sk_buff *skb, struct genl_info *info)
@@ -1634,43 +1634,45 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-static struct block_device *open_backing_dev(struct drbd_device *device,
+static struct bdev_handle *open_backing_dev(struct drbd_device *device,
 		const char *bdev_path, void *claim_ptr, bool do_bd_link)
 {
-	struct block_device *bdev;
+	struct bdev_handle *handle;
 	int err = 0;
 
-	bdev = blkdev_get_by_path(bdev_path, BLK_OPEN_READ | BLK_OPEN_WRITE,
-				  claim_ptr, NULL);
-	if (IS_ERR(bdev)) {
+	handle = blkdev_get_handle_by_path(bdev_path,
+			BLK_OPEN_READ | BLK_OPEN_WRITE, claim_ptr, NULL);
+	if (IS_ERR(handle)) {
 		drbd_err(device, "open(\"%s\") failed with %ld\n",
-				bdev_path, PTR_ERR(bdev));
-		return bdev;
+				bdev_path, PTR_ERR(handle));
+		return handle;
 	}
 
 	if (!do_bd_link)
-		return bdev;
+		return handle;
 
-	err = bd_link_disk_holder(bdev, device->vdisk);
+	err = bd_link_disk_holder(handle->bdev, device->vdisk);
 	if (err) {
-		blkdev_put(bdev, claim_ptr);
+		blkdev_handle_put(handle);
 		drbd_err(device, "bd_link_disk_holder(\"%s\", ...) failed with %d\n",
 				bdev_path, err);
-		bdev = ERR_PTR(err);
+		handle = ERR_PTR(err);
 	}
-	return bdev;
+	return handle;
 }
 
 static int open_backing_devices(struct drbd_device *device,
 		struct disk_conf *new_disk_conf,
 		struct drbd_backing_dev *nbc)
 {
-	struct block_device *bdev;
+	struct bdev_handle *handle;
 
-	bdev = open_backing_dev(device, new_disk_conf->backing_dev, device, true);
-	if (IS_ERR(bdev))
+	handle = open_backing_dev(device, new_disk_conf->backing_dev, device,
+				  true);
+	if (IS_ERR(handle))
 		return ERR_OPEN_DISK;
-	nbc->backing_bdev = bdev;
+	nbc->backing_bdev = handle->bdev;
+	nbc->backing_bdev_handle = handle;
 
 	/*
 	 * meta_dev_idx >= 0: external fixed size, possibly multiple
@@ -1680,7 +1682,7 @@ static int open_backing_devices(struct drbd_device *device,
 	 * should check it for you already; but if you don't, or
 	 * someone fooled it, we need to double check here)
 	 */
-	bdev = open_backing_dev(device, new_disk_conf->meta_dev,
+	handle = open_backing_dev(device, new_disk_conf->meta_dev,
 		/* claim ptr: device, if claimed exclusively; shared drbd_m_holder,
 		 * if potentially shared with other drbd minors */
 			(new_disk_conf->meta_dev_idx < 0) ? (void*)device : (void*)drbd_m_holder,
@@ -1688,20 +1690,21 @@ static int open_backing_devices(struct drbd_device *device,
 		 * as would happen with internal metadata. */
 			(new_disk_conf->meta_dev_idx != DRBD_MD_INDEX_FLEX_INT &&
 			 new_disk_conf->meta_dev_idx != DRBD_MD_INDEX_INTERNAL));
-	if (IS_ERR(bdev))
+	if (IS_ERR(handle))
 		return ERR_OPEN_MD_DISK;
-	nbc->md_bdev = bdev;
+	nbc->md_bdev = handle->bdev;
+	nbc->md_bdev_handle = handle;
 	return NO_ERROR;
 }
 
-static void close_backing_dev(struct drbd_device *device, struct block_device *bdev,
-		void *claim_ptr, bool do_bd_unlink)
+static void close_backing_dev(struct drbd_device *device,
+		struct bdev_handle *handle, bool do_bd_unlink)
 {
-	if (!bdev)
+	if (!handle)
 		return;
 	if (do_bd_unlink)
-		bd_unlink_disk_holder(bdev, device->vdisk);
-	blkdev_put(bdev, claim_ptr);
+		bd_unlink_disk_holder(handle->bdev, device->vdisk);
+	blkdev_handle_put(handle);
 }
 
 void drbd_backing_dev_free(struct drbd_device *device, struct drbd_backing_dev *ldev)
@@ -1709,11 +1712,9 @@ void drbd_backing_dev_free(struct drbd_device *device, struct drbd_backing_dev *
 	if (ldev == NULL)
 		return;
 
-	close_backing_dev(device, ldev->md_bdev,
-			  ldev->md.meta_dev_idx < 0 ?
-				(void *)device : (void *)drbd_m_holder,
+	close_backing_dev(device, ldev->md_bdev_handle,
 			  ldev->md_bdev != ldev->backing_bdev);
-	close_backing_dev(device, ldev->backing_bdev, device, true);
+	close_backing_dev(device, ldev->backing_bdev_handle, true);
 
 	kfree(ldev->disk_conf);
 	kfree(ldev);
@@ -2129,11 +2130,9 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
  fail:
 	conn_reconfig_done(connection);
 	if (nbc) {
-		close_backing_dev(device, nbc->md_bdev,
-			  nbc->disk_conf->meta_dev_idx < 0 ?
-				(void *)device : (void *)drbd_m_holder,
+		close_backing_dev(device, nbc->md_bdev_handle,
 			  nbc->md_bdev != nbc->backing_bdev);
-		close_backing_dev(device, nbc->backing_bdev, device, true);
+		close_backing_dev(device, nbc->backing_bdev_handle, true);
 		kfree(nbc);
 	}
 	kfree(new_disk_conf);
-- 
2.35.3

