Return-Path: <mirimmad@outlook.com>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
	(mail-dm6nam12olkn2053.outbound.protection.outlook.com [40.92.22.53])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id ED16042016E
	for <drbd-dev@lists.linbit.com>; Sun, 14 May 2023 14:56:04 +0200 (CEST)
From: mirimmad@outlook.com
To: 
Date: Sun, 14 May 2023 18:09:53 +0530
Message-ID: <CY5PR12MB64555F99E4FEF60569050F1FC67B9@CY5PR12MB6455.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Cc: Jens Axboe <axboe@kernel.dk>, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	skhan@linuxfoundation.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com, Immad Mir <mirimmad17@gmail.com>
Subject: [Drbd-dev] [PATCH] drdb: fix debugfs_create_dir and
	debugfs_create_symlink error handling
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

From: Immad Mir <mirimmad17@gmail.com>

debugfs_create_dir and debugfs_create_symlink return ERR_PTR incase of
a failure which must be checked with the inline function IS_ERR. This
patch attempts to do the same.

Signed-off-by: Immad Mir <mirimmad17@gmail.com>
---
 drivers/block/drbd/drbd_debugfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index 12460b584..1cec65563 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -781,6 +781,7 @@ void drbd_debugfs_device_add(struct drbd_device *device)

 	snprintf(vnr_buf, sizeof(vnr_buf), "%u", device->vnr);
 	dentry = debugfs_create_dir(vnr_buf, vols_dir);
+    if (IS_ERR(dentry)) goto fail;
 	device->debugfs_vol = dentry;

 	snprintf(minor_buf, sizeof(minor_buf), "%u", device->minor);
@@ -789,9 +790,12 @@ void drbd_debugfs_device_add(struct drbd_device *device)
 	if (!slink_name)
 		goto fail;
 	dentry = debugfs_create_symlink(minor_buf, drbd_debugfs_minors, slink_name);
+    if (!IS_ERR(dentry)) {
 	device->debugfs_minor = dentry;
 	kfree(slink_name);
 	slink_name = NULL;
+    } else
+        goto fail;

 #define DCF(name)	do {					\
 	dentry = debugfs_create_file(#name, 0440,	\
--
2.40.0

