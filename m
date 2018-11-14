Return-Path: <BATV+ddbc6e1cf1a82b64ebec+5561+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3C7251018D73
	for <drbd-dev@lists.linbit.com>; Wed, 14 Nov 2018 17:19:29 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 14 Nov 2018 17:02:08 +0100
Message-Id: <20181114160219.28328-6-hch@lst.de>
In-Reply-To: <20181114160219.28328-1-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/16] block: remove queue_lockdep_assert_held
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

The only remaining user unconditionally drops and reacquires the lock,
which means we really don't need any additional (conditional) annotation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-throttle.c |  1 -
 block/blk.h          | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 8e6f3c9821c2..a665b0950369 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2353,7 +2353,6 @@ void blk_throtl_drain(struct request_queue *q)
 	struct bio *bio;
 	int rw;
 
-	queue_lockdep_assert_held(q);
 	rcu_read_lock();
 
 	/*
diff --git a/block/blk.h b/block/blk.h
index f2ddc71e93da..027a0ccc175e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -35,19 +35,6 @@ extern struct kmem_cache *blk_requestq_cachep;
 extern struct kobj_type blk_queue_ktype;
 extern struct ida blk_queue_ida;
 
-/*
- * @q->queue_lock is set while a queue is being initialized. Since we know
- * that no other threads access the queue object before @q->queue_lock has
- * been set, it is safe to manipulate queue flags without holding the
- * queue_lock if @q->queue_lock == NULL. See also blk_alloc_queue_node() and
- * blk_init_allocated_queue().
- */
-static inline void queue_lockdep_assert_held(struct request_queue *q)
-{
-	if (q->queue_lock)
-		lockdep_assert_held(q->queue_lock);
-}
-
 static inline struct blk_flush_queue *
 blk_get_flush_queue(struct request_queue *q, struct blk_mq_ctx *ctx)
 {
-- 
2.19.1

