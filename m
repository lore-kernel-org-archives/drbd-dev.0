Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CB75E1057FFE
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 23:29:57 +0200 (CEST)
Received: by mail-wm0-f43.google.com with SMTP id z132so4513352wmg.1
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 14:29:57 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 24 Aug 2017 23:23:07 +0200
Message-Id: <1503609794-13233-11-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
References: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 10/17] drbd: fix rmmod cleanup,
	remove _all_ debugfs entries
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

If there are still resources defined, but "empty", no more volumes
or connections configured, they don't hold module reference counts,
so rmmod is possible.

To avoid DRBD leftovers in debugfs, we need to call our global
drbd_debugfs_cleanup() only after all resources have been cleaned up.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 056d9ab..8b8dd82 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2420,7 +2420,6 @@ static void drbd_cleanup(void)
 		destroy_workqueue(retry.wq);
 
 	drbd_genl_unregister();
-	drbd_debugfs_cleanup();
 
 	idr_for_each_entry(&drbd_devices, device, i)
 		drbd_delete_device(device);
@@ -2431,6 +2430,8 @@ static void drbd_cleanup(void)
 		drbd_free_resource(resource);
 	}
 
+	drbd_debugfs_cleanup();
+
 	drbd_destroy_mempools();
 	unregister_blkdev(DRBD_MAJOR, "drbd");
 
-- 
2.7.4

