Return-Path: <BATV+ddbc6e1cf1a82b64ebec+5561+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A7267103B4AE
	for <drbd-dev@lists.linbit.com>; Wed, 14 Nov 2018 17:19:30 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 14 Nov 2018 17:02:12 +0100
Message-Id: <20181114160219.28328-10-hch@lst.de>
In-Reply-To: <20181114160219.28328-1-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/16] blk-cgroup: consolidate error handling in
	blkcg_init_queue
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

Use a goto label to merge two identical pieces of error handling code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3296c0b7353a..717ab38a6c67 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1173,21 +1173,19 @@ int blkcg_init_queue(struct request_queue *q)
 		radix_tree_preload_end();
 
 	ret = blk_iolatency_init(q);
-	if (ret) {
-		spin_lock_irq(q->queue_lock);
-		blkg_destroy_all(q);
-		spin_unlock_irq(q->queue_lock);
-		return ret;
-	}
+	if (ret)
+		goto err_destroy_all;
 
 	ret = blk_throtl_init(q);
-	if (ret) {
-		spin_lock_irq(q->queue_lock);
-		blkg_destroy_all(q);
-		spin_unlock_irq(q->queue_lock);
-	}
-	return ret;
+	if (ret)
+		goto err_destroy_all;
+	return 0;
 
+err_destroy_all:
+	spin_lock_irq(q->queue_lock);
+	blkg_destroy_all(q);
+	spin_unlock_irq(q->queue_lock);
+	return ret;
 err_unlock:
 	spin_unlock_irq(q->queue_lock);
 	rcu_read_unlock();
-- 
2.19.1

