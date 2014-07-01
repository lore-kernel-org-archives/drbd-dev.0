Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EEAB7101707A
	for <drbd-dev@lists.linbit.com>; Tue,  1 Jul 2014 18:16:51 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue,  1 Jul 2014 18:16:49 +0200
Message-Id: <1404231410-29852-20-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1404231410-29852-1-git-send-email-philipp.reisner@linbit.com>
References: <1404231410-29852-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 19/20] drbd: consistently use list_add_tail for
	peer_request tracking
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

Keep the epoch entry lists (active_ee, read_ee, sync_ee, ...)
consistently "oldest first".  That way finding the oldest not yet
successfully processed request is simply list_first_entry_or_null.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 4 ++--
 drivers/block/drbd/drbd_worker.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 3a3c489..db5c580 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1777,7 +1777,7 @@ static int recv_resync_read(struct drbd_peer_device *peer_device, sector_t secto
 	peer_req->w.cb = e_end_resync_block;
 
 	spin_lock_irq(&device->resource->req_lock);
-	list_add(&peer_req->w.list, &device->sync_ee);
+	list_add_tail(&peer_req->w.list, &device->sync_ee);
 	spin_unlock_irq(&device->resource->req_lock);
 
 	atomic_add(pi->size >> 9, &device->rs_sect_ev);
@@ -2341,7 +2341,7 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 	 * active_ee to become empty in drbd_submit_peer_request();
 	 * better not add ourselves here. */
 	if ((peer_req->flags & EE_IS_TRIM_USE_ZEROOUT) == 0)
-		list_add(&peer_req->w.list, &device->active_ee);
+		list_add_tail(&peer_req->w.list, &device->active_ee);
 	spin_unlock_irq(&device->resource->req_lock);
 
 	if (device->state.conn == C_SYNC_TARGET)
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 49b8873..ad57129 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -410,7 +410,7 @@ static int read_for_csum(struct drbd_peer_device *peer_device, sector_t sector,
 
 	peer_req->w.cb = w_e_send_csum;
 	spin_lock_irq(&device->resource->req_lock);
-	list_add(&peer_req->w.list, &device->read_ee);
+	list_add_tail(&peer_req->w.list, &device->read_ee);
 	spin_unlock_irq(&device->resource->req_lock);
 
 	atomic_add(size >> 9, &device->rs_sect_ev);
-- 
1.9.1

