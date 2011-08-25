Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:08:02 +0200
Message-Id: <1314284934-17999-67-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 066/118] drbd: Revert "Make sure we dont send
	state if a cluster wide state change is in progress"
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This reverts commit 6e9fdc92b77915d5c7ab8fea751f48378f8b0080.

1) This did not fixed the issue
2) Long sleeping work items can cause IO requests to take as long as
   the longest work item

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_main.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index ed43cdc..dbd6d72 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -951,10 +951,6 @@ int drbd_send_state(struct drbd_conf *mdev)
 	struct p_state p;
 	int ok = 0;
 
-	/* Grab state lock so we wont send state if we're in the middle
-	 * of a cluster wide state change on another thread */
-	drbd_state_lock(mdev);
-
 	mutex_lock(&mdev->tconn->data.mutex);
 
 	p.state = cpu_to_be32(mdev->state.i); /* Within the send mutex */
@@ -966,7 +962,6 @@ int drbd_send_state(struct drbd_conf *mdev)
 
 	mutex_unlock(&mdev->tconn->data.mutex);
 
-	drbd_state_unlock(mdev);
 	return ok;
 }
 
-- 
1.7.4.1

