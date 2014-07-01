Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 084371019A35
	for <drbd-dev@lists.linbit.com>; Tue,  1 Jul 2014 18:16:52 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue,  1 Jul 2014 18:16:50 +0200
Message-Id: <1404231410-29852-21-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1404231410-29852-1-git-send-email-philipp.reisner@linbit.com>
References: <1404231410-29852-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 20/20] drbd: also keep track of trim -> zero-out
	fallback peer_requests
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

To be able to find and present such zero-out fallback peer_requests
in debugfs, we add those to "active_ee", once that list drained.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index db5c580..7a1078d 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1370,6 +1370,11 @@ int drbd_submit_peer_request(struct drbd_device *device,
 		/* wait for all pending IO completions, before we start
 		 * zeroing things out. */
 		conn_wait_active_ee_empty(first_peer_device(device)->connection);
+		/* add it to the active list now,
+		 * so we can find it to present it in debugfs */
+		spin_lock_irq(&device->resource->req_lock);
+		list_add_tail(&peer_req->w.list, &device->active_ee);
+		spin_unlock_irq(&device->resource->req_lock);
 		if (blkdev_issue_zeroout(device->ldev->backing_bdev,
 			sector, ds >> 9, GFP_NOIO))
 			peer_req->flags |= EE_WAS_ERROR;
-- 
1.9.1

