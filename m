Return-Path: <lars.ellenberg@linbit.com>
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Date: Thu, 20 Dec 2018 17:23:30 +0100
Message-Id: <20181220162344.8430-4-lars.ellenberg@linbit.com>
In-Reply-To: <20181220162344.8430-1-lars.ellenberg@linbit.com>
References: <20181220162344.8430-1-lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/17] drbd: centralize printk reporting of new
	size into drbd_set_my_capacity()
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

Previously, some implicit resizes that happend during handshake
have not been reported as prominently as explicit resize.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h  |  8 +-------
 drivers/block/drbd/drbd_main.c | 17 ++++++++++++++++-
 drivers/block/drbd/drbd_nl.c   |  3 ---
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 1e47db57b9d2..ab718582a092 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1609,13 +1609,7 @@ static inline void drbd_tcp_quickack(struct socket *sock)
 }
 
 /* sets the number of 512 byte sectors of our virtual device */
-static inline void drbd_set_my_capacity(struct drbd_device *device,
-					sector_t size)
-{
-	/* set_capacity(device->this_bdev->bd_disk, size); */
-	set_capacity(device->vdisk, size);
-	device->this_bdev->bd_inode->i_size = (loff_t)size << 9;
-}
+void drbd_set_my_capacity(struct drbd_device *device, sector_t size);
 
 /*
  * used to submit our private bio
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index f973a2a845c8..f9b4228cc2d9 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2034,6 +2034,21 @@ void drbd_init_set_defaults(struct drbd_device *device)
 	device->local_max_bio_size = DRBD_MAX_BIO_SIZE_SAFE;
 }
 
+static void _drbd_set_my_capacity(struct drbd_device *device, sector_t size)
+{
+	/* set_capacity(device->this_bdev->bd_disk, size); */
+	set_capacity(device->vdisk, size);
+	device->this_bdev->bd_inode->i_size = (loff_t)size << 9;
+}
+
+void drbd_set_my_capacity(struct drbd_device *device, sector_t size)
+{
+	char ppb[10];
+	_drbd_set_my_capacity(device, size);
+	drbd_info(device, "size = %s (%llu KB)\n",
+		ppsize(ppb, size>>1), (unsigned long long)size>>1);
+}
+
 void drbd_device_cleanup(struct drbd_device *device)
 {
 	int i;
@@ -2059,7 +2074,7 @@ void drbd_device_cleanup(struct drbd_device *device)
 	}
 	D_ASSERT(device, first_peer_device(device)->connection->net_conf == NULL);
 
-	drbd_set_my_capacity(device, 0);
+	_drbd_set_my_capacity(device, 0);
 	if (device->bitmap) {
 		/* maybe never allocated. */
 		drbd_bm_resize(device, 0, 1);
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index d15703b1ffe8..d02d38fd1288 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -921,7 +921,6 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 	} prev;
 	sector_t u_size, size;
 	struct drbd_md *md = &device->ldev->md;
-	char ppb[10];
 	void *buffer;
 
 	int md_moved, la_size_changed;
@@ -999,8 +998,6 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 		/* racy, see comments above. */
 		drbd_set_my_capacity(device, size);
 		md->la_size_sect = size;
-		drbd_info(device, "size = %s (%llu KB)\n", ppsize(ppb, size>>1),
-		     (unsigned long long)size>>1);
 	}
 	if (rv <= DS_ERROR)
 		goto err_out;
-- 
2.17.1

