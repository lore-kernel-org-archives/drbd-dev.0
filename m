Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2C810103B4AE
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jun 2019 17:06:58 +0200 (CEST)
Received: by mail-wm1-f68.google.com with SMTP id x15so13139168wmj.3
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jun 2019 08:06:58 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	l12sm24690451wrb.81.2019.06.24.08.06.56
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 24 Jun 2019 08:06:56 -0700 (PDT)
Resent-Message-ID: <20190624150655.GS30528@soda.linbit>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CD8FD1019AC6
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jun 2019 17:52:23 +0200 (CEST)
Date: Tue, 18 Jun 2019 17:45:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>
Message-ID: <20190618154549.GA15265@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] block: drbd: no need to check return value of
 debugfs_create functions
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

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/drbd/drbd_debugfs.c | 64 +------------------------------
 drivers/block/drbd/drbd_debugfs.h |  4 +-
 drivers/block/drbd/drbd_main.c    |  3 +-
 3 files changed, 5 insertions(+), 66 deletions(-)

diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index f13b48ff5f43..b3b9cd5628fd 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -465,35 +465,20 @@ static const struct file_operations in_flight_summary_fops = {
 void drbd_debugfs_resource_add(struct drbd_resource *resource)
 {
 	struct dentry *dentry;
-	if (!drbd_debugfs_resources)
-		return;
 
 	dentry = debugfs_create_dir(resource->name, drbd_debugfs_resources);
-	if (IS_ERR_OR_NULL(dentry))
-		goto fail;
 	resource->debugfs_res = dentry;
 
 	dentry = debugfs_create_dir("volumes", resource->debugfs_res);
-	if (IS_ERR_OR_NULL(dentry))
-		goto fail;
 	resource->debugfs_res_volumes = dentry;
 
 	dentry = debugfs_create_dir("connections", resource->debugfs_res);
-	if (IS_ERR_OR_NULL(dentry))
-		goto fail;
 	resource->debugfs_res_connections = dentry;
 
 	dentry = debugfs_create_file("in_flight_summary", 0440,
 				     resource->debugfs_res, resource,
 				     &in_flight_summary_fops);
-	if (IS_ERR_OR_NULL(dentry))
-		goto fail;
 	resource->debugfs_res_in_flight_summary = dentry;
-	return;
-
-fail:
-	drbd_debugfs_resource_cleanup(resource);
-	drbd_err(resource, "failed to create debugfs dentry\n");
 }
 
 static void drbd_debugfs_remove(struct dentry **dp)
@@ -636,35 +621,22 @@ void drbd_debugfs_connection_add(struct drbd_connection *connection)
 {
 	struct dentry *conns_dir = connection->resource->debugfs_res_connections;
 	struct dentry *dentry;
-	if (!conns_dir)
-		return;
 
 	/* Once we enable mutliple peers,
 	 * these connections will have descriptive names.
 	 * For now, it is just the one connection to the (only) "peer". */
 	dentry = debugfs_create_dir("peer", conns_dir);
-	if (IS_ERR_OR_NULL(dentry))
-		goto fail;
 	connection->debugfs_conn = dentry;
 
 	dentry = debugfs_create_file("callback_history", 0440,
 				     connection->debugfs_conn, connection,
 				     &connection_callback_history_fops);
-	if (IS_ERR_OR_NULL(dentry))
-		goto fail;
 	connection->debugfs_conn_callback_history = dentry;
 
 	dentry = debugfs_create_file("oldest_requests", 0440,
 				     connection->debugfs_conn, connection,
 				     &connection_oldest_requests_fops);
-	if (IS_ERR_OR_NULL(dentry))
-		goto fail;
 	connection->debugfs_conn_oldest_requests = dentry;
-	return;
-
-fail:
-	drbd_debugfs_connection_cleanup(connection);
-	drbd_err(connection, "failed to create debugfs dentry\n");
 }
 
 void drbd_debugfs_connection_cleanup(struct drbd_connection *connection)
@@ -809,8 +781,6 @@ void drbd_debugfs_device_add(struct drbd_device *device)
 
 	snprintf(vnr_buf, sizeof(vnr_buf), "%u", device->vnr);
 	dentry = debugfs_create_dir(vnr_buf, vols_dir);
-	if (IS_ERR_OR_NULL(dentry))
-		goto fail;
 	device->debugfs_vol = dentry;
 
 	snprintf(minor_buf, sizeof(minor_buf), "%u", device->minor);
@@ -819,18 +789,14 @@ void drbd_debugfs_device_add(struct drbd_device *device)
 	if (!slink_name)
 		goto fail;
 	dentry = debugfs_create_symlink(minor_buf, drbd_debugfs_minors, slink_name);
+	device->debugfs_minor = dentry;
 	kfree(slink_name);
 	slink_name = NULL;
-	if (IS_ERR_OR_NULL(dentry))
-		goto fail;
-	device->debugfs_minor = dentry;
 
 #define DCF(name)	do {					\
 	dentry = debugfs_create_file(#name, 0440,	\
 			device->debugfs_vol, device,		\
 			&device_ ## name ## _fops);		\
-	if (IS_ERR_OR_NULL(dentry))				\
-		goto fail;					\
 	device->debugfs_vol_ ## name = dentry;			\
 	} while (0)
 
@@ -864,19 +830,9 @@ void drbd_debugfs_peer_device_add(struct drbd_peer_device *peer_device)
 	struct dentry *dentry;
 	char vnr_buf[8];
 
-	if (!conn_dir)
-		return;
-
 	snprintf(vnr_buf, sizeof(vnr_buf), "%u", peer_device->device->vnr);
 	dentry = debugfs_create_dir(vnr_buf, conn_dir);
-	if (IS_ERR_OR_NULL(dentry))
-		goto fail;
 	peer_device->debugfs_peer_dev = dentry;
-	return;
-
-fail:
-	drbd_debugfs_peer_device_cleanup(peer_device);
-	drbd_err(peer_device, "failed to create debugfs entries\n");
 }
 
 void drbd_debugfs_peer_device_cleanup(struct drbd_peer_device *peer_device)
@@ -917,35 +873,19 @@ void drbd_debugfs_cleanup(void)
 	drbd_debugfs_remove(&drbd_debugfs_root);
 }
 
-int __init drbd_debugfs_init(void)
+void __init drbd_debugfs_init(void)
 {
 	struct dentry *dentry;
 
 	dentry = debugfs_create_dir("drbd", NULL);
-	if (IS_ERR_OR_NULL(dentry))
-		goto fail;
 	drbd_debugfs_root = dentry;
 
 	dentry = debugfs_create_file("version", 0444, drbd_debugfs_root, NULL, &drbd_version_fops);
-	if (IS_ERR_OR_NULL(dentry))
-		goto fail;
 	drbd_debugfs_version = dentry;
 
 	dentry = debugfs_create_dir("resources", drbd_debugfs_root);
-	if (IS_ERR_OR_NULL(dentry))
-		goto fail;
 	drbd_debugfs_resources = dentry;
 
 	dentry = debugfs_create_dir("minors", drbd_debugfs_root);
-	if (IS_ERR_OR_NULL(dentry))
-		goto fail;
 	drbd_debugfs_minors = dentry;
-	return 0;
-
-fail:
-	drbd_debugfs_cleanup();
-	if (dentry)
-		return PTR_ERR(dentry);
-	else
-		return -EINVAL;
 }
diff --git a/drivers/block/drbd/drbd_debugfs.h b/drivers/block/drbd/drbd_debugfs.h
index 4ecfbb3358d7..58e31cef0844 100644
--- a/drivers/block/drbd/drbd_debugfs.h
+++ b/drivers/block/drbd/drbd_debugfs.h
@@ -6,7 +6,7 @@
 #include "drbd_int.h"
 
 #ifdef CONFIG_DEBUG_FS
-int __init drbd_debugfs_init(void);
+void __init drbd_debugfs_init(void);
 void drbd_debugfs_cleanup(void);
 
 void drbd_debugfs_resource_add(struct drbd_resource *resource);
@@ -22,7 +22,7 @@ void drbd_debugfs_peer_device_add(struct drbd_peer_device *peer_device);
 void drbd_debugfs_peer_device_cleanup(struct drbd_peer_device *peer_device);
 #else
 
-static inline int __init drbd_debugfs_init(void) { return -ENODEV; }
+static inline void __init drbd_debugfs_init(void) { }
 static inline void drbd_debugfs_cleanup(void) { }
 
 static inline void drbd_debugfs_resource_add(struct drbd_resource *resource) { }
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 541b31fa42b3..40edaf87241c 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3009,8 +3009,7 @@ static int __init drbd_init(void)
 	spin_lock_init(&retry.lock);
 	INIT_LIST_HEAD(&retry.writes);
 
-	if (drbd_debugfs_init())
-		pr_notice("failed to initialize debugfs -- will not be available\n");
+	drbd_debugfs_init();
 
 	pr_info("initialized. "
 	       "Version: " REL_VERSION " (api:%d/proto:%d-%d)\n",
-- 
2.22.0

