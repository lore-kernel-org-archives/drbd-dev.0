Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  5 Sep 2011 13:45:31 +0200
Message-Id: <1315223145-20640-41-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
References: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 40/54] drbd: drbd_drain_block(): Return 0 upon
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
 drivers/block/drbd/drbd_receiver.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index d1a2dbf..ceced15 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1382,30 +1382,32 @@ read_in_block(struct drbd_conf *mdev, u64 id, sector_t sector,
 static int drbd_drain_block(struct drbd_conf *mdev, int data_size)
 {
 	struct page *page;
-	int rr, rv = 1;
+	int rr, err = 0;
 	void *data;
 
 	if (!data_size)
-		return true;
+		return 0;
 
 	page = drbd_pp_alloc(mdev, 1, 1);
 
 	data = kmap(page);
 	while (data_size) {
-		rr = drbd_recv(mdev->tconn, data, min_t(int, data_size, PAGE_SIZE));
-		if (rr != min_t(int, data_size, PAGE_SIZE)) {
-			rv = 0;
+		unsigned int len = min_t(int, data_size, PAGE_SIZE);
+
+		rr = drbd_recv(mdev->tconn, data, len);
+		if (rr != len) {
 			if (!signal_pending(current))
 				dev_warn(DEV,
 					"short read receiving data: read %d expected %d\n",
-					rr, min_t(int, data_size, PAGE_SIZE));
+					rr, len);
+			err = (rr < 0) ? rr : -EIO;
 			break;
 		}
 		data_size -= rr;
 	}
 	kunmap(page);
 	drbd_pp_free(mdev, page, 0);
-	return rv;
+	return err;
 }
 
 static int recv_dless_read(struct drbd_conf *mdev, struct drbd_request *req,
@@ -1596,7 +1598,7 @@ static int receive_RSDataReply(struct drbd_conf *mdev, enum drbd_packet cmd,
 		if (__ratelimit(&drbd_ratelimit_state))
 			dev_err(DEV, "Can not write resync data to local disk.\n");
 
-		ok = drbd_drain_block(mdev, data_size);
+		ok = !drbd_drain_block(mdev, data_size);
 
 		drbd_send_ack_dp(mdev, P_NEG_ACK, p, data_size);
 	}
@@ -1982,7 +1984,7 @@ static int receive_Data(struct drbd_conf *mdev, enum drbd_packet cmd,
 		err = wait_for_and_update_peer_seq(mdev, peer_seq);
 		drbd_send_ack_dp(mdev, P_NEG_ACK, p, data_size);
 		atomic_inc(&mdev->current_epoch->epoch_size);
-		return drbd_drain_block(mdev, data_size) && err == 0;
+		return !drbd_drain_block(mdev, data_size) && err == 0;
 	}
 
 	/*
@@ -2191,7 +2193,7 @@ static int receive_DataRequest(struct drbd_conf *mdev, enum drbd_packet cmd,
 			    "no local data.\n");
 
 		/* drain possibly payload */
-		return drbd_drain_block(mdev, digest_size);
+		return !drbd_drain_block(mdev, digest_size);
 	}
 
 	/* GFP_NOIO, because we must not cause arbitrary write-out: in a DRBD
-- 
1.7.4.1

