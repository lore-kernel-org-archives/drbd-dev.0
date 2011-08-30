Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue, 30 Aug 2011 11:05:37 +0200
Message-Id: <1314695149-387-4-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314695149-387-1-git-send-email-philipp.reisner@linbit.com>
References: <1314695149-387-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/15] drbd: Remove obsolete comment
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_req.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 18eb3d1..157c737 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -667,10 +667,9 @@ static int drbd_may_do_local_read(struct drbd_conf *mdev, sector_t sector, int s
 		return 0;
 	if (mdev->state.disk <  D_INCONSISTENT)
 		return 0;
-	/* state.disk == D_INCONSISTENT   We will have a look at the BitMap */
-	nr_sectors = drbd_get_capacity(mdev->this_bdev);
 	esector = sector + (size >> 9) - 1;
 
+	nr_sectors = drbd_get_capacity(mdev->this_bdev);
 	D_ASSERT(sector  < nr_sectors);
 	D_ASSERT(esector < nr_sectors);
 
-- 
1.7.4.1

