Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  5 Sep 2011 13:45:06 +0200
Message-Id: <1315223145-20640-16-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
References: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 15/54] drbd: drbd_send_sizes(): Return 0 upon
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
 drivers/block/drbd/drbd_main.c     |    4 +---
 drivers/block/drbd/drbd_receiver.c |    2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index ad3e2d0..e3b54ce 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -938,7 +938,6 @@ int drbd_send_sizes(struct drbd_conf *mdev, int trigger_reply, enum dds_flags fl
 	struct p_sizes p;
 	sector_t d_size, u_size;
 	int q_order_type, max_bio_size;
-	int ok;
 
 	if (get_ldev_if_state(mdev, D_NEGOTIATING)) {
 		D_ASSERT(mdev->ldev->backing_bdev);
@@ -962,8 +961,7 @@ int drbd_send_sizes(struct drbd_conf *mdev, int trigger_reply, enum dds_flags fl
 	p.queue_order_type = cpu_to_be16(q_order_type);
 	p.dds_flags = cpu_to_be16(flags);
 
-	ok = !drbd_send_cmd(mdev, &mdev->tconn->data, P_SIZES, &p.head, sizeof(p));
-	return ok;
+	return drbd_send_cmd(mdev, &mdev->tconn->data, P_SIZES, &p.head, sizeof(p));
 }
 
 /**
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 9a9c688..b1d8f91 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -764,7 +764,7 @@ int drbd_connected(int vnr, void *p, void *data)
 		&mdev->own_state_mutex;
 
 	ok &= !drbd_send_sync_param(mdev);
-	ok &= drbd_send_sizes(mdev, 0, 0);
+	ok &= !drbd_send_sizes(mdev, 0, 0);
 	ok &= !drbd_send_uuids(mdev);
 	ok &= !drbd_send_state(mdev);
 	clear_bit(USE_DEGR_WFC_T, &mdev->flags);
-- 
1.7.4.1

