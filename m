Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8383C101AC7A
	for <drbd-dev@lists.linbit.com>; Mon, 30 Jun 2014 17:53:08 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 30 Jun 2014 17:53:03 +0200
Message-Id: <1404143587-24344-15-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1404143587-24344-1-git-send-email-philipp.reisner@linbit.com>
References: <1404143587-24344-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 14/18] drbd: explicitly submit meta data requests
	with REQ_NOIDLE
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

For some reason we have assumed NOIDLE was implied
by one of the other flags we set. It is not (anymore?).
Explicitly set REQ_NOIDLE for synchronous meta data updates,
or we can seriously starve random writes when using CFQ.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 278c31f..14b2f27 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -150,7 +150,7 @@ static int _drbd_md_sync_page_io(struct drbd_device *device,
 
 	if ((rw & WRITE) && !test_bit(MD_NO_FUA, &device->flags))
 		rw |= REQ_FUA | REQ_FLUSH;
-	rw |= REQ_SYNC;
+	rw |= REQ_SYNC | REQ_NOIDLE;
 
 	bio = bio_alloc_drbd(GFP_NOIO);
 	bio->bi_bdev = bdev->md_bdev;
-- 
1.9.1

