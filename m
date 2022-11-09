Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
	[209.85.208.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E8E4542210A
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2022 14:35:08 +0100 (CET)
Received: by mail-ed1-f43.google.com with SMTP id a5so27228306edb.11
	for <drbd-dev@lists.linbit.com>; Wed, 09 Nov 2022 05:35:08 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  9 Nov 2022 14:34:51 +0100
Message-Id: <20221109133453.51652-2-christoph.boehmwalder@linbit.com>
In-Reply-To: <20221109133453.51652-1-christoph.boehmwalder@linbit.com>
References: <20221109133453.51652-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 1/3] drbd: use blk_queue_max_discard_sectors
	helper
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

We currently only set q->limits.max_discard_sectors, but that is not
enough. Another field, max_hw_discard_sectors, was introduced in
commit 0034af036554 ("block: make /sys/block/<dev>/queue/discard_max_bytes
writeable").

The difference is that max_discard_sectors can be changed from user
space via sysfs, while max_hw_discard_sectors is the "hardware" upper
limit.

So use this helper, which sets both.

This is also a fixup for commit 998e9cbcd615 ("drbd: cleanup
decide_on_discard_support"): if discards are not supported, that does
not necessarily mean we also want to disable write_zeroes.

Fixes: 998e9cbcd615 ("drbd: cleanup decide_on_discard_support")
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 864c98e74875..249eba7d21c2 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1210,6 +1210,7 @@ static void decide_on_discard_support(struct drbd_device *device,
 	struct drbd_connection *connection =
 		first_peer_device(device)->connection;
 	struct request_queue *q = device->rq_queue;
+	unsigned int max_discard_sectors;
 
 	if (bdev && !bdev_max_discard_sectors(bdev->backing_bdev))
 		goto not_supported;
@@ -1230,15 +1231,14 @@ static void decide_on_discard_support(struct drbd_device *device,
 	 * topology on all peers.
 	 */
 	blk_queue_discard_granularity(q, 512);
-	q->limits.max_discard_sectors = drbd_max_discard_sectors(connection);
-	q->limits.max_write_zeroes_sectors =
-		drbd_max_discard_sectors(connection);
+	max_discard_sectors = drbd_max_discard_sectors(connection);
+	blk_queue_max_discard_sectors(q, max_discard_sectors);
+	blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
 	return;
 
 not_supported:
 	blk_queue_discard_granularity(q, 0);
-	q->limits.max_discard_sectors = 0;
-	q->limits.max_write_zeroes_sectors = 0;
+	blk_queue_max_discard_sectors(q, 0);
 }
 
 static void fixup_write_zeroes(struct drbd_device *device, struct request_queue *q)
-- 
2.38.1

