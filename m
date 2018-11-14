Return-Path: <BATV+ddbc6e1cf1a82b64ebec+5561+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A8B19103B4BD
	for <drbd-dev@lists.linbit.com>; Wed, 14 Nov 2018 17:22:10 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 14 Nov 2018 17:02:17 +0100
Message-Id: <20181114160219.28328-15-hch@lst.de>
In-Reply-To: <20181114160219.28328-1-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 14/16] mmc: stop abusing the request queue_lock
	pointer
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

mmc uses the block layer struct request pointer to indirect their own
lock to the mmc_queue structure, given that the original lock isn't
reachable outside of block.c.  Add a lock pointer to struct mmc_queue
instead and stop overriding the block layer lock which protects fields
entirely separate from the mmc use.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/core/block.c | 22 ++++++++++------------
 drivers/mmc/core/queue.c | 26 +++++++++++++-------------
 drivers/mmc/core/queue.h |  1 +
 3 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 27606e1382e5..70ec465beb69 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1483,7 +1483,7 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
 		blk_mq_end_request(req, BLK_STS_OK);
 	}
 
-	spin_lock_irqsave(q->queue_lock, flags);
+	spin_lock_irqsave(mq->lock, flags);
 
 	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
 
@@ -1491,7 +1491,7 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
 
 	mmc_cqe_check_busy(mq);
 
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	spin_unlock_irqrestore(mq->lock, flags);
 
 	if (!mq->cqe_busy)
 		blk_mq_run_hw_queues(q, true);
@@ -1988,17 +1988,16 @@ static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
 
 static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
 {
-	struct request_queue *q = req->q;
 	unsigned long flags;
 	bool put_card;
 
-	spin_lock_irqsave(q->queue_lock, flags);
+	spin_lock_irqsave(mq->lock, flags);
 
 	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
 
 	put_card = (mmc_tot_in_flight(mq) == 0);
 
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	spin_unlock_irqrestore(mq->lock, flags);
 
 	if (put_card)
 		mmc_put_card(mq->card, &mq->ctx);
@@ -2094,11 +2093,11 @@ static void mmc_blk_mq_req_done(struct mmc_request *mrq)
 		 * request does not need to wait (although it does need to
 		 * complete complete_req first).
 		 */
-		spin_lock_irqsave(q->queue_lock, flags);
+		spin_lock_irqsave(mq->lock, flags);
 		mq->complete_req = req;
 		mq->rw_wait = false;
 		waiting = mq->waiting;
-		spin_unlock_irqrestore(q->queue_lock, flags);
+		spin_unlock_irqrestore(mq->lock, flags);
 
 		/*
 		 * If 'waiting' then the waiting task will complete this
@@ -2117,10 +2116,10 @@ static void mmc_blk_mq_req_done(struct mmc_request *mrq)
 	/* Take the recovery path for errors or urgent background operations */
 	if (mmc_blk_rq_error(&mqrq->brq) ||
 	    mmc_blk_urgent_bkops_needed(mq, mqrq)) {
-		spin_lock_irqsave(q->queue_lock, flags);
+		spin_lock_irqsave(mq->lock, flags);
 		mq->recovery_needed = true;
 		mq->recovery_req = req;
-		spin_unlock_irqrestore(q->queue_lock, flags);
+		spin_unlock_irqrestore(mq->lock, flags);
 		wake_up(&mq->wait);
 		schedule_work(&mq->recovery_work);
 		return;
@@ -2136,7 +2135,6 @@ static void mmc_blk_mq_req_done(struct mmc_request *mrq)
 
 static bool mmc_blk_rw_wait_cond(struct mmc_queue *mq, int *err)
 {
-	struct request_queue *q = mq->queue;
 	unsigned long flags;
 	bool done;
 
@@ -2144,7 +2142,7 @@ static bool mmc_blk_rw_wait_cond(struct mmc_queue *mq, int *err)
 	 * Wait while there is another request in progress, but not if recovery
 	 * is needed. Also indicate whether there is a request waiting to start.
 	 */
-	spin_lock_irqsave(q->queue_lock, flags);
+	spin_lock_irqsave(mq->lock, flags);
 	if (mq->recovery_needed) {
 		*err = -EBUSY;
 		done = true;
@@ -2152,7 +2150,7 @@ static bool mmc_blk_rw_wait_cond(struct mmc_queue *mq, int *err)
 		done = !mq->rw_wait;
 	}
 	mq->waiting = !done;
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	spin_unlock_irqrestore(mq->lock, flags);
 
 	return done;
 }
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 37617fb1f9de..ac6a5245275a 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -89,9 +89,9 @@ void mmc_cqe_recovery_notifier(struct mmc_request *mrq)
 	struct mmc_queue *mq = q->queuedata;
 	unsigned long flags;
 
-	spin_lock_irqsave(q->queue_lock, flags);
+	spin_lock_irqsave(mq->lock, flags);
 	__mmc_cqe_recovery_notifier(mq);
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	spin_unlock_irqrestore(mq->lock, flags);
 }
 
 static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
@@ -128,14 +128,14 @@ static enum blk_eh_timer_return mmc_mq_timed_out(struct request *req,
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(q->queue_lock, flags);
+	spin_lock_irqsave(mq->lock, flags);
 
 	if (mq->recovery_needed || !mq->use_cqe)
 		ret = BLK_EH_RESET_TIMER;
 	else
 		ret = mmc_cqe_timed_out(req);
 
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	spin_unlock_irqrestore(mq->lock, flags);
 
 	return ret;
 }
@@ -157,9 +157,9 @@ static void mmc_mq_recovery_handler(struct work_struct *work)
 
 	mq->in_recovery = false;
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(mq->lock);
 	mq->recovery_needed = false;
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(mq->lock);
 
 	mmc_put_card(mq->card, &mq->ctx);
 
@@ -258,10 +258,10 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	issue_type = mmc_issue_type(mq, req);
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(mq->lock);
 
 	if (mq->recovery_needed || mq->busy) {
-		spin_unlock_irq(q->queue_lock);
+		spin_unlock_irq(mq->lock);
 		return BLK_STS_RESOURCE;
 	}
 
@@ -269,7 +269,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	case MMC_ISSUE_DCMD:
 		if (mmc_cqe_dcmd_busy(mq)) {
 			mq->cqe_busy |= MMC_CQE_DCMD_BUSY;
-			spin_unlock_irq(q->queue_lock);
+			spin_unlock_irq(mq->lock);
 			return BLK_STS_RESOURCE;
 		}
 		break;
@@ -294,7 +294,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	get_card = (mmc_tot_in_flight(mq) == 1);
 	cqe_retune_ok = (mmc_cqe_qcnt(mq) == 1);
 
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(mq->lock);
 
 	if (!(req->rq_flags & RQF_DONTPREP)) {
 		req_to_mmc_queue_req(req)->retries = 0;
@@ -328,12 +328,12 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (issued != MMC_REQ_STARTED) {
 		bool put_card = false;
 
-		spin_lock_irq(q->queue_lock);
+		spin_lock_irq(mq->lock);
 		mq->in_flight[issue_type] -= 1;
 		if (mmc_tot_in_flight(mq) == 0)
 			put_card = true;
 		mq->busy = false;
-		spin_unlock_irq(q->queue_lock);
+		spin_unlock_irq(mq->lock);
 		if (put_card)
 			mmc_put_card(card, &mq->ctx);
 	} else {
@@ -397,6 +397,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	int ret;
 
 	mq->card = card;
+	mq->lock = lock;
 	mq->use_cqe = host->cqe_enabled;
 
 	memset(&mq->tag_set, 0, sizeof(mq->tag_set));
@@ -427,7 +428,6 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 		goto free_tag_set;
 	}
 
-	mq->queue->queue_lock = lock;
 	mq->queue->queuedata = mq;
 	blk_queue_rq_timeout(mq->queue, 60 * HZ);
 
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 29218e12900d..5421f1542e71 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -73,6 +73,7 @@ struct mmc_queue_req {
 
 struct mmc_queue {
 	struct mmc_card		*card;
+	spinlock_t		*lock;
 	struct mmc_ctx		ctx;
 	struct blk_mq_tag_set	tag_set;
 	struct mmc_blk_data	*blkdata;
-- 
2.19.1

