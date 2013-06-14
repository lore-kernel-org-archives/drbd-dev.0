Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri, 14 Jun 2013 20:54:18 +0200
Message-Id: <1371236063-17198-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1371236063-17198-1-git-send-email-philipp.reisner@linbit.com>
References: <1371236063-17198-1-git-send-email-philipp.reisner@linbit.com>
Cc: Andreas Gruenbacher <agruen@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 1/6] drbd: Do not sleep inside rcu
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

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 4222aff..adee58e 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1039,6 +1039,8 @@ randomize:
 	rcu_read_lock();
 	idr_for_each_entry(&tconn->volumes, mdev, vnr) {
 		kref_get(&mdev->kref);
+		rcu_read_unlock();
+
 		/* Prevent a race between resync-handshake and
 		 * being promoted to Primary.
 		 *
@@ -1049,8 +1051,6 @@ randomize:
 		mutex_lock(mdev->state_mutex);
 		mutex_unlock(mdev->state_mutex);
 
-		rcu_read_unlock();
-
 		if (discard_my_data)
 			set_bit(DISCARD_MY_DATA, &mdev->flags);
 		else
-- 
1.7.9.5

