Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D18D71055F4A
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:28 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:53:38 +0100
Message-Id: <1448448851-10343-6-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/38] drbd: Move enum write_ordering_e to drbd.h
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

From: Andreas Gruenbacher <agruen@linbit.com>

Also change the enum values to all-capital letters.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h      |  6 ------
 drivers/block/drbd/drbd_main.c     |  2 +-
 drivers/block/drbd/drbd_nl.c       |  4 ++--
 drivers/block/drbd/drbd_proc.c     |  6 +++---
 drivers/block/drbd/drbd_receiver.c | 28 ++++++++++++++--------------
 include/linux/drbd.h               |  7 +++++++
 6 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index e66d453..47d4b02 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -632,12 +632,6 @@ struct bm_io_work {
 	void (*done)(struct drbd_device *device, int rv);
 };
 
-enum write_ordering_e {
-	WO_none,
-	WO_drain_io,
-	WO_bdev_flush,
-};
-
 struct fifo_buffer {
 	unsigned int head_index;
 	unsigned int size;
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 74d97f4..3ee4a44 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2590,7 +2590,7 @@ struct drbd_resource *drbd_create_resource(const char *name)
 	kref_init(&resource->kref);
 	idr_init(&resource->devices);
 	INIT_LIST_HEAD(&resource->connections);
-	resource->write_ordering = WO_bdev_flush;
+	resource->write_ordering = WO_BDEV_FLUSH;
 	list_add_tail_rcu(&resource->resources, &drbd_resources);
 	mutex_init(&resource->conf_update);
 	mutex_init(&resource->adm_mutex);
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index a1a01cc..dfc1799 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1418,7 +1418,7 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 		set_bit(MD_NO_FUA, &device->flags);
 
 	if (write_ordering_changed(old_disk_conf, new_disk_conf))
-		drbd_bump_write_ordering(device->resource, NULL, WO_bdev_flush);
+		drbd_bump_write_ordering(device->resource, NULL, WO_BDEV_FLUSH);
 
 	drbd_md_sync(device);
 
@@ -1727,7 +1727,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	new_disk_conf = NULL;
 	new_plan = NULL;
 
-	drbd_bump_write_ordering(device->resource, device->ldev, WO_bdev_flush);
+	drbd_bump_write_ordering(device->resource, device->ldev, WO_BDEV_FLUSH);
 
 	if (drbd_md_test_flag(device->ldev, MDF_CRASHED_PRIMARY))
 		set_bit(CRASHED_PRIMARY, &device->flags);
diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index 3b10fa6..6537b25 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -245,9 +245,9 @@ static int drbd_seq_show(struct seq_file *seq, void *v)
 	char wp;
 
 	static char write_ordering_chars[] = {
-		[WO_none] = 'n',
-		[WO_drain_io] = 'd',
-		[WO_bdev_flush] = 'f',
+		[WO_NONE] = 'n',
+		[WO_DRAIN_IO] = 'd',
+		[WO_BDEV_FLUSH] = 'f',
 	};
 
 	seq_printf(seq, "version: " REL_VERSION " (api:%d/proto:%d-%d)\n%s\n",
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 5bb71e5..bf38b95 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1178,7 +1178,7 @@ static void drbd_flush(struct drbd_connection *connection)
 	struct drbd_peer_device *peer_device;
 	int vnr;
 
-	if (connection->resource->write_ordering >= WO_bdev_flush) {
+	if (connection->resource->write_ordering >= WO_BDEV_FLUSH) {
 		rcu_read_lock();
 		idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
 			struct drbd_device *device = peer_device->device;
@@ -1203,7 +1203,7 @@ static void drbd_flush(struct drbd_connection *connection)
 				/* would rather check on EOPNOTSUPP, but that is not reliable.
 				 * don't try again for ANY return value != 0
 				 * if (rv == -EOPNOTSUPP) */
-				drbd_bump_write_ordering(connection->resource, NULL, WO_drain_io);
+				drbd_bump_write_ordering(connection->resource, NULL, WO_DRAIN_IO);
 			}
 			put_ldev(device);
 			kref_put(&device->kref, drbd_destroy_device);
@@ -1299,10 +1299,10 @@ max_allowed_wo(struct drbd_backing_dev *bdev, enum write_ordering_e wo)
 
 	dc = rcu_dereference(bdev->disk_conf);
 
-	if (wo == WO_bdev_flush && !dc->disk_flushes)
-		wo = WO_drain_io;
-	if (wo == WO_drain_io && !dc->disk_drain)
-		wo = WO_none;
+	if (wo == WO_BDEV_FLUSH && !dc->disk_flushes)
+		wo = WO_DRAIN_IO;
+	if (wo == WO_DRAIN_IO && !dc->disk_drain)
+		wo = WO_NONE;
 
 	return wo;
 }
@@ -1319,13 +1319,13 @@ void drbd_bump_write_ordering(struct drbd_resource *resource, struct drbd_backin
 	enum write_ordering_e pwo;
 	int vnr;
 	static char *write_ordering_str[] = {
-		[WO_none] = "none",
-		[WO_drain_io] = "drain",
-		[WO_bdev_flush] = "flush",
+		[WO_NONE] = "none",
+		[WO_DRAIN_IO] = "drain",
+		[WO_BDEV_FLUSH] = "flush",
 	};
 
 	pwo = resource->write_ordering;
-	if (wo != WO_bdev_flush)
+	if (wo != WO_BDEV_FLUSH)
 		wo = min(pwo, wo);
 	rcu_read_lock();
 	idr_for_each_entry(&resource->devices, device, vnr) {
@@ -1343,7 +1343,7 @@ void drbd_bump_write_ordering(struct drbd_resource *resource, struct drbd_backin
 	rcu_read_unlock();
 
 	resource->write_ordering = wo;
-	if (pwo != resource->write_ordering || wo == WO_bdev_flush)
+	if (pwo != resource->write_ordering || wo == WO_BDEV_FLUSH)
 		drbd_info(resource, "Method to ensure write ordering: %s\n", write_ordering_str[resource->write_ordering]);
 }
 
@@ -1533,7 +1533,7 @@ static int receive_Barrier(struct drbd_connection *connection, struct packet_inf
 	 * Therefore we must send the barrier_ack after the barrier request was
 	 * completed. */
 	switch (connection->resource->write_ordering) {
-	case WO_none:
+	case WO_NONE:
 		if (rv == FE_RECYCLED)
 			return 0;
 
@@ -1546,8 +1546,8 @@ static int receive_Barrier(struct drbd_connection *connection, struct packet_inf
 			drbd_warn(connection, "Allocation of an epoch failed, slowing down\n");
 			/* Fall through */
 
-	case WO_bdev_flush:
-	case WO_drain_io:
+	case WO_BDEV_FLUSH:
+	case WO_DRAIN_IO:
 		conn_wait_active_ee_empty(connection);
 		drbd_flush(connection);
 
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index 8723f2a..15a1472 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -357,6 +357,13 @@ enum drbd_timeout_flag {
 
 #define UUID_JUST_CREATED ((__u64)4)
 
+enum write_ordering_e {
+	WO_NONE,
+	WO_DRAIN_IO,
+	WO_BDEV_FLUSH,
+	WO_BIO_BARRIER
+};
+
 /* magic numbers used in meta data and network packets */
 #define DRBD_MAGIC 0x83740267
 #define DRBD_MAGIC_BIG 0x835a
-- 
1.9.1

