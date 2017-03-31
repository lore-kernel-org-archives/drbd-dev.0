Return-Path: <BATV+2133f6211fed31f2c605+4968+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 987011057FCB
	for <drbd-dev@lists.linbit.com>;
	Fri, 31 Mar 2017 18:33:29 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Fri, 31 Mar 2017 18:32:51 +0200
Message-Id: <20170331163313.31821-4-hch@lst.de>
In-Reply-To: <20170331163313.31821-1-hch@lst.de>
References: <20170331163313.31821-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/25] block: implement splitting of
	REQ_OP_WRITE_ZEROES bios
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

Copy and past the REQ_OP_WRITE_SAME code to prepare to implementations
that limit the write zeroes size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2afa262425d1..3990ae406341 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -54,6 +54,20 @@ static struct bio *blk_bio_discard_split(struct request_queue *q,
 	return bio_split(bio, split_sectors, GFP_NOIO, bs);
 }
 
+static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
+		struct bio *bio, struct bio_set *bs, unsigned *nsegs)
+{
+	*nsegs = 1;
+
+	if (!q->limits.max_write_zeroes_sectors)
+		return NULL;
+
+	if (bio_sectors(bio) <= q->limits.max_write_zeroes_sectors)
+		return NULL;
+
+	return bio_split(bio, q->limits.max_write_zeroes_sectors, GFP_NOIO, bs);
+}
+
 static struct bio *blk_bio_write_same_split(struct request_queue *q,
 					    struct bio *bio,
 					    struct bio_set *bs,
@@ -200,8 +214,7 @@ void blk_queue_split(struct request_queue *q, struct bio **bio,
 		split = blk_bio_discard_split(q, *bio, bs, &nsegs);
 		break;
 	case REQ_OP_WRITE_ZEROES:
-		split = NULL;
-		nsegs = (*bio)->bi_phys_segments;
+		split = blk_bio_write_zeroes_split(q, *bio, bs, &nsegs);
 		break;
 	case REQ_OP_WRITE_SAME:
 		split = blk_bio_write_same_split(q, *bio, bs, &nsegs);
-- 
2.11.0

