Return-Path: <BATV+b2e8b8bc6a48568b3498+7499+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 88940420319
	for <drbd-dev@lists.linbit.com>; Tue,  5 Mar 2024 14:40:45 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/7] drbd: refactor drbd_reconsider_queue_parameters
Date: Tue,  5 Mar 2024 06:40:36 -0700
Message-Id: <20240305134041.137006-3-hch@lst.de>
In-Reply-To: <20240305134041.137006-1-hch@lst.de>
References: <20240305134041.137006-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, drbd-dev@lists.linbit.com
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

Split out a drbd_max_peer_bio_size helper for the peer I/O size,
and condense the various checks to a nested min3(..., max())) instead
of using a lot of local variables.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_nl.c | 84 +++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 35 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 43747a1aae4353..9135001a8e572d 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1189,6 +1189,33 @@ static int drbd_check_al_size(struct drbd_device *device, struct disk_conf *dc)
 	return 0;
 }
 
+static unsigned int drbd_max_peer_bio_size(struct drbd_device *device)
+{
+	/*
+	 * We may ignore peer limits if the peer is modern enough.  From 8.3.8
+	 * onwards the peer can use multiple BIOs for a single peer_request.
+	 */
+	if (device->state.conn < C_WF_REPORT_PARAMS)
+		return device->peer_max_bio_size;
+
+	if (first_peer_device(device)->connection->agreed_pro_version < 94)
+		return min(device->peer_max_bio_size, DRBD_MAX_SIZE_H80_PACKET);
+
+	/*
+	 * Correct old drbd (up to 8.3.7) if it believes it can do more than
+	 * 32KiB.
+	 */
+	if (first_peer_device(device)->connection->agreed_pro_version == 94)
+		return DRBD_MAX_SIZE_H80_PACKET;
+
+	/*
+	 * drbd 8.3.8 onwards, before 8.4.0
+	 */
+	if (first_peer_device(device)->connection->agreed_pro_version < 100)
+		return DRBD_MAX_BIO_SIZE_P95;
+	return DRBD_MAX_BIO_SIZE;
+}
+
 static void blk_queue_discard_granularity(struct request_queue *q, unsigned int granularity)
 {
 	q->limits.discard_granularity = granularity;
@@ -1303,48 +1330,35 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 	fixup_discard_support(device, q);
 }
 
-void drbd_reconsider_queue_parameters(struct drbd_device *device, struct drbd_backing_dev *bdev, struct o_qlim *o)
+void drbd_reconsider_queue_parameters(struct drbd_device *device,
+		struct drbd_backing_dev *bdev, struct o_qlim *o)
 {
-	unsigned int now, new, local, peer;
-
-	now = queue_max_hw_sectors(device->rq_queue) << 9;
-	local = device->local_max_bio_size; /* Eventually last known value, from volatile memory */
-	peer = device->peer_max_bio_size; /* Eventually last known value, from meta data */
+	unsigned int now = queue_max_hw_sectors(device->rq_queue) <<
+			SECTOR_SHIFT;
+	unsigned int new;
 
 	if (bdev) {
-		local = queue_max_hw_sectors(bdev->backing_bdev->bd_disk->queue) << 9;
-		device->local_max_bio_size = local;
-	}
-	local = min(local, DRBD_MAX_BIO_SIZE);
-
-	/* We may ignore peer limits if the peer is modern enough.
-	   Because new from 8.3.8 onwards the peer can use multiple
-	   BIOs for a single peer_request */
-	if (device->state.conn >= C_WF_REPORT_PARAMS) {
-		if (first_peer_device(device)->connection->agreed_pro_version < 94)
-			peer = min(device->peer_max_bio_size, DRBD_MAX_SIZE_H80_PACKET);
-			/* Correct old drbd (up to 8.3.7) if it believes it can do more than 32KiB */
-		else if (first_peer_device(device)->connection->agreed_pro_version == 94)
-			peer = DRBD_MAX_SIZE_H80_PACKET;
-		else if (first_peer_device(device)->connection->agreed_pro_version < 100)
-			peer = DRBD_MAX_BIO_SIZE_P95;  /* drbd 8.3.8 onwards, before 8.4.0 */
-		else
-			peer = DRBD_MAX_BIO_SIZE;
+		struct request_queue *b = bdev->backing_bdev->bd_disk->queue;
 
-		/* We may later detach and re-attach on a disconnected Primary.
-		 * Avoid this setting to jump back in that case.
-		 * We want to store what we know the peer DRBD can handle,
-		 * not what the peer IO backend can handle. */
-		if (peer > device->peer_max_bio_size)
-			device->peer_max_bio_size = peer;
+		device->local_max_bio_size =
+			queue_max_hw_sectors(b) << SECTOR_SHIFT;
 	}
-	new = min(local, peer);
 
-	if (device->state.role == R_PRIMARY && new < now)
-		drbd_err(device, "ASSERT FAILED new < now; (%u < %u)\n", new, now);
-
-	if (new != now)
+	/*
+	 * We may later detach and re-attach on a disconnected Primary.  Avoid
+	 * decreasing the value in this case.
+	 *
+	 * We want to store what we know the peer DRBD can handle, not what the
+	 * peer IO backend can handle.
+	 */
+	new = min3(DRBD_MAX_BIO_SIZE, device->local_max_bio_size,
+		max(drbd_max_peer_bio_size(device), device->peer_max_bio_size));
+	if (new != now) {
+		if (device->state.role == R_PRIMARY && new < now)
+			drbd_err(device, "ASSERT FAILED new < now; (%u < %u)\n",
+					new, now);
 		drbd_info(device, "max BIO size = %u\n", new);
+	}
 
 	drbd_setup_queue_param(device, bdev, new, o);
 }
-- 
2.39.2

