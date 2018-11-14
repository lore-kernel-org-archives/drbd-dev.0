Return-Path: <BATV+ddbc6e1cf1a82b64ebec+5561+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 25F81103B4D7
	for <drbd-dev@lists.linbit.com>; Wed, 14 Nov 2018 17:22:12 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 14 Nov 2018 17:02:13 +0100
Message-Id: <20181114160219.28328-11-hch@lst.de>
In-Reply-To: <20181114160219.28328-1-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 10/16] blk-cgroup: move locking into
	blkg_destroy_all
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 717ab38a6c67..3ba23b9bfeb9 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -349,8 +349,7 @@ static void blkg_destroy_all(struct request_queue *q)
 {
 	struct blkcg_gq *blkg, *n;
 
-	lockdep_assert_held(q->queue_lock);
-
+	spin_lock_irq(q->queue_lock);
 	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 
@@ -360,6 +359,7 @@ static void blkg_destroy_all(struct request_queue *q)
 	}
 
 	q->root_blkg = NULL;
+	spin_unlock_irq(q->queue_lock);
 }
 
 /*
@@ -1182,9 +1182,7 @@ int blkcg_init_queue(struct request_queue *q)
 	return 0;
 
 err_destroy_all:
-	spin_lock_irq(q->queue_lock);
 	blkg_destroy_all(q);
-	spin_unlock_irq(q->queue_lock);
 	return ret;
 err_unlock:
 	spin_unlock_irq(q->queue_lock);
@@ -1222,10 +1220,7 @@ void blkcg_drain_queue(struct request_queue *q)
  */
 void blkcg_exit_queue(struct request_queue *q)
 {
-	spin_lock_irq(q->queue_lock);
 	blkg_destroy_all(q);
-	spin_unlock_irq(q->queue_lock);
-
 	blk_throtl_exit(q);
 }
 
-- 
2.19.1

