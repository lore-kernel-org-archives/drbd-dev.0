Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C77D2101AC7A
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 10:43:15 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu,  3 Jul 2014 10:42:54 +0200
Message-Id: <1404376995-4877-3-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1404376995-4877-1-git-send-email-philipp.reisner@linbit.com>
References: <1404376995-4877-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 02/23] drbd: fix drbd_destroy_device reference
	count updates
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

drbd_destroy_device means to give up reference counts
on the connection(s) reachable via the peer_device(s).

It must not do that by iterating via device->resource->connections,
resource and connections may have already been disassociated
by drbd_free_resource, and we'd leak connection refs.

Instead, iterate via device->peer_devices->connection.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 92547d1..56cf11b 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2160,7 +2160,7 @@ void drbd_destroy_device(struct kref *kref)
 {
 	struct drbd_device *device = container_of(kref, struct drbd_device, kref);
 	struct drbd_resource *resource = device->resource;
-	struct drbd_connection *connection;
+	struct drbd_peer_device *peer_device, *tmp_peer_device;
 
 	del_timer_sync(&device->request_timer);
 
@@ -2191,12 +2191,16 @@ void drbd_destroy_device(struct kref *kref)
 	put_disk(device->vdisk);
 	blk_cleanup_queue(device->rq_queue);
 	kfree(device->rs_plan_s);
-	kfree(first_peer_device(device));
+
+	/* not for_each_connection(connection, resource):
+	 * those may have been cleaned up and disassociated already.
+	 */
+	for_each_peer_device_safe(peer_device, tmp_peer_device, device) {
+		kref_put(&peer_device->connection->kref, drbd_destroy_connection);
+		kfree(peer_device);
+	}
 	memset(device, 0xfd, sizeof(*device));
 	kfree(device);
-
-	for_each_connection(connection, resource)
-		kref_put(&connection->kref, drbd_destroy_connection);
 	kref_put(&resource->kref, drbd_destroy_resource);
 }
 
-- 
1.9.1

