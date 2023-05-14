Return-Path: <mirimmad@outlook.com>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
	(mail-dm6nam12olkn2015.outbound.protection.outlook.com [40.92.22.15])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4348742016E
	for <drbd-dev@lists.linbit.com>; Sun, 14 May 2023 16:25:22 +0200 (CEST)
From: mirimmad@outlook.com
To: 
Date: Sun, 14 May 2023 19:40:33 +0530
Message-ID: <CY5PR12MB64558DB2E8ACBD592F26E61AC67B9@CY5PR12MB6455.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB64555F99E4FEF60569050F1FC67B9@CY5PR12MB6455.namprd12.prod.outlook.com>
References: <CY5PR12MB64555F99E4FEF60569050F1FC67B9@CY5PR12MB6455.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, skhan@linuxfoundation.org,
	lars.ellenberg@linbit.com, mirimmad17@gmail.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v2] drdb: fix debugfs_create_dir and
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
Changes in v2:
    - Fix indentation
    - Fix potential memory leak

 drivers/block/drbd/drbd_debugfs.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index 12460b584..ab431a3f2 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -781,6 +781,7 @@ void drbd_debugfs_device_add(struct drbd_device *device)

 	snprintf(vnr_buf, sizeof(vnr_buf), "%u", device->vnr);
 	dentry = debugfs_create_dir(vnr_buf, vols_dir);
+    if (IS_ERR(dentry)) goto fail;
 	device->debugfs_vol = dentry;

 	snprintf(minor_buf, sizeof(minor_buf), "%u", device->minor);
@@ -789,9 +790,15 @@ void drbd_debugfs_device_add(struct drbd_device *device)
 	if (!slink_name)
 		goto fail;
 	dentry = debugfs_create_symlink(minor_buf, drbd_debugfs_minors, slink_name);
-	device->debugfs_minor = dentry;
-	kfree(slink_name);
-	slink_name = NULL;
+    if (!IS_ERR(dentry)) {
+        device->debugfs_minor = dentry;
+        kfree(slink_name);
+        slink_name = NULL;
+    } else {
+        kfree(slink_name);
+        slink_name = NULL;
+        goto fail;
+    }

 #define DCF(name)	do {					\
 	dentry = debugfs_create_file(#name, 0440,	\
--
2.40.0

