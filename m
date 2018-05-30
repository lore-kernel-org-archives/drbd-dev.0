Return-Path: <johannes@johannesthoma.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C2109101AC56
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2018 17:42:57 +0200 (CEST)
From: johannes@johannesthoma.com
To: drbd-dev@lists.linbit.com
Date: Wed, 30 May 2018 17:37:27 +0200
Message-Id: <20180530153727.2334-1-johannes@johannesthoma.com>
Subject: [Drbd-dev] [PATCH] Added missing kref_debug_put()'s on failure path
	of drbd_create_device().
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

From: Johannes Thoma <johannes@johannesthoma.com>

On failing late in drbd_create_device() some kref_debug_put()'s
were missing, which lead to false positives on kref_debug_destroy().

This patch adds the missing calls.

Signed-off-by: Johannes Thoma <johannes@johannesthoma.com>
---
 drbd/drbd_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index 04ec052..ba60e3b 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -3762,11 +3762,14 @@ out_remove_peer_device:
 		kfree(peer_device);
 		kref_debug_put(&connection->kref_debug, 3);
 		kref_put(&connection->kref, drbd_destroy_connection);
+		kref_debug_put(&device->kref_debug, 1);
 	}
 	idr_remove(&resource->devices, vnr);
+	kref_debug_put(&device->kref_debug, 1);
 
 out_idr_remove_minor:
 	idr_remove(&drbd_devices, minor);
+	kref_debug_put(&device->kref_debug, 1);
 out_no_minor_idr:
 	if (locked)
 		spin_unlock_irq(&resource->req_lock);
@@ -3787,6 +3790,9 @@ out_no_disk:
 	blk_cleanup_queue(q);
 out_no_q:
 	kref_put(&resource->kref, drbd_destroy_resource);
+	kref_debug_put(&resource->kref_debug, 4);
+		/* kref debugging wants an extra put, see has_refs() */
+	kref_debug_put(&device->kref_debug, 4);
 	kref_debug_destroy(&device->kref_debug);
 	kfree(device);
 	return err;
-- 
2.7.4

