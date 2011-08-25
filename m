Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:08:33 +0200
Message-Id: <1314284934-17999-98-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 097/118] drbd: Converted drbdd_init() from mdev
	to tconn
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
 drivers/block/drbd/drbd_receiver.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 3fcc8dc..cc5e937 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4229,33 +4229,33 @@ static int drbd_do_auth(struct drbd_tconn *tconn)
 
 int drbdd_init(struct drbd_thread *thi)
 {
-	struct drbd_conf *mdev = thi->mdev;
+	struct drbd_tconn *tconn = thi->mdev->tconn;
 	int h;
 
-	dev_info(DEV, "receiver (re)started\n");
+	conn_info(tconn, "receiver (re)started\n");
 
 	do {
-		h = drbd_connect(mdev->tconn);
+		h = drbd_connect(tconn);
 		if (h == 0) {
-			drbd_disconnect(mdev->tconn);
+			drbd_disconnect(tconn);
 			schedule_timeout_interruptible(HZ);
 		}
 		if (h == -1) {
-			dev_warn(DEV, "Discarding network configuration.\n");
-			drbd_force_state(mdev, NS(conn, C_DISCONNECTING));
+			conn_warn(tconn, "Discarding network configuration.\n");
+			drbd_force_state(tconn->volume0, NS(conn, C_DISCONNECTING));
 		}
 	} while (h == 0);
 
 	if (h > 0) {
-		if (get_net_conf(mdev->tconn)) {
-			drbdd(mdev->tconn);
-			put_net_conf(mdev->tconn);
+		if (get_net_conf(tconn)) {
+			drbdd(tconn);
+			put_net_conf(tconn);
 		}
 	}
 
-	drbd_disconnect(mdev->tconn);
+	drbd_disconnect(tconn);
 
-	dev_info(DEV, "receiver terminated\n");
+	conn_info(tconn, "receiver terminated\n");
 	return 0;
 }
 
-- 
1.7.4.1

