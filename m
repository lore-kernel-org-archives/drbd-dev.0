Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 13 Oct 2011 12:32:16 +0200
Message-Id: <1318501936-11689-11-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1318501936-11689-1-git-send-email-philipp.reisner@linbit.com>
References: <1318501936-11689-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 10/10] drbd: Eliminated the "notified peer"
	messages
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
 drivers/block/drbd/drbd_state.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index fe46a8b..5319130 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1333,9 +1333,7 @@ static void after_state_ch(struct drbd_conf *mdev, union drbd_state os,
 				"ASSERT FAILED: disk is %s during detach\n",
 				drbd_disk_str(mdev->state.disk));
 
-		if (!drbd_send_state(mdev))
-			dev_info(DEV, "Notified peer that I am detaching my disk\n");
-
+		drbd_send_state(mdev);
 		drbd_rs_cancel_all(mdev);
 
 		/* In case we want to get something to stable storage still,
@@ -1363,8 +1361,7 @@ static void after_state_ch(struct drbd_conf *mdev, union drbd_state os,
                 mdev->rs_failed = 0;
                 atomic_set(&mdev->rs_pending_cnt, 0);
 
-		if (!drbd_send_state(mdev))
-			dev_info(DEV, "Notified peer that I'm now diskless.\n");
+		drbd_send_state(mdev);
 		/* corresponding get_ldev in __drbd_set_state
 		 * this may finally trigger drbd_ldev_destroy. */
 		put_ldev(mdev);
-- 
1.7.4.1

