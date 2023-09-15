Return-Path: <mcgrof@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A59BA4203B2
	for <drbd-dev@lists.linbit.com>; Sat, 16 Sep 2023 01:01:55 +0200 (CEST)
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, hch@infradead.org, djwong@kernel.org,
	minchan@kernel.org, senozhatsky@chromium.org
Date: Fri, 15 Sep 2023 15:43:43 -0700
Message-Id: <20230915224343.2740317-5-mcgrof@kernel.org>
In-Reply-To: <20230915224343.2740317-1-mcgrof@kernel.org>
References: <20230915224343.2740317-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Cc: p.raghav@samsung.com, linux-xfs@vger.kernel.org, rohan.puri@samsung.com,
	da.gomez@samsung.com, mcgrof@kernel.org, patches@lists.linux.dev,
	willy@infradead.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	dm-devel@redhat.com, hare@suse.de, linux-fsdevel@vger.kernel.org,
	rpuri.linux@gmail.com, kbusch@kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v3 4/4] zram: use generic PAGE_SECTORS and
	PAGE_SECTORS_SHIFT
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Instead of re-defining the already existing constants use the provided ones:

So replace:

 o SECTORS_PER_PAGE_SHIFT with PAGE_SECTORS_SHIFT
 o SECTORS_PER_PAGE       with PAGE_SECTORS
 o SECTORS_PER_PAGE - 1   with SECTOR_MASK

This produces no functional changes.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/zram/zram_drv.c | 15 ++++++---------
 drivers/block/zram/zram_drv.h |  2 --
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 06673c6ca255..58d36c8574d4 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1834,9 +1834,8 @@ static ssize_t recompress_store(struct device *dev,
 static void zram_bio_discard(struct zram *zram, struct bio *bio)
 {
 	size_t n = bio->bi_iter.bi_size;
-	u32 index = bio->bi_iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
-	u32 offset = (bio->bi_iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
-			SECTOR_SHIFT;
+	u32 index = bio->bi_iter.bi_sector >> PAGE_SECTORS_SHIFT;
+	u32 offset = (bio->bi_iter.bi_sector & SECTOR_MASK) << SECTOR_SHIFT;
 
 	/*
 	 * zram manages data in physical block size units. Because logical block
@@ -1874,9 +1873,8 @@ static void zram_bio_read(struct zram *zram, struct bio *bio)
 	struct bvec_iter iter = bio->bi_iter;
 
 	do {
-		u32 index = iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
-		u32 offset = (iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
-				SECTOR_SHIFT;
+		u32 index = iter.bi_sector >> PAGE_SECTORS_SHIFT;
+		u32 offset = (iter.bi_sector & SECTOR_MASK) << SECTOR_SHIFT;
 		struct bio_vec bv = bio_iter_iovec(bio, iter);
 
 		bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
@@ -1905,9 +1903,8 @@ static void zram_bio_write(struct zram *zram, struct bio *bio)
 	struct bvec_iter iter = bio->bi_iter;
 
 	do {
-		u32 index = iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
-		u32 offset = (iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
-				SECTOR_SHIFT;
+		u32 index = iter.bi_sector >> PAGE_SECTORS_SHIFT;
+		u32 offset = (iter.bi_sector & SECTOR_MASK) << SECTOR_SHIFT;
 		struct bio_vec bv = bio_iter_iovec(bio, iter);
 
 		bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index ca7a15bd4845..9f2543af5c76 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -21,8 +21,6 @@
 
 #include "zcomp.h"
 
-#define SECTORS_PER_PAGE_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
-#define SECTORS_PER_PAGE	(1 << SECTORS_PER_PAGE_SHIFT)
 #define ZRAM_LOGICAL_BLOCK_SHIFT 12
 #define ZRAM_LOGICAL_BLOCK_SIZE	(1 << ZRAM_LOGICAL_BLOCK_SHIFT)
 #define ZRAM_SECTOR_PER_LOGICAL_BLOCK	\
-- 
2.39.2

