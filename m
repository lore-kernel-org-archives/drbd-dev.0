Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 29 Sep 2011 10:15:20 +0200
Message-Id: <1317284131-17464-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317284131-17464-1-git-send-email-philipp.reisner@linbit.com>
References: <1317284131-17464-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/12] drbd: validate_req_change_req_state():
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
 drivers/block/drbd/drbd_receiver.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 7539253..af9c2c0 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4587,14 +4587,14 @@ validate_req_change_req_state(struct drbd_conf *mdev, u64 id, sector_t sector,
 	req = find_request(mdev, root, id, sector, missing_ok, func);
 	if (unlikely(!req)) {
 		spin_unlock_irq(&mdev->tconn->req_lock);
-		return false;
+		return -EIO;
 	}
 	__req_mod(req, what, &m);
 	spin_unlock_irq(&mdev->tconn->req_lock);
 
 	if (m.bio)
 		complete_master_bio(mdev, &m);
-	return true;
+	return 0;
 }
 
 static int got_BlockAck(struct drbd_tconn *tconn, struct packet_info *pi)
@@ -4642,9 +4642,9 @@ static int got_BlockAck(struct drbd_tconn *tconn, struct packet_info *pi)
 		return false;
 	}
 
-	return validate_req_change_req_state(mdev, p->block_id, sector,
-					     &mdev->write_requests, __func__,
-					     what, false);
+	return !validate_req_change_req_state(mdev, p->block_id, sector,
+					      &mdev->write_requests, __func__,
+					      what, false);
 }
 
 static int got_NegAck(struct drbd_tconn *tconn, struct packet_info *pi)
@@ -4655,7 +4655,7 @@ static int got_NegAck(struct drbd_tconn *tconn, struct packet_info *pi)
 	int size = be32_to_cpu(p->blksize);
 	bool missing_ok = tconn->net_conf->wire_protocol == DRBD_PROT_A ||
 			  tconn->net_conf->wire_protocol == DRBD_PROT_B;
-	bool found;
+	int err;
 
 	mdev = vnr_to_mdev(tconn, pi->vnr);
 	if (!mdev)
@@ -4669,10 +4669,10 @@ static int got_NegAck(struct drbd_tconn *tconn, struct packet_info *pi)
 		return true;
 	}
 
-	found = validate_req_change_req_state(mdev, p->block_id, sector,
-					      &mdev->write_requests, __func__,
-					      NEG_ACKED, missing_ok);
-	if (!found) {
+	err = validate_req_change_req_state(mdev, p->block_id, sector,
+					    &mdev->write_requests, __func__,
+					    NEG_ACKED, missing_ok);
+	if (err) {
 		/* Protocol A has no P_WRITE_ACKs, but has P_NEG_ACKs.
 		   The master bio might already be completed, therefore the
 		   request is no longer in the collision hash. */
@@ -4700,9 +4700,9 @@ static int got_NegDReply(struct drbd_tconn *tconn, struct packet_info *pi)
 	dev_err(DEV, "Got NegDReply; Sector %llus, len %u; Fail original request.\n",
 	    (unsigned long long)sector, be32_to_cpu(p->blksize));
 
-	return validate_req_change_req_state(mdev, p->block_id, sector,
-					     &mdev->read_requests, __func__,
-					     NEG_ACKED, false);
+	return !validate_req_change_req_state(mdev, p->block_id, sector,
+					      &mdev->read_requests, __func__,
+					      NEG_ACKED, false);
 }
 
 static int got_NegRSDReply(struct drbd_tconn *tconn, struct packet_info *pi)
-- 
1.7.4.1

