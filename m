Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon,  5 Sep 2011 13:45:23 +0200
Message-Id: <1315223145-20640-33-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
References: <1315223145-20640-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 32/54] drbd: _drbd_send_bio(),
	_drbd_send_zc_bio(): Return 0 upon success and an error code
	otherwise
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
 drivers/block/drbd/drbd_main.c |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 9b53d86..a12cd82 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1475,12 +1475,15 @@ static int _drbd_send_bio(struct drbd_conf *mdev, struct bio *bio)
 	int i;
 	/* hint all but last page with MSG_MORE */
 	__bio_for_each_segment(bvec, bio, i, 0) {
-		if (_drbd_no_send_page(mdev, bvec->bv_page,
-				       bvec->bv_offset, bvec->bv_len,
-				       i == bio->bi_vcnt -1 ? 0 : MSG_MORE))
-			return 0;
+		int err;
+
+		err = _drbd_no_send_page(mdev, bvec->bv_page,
+					 bvec->bv_offset, bvec->bv_len,
+					 i == bio->bi_vcnt - 1 ? 0 : MSG_MORE);
+		if (err)
+			return err;
 	}
-	return 1;
+	return 0;
 }
 
 static int _drbd_send_zc_bio(struct drbd_conf *mdev, struct bio *bio)
@@ -1489,12 +1492,15 @@ static int _drbd_send_zc_bio(struct drbd_conf *mdev, struct bio *bio)
 	int i;
 	/* hint all but last page with MSG_MORE */
 	__bio_for_each_segment(bvec, bio, i, 0) {
-		if (_drbd_send_page(mdev, bvec->bv_page,
-				    bvec->bv_offset, bvec->bv_len,
-				    i == bio->bi_vcnt -1 ? 0 : MSG_MORE))
-			return 0;
+		int err;
+
+		err = _drbd_send_page(mdev, bvec->bv_page,
+				      bvec->bv_offset, bvec->bv_len,
+				      i == bio->bi_vcnt - 1 ? 0 : MSG_MORE);
+		if (err)
+			return err;
 	}
-	return 1;
+	return 0;
 }
 
 static int _drbd_send_zc_ee(struct drbd_conf *mdev,
@@ -1578,9 +1584,9 @@ int drbd_send_dblock(struct drbd_conf *mdev, struct drbd_request *req)
 		 * receiving side, we sure have detected corruption elsewhere.
 		 */
 		if (mdev->tconn->net_conf->wire_protocol == DRBD_PROT_A || dgs)
-			ok = _drbd_send_bio(mdev, req->master_bio);
+			ok = !_drbd_send_bio(mdev, req->master_bio);
 		else
-			ok = _drbd_send_zc_bio(mdev, req->master_bio);
+			ok = !_drbd_send_zc_bio(mdev, req->master_bio);
 
 		/* double check digest, sometimes buffers have been modified in flight. */
 		if (dgs > 0 && dgs <= 64) {
-- 
1.7.4.1

