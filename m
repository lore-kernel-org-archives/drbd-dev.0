Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 819BA1055725
	for <drbd-dev@lists.linbit.com>; Tue,  4 Aug 2015 14:56:58 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue,  4 Aug 2015 14:56:28 +0200
Message-Id: <1438693003-17554-5-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1438693003-17554-1-git-send-email-philipp.reisner@linbit.com>
References: <1438693003-17554-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 04/19] drbd: debugfs: expose ed_data_gen_id
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

The effective data generation ID may be interesting for debugging
purposes of scenarios involving diskless states.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_debugfs.c | 10 ++++++++++
 drivers/block/drbd/drbd_int.h     |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index 6b88a35..96a0107 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -771,6 +771,13 @@ static int device_data_gen_id_show(struct seq_file *m, void *ignored)
 	return 0;
 }
 
+static int device_ed_gen_id_show(struct seq_file *m, void *ignored)
+{
+	struct drbd_device *device = m->private;
+	seq_printf(m, "0x%016llX\n", (unsigned long long)device->ed_uuid);
+	return 0;
+}
+
 #define drbd_debugfs_device_attr(name)						\
 static int device_ ## name ## _open(struct inode *inode, struct file *file)	\
 {										\
@@ -796,6 +803,7 @@ drbd_debugfs_device_attr(oldest_requests)
 drbd_debugfs_device_attr(act_log_extents)
 drbd_debugfs_device_attr(resync_extents)
 drbd_debugfs_device_attr(data_gen_id)
+drbd_debugfs_device_attr(ed_gen_id)
 
 void drbd_debugfs_device_add(struct drbd_device *device)
 {
@@ -839,6 +847,7 @@ void drbd_debugfs_device_add(struct drbd_device *device)
 	DCF(act_log_extents);
 	DCF(resync_extents);
 	DCF(data_gen_id);
+	DCF(ed_gen_id);
 #undef DCF
 	return;
 
@@ -854,6 +863,7 @@ void drbd_debugfs_device_cleanup(struct drbd_device *device)
 	drbd_debugfs_remove(&device->debugfs_vol_act_log_extents);
 	drbd_debugfs_remove(&device->debugfs_vol_resync_extents);
 	drbd_debugfs_remove(&device->debugfs_vol_data_gen_id);
+	drbd_debugfs_remove(&device->debugfs_vol_ed_gen_id);
 	drbd_debugfs_remove(&device->debugfs_vol);
 }
 
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 9bf3178..249a909 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -835,6 +835,7 @@ struct drbd_device {
 	struct dentry *debugfs_vol_act_log_extents;
 	struct dentry *debugfs_vol_resync_extents;
 	struct dentry *debugfs_vol_data_gen_id;
+	struct dentry *debugfs_vol_ed_gen_id;
 #endif
 
 	unsigned int vnr;	/* volume number within the connection */
-- 
1.9.1

