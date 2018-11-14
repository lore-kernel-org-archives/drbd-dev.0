Return-Path: <BATV+ddbc6e1cf1a82b64ebec+5561+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5D7D9101E041
	for <drbd-dev@lists.linbit.com>; Wed, 14 Nov 2018 17:19:26 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 14 Nov 2018 17:02:05 +0100
Message-Id: <20181114160219.28328-3-hch@lst.de>
In-Reply-To: <20181114160219.28328-1-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 02/16] block: remove deadline __deadline
	manipulation helpers
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

No users left since the removal of the legacy request interface, we can
remove all the magic bit stealing now and make it a normal field.

But use WRITE_ONCE/READ_ONCE on the new deadline field, given that we
don't seem to have any mechanism to guarantee a new value actually
gets seen by other threads.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         |  4 ++--
 block/blk-timeout.c    |  8 +++++---
 block/blk.h            | 35 -----------------------------------
 include/linux/blkdev.h |  4 +---
 4 files changed, 8 insertions(+), 43 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 411be60d0cb6..4c82b4b4fa3e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -325,7 +325,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->special = NULL;
 	/* tag was already set */
 	rq->extra_len = 0;
-	rq->__deadline = 0;
+	WRITE_ONCE(rq->deadline, 0);
 
 	rq->timeout = 0;
 
@@ -839,7 +839,7 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
 	if (rq->rq_flags & RQF_TIMED_OUT)
 		return false;
 
-	deadline = blk_rq_deadline(rq);
+	deadline = READ_ONCE(rq->deadline);
 	if (time_after_eq(jiffies, deadline))
 		return true;
 
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 006cff4390c0..3b0179fbdd6a 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -84,7 +84,7 @@ void blk_abort_request(struct request *req)
 	 * immediately and that scan sees the new timeout value.
 	 * No need for fancy synchronizations.
 	 */
-	blk_rq_set_deadline(req, jiffies);
+	WRITE_ONCE(req->deadline, jiffies);
 	kblockd_schedule_work(&req->q->timeout_work);
 }
 EXPORT_SYMBOL_GPL(blk_abort_request);
@@ -121,14 +121,16 @@ void blk_add_timer(struct request *req)
 		req->timeout = q->rq_timeout;
 
 	req->rq_flags &= ~RQF_TIMED_OUT;
-	blk_rq_set_deadline(req, jiffies + req->timeout);
+
+	expiry = jiffies + req->timeout;
+	WRITE_ONCE(req->deadline, expiry);
 
 	/*
 	 * If the timer isn't already pending or this timeout is earlier
 	 * than an existing one, modify the timer. Round up to next nearest
 	 * second.
 	 */
-	expiry = blk_rq_timeout(round_jiffies_up(blk_rq_deadline(req)));
+	expiry = blk_rq_timeout(round_jiffies_up(expiry));
 
 	if (!timer_pending(&q->timeout) ||
 	    time_before(expiry, q->timeout.expires)) {
diff --git a/block/blk.h b/block/blk.h
index 41b64e6e101b..08a5845b03ba 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -238,26 +238,6 @@ void blk_account_io_start(struct request *req, bool new_io);
 void blk_account_io_completion(struct request *req, unsigned int bytes);
 void blk_account_io_done(struct request *req, u64 now);
 
-/*
- * EH timer and IO completion will both attempt to 'grab' the request, make
- * sure that only one of them succeeds. Steal the bottom bit of the
- * __deadline field for this.
- */
-static inline int blk_mark_rq_complete(struct request *rq)
-{
-	return test_and_set_bit(0, &rq->__deadline);
-}
-
-static inline void blk_clear_rq_complete(struct request *rq)
-{
-	clear_bit(0, &rq->__deadline);
-}
-
-static inline bool blk_rq_is_complete(struct request *rq)
-{
-	return test_bit(0, &rq->__deadline);
-}
-
 /*
  * Internal elevator interface
  */
@@ -322,21 +302,6 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
 		q->last_merge = NULL;
 }
 
-/*
- * Steal a bit from this field for legacy IO path atomic IO marking. Note that
- * setting the deadline clears the bottom bit, potentially clearing the
- * completed bit. The user has to be OK with this (current ones are fine).
- */
-static inline void blk_rq_set_deadline(struct request *rq, unsigned long time)
-{
-	rq->__deadline = time & ~0x1UL;
-}
-
-static inline unsigned long blk_rq_deadline(struct request *rq)
-{
-	return rq->__deadline & ~0x1UL;
-}
-
 /*
  * Internal io_context interface
  */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c92aafcde0b8..1aa94759d219 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -224,9 +224,7 @@ struct request {
 	refcount_t ref;
 
 	unsigned int timeout;
-
-	/* access through blk_rq_set_deadline, blk_rq_deadline */
-	unsigned long __deadline;
+	unsigned long deadline;
 
 	union {
 		struct __call_single_data csd;
-- 
2.19.1

