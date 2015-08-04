Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 585B91055F44
	for <drbd-dev@lists.linbit.com>; Tue,  4 Aug 2015 14:56:59 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue,  4 Aug 2015 14:56:33 +0200
Message-Id: <1438693003-17554-10-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1438693003-17554-1-git-send-email-philipp.reisner@linbit.com>
References: <1438693003-17554-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/19] drbd: fix queue limit setup for discard
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

We cannot possibly support SECDISCARD, even if all backend devices would
support it: if our peer is currently unreachable, some instance of the
data may obviously still be recoverable.

We did not set discard_granularity at all.  We don't really care (yet),
we only pass them on, so for now, set our granularity to one sector.
blkdev_stack_limits() takes care of the rest.

If we decide we cannot support discards,
not only clear the (not user visible) QUEUE_FLAG_DISCARD,
but set both (user visible) discard_granularity and max_discard_sectors
to zero, to avoid confusion with e.g. lsblk -D.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 66e8acd..9f60a68 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1168,21 +1168,19 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 	if (b) {
 		struct drbd_connection *connection = first_peer_device(device)->connection;
 
+		q->limits.max_discard_sectors = DRBD_MAX_DISCARD_SECTORS;
+
 		if (blk_queue_discard(b) &&
 		    (connection->cstate < C_CONNECTED || connection->agreed_features & FF_TRIM)) {
-			/* For now, don't allow more than one activity log extent worth of data
-			 * to be discarded in one go. We may need to rework drbd_al_begin_io()
-			 * to allow for even larger discard ranges */
-			q->limits.max_discard_sectors = DRBD_MAX_DISCARD_SECTORS;
-
+			/* We don't care, stacking below should fix it for the local device.
+			 * Whether or not it is a suitable granularity on the remote device
+			 * is not our problem, really. If you care, you need to
+			 * use devices with similar topology on all peers. */
+			q->limits.discard_granularity = 512;
 			queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
-			/* REALLY? Is stacking secdiscard "legal"? */
-			if (blk_queue_secdiscard(b))
-				queue_flag_set_unlocked(QUEUE_FLAG_SECDISCARD, q);
 		} else {
-			q->limits.max_discard_sectors = 0;
 			queue_flag_clear_unlocked(QUEUE_FLAG_DISCARD, q);
-			queue_flag_clear_unlocked(QUEUE_FLAG_SECDISCARD, q);
+			q->limits.discard_granularity = 0;
 		}
 
 		blk_queue_stack_limits(q, b);
@@ -1194,6 +1192,12 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 			q->backing_dev_info.ra_pages = b->backing_dev_info.ra_pages;
 		}
 	}
+	/* To avoid confusion, if this queue does not support discard, clear
+	 * max_discard_sectors, which is what lsblk -D reports to the user.  */
+	if (!blk_queue_discard(q)) {
+		q->limits.max_discard_sectors = 0;
+		q->limits.discard_granularity = 0;
+	}
 }
 
 void drbd_reconsider_max_bio_size(struct drbd_device *device, struct drbd_backing_dev *bdev)
-- 
1.9.1

