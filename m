Return-Path: <BATV+b18bff4eac1ff4fd9b6a+6737+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2B379420192
	for <drbd-dev@lists.linbit.com>; Wed,  2 Feb 2022 17:01:21 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  2 Feb 2022 17:00:58 +0100
Message-Id: <20220202160109.108149-3-hch@lst.de>
In-Reply-To: <20220202160109.108149-1-hch@lst.de>
References: <20220202160109.108149-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Pavel Begunkov <asml.silence@gmail.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 02/13] dm: add a clone_to_tio helper
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

Add a helper to stop open coding the container_of operations to get
from the clone bio to the tio structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index fa596b654c99c..5543e18f3c3bc 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -79,10 +79,14 @@ struct clone_info {
 #define DM_IO_BIO_OFFSET \
 	(offsetof(struct dm_target_io, clone) + offsetof(struct dm_io, tio))
 
+static inline struct dm_target_io *clone_to_tio(struct bio *clone)
+{
+	return container_of(clone, struct dm_target_io, clone);
+}
+
 void *dm_per_bio_data(struct bio *bio, size_t data_size)
 {
-	struct dm_target_io *tio = container_of(bio, struct dm_target_io, clone);
-	if (!tio->inside_dm_io)
+	if (!clone_to_tio(bio)->inside_dm_io)
 		return (char *)bio - DM_TARGET_IO_BIO_OFFSET - data_size;
 	return (char *)bio - DM_IO_BIO_OFFSET - data_size;
 }
@@ -477,10 +481,7 @@ static int dm_blk_ioctl(struct block_device *bdev, fmode_t mode,
 
 u64 dm_start_time_ns_from_clone(struct bio *bio)
 {
-	struct dm_target_io *tio = container_of(bio, struct dm_target_io, clone);
-	struct dm_io *io = tio->io;
-
-	return jiffies_to_nsecs(io->start_time);
+	return jiffies_to_nsecs(clone_to_tio(bio)->io->start_time);
 }
 EXPORT_SYMBOL_GPL(dm_start_time_ns_from_clone);
 
@@ -521,7 +522,7 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
 
 	clone = bio_alloc_bioset(NULL, 0, 0, GFP_NOIO, &md->io_bs);
 
-	tio = container_of(clone, struct dm_target_io, clone);
+	tio = clone_to_tio(clone);
 	tio->inside_dm_io = true;
 	tio->io = NULL;
 
@@ -557,7 +558,7 @@ static struct dm_target_io *alloc_tio(struct clone_info *ci, struct dm_target *t
 		if (!clone)
 			return NULL;
 
-		tio = container_of(clone, struct dm_target_io, clone);
+		tio = clone_to_tio(clone);
 		tio->inside_dm_io = false;
 	}
 
@@ -878,7 +879,7 @@ static bool swap_bios_limit(struct dm_target *ti, struct bio *bio)
 static void clone_endio(struct bio *bio)
 {
 	blk_status_t error = bio->bi_status;
-	struct dm_target_io *tio = container_of(bio, struct dm_target_io, clone);
+	struct dm_target_io *tio = clone_to_tio(bio);
 	struct dm_io *io = tio->io;
 	struct mapped_device *md = tio->io->md;
 	dm_endio_fn endio = tio->ti->type->end_io;
@@ -1084,7 +1085,7 @@ static int dm_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
  */
 void dm_accept_partial_bio(struct bio *bio, unsigned n_sectors)
 {
-	struct dm_target_io *tio = container_of(bio, struct dm_target_io, clone);
+	struct dm_target_io *tio = clone_to_tio(bio);
 	unsigned bi_size = bio->bi_iter.bi_size >> SECTOR_SHIFT;
 
 	BUG_ON(bio->bi_opf & REQ_PREFLUSH);
@@ -1257,10 +1258,8 @@ static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
 		if (bio_nr == num_bios)
 			return;
 
-		while ((bio = bio_list_pop(blist))) {
-			tio = container_of(bio, struct dm_target_io, clone);
-			free_tio(tio);
-		}
+		while ((bio = bio_list_pop(blist)))
+			free_tio(clone_to_tio(bio));
 	}
 }
 
@@ -1282,14 +1281,11 @@ static void __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
 {
 	struct bio_list blist = BIO_EMPTY_LIST;
 	struct bio *bio;
-	struct dm_target_io *tio;
 
 	alloc_multiple_bios(&blist, ci, ti, num_bios);
 
-	while ((bio = bio_list_pop(&blist))) {
-		tio = container_of(bio, struct dm_target_io, clone);
-		__clone_and_map_simple_bio(ci, tio, len);
-	}
+	while ((bio = bio_list_pop(&blist)))
+		__clone_and_map_simple_bio(ci, clone_to_tio(bio), len);
 }
 
 static int __send_empty_flush(struct clone_info *ci)
-- 
2.30.2

