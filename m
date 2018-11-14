Return-Path: <BATV+ddbc6e1cf1a82b64ebec+5561+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 33467103B4B7
	for <drbd-dev@lists.linbit.com>; Wed, 14 Nov 2018 17:22:10 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 14 Nov 2018 17:02:18 +0100
Message-Id: <20181114160219.28328-16-hch@lst.de>
In-Reply-To: <20181114160219.28328-1-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 15/16] block: remove the lock argument to
	blk_alloc_queue_node
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

With the legacy request path gone there is no real need to override the
queue_lock.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c               | 16 +++-------------
 block/blk-mq.c                 |  2 +-
 drivers/block/drbd/drbd_main.c |  2 +-
 drivers/block/null_blk_main.c  |  3 +--
 drivers/block/umem.c           |  2 +-
 drivers/lightnvm/core.c        |  2 +-
 drivers/md/dm.c                |  2 +-
 drivers/nvdimm/pmem.c          |  2 +-
 drivers/nvme/host/multipath.c  |  2 +-
 include/linux/blkdev.h         |  3 +--
 10 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5c8e66a09d82..3f94c9de0252 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -393,7 +393,7 @@ EXPORT_SYMBOL(blk_cleanup_queue);
 
 struct request_queue *blk_alloc_queue(gfp_t gfp_mask)
 {
-	return blk_alloc_queue_node(gfp_mask, NUMA_NO_NODE, NULL);
+	return blk_alloc_queue_node(gfp_mask, NUMA_NO_NODE);
 }
 EXPORT_SYMBOL(blk_alloc_queue);
 
@@ -473,17 +473,8 @@ static void blk_rq_timed_out_timer(struct timer_list *t)
  * blk_alloc_queue_node - allocate a request queue
  * @gfp_mask: memory allocation flags
  * @node_id: NUMA node to allocate memory from
- * @lock: For legacy queues, pointer to a spinlock that will be used to e.g.
- *        serialize calls to the legacy .request_fn() callback. Ignored for
- *	  blk-mq request queues.
- *
- * Note: pass the queue lock as the third argument to this function instead of
- * setting the queue lock pointer explicitly to avoid triggering a sporadic
- * crash in the blkcg code. This function namely calls blkcg_init_queue() and
- * the queue lock pointer must be set before blkcg_init_queue() is called.
  */
-struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
-					   spinlock_t *lock)
+struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 {
 	struct request_queue *q;
 	int ret;
@@ -534,8 +525,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
 #endif
 	mutex_init(&q->sysfs_lock);
 	spin_lock_init(&q->__queue_lock);
-
-	q->queue_lock = lock ? : &q->__queue_lock;
+	q->queue_lock = &q->__queue_lock;
 
 	init_waitqueue_head(&q->mq_freeze_wq);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a3f057fdd045..3b823891b3ef 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2548,7 +2548,7 @@ struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
 {
 	struct request_queue *uninit_q, *q;
 
-	uninit_q = blk_alloc_queue_node(GFP_KERNEL, set->numa_node, NULL);
+	uninit_q = blk_alloc_queue_node(GFP_KERNEL, set->numa_node);
 	if (!uninit_q)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index b66c59ce6260..f973a2a845c8 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2792,7 +2792,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 
 	drbd_init_set_defaults(device);
 
-	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, NULL);
+	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE);
 	if (!q)
 		goto out_no_q;
 	device->rq_queue = q;
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 63c23fcfc4df..62c9654b9ce8 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1659,8 +1659,7 @@ static int null_add_dev(struct nullb_device *dev)
 		}
 		null_init_queues(nullb);
 	} else if (dev->queue_mode == NULL_Q_BIO) {
-		nullb->q = blk_alloc_queue_node(GFP_KERNEL, dev->home_node,
-						NULL);
+		nullb->q = blk_alloc_queue_node(GFP_KERNEL, dev->home_node);
 		if (!nullb->q) {
 			rv = -ENOMEM;
 			goto out_cleanup_queues;
diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index 8a27b5adc2b3..aa035cf8a51d 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -888,7 +888,7 @@ static int mm_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	card->biotail = &card->bio;
 	spin_lock_init(&card->lock);
 
-	card->queue = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, NULL);
+	card->queue = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE);
 	if (!card->queue)
 		goto failed_alloc;
 
diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index efb976a863d2..60ab11fcc81c 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -389,7 +389,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 		goto err_dev;
 	}
 
-	tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node, NULL);
+	tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node);
 	if (!tqueue) {
 		ret = -ENOMEM;
 		goto err_disk;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index c510179a7f84..a733e4c920af 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1896,7 +1896,7 @@ static struct mapped_device *alloc_dev(int minor)
 	INIT_LIST_HEAD(&md->table_devices);
 	spin_lock_init(&md->uevent_lock);
 
-	md->queue = blk_alloc_queue_node(GFP_KERNEL, numa_node_id, NULL);
+	md->queue = blk_alloc_queue_node(GFP_KERNEL, numa_node_id);
 	if (!md->queue)
 		goto bad;
 	md->queue->queuedata = md;
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 0e39e3d1846f..f7019294740c 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -393,7 +393,7 @@ static int pmem_attach_disk(struct device *dev,
 		return -EBUSY;
 	}
 
-	q = blk_alloc_queue_node(GFP_KERNEL, dev_to_node(dev), NULL);
+	q = blk_alloc_queue_node(GFP_KERNEL, dev_to_node(dev));
 	if (!q)
 		return -ENOMEM;
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 5e3cc8c59a39..b82b0d3ca39a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -276,7 +276,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	if (!(ctrl->subsys->cmic & (1 << 1)) || !multipath)
 		return 0;
 
-	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, NULL);
+	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE);
 	if (!q)
 		goto out;
 	q->queuedata = head;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2b887e24837e..666c73b97b0d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1125,8 +1125,7 @@ extern long nr_blockdev_pages(void);
 
 bool __must_check blk_get_queue(struct request_queue *);
 struct request_queue *blk_alloc_queue(gfp_t);
-struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
-					   spinlock_t *lock);
+struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id);
 extern void blk_put_queue(struct request_queue *);
 extern void blk_set_queue_dying(struct request_queue *);
 
-- 
2.19.1

