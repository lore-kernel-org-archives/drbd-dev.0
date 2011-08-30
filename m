Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue, 30 Aug 2011 11:05:39 +0200
Message-Id: <1314695149-387-6-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314695149-387-1-git-send-email-philipp.reisner@linbit.com>
References: <1314695149-387-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/15] drbd: simplify condition in
	drbd_may_do_local_read()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

fold
	if (x >= (N+1))
		return 0;
	if (x < N)
		return 0;
into
	if (x != N)
		return 0;

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_req.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 48d313d..7332198 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -663,9 +663,7 @@ static int drbd_may_do_local_read(struct drbd_conf *mdev, sector_t sector, int s
 
 	if (mdev->state.disk == D_UP_TO_DATE)
 		return 1;
-	if (mdev->state.disk >= D_OUTDATED)
-		return 0;
-	if (mdev->state.disk <  D_INCONSISTENT)
+	if (mdev->state.disk != D_INCONSISTENT)
 		return 0;
 	esector = sector + (size >> 9) - 1;
 
-- 
1.7.4.1

