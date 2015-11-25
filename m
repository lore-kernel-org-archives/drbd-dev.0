Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 536CB10562CF
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:37 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:54:03 +0100
Message-Id: <1448448851-10343-31-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 30/38] drbd: make drbd known to lsblk: use
	bd_link_disk_holder
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

lsblk should be able to pick up stacking device driver relations
involving DRBD conveniently.

Even though upstream kernel since 2011 says
	"DON'T USE THIS UNLESS YOU'RE ALREADY USING IT."
a new user has been added since (bcache),
which sets the precedences for us to use it as well.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h    |   2 +-
 drivers/block/drbd/drbd_main.c   |  16 +-----
 drivers/block/drbd/drbd_nl.c     | 121 ++++++++++++++++++++++++++++-----------
 drivers/block/drbd/drbd_worker.c |   2 +-
 include/linux/drbd.h             |   2 +-
 5 files changed, 91 insertions(+), 52 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 08f266e..a262653 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1126,7 +1126,7 @@ extern int drbd_send_ov_request(struct drbd_peer_device *, sector_t sector, int
 extern int drbd_send_bitmap(struct drbd_device *device);
 extern void drbd_send_sr_reply(struct drbd_peer_device *, enum drbd_state_rv retcode);
 extern void conn_send_sr_reply(struct drbd_connection *connection, enum drbd_state_rv retcode);
-extern void drbd_free_ldev(struct drbd_backing_dev *ldev);
+extern void drbd_backing_dev_free(struct drbd_device *device, struct drbd_backing_dev *ldev);
 extern void drbd_device_cleanup(struct drbd_device *device);
 void drbd_print_uuids(struct drbd_device *device, const char *text);
 
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index a4aa7eb..136fa73 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1992,7 +1992,7 @@ void drbd_device_cleanup(struct drbd_device *device)
 		drbd_bm_cleanup(device);
 	}
 
-	drbd_free_ldev(device->ldev);
+	drbd_backing_dev_free(device, device->ldev);
 	device->ldev = NULL;
 
 	clear_bit(AL_SUSPENDED, &device->flags);
@@ -2171,7 +2171,7 @@ void drbd_destroy_device(struct kref *kref)
 	if (device->this_bdev)
 		bdput(device->this_bdev);
 
-	drbd_free_ldev(device->ldev);
+	drbd_backing_dev_free(device, device->ldev);
 	device->ldev = NULL;
 
 	drbd_release_all_peer_reqs(device);
@@ -2964,18 +2964,6 @@ fail:
 	return err;
 }
 
-void drbd_free_ldev(struct drbd_backing_dev *ldev)
-{
-	if (ldev == NULL)
-		return;
-
-	blkdev_put(ldev->backing_bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
-	blkdev_put(ldev->md_bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
-
-	kfree(ldev->disk_conf);
-	kfree(ldev);
-}
-
 static void drbd_free_one_sock(struct drbd_socket *ds)
 {
 	struct socket *s;
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 4703f1a..ee34739 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1471,6 +1471,88 @@ success:
 	return 0;
 }
 
+static struct block_device *open_backing_dev(struct drbd_device *device,
+		const char *bdev_path, void *claim_ptr, bool do_bd_link)
+{
+	struct block_device *bdev;
+	int err = 0;
+
+	bdev = blkdev_get_by_path(bdev_path,
+				  FMODE_READ | FMODE_WRITE | FMODE_EXCL, claim_ptr);
+	if (IS_ERR(bdev)) {
+		drbd_err(device, "open(\"%s\") failed with %ld\n",
+				bdev_path, PTR_ERR(bdev));
+		return bdev;
+	}
+
+	if (!do_bd_link)
+		return bdev;
+
+	err = bd_link_disk_holder(bdev, device->vdisk);
+	if (err) {
+		blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+		drbd_err(device, "bd_link_disk_holder(\"%s\", ...) failed with %d\n",
+				bdev_path, err);
+		bdev = ERR_PTR(err);
+	}
+	return bdev;
+}
+
+static int open_backing_devices(struct drbd_device *device,
+		struct disk_conf *new_disk_conf,
+		struct drbd_backing_dev *nbc)
+{
+	struct block_device *bdev;
+
+	bdev = open_backing_dev(device, new_disk_conf->backing_dev, device, true);
+	if (IS_ERR(bdev))
+		return ERR_OPEN_DISK;
+	nbc->backing_bdev = bdev;
+
+	/*
+	 * meta_dev_idx >= 0: external fixed size, possibly multiple
+	 * drbd sharing one meta device.  TODO in that case, paranoia
+	 * check that [md_bdev, meta_dev_idx] is not yet used by some
+	 * other drbd minor!  (if you use drbd.conf + drbdadm, that
+	 * should check it for you already; but if you don't, or
+	 * someone fooled it, we need to double check here)
+	 */
+	bdev = open_backing_dev(device, new_disk_conf->meta_dev,
+		/* claim ptr: device, if claimed exclusively; shared drbd_m_holder,
+		 * if potentially shared with other drbd minors */
+			(new_disk_conf->meta_dev_idx < 0) ? (void*)device : (void*)drbd_m_holder,
+		/* avoid double bd_claim_by_disk() for the same (source,target) tuple,
+		 * as would happen with internal metadata. */
+			(new_disk_conf->meta_dev_idx != DRBD_MD_INDEX_FLEX_INT &&
+			 new_disk_conf->meta_dev_idx != DRBD_MD_INDEX_INTERNAL));
+	if (IS_ERR(bdev))
+		return ERR_OPEN_MD_DISK;
+	nbc->md_bdev = bdev;
+	return NO_ERROR;
+}
+
+static void close_backing_dev(struct drbd_device *device, struct block_device *bdev,
+	bool do_bd_unlink)
+{
+	if (!bdev)
+		return;
+	if (do_bd_unlink)
+		bd_unlink_disk_holder(bdev, device->vdisk);
+	blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+}
+
+void drbd_backing_dev_free(struct drbd_device *device, struct drbd_backing_dev *ldev)
+{
+	if (ldev == NULL)
+		return;
+
+	close_backing_dev(device, ldev->md_bdev, ldev->md_bdev != ldev->backing_bdev);
+	close_backing_dev(device, ldev->backing_bdev, true);
+
+	kfree(ldev->disk_conf);
+	kfree(ldev);
+}
+
 int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 {
 	struct drbd_config_context adm_ctx;
@@ -1484,7 +1566,6 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	sector_t min_md_device_sectors;
 	struct drbd_backing_dev *nbc = NULL; /* new_backing_conf */
 	struct disk_conf *new_disk_conf = NULL;
-	struct block_device *bdev;
 	struct lru_cache *resync_lru = NULL;
 	struct fifo_buffer *new_plan = NULL;
 	union drbd_state ns, os;
@@ -1572,35 +1653,9 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	}
 	rcu_read_unlock();
 
-	bdev = blkdev_get_by_path(new_disk_conf->backing_dev,
-				  FMODE_READ | FMODE_WRITE | FMODE_EXCL, device);
-	if (IS_ERR(bdev)) {
-		drbd_err(device, "open(\"%s\") failed with %ld\n", new_disk_conf->backing_dev,
-			PTR_ERR(bdev));
-		retcode = ERR_OPEN_DISK;
-		goto fail;
-	}
-	nbc->backing_bdev = bdev;
-
-	/*
-	 * meta_dev_idx >= 0: external fixed size, possibly multiple
-	 * drbd sharing one meta device.  TODO in that case, paranoia
-	 * check that [md_bdev, meta_dev_idx] is not yet used by some
-	 * other drbd minor!  (if you use drbd.conf + drbdadm, that
-	 * should check it for you already; but if you don't, or
-	 * someone fooled it, we need to double check here)
-	 */
-	bdev = blkdev_get_by_path(new_disk_conf->meta_dev,
-				  FMODE_READ | FMODE_WRITE | FMODE_EXCL,
-				  (new_disk_conf->meta_dev_idx < 0) ?
-				  (void *)device : (void *)drbd_m_holder);
-	if (IS_ERR(bdev)) {
-		drbd_err(device, "open(\"%s\") failed with %ld\n", new_disk_conf->meta_dev,
-			PTR_ERR(bdev));
-		retcode = ERR_OPEN_MD_DISK;
+	retcode = open_backing_devices(device, new_disk_conf, nbc);
+	if (retcode != NO_ERROR)
 		goto fail;
-	}
-	nbc->md_bdev = bdev;
 
 	if ((nbc->backing_bdev == nbc->md_bdev) !=
 	    (new_disk_conf->meta_dev_idx == DRBD_MD_INDEX_INTERNAL ||
@@ -1900,12 +1955,8 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
  fail:
 	conn_reconfig_done(connection);
 	if (nbc) {
-		if (nbc->backing_bdev)
-			blkdev_put(nbc->backing_bdev,
-				   FMODE_READ | FMODE_WRITE | FMODE_EXCL);
-		if (nbc->md_bdev)
-			blkdev_put(nbc->md_bdev,
-				   FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+		close_backing_dev(device, nbc->md_bdev, nbc->md_bdev != nbc->backing_bdev);
+		close_backing_dev(device, nbc->backing_bdev, true);
 		kfree(nbc);
 	}
 	kfree(new_disk_conf);
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 2f29bf3..eff716c 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1841,7 +1841,7 @@ static void drbd_ldev_destroy(struct drbd_device *device)
 	device->act_log = NULL;
 
 	__acquire(local);
-	drbd_free_ldev(device->ldev);
+	drbd_backing_dev_free(device, device->ldev);
 	device->ldev = NULL;
 	__release(local);
 
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index 392fc0e..d6b3c99 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -51,7 +51,7 @@
 #endif
 
 extern const char *drbd_buildtag(void);
-#define REL_VERSION "8.4.5"
+#define REL_VERSION "8.4.6"
 #define API_VERSION 1
 #define PRO_VERSION_MIN 86
 #define PRO_VERSION_MAX 101
-- 
1.9.1

