Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 12 Oct 2011 14:27:23 +0200
Message-Id: <1318422455-17539-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1318422455-17539-1-git-send-email-philipp.reisner@linbit.com>
References: <1318422455-17539-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/13] drbd: Lower log priority for an event that
	is definitely not an error
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 9611303..4ba0972 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1084,7 +1084,7 @@ static void drbd_flush(struct drbd_conf *mdev)
 		rv = blkdev_issue_flush(mdev->ldev->backing_bdev, GFP_KERNEL,
 					NULL);
 		if (rv) {
-			dev_err(DEV, "local disk flush failed with status %d\n", rv);
+			dev_info(DEV, "local disk flush failed with status %d\n", rv);
 			/* would rather check on EOPNOTSUPP, but that is not reliable.
 			 * don't try again for ANY return value != 0
 			 * if (rv == -EOPNOTSUPP) */
-- 
1.7.4.1

