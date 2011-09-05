Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  5 Sep 2011 13:45:16 +0200
Message-Id: <1315223145-20640-26-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
References: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 25/54] drbd: drbd_send_drequest(): Return 0 upon
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
 drivers/block/drbd/drbd_main.c   |    4 +---
 drivers/block/drbd/drbd_worker.c |    6 +++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index c120977..c0f6146 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1308,15 +1308,13 @@ int drbd_send_ack_ex(struct drbd_conf *mdev, enum drbd_packet cmd,
 int drbd_send_drequest(struct drbd_conf *mdev, int cmd,
 		       sector_t sector, int size, u64 block_id)
 {
-	int ok;
 	struct p_block_req p;
 
 	p.sector   = cpu_to_be64(sector);
 	p.block_id = block_id;
 	p.blksize  = cpu_to_be32(size);
 
-	ok = !drbd_send_cmd(mdev, &mdev->tconn->data, cmd, &p.head, sizeof(p));
-	return ok;
+	return drbd_send_cmd(mdev, &mdev->tconn->data, cmd, &p.head, sizeof(p));
 }
 
 int drbd_send_drequest_csum(struct drbd_conf *mdev, sector_t sector, int size,
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 9b74086..dc07437 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -637,7 +637,7 @@ next_sector:
 			}
 		} else {
 			inc_rs_pending(mdev);
-			if (!drbd_send_drequest(mdev, P_RS_DATA_REQUEST,
+			if (drbd_send_drequest(mdev, P_RS_DATA_REQUEST,
 					       sector, size, ID_SYNCER)) {
 				dev_err(DEV, "drbd_send_drequest() failed, aborting...\n");
 				dec_rs_pending(mdev);
@@ -1287,8 +1287,8 @@ int w_send_read_req(struct drbd_work *w, int cancel)
 		return 1;
 	}
 
-	ok = drbd_send_drequest(mdev, P_DATA_REQUEST, req->i.sector, req->i.size,
-				(unsigned long)req);
+	ok = !drbd_send_drequest(mdev, P_DATA_REQUEST, req->i.sector, req->i.size,
+				 (unsigned long)req);
 
 	req_mod(req, ok ? HANDED_OVER_TO_NETWORK : SEND_FAILED);
 
-- 
1.7.4.1

