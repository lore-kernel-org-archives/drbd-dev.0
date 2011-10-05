Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed,  5 Oct 2011 11:38:02 +0200
Message-Id: <1317807484-24628-15-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317807484-24628-1-git-send-email-philipp.reisner@linbit.com>
References: <1317807484-24628-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 14/16] drbd: fix schedule in atomic
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

An administrative detach used to request a state change directly to D_DISKLESS,
first suspending IO to avoid the last put_ldev() occuring from an endio handler,
potentially in irq context.

This is not enough on the receiving side (typically secondary), we may miss
some peer_req on the way to local disk, which then may do the last put_ldev()
from their drbd_peer_request_endio().

This patch makes the detach always go through the intermediate D_FAILED state.
We may consider to rename it D_DETACHING.

Alternative approach would be to create yet an other work item to be scheduled
on the worker, do the destructor work from there, and get the timing right.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 019f762..414503a 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1706,12 +1706,17 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 static int adm_detach(struct drbd_conf *mdev)
 {
 	enum drbd_ret_code retcode;
+	int ret;
 	drbd_suspend_io(mdev); /* so no-one is stuck in drbd_al_begin_io */
-	retcode = drbd_request_state(mdev, NS(disk, D_DISKLESS));
-	wait_event(mdev->misc_wait,
-			mdev->state.disk != D_DISKLESS ||
-			!atomic_read(&mdev->local_cnt));
+	retcode = drbd_request_state(mdev, NS(disk, D_FAILED));
+	/* D_FAILED will transition to DISKLESS. */
+	ret = wait_event_interruptible(mdev->misc_wait,
+			mdev->state.disk != D_FAILED);
 	drbd_resume_io(mdev);
+	if (retcode == SS_IS_DISKLESS)
+		retcode = SS_NOTHING_TO_DO;
+	if (ret)
+		retcode = ERR_INTR;
 	return retcode;
 }
 
-- 
1.7.4.1

