Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 29 Sep 2011 10:15:31 +0200
Message-Id: <1317284131-17464-13-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317284131-17464-1-git-send-email-philipp.reisner@linbit.com>
References: <1317284131-17464-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 12/12] drbd: Rename drbd_pp_free() to
	drbd_free_pages()
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
index eeeedeb..06c6152 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -283,7 +283,7 @@ struct page *drbd_alloc_pages(struct drbd_conf *mdev, unsigned int number,
  * Is also used from inside an other spin_lock_irq(&mdev->tconn->req_lock);
  * Either links the page chain back to the global pool,
  * or returns all pages to the system. */
-static void drbd_pp_free(struct drbd_conf *mdev, struct page *page, int is_net)
+static void drbd_free_pages(struct drbd_conf *mdev, struct page *page, int is_net)
 {
 	atomic_t *a = is_net ? &mdev->pp_in_use_by_net : &mdev->pp_in_use;
 	int i;
@@ -370,7 +370,7 @@ void __drbd_free_peer_req(struct drbd_conf *mdev, struct drbd_peer_request *peer
 {
 	if (peer_req->flags & EE_HAS_DIGEST)
 		kfree(peer_req->digest);
-	drbd_pp_free(mdev, peer_req->pages, is_net);
+	drbd_free_pages(mdev, peer_req->pages, is_net);
 	D_ASSERT(atomic_read(&peer_req->pending_bios) == 0);
 	D_ASSERT(drbd_interval_empty(&peer_req->i));
 	mempool_free(peer_req, drbd_ee_mempool);
@@ -1438,7 +1438,7 @@ static int drbd_drain_block(struct drbd_conf *mdev, int data_size)
 		data_size -= len;
 	}
 	kunmap(page);
-	drbd_pp_free(mdev, page, 0);
+	drbd_free_pages(mdev, page, 0);
 	return err;
 }
 
-- 
1.7.4.1

