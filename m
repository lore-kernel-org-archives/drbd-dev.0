Return-Path: <BATV+4e9b246676c62bade7ff+4980+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 42A3E1057FD6
	for <drbd-dev@lists.linbit.com>;
	Wed, 12 Apr 2017 10:48:35 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, target-devel@vger.kernel.org
Date: Wed, 12 Apr 2017 10:48:08 +0200
Message-Id: <20170412084809.8245-8-hch@lst.de>
In-Reply-To: <20170412084809.8245-1-hch@lst.de>
References: <20170412084809.8245-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com,
	linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 7/8] block: remove bio_no_advance_iter
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

Now that we don't have to support the odd Write Same special case
we can simply increment the iter if the bio has data, else just
manipulate bi_size directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bio.h | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 96a20afb8575..7a24a1a24967 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -83,13 +83,6 @@ static inline bool bio_has_data(struct bio *bio)
 	return false;
 }
 
-static inline bool bio_no_advance_iter(struct bio *bio)
-{
-	return bio_op(bio) == REQ_OP_DISCARD ||
-	       bio_op(bio) == REQ_OP_SECURE_ERASE ||
-	       bio_op(bio) == REQ_OP_WRITE_ZEROES;
-}
-
 static inline bool bio_mergeable(struct bio *bio)
 {
 	if (bio->bi_opf & REQ_NOMERGE_FLAGS)
@@ -165,10 +158,10 @@ static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
 {
 	iter->bi_sector += bytes >> 9;
 
-	if (bio_no_advance_iter(bio))
-		iter->bi_size -= bytes;
-	else
+	if (bio_has_data(bio))
 		bvec_iter_advance(bio->bi_io_vec, iter, bytes);
+	else
+		iter->bi_size -= bytes;
 }
 
 #define __bio_for_each_segment(bvl, bio, iter, start)			\
-- 
2.11.0

