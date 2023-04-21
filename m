Return-Path: <mcgrof@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0B2D04252C7
	for <drbd-dev@lists.linbit.com>; Fri, 21 Apr 2023 22:22:55 +0200 (CEST)
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, hch@infradead.org, djwong@kernel.org,
	minchan@kernel.org, senozhatsky@chromium.org
Date: Fri, 21 Apr 2023 12:58:07 -0700
Message-Id: <20230421195807.2804512-6-mcgrof@kernel.org>
In-Reply-To: <20230421195807.2804512-1-mcgrof@kernel.org>
References: <20230421195807.2804512-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Cc: p.raghav@samsung.com, linux-xfs@vger.kernel.org, mcgrof@kernel.org,
	da.gomez@samsung.com, patches@lists.linux.dev,
	willy@infradead.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	dm-devel@redhat.com, hare@suse.de, linux-fsdevel@vger.kernel.org,
	kbusch@kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 5/5] zram: use generic PAGE_SECTORS and
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

This produces no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/zram/zram_drv.c | 12 ++++++------
 drivers/block/zram/zram_drv.h |  2 --
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a84c4268257a..11c9b5a9ac7a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1834,8 +1834,8 @@ static ssize_t recompress_store(struct device *dev,
 static void zram_bio_discard(struct zram *zram, struct bio *bio)
 {
 	size_t n = bio->bi_iter.bi_size;
-	u32 index = bio->bi_iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
-	u32 offset = (bio->bi_iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
+	u32 index = bio->bi_iter.bi_sector >> PAGE_SECTORS_SHIFT;
+	u32 offset = (bio->bi_iter.bi_sector & (PAGE_SECTORS - 1)) <<
 			SECTOR_SHIFT;
 
 	/*
@@ -1876,8 +1876,8 @@ static void zram_bio_read(struct zram *zram, struct bio *bio)
 
 	start_time = bio_start_io_acct(bio);
 	bio_for_each_segment(bv, bio, iter) {
-		u32 index = iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
-		u32 offset = (iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
+		u32 index = iter.bi_sector >> PAGE_SECTORS_SHIFT;
+		u32 offset = (iter.bi_sector & (PAGE_SECTORS - 1)) <<
 				SECTOR_SHIFT;
 
 		if (zram_bvec_read(zram, &bv, index, offset, bio) < 0) {
@@ -1903,8 +1903,8 @@ static void zram_bio_write(struct zram *zram, struct bio *bio)
 
 	start_time = bio_start_io_acct(bio);
 	bio_for_each_segment(bv, bio, iter) {
-		u32 index = iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
-		u32 offset = (iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
+		u32 index = iter.bi_sector >> PAGE_SECTORS_SHIFT;
+		u32 offset = (iter.bi_sector & (PAGE_SECTORS - 1)) <<
 				SECTOR_SHIFT;
 
 		if (zram_bvec_write(zram, &bv, index, offset, bio) < 0) {
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

