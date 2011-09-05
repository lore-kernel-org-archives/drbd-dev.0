Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  5 Sep 2011 13:45:15 +0200
Message-Id: <1315223145-20640-25-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
References: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 24/54] drbd: drbd_send_ack_ex(): Return 0 upon
	success and an error code otherwise
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
 drivers/block/drbd/drbd_main.c   |    8 ++++----
 drivers/block/drbd/drbd_worker.c |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index a5371fb..c120977 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1299,10 +1299,10 @@ int drbd_send_ack(struct drbd_conf *mdev, enum drbd_packet cmd,
 int drbd_send_ack_ex(struct drbd_conf *mdev, enum drbd_packet cmd,
 		     sector_t sector, int blksize, u64 block_id)
 {
-	return !_drbd_send_ack(mdev, cmd,
-			       cpu_to_be64(sector),
-			       cpu_to_be32(blksize),
-			       cpu_to_be64(block_id));
+	return _drbd_send_ack(mdev, cmd,
+			      cpu_to_be64(sector),
+			      cpu_to_be32(blksize),
+			      cpu_to_be64(block_id));
 }
 
 int drbd_send_drequest(struct drbd_conf *mdev, int cmd,
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 69db6de..9b74086 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1163,8 +1163,8 @@ int w_e_end_ov_reply(struct drbd_work *w, int cancel)
 	else
 		ov_oos_print(mdev);
 
-	ok = drbd_send_ack_ex(mdev, P_OV_RESULT, sector, size,
-			      eq ? ID_IN_SYNC : ID_OUT_OF_SYNC);
+	ok = !drbd_send_ack_ex(mdev, P_OV_RESULT, sector, size,
+			       eq ? ID_IN_SYNC : ID_OUT_OF_SYNC);
 
 	dec_unacked(mdev);
 
-- 
1.7.4.1

