Return-Path: <johannes@johannesthoma.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6D19B1011B93
	for <drbd-dev@lists.linbit.com>; Tue, 22 May 2018 18:46:26 +0200 (CEST)
From: johannes@johannesthoma.com
To: drbd-dev@lists.linbit.com
Date: Tue, 22 May 2018 18:40:39 +0200
Message-Id: <1527007239-2887-1-git-send-email-johannes@johannesthoma.com>
Subject: [Drbd-dev] [PATCH] drbd_create_device: also remove device from
	resource idr on failure.
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

On failure, a drbdadm status may OOPS when the already freed
device is still on this idr, should we fail late in
drbd_create_device(). This patch does the cleanup.
---
 drbd/drbd_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index 300b684..04ec052 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -3763,6 +3763,7 @@ out_remove_peer_device:
 		kref_debug_put(&connection->kref_debug, 3);
 		kref_put(&connection->kref, drbd_destroy_connection);
 	}
+	idr_remove(&resource->devices, vnr);
 
 out_idr_remove_minor:
 	idr_remove(&drbd_devices, minor);
-- 
2.7.4

