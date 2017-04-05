Return-Path: <BATV+9cf0d970ddff402c2c33+4973+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0C3271057FCB
	for <drbd-dev@lists.linbit.com>;
	Wed,  5 Apr 2017 20:04:08 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Wed,  5 Apr 2017 19:21:17 +0200
Message-Id: <20170405172125.22600-20-hch@lst.de>
In-Reply-To: <20170405172125.22600-1-hch@lst.de>
References: <20170405172125.22600-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 19/27] rbd: remove the discard_zeroes_data flag
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

rbd only supports discarding on large alignments, so the zeroing code
would always fall back to explicit writings of zeroes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 drivers/block/rbd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f24ade333e0c..089ac4179919 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4380,7 +4380,6 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	q->limits.discard_granularity = segment_size;
 	q->limits.discard_alignment = segment_size;
 	blk_queue_max_discard_sectors(q, segment_size / SECTOR_SIZE);
-	q->limits.discard_zeroes_data = 1;
 
 	if (!ceph_test_opt(rbd_dev->rbd_client->client, NOCRC))
 		q->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
-- 
2.11.0

