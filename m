Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  5 Sep 2011 13:45:04 +0200
Message-Id: <1315223145-20640-14-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
References: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 13/54] drbd: drbd_send_uuids() and its variants:
	Return 0 upon success and an error code otherwise
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
 drivers/block/drbd/drbd_main.c     |    4 ++--
 drivers/block/drbd/drbd_receiver.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 9ee7cf1..774b3ed 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -872,7 +872,7 @@ int _drbd_send_uuids(struct drbd_conf *mdev, u64 uuid_flags)
 	int i;
 
 	if (!get_ldev_if_state(mdev, D_NEGOTIATING))
-		return 1;
+		return 0;
 
 	for (i = UI_CURRENT; i < UI_SIZE; i++)
 		p.uuid[i] = mdev->ldev ? cpu_to_be64(mdev->ldev->md.uuid[i]) : 0;
@@ -886,7 +886,7 @@ int _drbd_send_uuids(struct drbd_conf *mdev, u64 uuid_flags)
 
 	put_ldev(mdev);
 
-	return !drbd_send_cmd(mdev, &mdev->tconn->data, P_UUIDS, &p.head, sizeof(p));
+	return drbd_send_cmd(mdev, &mdev->tconn->data, P_UUIDS, &p.head, sizeof(p));
 }
 
 int drbd_send_uuids(struct drbd_conf *mdev)
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 0ca559b..9a9c688 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -765,7 +765,7 @@ int drbd_connected(int vnr, void *p, void *data)
 
 	ok &= !drbd_send_sync_param(mdev);
 	ok &= drbd_send_sizes(mdev, 0, 0);
-	ok &= drbd_send_uuids(mdev);
+	ok &= !drbd_send_uuids(mdev);
 	ok &= !drbd_send_state(mdev);
 	clear_bit(USE_DEGR_WFC_T, &mdev->flags);
 	clear_bit(RESIZE_PENDING, &mdev->flags);
-- 
1.7.4.1

