Return-Path: <philipp.reisner@linbit.com>
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
	[209.85.208.50])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3DF824205E9
	for <drbd-dev@lists.linbit.com>; Wed,  6 Mar 2024 15:04:21 +0100 (CET)
Received: by mail-ed1-f50.google.com with SMTP id
	4fb4d7f45d1cf-55a5e7fa471so9995275a12.1
	for <drbd-dev@lists.linbit.com>; Wed, 06 Mar 2024 06:04:21 -0800 (PST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/7] drbd: split out a drbd_discard_supported helper
Date: Wed,  6 Mar 2024 15:03:31 +0100
Message-Id: <20240306140332.623759-7-philipp.reisner@linbit.com>
In-Reply-To: <20240305134041.137006-1-hch@lst.de>
References: <20240305134041.137006-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
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

From: Christoph Hellwig <hch@lst.de>

Add a helper to check if discard is supported for a given connection /
backing device combination.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Philipp Reisner <philipp.reisner@linbit.com>
Reviewed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Tested-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index a79b7fe5335d..94ed2b3ea636 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1231,24 +1231,33 @@ static unsigned int drbd_max_discard_sectors(struct drbd_connection *connection)
 	return AL_EXTENT_SIZE >> 9;
 }
 
-static void decide_on_discard_support(struct drbd_device *device,
+static bool drbd_discard_supported(struct drbd_connection *connection,
 		struct drbd_backing_dev *bdev)
 {
-	struct drbd_connection *connection =
-		first_peer_device(device)->connection;
-	struct request_queue *q = device->rq_queue;
-	unsigned int max_discard_sectors;
-
 	if (bdev && !bdev_max_discard_sectors(bdev->backing_bdev))
-		goto not_supported;
+		return false;
 
 	if (connection->cstate >= C_CONNECTED &&
 	    !(connection->agreed_features & DRBD_FF_TRIM)) {
 		drbd_info(connection,
 			"peer DRBD too old, does not support TRIM: disabling discards\n");
-		goto not_supported;
+		return false;
 	}
 
+	return true;
+}
+
+static void decide_on_discard_support(struct drbd_device *device,
+		struct drbd_backing_dev *bdev)
+{
+	struct drbd_connection *connection =
+		first_peer_device(device)->connection;
+	struct request_queue *q = device->rq_queue;
+	unsigned int max_discard_sectors;
+
+	if (!drbd_discard_supported(connection, bdev))
+		goto not_supported;
+
 	/*
 	 * We don't care for the granularity, really.
 	 *
-- 
2.40.1

