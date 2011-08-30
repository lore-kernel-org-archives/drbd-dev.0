Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue, 30 Aug 2011 11:05:49 +0200
Message-Id: <1314695149-387-16-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314695149-387-1-git-send-email-philipp.reisner@linbit.com>
References: <1314695149-387-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 15/15] drbd: fix a wrong likely(),
	updated comments
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_worker.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 01ab0bc..8ee5c4f 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -295,6 +295,7 @@ void drbd_csum_bio(struct drbd_conf *mdev, struct crypto_hash *tfm, struct bio *
 	crypto_hash_final(&desc, digest);
 }
 
+/* MAYBE merge common code with w_e_end_ov_req */
 static int w_e_send_csum(struct drbd_work *w, int cancel)
 {
 	struct drbd_peer_request *peer_req = container_of(w, struct drbd_peer_request, w);
@@ -306,7 +307,7 @@ static int w_e_send_csum(struct drbd_work *w, int cancel)
 	if (unlikely(cancel))
 		goto out;
 
-	if (likely((peer_req->flags & EE_WAS_ERROR) != 0))
+	if (unlikely((peer_req->flags & EE_WAS_ERROR) != 0))
 		goto out;
 
 	digest_size = crypto_hash_digestsize(mdev->csums_tfm);
@@ -315,7 +316,7 @@ static int w_e_send_csum(struct drbd_work *w, int cancel)
 		sector_t sector = peer_req->i.sector;
 		unsigned int size = peer_req->i.size;
 		drbd_csum_ee(mdev, mdev->csums_tfm, peer_req, digest);
-		/* Free e and pages before send.
+		/* Free peer_req and pages before send.
 		 * In case we block on congestion, we could otherwise run into
 		 * some distributed deadlock, if the other side blocks on
 		 * congestion as well, because our receiver blocks in
@@ -1151,11 +1152,11 @@ int w_e_end_ov_reply(struct drbd_work *w, int cancel)
 		}
 	}
 
-		/* Free e and pages before send.
-		 * In case we block on congestion, we could otherwise run into
-		 * some distributed deadlock, if the other side blocks on
-		 * congestion as well, because our receiver blocks in
-		 * drbd_pp_alloc due to pp_in_use > max_buffers. */
+	/* Free peer_req and pages before send.
+	 * In case we block on congestion, we could otherwise run into
+	 * some distributed deadlock, if the other side blocks on
+	 * congestion as well, because our receiver blocks in
+	 * drbd_pp_alloc due to pp_in_use > max_buffers. */
 	drbd_free_ee(mdev, peer_req);
 	if (!eq)
 		drbd_ov_oos_found(mdev, sector, size);
-- 
1.7.4.1

