Return-Path: <BATV+ddbc6e1cf1a82b64ebec+5561+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id F0C861013836
	for <drbd-dev@lists.linbit.com>; Wed, 14 Nov 2018 17:22:08 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 14 Nov 2018 17:02:16 +0100
Message-Id: <20181114160219.28328-14-hch@lst.de>
In-Reply-To: <20181114160219.28328-1-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 13/16] mmc: simplify queue initialization
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Merge three functions initializing the queue into a single one, and drop
an unused argument for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/core/block.c |  2 +-
 drivers/mmc/core/queue.c | 86 ++++++++++++++--------------------------
 drivers/mmc/core/queue.h |  3 +-
 3 files changed, 32 insertions(+), 59 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index c35b5b08bb33..27606e1382e5 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2334,7 +2334,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	INIT_LIST_HEAD(&md->rpmbs);
 	md->usage = 1;
 
-	ret = mmc_init_queue(&md->queue, card, &md->lock, subname);
+	ret = mmc_init_queue(&md->queue, card, &md->lock);
 	if (ret)
 		goto err_putdisk;
 
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 6edffeed9953..37617fb1f9de 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -378,14 +378,38 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 	init_waitqueue_head(&mq->wait);
 }
 
-static int mmc_mq_init_queue(struct mmc_queue *mq, int q_depth,
-			     const struct blk_mq_ops *mq_ops, spinlock_t *lock)
+/* Set queue depth to get a reasonable value for q->nr_requests */
+#define MMC_QUEUE_DEPTH 64
+
+/**
+ * mmc_init_queue - initialise a queue structure.
+ * @mq: mmc queue
+ * @card: mmc card to attach this queue
+ * @lock: queue lock
+ * @subname: partition subname
+ *
+ * Initialise a MMC card request queue.
+ */
+int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
+		   spinlock_t *lock)
 {
+	struct mmc_host *host = card->host;
 	int ret;
 
+	mq->card = card;
+	mq->use_cqe = host->cqe_enabled;
+
 	memset(&mq->tag_set, 0, sizeof(mq->tag_set));
-	mq->tag_set.ops = mq_ops;
-	mq->tag_set.queue_depth = q_depth;
+	mq->tag_set.ops = &mmc_mq_ops;
+	/*
+	 * The queue depth for CQE must match the hardware because the request
+	 * tag is used to index the hardware queue.
+	 */
+	if (mq->use_cqe)
+		mq->tag_set.queue_depth =
+			min_t(int, card->ext_csd.cmdq_depth, host->cqe_qdepth);
+	else
+		mq->tag_set.queue_depth = MMC_QUEUE_DEPTH;
 	mq->tag_set.numa_node = NUMA_NO_NODE;
 	mq->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE |
 			    BLK_MQ_F_BLOCKING;
@@ -405,66 +429,16 @@ static int mmc_mq_init_queue(struct mmc_queue *mq, int q_depth,
 
 	mq->queue->queue_lock = lock;
 	mq->queue->queuedata = mq;
+	blk_queue_rq_timeout(mq->queue, 60 * HZ);
 
+	mmc_setup_queue(mq, card);
 	return 0;
 
 free_tag_set:
 	blk_mq_free_tag_set(&mq->tag_set);
-
 	return ret;
 }
 
-/* Set queue depth to get a reasonable value for q->nr_requests */
-#define MMC_QUEUE_DEPTH 64
-
-static int mmc_mq_init(struct mmc_queue *mq, struct mmc_card *card,
-			 spinlock_t *lock)
-{
-	struct mmc_host *host = card->host;
-	int q_depth;
-	int ret;
-
-	/*
-	 * The queue depth for CQE must match the hardware because the request
-	 * tag is used to index the hardware queue.
-	 */
-	if (mq->use_cqe)
-		q_depth = min_t(int, card->ext_csd.cmdq_depth, host->cqe_qdepth);
-	else
-		q_depth = MMC_QUEUE_DEPTH;
-
-	ret = mmc_mq_init_queue(mq, q_depth, &mmc_mq_ops, lock);
-	if (ret)
-		return ret;
-
-	blk_queue_rq_timeout(mq->queue, 60 * HZ);
-
-	mmc_setup_queue(mq, card);
-
-	return 0;
-}
-
-/**
- * mmc_init_queue - initialise a queue structure.
- * @mq: mmc queue
- * @card: mmc card to attach this queue
- * @lock: queue lock
- * @subname: partition subname
- *
- * Initialise a MMC card request queue.
- */
-int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
-		   spinlock_t *lock, const char *subname)
-{
-	struct mmc_host *host = card->host;
-
-	mq->card = card;
-
-	mq->use_cqe = host->cqe_enabled;
-
-	return mmc_mq_init(mq, card, lock);
-}
-
 void mmc_queue_suspend(struct mmc_queue *mq)
 {
 	blk_mq_quiesce_queue(mq->queue);
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 9bf3c9245075..29218e12900d 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -95,8 +95,7 @@ struct mmc_queue {
 	struct work_struct	complete_work;
 };
 
-extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
-			  const char *);
+extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *);
 extern void mmc_cleanup_queue(struct mmc_queue *);
 extern void mmc_queue_suspend(struct mmc_queue *);
 extern void mmc_queue_resume(struct mmc_queue *);
-- 
2.19.1

