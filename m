Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BD01E10562D4
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:37 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:54:05 +0100
Message-Id: <1448448851-10343-33-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 32/38] drbd: don't block forever in disconnect
	during resync if fencing=r-a-stonith
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

Disconnect should wait for pending bitmap IO.
But if that bitmap IO is not happening, because it is waiting for
pending application IO, and there is no progress, because the fencing
policy suspended application IO because of the disconnect,
then we deadlock.

The bitmap writeout in this case does not care for concurrent
application IO, so there is no point waiting for it.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 136fa73..5b43dfb 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3563,7 +3563,9 @@ void drbd_queue_bitmap_io(struct drbd_device *device,
 
 	spin_lock_irq(&device->resource->req_lock);
 	set_bit(BITMAP_IO, &device->flags);
-	if (atomic_read(&device->ap_bio_cnt) == 0) {
+	/* don't wait for pending application IO if the caller indicates that
+	 * application IO does not conflict anyways. */
+	if (flags == BM_LOCKED_CHANGE_ALLOWED || atomic_read(&device->ap_bio_cnt) == 0) {
 		if (!test_and_set_bit(BITMAP_IO_QUEUED, &device->flags))
 			drbd_queue_work(&first_peer_device(device)->connection->sender_work,
 					&device->bm_io_work.w);
-- 
1.9.1

