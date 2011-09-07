Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed,  7 Sep 2011 16:17:31 +0200
Message-Id: <1315405061-1473-5-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315405061-1473-1-git-send-email-philipp.reisner@linbit.com>
References: <1315405061-1473-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 04/14] drbd: Make _drbd_send_bitmap() static
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
 drivers/block/drbd/drbd_int.h  |    1 -
 drivers/block/drbd/drbd_main.c |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 1aec096..077aa0c 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1201,7 +1201,6 @@ extern int drbd_send_drequest_csum(struct drbd_conf *mdev, sector_t sector,
 extern int drbd_send_ov_request(struct drbd_conf *mdev,sector_t sector,int size);
 
 extern int drbd_send_bitmap(struct drbd_conf *mdev);
-extern int _drbd_send_bitmap(struct drbd_conf *mdev);
 extern void drbd_send_sr_reply(struct drbd_conf *mdev, enum drbd_state_rv retcode);
 extern int conn_send_sr_reply(struct drbd_tconn *tconn, enum drbd_state_rv retcode);
 extern void drbd_free_bc(struct drbd_backing_dev *ldev);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 34627ae..53e887d 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1182,7 +1182,7 @@ send_bitmap_rle_or_plain(struct drbd_conf *mdev,
 }
 
 /* See the comment at receive_bitmap() */
-int _drbd_send_bitmap(struct drbd_conf *mdev)
+static int _drbd_send_bitmap(struct drbd_conf *mdev)
 {
 	struct bm_xfer_ctx c;
 	struct p_header *p;
-- 
1.7.4.1

