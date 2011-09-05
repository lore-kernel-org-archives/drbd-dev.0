Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  5 Sep 2011 13:45:32 +0200
Message-Id: <1315223145-20640-42-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
References: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 41/54] drbd: recv_dless_read(): Return 0 upon
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
 drivers/block/drbd/drbd_receiver.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index ceced15..6e5ffeb 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1429,7 +1429,7 @@ static int recv_dless_read(struct drbd_conf *mdev, struct drbd_request *req,
 				dev_warn(DEV,
 					"short read receiving data reply digest: read %d expected %d\n",
 					rr, dgs);
-			return 0;
+			return rr < 0 ? rr : -EIO;
 		}
 	}
 
@@ -1453,7 +1453,7 @@ static int recv_dless_read(struct drbd_conf *mdev, struct drbd_request *req,
 				dev_warn(DEV, "short read receiving data reply: "
 					"read %d expected %d\n",
 					rr, expect);
-			return 0;
+			return rr < 0 ? rr : -EIO;
 		}
 		data_size -= rr;
 	}
@@ -1462,12 +1462,12 @@ static int recv_dless_read(struct drbd_conf *mdev, struct drbd_request *req,
 		drbd_csum_bio(mdev, mdev->tconn->integrity_r_tfm, bio, dig_vv);
 		if (memcmp(dig_in, dig_vv, dgs)) {
 			dev_err(DEV, "Digest integrity check FAILED. Broken NICs?\n");
-			return 0;
+			return -EINVAL;
 		}
 	}
 
 	D_ASSERT(data_size == 0);
-	return 1;
+	return 0;
 }
 
 /* e_end_resync_block() is called via
@@ -1568,7 +1568,7 @@ static int receive_DataReply(struct drbd_conf *mdev, enum drbd_packet cmd,
 	/* hlist_del(&req->collision) is done in _req_may_be_done, to avoid
 	 * special casing it there for the various failure cases.
 	 * still no race with drbd_fail_pending_reads */
-	ok = recv_dless_read(mdev, req, sector, data_size);
+	ok = !recv_dless_read(mdev, req, sector, data_size);
 
 	if (ok)
 		req_mod(req, DATA_RECEIVED);
-- 
1.7.4.1

