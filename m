Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:07:20 +0200
Message-Id: <1314284934-17999-25-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 024/118] drbd: Remove some useless paranoia code
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

The open_cnt check is an open-coded D_ASSERT() check.

In case the data.work queue is not empty, it does not really help to
know which drbd_work elements remained on that list: they will be freed
immediately afterwards, anyway.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_main.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 46ba4aa..2902f6d 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3254,16 +3254,8 @@ static void drbd_delete_device(unsigned int minor)
 		return;
 
 	/* paranoia asserts */
-	if (mdev->open_cnt != 0)
-		dev_err(DEV, "open_cnt = %d in %s:%u", mdev->open_cnt,
-				__FILE__ , __LINE__);
-
-	if (!expect(list_empty(&mdev->data.work.q))) {
-		struct list_head *lp;
-		list_for_each(lp, &mdev->data.work.q) {
-			dev_err(DEV, "lp = %p\n", lp);
-		}
-	};
+	D_ASSERT(mdev->open_cnt == 0);
+	D_ASSERT(list_empty(&mdev->data.work.q));
 	/* end paranoia asserts */
 
 	del_gendisk(mdev->vdisk);
-- 
1.7.4.1

