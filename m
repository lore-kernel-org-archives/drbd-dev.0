Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 29 Sep 2011 10:15:30 +0200
Message-Id: <1317284131-17464-12-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317284131-17464-1-git-send-email-philipp.reisner@linbit.com>
References: <1317284131-17464-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/12] drbd: Rename drbd_pp_alloc() to
	drbd_alloc_pages() and make it non-static
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
 drivers/block/drbd/drbd_int.h      |    1 +
 drivers/block/drbd/drbd_receiver.c |   15 ++++++++-------
 drivers/block/drbd/drbd_worker.c   |    6 +++---
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 8fc21a7..2d9a124 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1463,6 +1463,7 @@ extern void __drbd_free_peer_req(struct drbd_conf *, struct drbd_peer_request *,
 				 int);
 #define drbd_free_peer_req(m,e) __drbd_free_peer_req(m, e, 0)
 #define drbd_free_net_peer_req(m,e) __drbd_free_peer_req(m, e, 1)
+extern struct page *drbd_alloc_pages(struct drbd_conf *, unsigned int, bool);
 extern void drbd_set_recv_tcq(struct drbd_conf *mdev, int tcq_enabled);
 extern void _drbd_clear_done_ee(struct drbd_conf *mdev, struct list_head *to_be_freed);
 extern void conn_flush_workqueue(struct drbd_tconn *tconn);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 0e4e651..eeeedeb 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -184,7 +184,7 @@ static struct page *__drbd_alloc_pages(struct drbd_conf *mdev,
 		return page;
 
 	/* Not enough pages immediately available this time.
-	 * No need to jump around here, drbd_pp_alloc will retry this
+	 * No need to jump around here, drbd_alloc_pages will retry this
 	 * function "soon". */
 	if (page) {
 		tmp = page_chain_tail(page, NULL);
@@ -229,7 +229,7 @@ static void drbd_kick_lo_and_reclaim_net(struct drbd_conf *mdev)
 }
 
 /**
- * drbd_pp_alloc() - Returns @number pages, retries forever (or until signalled)
+ * drbd_alloc_pages() - Returns @number pages, retries forever (or until signalled)
  * @mdev:	DRBD device.
  * @number:	number of pages requested
  * @retry:	whether to retry, if not enough pages are available right now
@@ -240,7 +240,8 @@ static void drbd_kick_lo_and_reclaim_net(struct drbd_conf *mdev)
  *
  * Returns a page chain linked via page->private.
  */
-static struct page *drbd_pp_alloc(struct drbd_conf *mdev, unsigned number, bool retry)
+struct page *drbd_alloc_pages(struct drbd_conf *mdev, unsigned int number,
+			      bool retry)
 {
 	struct page *page = NULL;
 	DEFINE_WAIT(wait);
@@ -265,7 +266,7 @@ static struct page *drbd_pp_alloc(struct drbd_conf *mdev, unsigned number, bool
 			break;
 
 		if (signal_pending(current)) {
-			dev_warn(DEV, "drbd_pp_alloc interrupted!\n");
+			dev_warn(DEV, "drbd_alloc_pages interrupted!\n");
 			break;
 		}
 
@@ -278,7 +279,7 @@ static struct page *drbd_pp_alloc(struct drbd_conf *mdev, unsigned number, bool
 	return page;
 }
 
-/* Must not be used from irq, as that may deadlock: see drbd_pp_alloc.
+/* Must not be used from irq, as that may deadlock: see drbd_alloc_pages.
  * Is also used from inside an other spin_lock_irq(&mdev->tconn->req_lock);
  * Either links the page chain back to the global pool,
  * or returns all pages to the system. */
@@ -336,7 +337,7 @@ drbd_alloc_peer_req(struct drbd_conf *mdev, u64 id, sector_t sector,
 		return NULL;
 	}
 
-	page = drbd_pp_alloc(mdev, nr_pages, (gfp_mask & __GFP_WAIT));
+	page = drbd_alloc_pages(mdev, nr_pages, (gfp_mask & __GFP_WAIT));
 	if (!page)
 		goto fail;
 
@@ -1425,7 +1426,7 @@ static int drbd_drain_block(struct drbd_conf *mdev, int data_size)
 	if (!data_size)
 		return 0;
 
-	page = drbd_pp_alloc(mdev, 1, 1);
+	page = drbd_alloc_pages(mdev, 1, 1);
 
 	data = kmap(page);
 	while (data_size) {
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 2a80563..62536bc 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -318,7 +318,7 @@ static int w_e_send_csum(struct drbd_work *w, int cancel)
 		 * In case we block on congestion, we could otherwise run into
 		 * some distributed deadlock, if the other side blocks on
 		 * congestion as well, because our receiver blocks in
-		 * drbd_pp_alloc due to pp_in_use > max_buffers. */
+		 * drbd_alloc_pages due to pp_in_use > max_buffers. */
 		drbd_free_peer_req(mdev, peer_req);
 		peer_req = NULL;
 		inc_rs_pending(mdev);
@@ -1087,7 +1087,7 @@ int w_e_end_ov_req(struct drbd_work *w, int cancel)
 	 * In case we block on congestion, we could otherwise run into
 	 * some distributed deadlock, if the other side blocks on
 	 * congestion as well, because our receiver blocks in
-	 * drbd_pp_alloc due to pp_in_use > max_buffers. */
+	 * drbd_alloc_pages due to pp_in_use > max_buffers. */
 	drbd_free_peer_req(mdev, peer_req);
 	peer_req = NULL;
 	inc_rs_pending(mdev);
@@ -1158,7 +1158,7 @@ int w_e_end_ov_reply(struct drbd_work *w, int cancel)
 	 * In case we block on congestion, we could otherwise run into
 	 * some distributed deadlock, if the other side blocks on
 	 * congestion as well, because our receiver blocks in
-	 * drbd_pp_alloc due to pp_in_use > max_buffers. */
+	 * drbd_alloc_pages due to pp_in_use > max_buffers. */
 	drbd_free_peer_req(mdev, peer_req);
 	if (!eq)
 		drbd_ov_out_of_sync_found(mdev, sector, size);
-- 
1.7.4.1

