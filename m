Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 29 Sep 2011 10:15:27 +0200
Message-Id: <1317284131-17464-9-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317284131-17464-1-git-send-email-philipp.reisner@linbit.com>
References: <1317284131-17464-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 08/12] drbd: Rename drbd_{ ee -> peer_req
	}_has_active_page
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
 drivers/block/drbd/drbd_int.h      |    2 +-
 drivers/block/drbd/drbd_receiver.c |    2 +-
 drivers/block/drbd/drbd_worker.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 53d6dc3..d64aaf3 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1594,7 +1594,7 @@ static inline int drbd_bio_has_active_page(struct bio *bio)
 	return 0;
 }
 
-static inline int drbd_ee_has_active_page(struct drbd_peer_request *peer_req)
+static inline int drbd_peer_req_has_active_page(struct drbd_peer_request *peer_req)
 {
 	struct page *page = peer_req->pages;
 	page_chain_for_each(page) {
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 0eda1f0..8b73589 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -208,7 +208,7 @@ static void reclaim_finished_net_peer_reqs(struct drbd_conf *mdev,
 
 	list_for_each_safe(le, tle, &mdev->net_ee) {
 		peer_req = list_entry(le, struct drbd_peer_request, w.list);
-		if (drbd_ee_has_active_page(peer_req))
+		if (drbd_peer_req_has_active_page(peer_req))
 			break;
 		list_move(le, to_be_freed);
 	}
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index d2317c7..2a80563 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -890,7 +890,7 @@ out:
 /* helper */
 static void move_to_net_ee_or_free(struct drbd_conf *mdev, struct drbd_peer_request *peer_req)
 {
-	if (drbd_ee_has_active_page(peer_req)) {
+	if (drbd_peer_req_has_active_page(peer_req)) {
 		/* This might happen if sendpage() has not finished */
 		int i = (peer_req->i.size + PAGE_SIZE -1) >> PAGE_SHIFT;
 		atomic_add(i, &mdev->pp_in_use_by_net);
-- 
1.7.4.1

