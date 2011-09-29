Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 29 Sep 2011 10:15:22 +0200
Message-Id: <1317284131-17464-4-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317284131-17464-1-git-send-email-philipp.reisner@linbit.com>
References: <1317284131-17464-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/12] drbd: drbd_init_ee() no longer exists
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_main.c     |    4 ----
 drivers/block/drbd/drbd_receiver.c |    1 -
 2 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 6afcfab..f759a7e 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2006,10 +2006,6 @@ void drbd_mdev_cleanup(struct drbd_conf *mdev)
 	drbd_free_resources(mdev);
 	clear_bit(AL_SUSPENDED, &mdev->flags);
 
-	/*
-	 * currently we drbd_init_ee only on module load, so
-	 * we may do drbd_release_ee only on module unload!
-	 */
 	D_ASSERT(list_empty(&mdev->active_ee));
 	D_ASSERT(list_empty(&mdev->sync_ee));
 	D_ASSERT(list_empty(&mdev->done_ee));
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index cd2586b..b4ab05e 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -309,7 +309,6 @@ You need to hold the req_lock:
 You must not have the req_lock:
  drbd_free_ee()
  drbd_alloc_ee()
- drbd_init_ee()
  drbd_release_ee()
  drbd_ee_fix_bhs()
  drbd_process_done_ee()
-- 
1.7.4.1

