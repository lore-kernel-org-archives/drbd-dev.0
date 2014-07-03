Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4D96E101AC75
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 10:43:16 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu,  3 Jul 2014 10:43:01 +0200
Message-Id: <1404376995-4877-10-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1404376995-4877-1-git-send-email-philipp.reisner@linbit.com>
References: <1404376995-4877-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/23] drbd: register peer requests on read_ee
	early
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

Initialize peer_request with timestamp and proper empty list head.
Add peer_request to list early, so debugfs can find this request and
report it as "preparing", even if we sleep before we actually submit it.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 2f67dc0..42e3835 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -362,17 +362,14 @@ drbd_alloc_peer_req(struct drbd_peer_device *peer_device, u64 id, sector_t secto
 			goto fail;
 	}
 
+	memset(peer_req, 0, sizeof(*peer_req));
+	INIT_LIST_HEAD(&peer_req->w.list);
 	drbd_clear_interval(&peer_req->i);
 	peer_req->i.size = data_size;
 	peer_req->i.sector = sector;
-	peer_req->i.local = false;
-	peer_req->i.waiting = false;
-
-	peer_req->epoch = NULL;
+	peer_req->submit_jif = jiffies;
 	peer_req->peer_device = peer_device;
 	peer_req->pages = page;
-	atomic_set(&peer_req->pending_bios, 0);
-	peer_req->flags = 0;
 	/*
 	 * The block_id is opaque to the receiver.  It is not endianness
 	 * converted, and sent back to the sender unchanged.
@@ -2668,6 +2665,15 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 	 * we would also throttle its application reads.
 	 * In that case, throttling is done on the SyncTarget only.
 	 */
+
+	/* Even though this may be a resync request, we do add to "read_ee";
+	 * "sync_ee" is only used for resync WRITEs.
+	 * Add to list early, so debugfs can find this request
+	 * even if we have to sleep below. */
+	spin_lock_irq(&device->resource->req_lock);
+	list_add_tail(&peer_req->w.list, &device->read_ee);
+	spin_unlock_irq(&device->resource->req_lock);
+
 	if (device->state.peer != R_PRIMARY
 	&& drbd_rs_should_slow_down(device, sector, false))
 		schedule_timeout_uninterruptible(HZ/10);
@@ -2679,21 +2685,18 @@ submit_for_resync:
 
 submit:
 	inc_unacked(device);
-	spin_lock_irq(&device->resource->req_lock);
-	list_add_tail(&peer_req->w.list, &device->read_ee);
-	spin_unlock_irq(&device->resource->req_lock);
-
 	if (drbd_submit_peer_request(device, peer_req, READ, fault_type) == 0)
 		return 0;
 
 	/* don't care for the reason here */
 	drbd_err(device, "submit failed, triggering re-connect\n");
+
+out_free_e:
 	spin_lock_irq(&device->resource->req_lock);
 	list_del(&peer_req->w.list);
 	spin_unlock_irq(&device->resource->req_lock);
 	/* no drbd_rs_complete_io(), we are dropping the connection anyways */
 
-out_free_e:
 	put_ldev(device);
 	drbd_free_peer_req(device, peer_req);
 	return -EIO;
-- 
1.9.1

