Return-Path: <BATV+ddbc6e1cf1a82b64ebec+5561+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2D93D103B4C1
	for <drbd-dev@lists.linbit.com>; Wed, 14 Nov 2018 17:22:11 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 14 Nov 2018 17:02:15 +0100
Message-Id: <20181114160219.28328-13-hch@lst.de>
In-Reply-To: <20181114160219.28328-1-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 12/16] umem: don't override the queue_lock
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

The umem card->lock and the block layer queue_lock are used for entirely
different resources.  Stop using card->lock as the block layer
queue_lock.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/umem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index be3e3ab79950..8a27b5adc2b3 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -888,8 +888,7 @@ static int mm_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	card->biotail = &card->bio;
 	spin_lock_init(&card->lock);
 
-	card->queue = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE,
-					   &card->lock);
+	card->queue = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, NULL);
 	if (!card->queue)
 		goto failed_alloc;
 
-- 
2.19.1

