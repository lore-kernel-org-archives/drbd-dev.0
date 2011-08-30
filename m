Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue, 30 Aug 2011 11:05:41 +0200
Message-Id: <1314695149-387-8-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314695149-387-1-git-send-email-philipp.reisner@linbit.com>
References: <1314695149-387-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 07/15] drbd: in drbd_suspend_al,
	set AL_SUSPENDED before unlocking the activity log
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

As using an empty activity log is the whole point of the excercise,
make sure it is still empty when setting AL_SUSPENDED.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index d6832f8..ae8f42e 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -901,19 +901,17 @@ static void drbd_suspend_al(struct drbd_conf *mdev)
 {
 	int s = 0;
 
-	if (lc_try_lock(mdev->act_log)) {
-		drbd_al_shrink(mdev);
-		lc_unlock(mdev->act_log);
-	} else {
+	if (!lc_try_lock(mdev->act_log)) {
 		dev_warn(DEV, "Failed to lock al in drbd_suspend_al()\n");
 		return;
 	}
 
+	drbd_al_shrink(mdev);
 	spin_lock_irq(&mdev->tconn->req_lock);
 	if (mdev->state.conn < C_CONNECTED)
 		s = !test_and_set_bit(AL_SUSPENDED, &mdev->flags);
-
 	spin_unlock_irq(&mdev->tconn->req_lock);
+	lc_unlock(mdev->act_log);
 
 	if (s)
 		dev_info(DEV, "Suspended AL updates\n");
-- 
1.7.4.1

