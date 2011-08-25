Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:07:05 +0200
Message-Id: <1314284934-17999-10-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 009/118] drbd: Request lookup code cleanup (1)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Move _ar_id_to_req() to drbd_receiver.c and mark it non-inline.  Remove
the leading underscores from _ar_id_to_req() and _ack_id_to_req().  Mark
ar_hash_slot() inline.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |   32 +++++++++++++++++++++++++-------
 drivers/block/drbd/drbd_req.h      |   21 ++-------------------
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 26810ce..1684c48 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1469,6 +1469,24 @@ fail:
 	return false;
 }
 
+/* when we receive the answer for a read request,
+ * verify that we actually know about it */
+static struct drbd_request *ar_id_to_req(struct drbd_conf *mdev, u64 id,
+					 sector_t sector)
+{
+	struct hlist_head *slot = ar_hash_slot(mdev, sector);
+	struct hlist_node *n;
+	struct drbd_request *req;
+
+	hlist_for_each_entry(req, n, slot, collision) {
+		if ((unsigned long)req == (unsigned long)id) {
+			D_ASSERT(req->sector == sector);
+			return req;
+		}
+	}
+	return NULL;
+}
+
 static int receive_DataReply(struct drbd_conf *mdev, enum drbd_packets cmd, unsigned int data_size)
 {
 	struct drbd_request *req;
@@ -1479,7 +1497,7 @@ static int receive_DataReply(struct drbd_conf *mdev, enum drbd_packets cmd, unsi
 	sector = be64_to_cpu(p->sector);
 
 	spin_lock_irq(&mdev->req_lock);
-	req = _ar_id_to_req(mdev, p->block_id, sector);
+	req = ar_id_to_req(mdev, p->block_id, sector);
 	spin_unlock_irq(&mdev->req_lock);
 	if (unlikely(!req)) {
 		dev_err(DEV, "Got a corrupt block_id/sector pair(1).\n");
@@ -4222,8 +4240,8 @@ static int got_IsInSync(struct drbd_conf *mdev, struct p_header80 *h)
 
 /* when we receive the ACK for a write request,
  * verify that we actually know about it */
-static struct drbd_request *_ack_id_to_req(struct drbd_conf *mdev,
-	u64 id, sector_t sector)
+static struct drbd_request *ack_id_to_req(struct drbd_conf *mdev, u64 id,
+					  sector_t sector)
 {
 	struct hlist_head *slot = tl_hash_slot(mdev, sector);
 	struct hlist_node *n;
@@ -4232,7 +4250,7 @@ static struct drbd_request *_ack_id_to_req(struct drbd_conf *mdev,
 	hlist_for_each_entry(req, n, slot, collision) {
 		if ((unsigned long)req == (unsigned long)id) {
 			if (req->sector != sector) {
-				dev_err(DEV, "_ack_id_to_req: found req %p but it has "
+				dev_err(DEV, "ack_id_to_req: found req %p but it has "
 				    "wrong sector (%llus versus %llus)\n", req,
 				    (unsigned long long)req->sector,
 				    (unsigned long long)sector);
@@ -4306,7 +4324,7 @@ static int got_BlockAck(struct drbd_conf *mdev, struct p_header80 *h)
 	}
 
 	return validate_req_change_req_state(mdev, p->block_id, sector,
-		_ack_id_to_req, __func__ , what);
+					     ack_id_to_req, __func__, what);
 }
 
 static int got_NegAck(struct drbd_conf *mdev, struct p_header80 *h)
@@ -4326,7 +4344,7 @@ static int got_NegAck(struct drbd_conf *mdev, struct p_header80 *h)
 	}
 
 	spin_lock_irq(&mdev->req_lock);
-	req = _ack_id_to_req(mdev, p->block_id, sector);
+	req = ack_id_to_req(mdev, p->block_id, sector);
 	if (!req) {
 		spin_unlock_irq(&mdev->req_lock);
 		if (mdev->net_conf->wire_protocol == DRBD_PROT_A ||
@@ -4363,7 +4381,7 @@ static int got_NegDReply(struct drbd_conf *mdev, struct p_header80 *h)
 	    (unsigned long long)sector, be32_to_cpu(p->blksize));
 
 	return validate_req_change_req_state(mdev, p->block_id, sector,
-		_ar_id_to_req, __func__ , neg_acked);
+					     ar_id_to_req, __func__ , neg_acked);
 }
 
 static int got_NegRSDReply(struct drbd_conf *mdev, struct p_header80 *h)
diff --git a/drivers/block/drbd/drbd_req.h b/drivers/block/drbd/drbd_req.h
index 68a234a..a773636 100644
--- a/drivers/block/drbd/drbd_req.h
+++ b/drivers/block/drbd/drbd_req.h
@@ -241,30 +241,13 @@ struct hlist_head *tl_hash_slot(struct drbd_conf *mdev, sector_t sector)
 }
 
 /* application reads (drbd_request objects) */
-static struct hlist_head *ar_hash_slot(struct drbd_conf *mdev, sector_t sector)
+static inline
+struct hlist_head *ar_hash_slot(struct drbd_conf *mdev, sector_t sector)
 {
 	return mdev->app_reads_hash
 		+ ((unsigned int)(sector) % APP_R_HSIZE);
 }
 
-/* when we receive the answer for a read request,
- * verify that we actually know about it */
-static inline struct drbd_request *_ar_id_to_req(struct drbd_conf *mdev,
-	u64 id, sector_t sector)
-{
-	struct hlist_head *slot = ar_hash_slot(mdev, sector);
-	struct hlist_node *n;
-	struct drbd_request *req;
-
-	hlist_for_each_entry(req, n, slot, collision) {
-		if ((unsigned long)req == (unsigned long)id) {
-			D_ASSERT(req->sector == sector);
-			return req;
-		}
-	}
-	return NULL;
-}
-
 static inline void drbd_req_make_private_bio(struct drbd_request *req, struct bio *bio_src)
 {
 	struct bio *bio;
-- 
1.7.4.1

