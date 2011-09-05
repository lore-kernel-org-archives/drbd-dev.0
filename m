Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  5 Sep 2011 13:45:00 +0200
Message-Id: <1315223145-20640-10-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
References: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/54] drbd: drbd_send_sync_param(): Return 0
	upon success and an error code otherwise
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
 drivers/block/drbd/drbd_main.c     |    8 ++++----
 drivers/block/drbd/drbd_receiver.c |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index b2f1022..7a5019a 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -769,7 +769,7 @@ int drbd_send_sync_param(struct drbd_conf *mdev)
 {
 	struct p_rs_param_95 *p;
 	struct socket *sock;
-	int size, rv;
+	int size, err;
 	const int apv = mdev->tconn->agreed_pro_version;
 
 	size = apv <= 87 ? sizeof(struct p_rs_param)
@@ -813,13 +813,13 @@ int drbd_send_sync_param(struct drbd_conf *mdev)
 		if (apv >= 89)
 			strcpy(p->csums_alg, mdev->tconn->net_conf->csums_alg);
 
-		rv = !_drbd_send_cmd(mdev, sock, cmd, &p->head, size, 0);
+		err = _drbd_send_cmd(mdev, sock, cmd, &p->head, size, 0);
 	} else
-		rv = 0; /* not ok */
+		err = -EIO;
 
 	mutex_unlock(&mdev->tconn->data.mutex);
 
-	return rv;
+	return err;
 }
 
 int drbd_send_protocol(struct drbd_tconn *tconn)
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 7431e3c..d93bb3c 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -763,7 +763,7 @@ int drbd_connected(int vnr, void *p, void *data)
 		&mdev->tconn->cstate_mutex :
 		&mdev->own_state_mutex;
 
-	ok &= drbd_send_sync_param(mdev);
+	ok &= !drbd_send_sync_param(mdev);
 	ok &= drbd_send_sizes(mdev, 0, 0);
 	ok &= drbd_send_uuids(mdev);
 	ok &= drbd_send_state(mdev);
-- 
1.7.4.1

