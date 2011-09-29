Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 29 Sep 2011 10:15:29 +0200
Message-Id: <1317284131-17464-11-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317284131-17464-1-git-send-email-philipp.reisner@linbit.com>
References: <1317284131-17464-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 10/12] drbd: Rename
	drbd_pp_first_pages_or_try_alloc() to __drbd_alloc_pages()
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
 drivers/block/drbd/drbd_receiver.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 3003d9e..0e4e651 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -150,11 +150,12 @@ static void page_chain_add(struct page **head,
 	*head = chain_first;
 }
 
-static struct page *drbd_pp_first_pages_or_try_alloc(struct drbd_conf *mdev, int number)
+static struct page *__drbd_alloc_pages(struct drbd_conf *mdev,
+				       unsigned int number)
 {
 	struct page *page = NULL;
 	struct page *tmp = NULL;
-	int i = 0;
+	unsigned int i = 0;
 
 	/* Yes, testing drbd_pp_vacant outside the lock is racy.
 	 * So what. It saves a spin_lock. */
@@ -247,7 +248,7 @@ static struct page *drbd_pp_alloc(struct drbd_conf *mdev, unsigned number, bool
 	/* Yes, we may run up to @number over max_buffers. If we
 	 * follow it strictly, the admin will get it wrong anyways. */
 	if (atomic_read(&mdev->pp_in_use) < mdev->tconn->net_conf->max_buffers)
-		page = drbd_pp_first_pages_or_try_alloc(mdev, number);
+		page = __drbd_alloc_pages(mdev, number);
 
 	while (page == NULL) {
 		prepare_to_wait(&drbd_pp_wait, &wait, TASK_INTERRUPTIBLE);
@@ -255,7 +256,7 @@ static struct page *drbd_pp_alloc(struct drbd_conf *mdev, unsigned number, bool
 		drbd_kick_lo_and_reclaim_net(mdev);
 
 		if (atomic_read(&mdev->pp_in_use) < mdev->tconn->net_conf->max_buffers) {
-			page = drbd_pp_first_pages_or_try_alloc(mdev, number);
+			page = __drbd_alloc_pages(mdev, number);
 			if (page)
 				break;
 		}
-- 
1.7.4.1

