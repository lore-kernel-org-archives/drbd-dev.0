Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  5 Sep 2011 13:45:25 +0200
Message-Id: <1315223145-20640-35-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
References: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 34/54] drbd: drbd_send_short_cmd(): Return 0 upon
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
 drivers/block/drbd/drbd_int.h    |    2 +-
 drivers/block/drbd/drbd_worker.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index d10505e..24d3202 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1937,7 +1937,7 @@ static inline int drbd_send_short_cmd(struct drbd_conf *mdev,
 				      enum drbd_packet cmd)
 {
 	struct p_header h;
-	return !drbd_send_cmd(mdev, &mdev->tconn->data, cmd, &h, sizeof(h));
+	return drbd_send_cmd(mdev, &mdev->tconn->data, cmd, &h, sizeof(h));
 }
 
 static inline int drbd_send_ping(struct drbd_tconn *tconn)
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 81ddf1c..81d71c7 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1227,7 +1227,7 @@ int w_send_write_hint(struct drbd_work *w, int cancel)
 	struct drbd_conf *mdev = w->mdev;
 	if (cancel)
 		return 1;
-	return drbd_send_short_cmd(mdev, P_UNPLUG_REMOTE);
+	return !drbd_send_short_cmd(mdev, P_UNPLUG_REMOTE);
 }
 
 int w_send_oos(struct drbd_work *w, int cancel)
-- 
1.7.4.1

