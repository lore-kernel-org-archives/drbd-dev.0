Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed,  7 Sep 2011 16:17:28 +0200
Message-Id: <1315405061-1473-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315405061-1473-1-git-send-email-philipp.reisner@linbit.com>
References: <1315405061-1473-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/14] drbd: drbd_connected(): Return an error
	code upon failure.
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
 drivers/block/drbd/drbd_receiver.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 49dc08a..2253423 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -781,7 +781,7 @@ static int drbd_socket_okay(struct socket **sock)
 int drbd_connected(int vnr, void *p, void *data)
 {
 	struct drbd_conf *mdev = (struct drbd_conf *)p;
-	int ok = 1;
+	int err;
 
 	atomic_set(&mdev->packet_seq, 0);
 	mdev->peer_seq = 0;
@@ -790,15 +790,16 @@ int drbd_connected(int vnr, void *p, void *data)
 		&mdev->tconn->cstate_mutex :
 		&mdev->own_state_mutex;
 
-	ok &= !drbd_send_sync_param(mdev);
-	ok &= !drbd_send_sizes(mdev, 0, 0);
-	ok &= !drbd_send_uuids(mdev);
-	ok &= !drbd_send_state(mdev);
+	err = drbd_send_sync_param(mdev);
+	if (!err)
+		err = drbd_send_sizes(mdev, 0, 0);
+	if (!err)
+		err = drbd_send_uuids(mdev);
+	if (!err)
+		err = drbd_send_state(mdev);
 	clear_bit(USE_DEGR_WFC_T, &mdev->flags);
 	clear_bit(RESIZE_PENDING, &mdev->flags);
-
-
-	return !ok;
+	return err;
 }
 
 /*
-- 
1.7.4.1

