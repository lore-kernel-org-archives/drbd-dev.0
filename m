Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:07:06 +0200
Message-Id: <1314284934-17999-11-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 010/118] drbd: Request lookup code cleanup (2)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Unify the ar_id_to_req() and ack_id_to_req() functions: make both fail
if the consistency check fails.  Move the request lookup code now
duplicated in both functions into its own function.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |   49 +++++++++++++++++------------------
 1 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 1684c48..ae32aed 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1469,24 +1469,39 @@ fail:
 	return false;
 }
 
-/* when we receive the answer for a read request,
- * verify that we actually know about it */
-static struct drbd_request *ar_id_to_req(struct drbd_conf *mdev, u64 id,
-					 sector_t sector)
+static struct drbd_request *
+find_request(struct drbd_conf *mdev,
+	     struct hlist_head *(*hash_slot)(struct drbd_conf *, sector_t),
+	     u64 id, sector_t sector, const char *func)
 {
-	struct hlist_head *slot = ar_hash_slot(mdev, sector);
+	struct hlist_head *slot = hash_slot(mdev, sector);
 	struct hlist_node *n;
 	struct drbd_request *req;
 
 	hlist_for_each_entry(req, n, slot, collision) {
-		if ((unsigned long)req == (unsigned long)id) {
-			D_ASSERT(req->sector == sector);
-			return req;
+		if ((unsigned long)req != (unsigned long)id)
+			continue;
+		if (req->sector != sector) {
+			dev_err(DEV, "%s: found request %lu but it has "
+				"wrong sector (%llus versus %llus)\n",
+				func, (unsigned long)req,
+				(unsigned long long)req->sector,
+				(unsigned long long)sector);
+			break;
 		}
+		return req;
 	}
 	return NULL;
 }
 
+/* when we receive the answer for a read request,
+ * verify that we actually know about it */
+static struct drbd_request *ar_id_to_req(struct drbd_conf *mdev, u64 id,
+					 sector_t sector)
+{
+	return find_request(mdev, ar_hash_slot, id, sector, __func__);
+}
+
 static int receive_DataReply(struct drbd_conf *mdev, enum drbd_packets cmd, unsigned int data_size)
 {
 	struct drbd_request *req;
@@ -4243,23 +4258,7 @@ static int got_IsInSync(struct drbd_conf *mdev, struct p_header80 *h)
 static struct drbd_request *ack_id_to_req(struct drbd_conf *mdev, u64 id,
 					  sector_t sector)
 {
-	struct hlist_head *slot = tl_hash_slot(mdev, sector);
-	struct hlist_node *n;
-	struct drbd_request *req;
-
-	hlist_for_each_entry(req, n, slot, collision) {
-		if ((unsigned long)req == (unsigned long)id) {
-			if (req->sector != sector) {
-				dev_err(DEV, "ack_id_to_req: found req %p but it has "
-				    "wrong sector (%llus versus %llus)\n", req,
-				    (unsigned long long)req->sector,
-				    (unsigned long long)sector);
-				break;
-			}
-			return req;
-		}
-	}
-	return NULL;
+	return find_request(mdev, tl_hash_slot, id, sector, __func__);
 }
 
 static int validate_req_change_req_state(struct drbd_conf *mdev,
-- 
1.7.4.1

