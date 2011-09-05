Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  5 Sep 2011 13:45:33 +0200
Message-Id: <1315223145-20640-43-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
References: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 42/54] drbd: recv_resync_read(): Return 0 upon
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
 drivers/block/drbd/drbd_receiver.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 6e5ffeb..87f03ca 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1518,7 +1518,7 @@ static int recv_resync_read(struct drbd_conf *mdev, sector_t sector, int data_si
 
 	atomic_add(data_size >> 9, &mdev->rs_sect_ev);
 	if (drbd_submit_peer_request(mdev, peer_req, WRITE, DRBD_FAULT_RS_WR) == 0)
-		return true;
+		return 0;
 
 	/* don't care for the reason here */
 	dev_err(DEV, "submit failed, triggering re-connect\n");
@@ -1529,7 +1529,7 @@ static int recv_resync_read(struct drbd_conf *mdev, sector_t sector, int data_si
 	drbd_free_ee(mdev, peer_req);
 fail:
 	put_ldev(mdev);
-	return false;
+	return -EIO;
 }
 
 static struct drbd_request *
@@ -1593,7 +1593,7 @@ static int receive_RSDataReply(struct drbd_conf *mdev, enum drbd_packet cmd,
 		/* data is submitted to disk within recv_resync_read.
 		 * corresponding put_ldev done below on error,
 		 * or in drbd_peer_request_endio. */
-		ok = recv_resync_read(mdev, sector, data_size);
+		ok = !recv_resync_read(mdev, sector, data_size);
 	} else {
 		if (__ratelimit(&drbd_ratelimit_state))
 			dev_err(DEV, "Can not write resync data to local disk.\n");
-- 
1.7.4.1

