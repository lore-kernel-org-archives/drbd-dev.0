Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 27 Mar 2013 14:08:49 +0100
Message-Id: <1364389729-17559-18-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1364389729-17559-1-git-send-email-philipp.reisner@linbit.com>
References: <1364389729-17559-1-git-send-email-philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 17/17] drbd: fix if(); found by kbuild test robot
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

Recently introduced al_begin_io_nonblock() was returning -EBUSY,
even when it should return -EWOULDBLOCK.

Impact:
A few spurious wake_up() calls in prepare_al_transaction_nonblock().

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 6afe173..6608076 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -389,7 +389,7 @@ int drbd_al_begin_io_nonblock(struct drbd_conf *mdev, struct drbd_interval *i)
 		if (unlikely(tmp != NULL)) {
 			struct bm_extent  *bm_ext = lc_entry(tmp, struct bm_extent, lce);
 			if (test_bit(BME_NO_WRITES, &bm_ext->flags)) {
-				if (!test_and_set_bit(BME_PRIORITY, &bm_ext->flags));
+				if (!test_and_set_bit(BME_PRIORITY, &bm_ext->flags))
 					return -EBUSY;
 				return -EWOULDBLOCK;
 			}
-- 
1.7.9.5

