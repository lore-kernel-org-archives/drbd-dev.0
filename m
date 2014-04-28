Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:17 +0200
Message-Id: <1398703415-17780-7-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 06/24] drbd: resync: fix too large bursts for
	very slow rates
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

While merging adjacent dirty blocks into resync requests,
the resync rate throttle was disregarded.
For very low resync rates, the effective rate may have exceeded
the intended rate by a larger margin.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_worker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 2c4ce42..dcd95a6 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -647,7 +647,7 @@ next_sector:
 		 */
 		align = 1;
 		rollback_i = i;
-		for (;;) {
+		while (i < number) {
 			if (size + BM_BLOCK_SIZE > max_bio_size)
 				break;
 
-- 
1.9.1

