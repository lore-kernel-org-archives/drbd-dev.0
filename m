Return-Path: <BATV+b18bff4eac1ff4fd9b6a+6737+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5A3C84201B5
	for <drbd-dev@lists.linbit.com>; Wed,  2 Feb 2022 17:01:25 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  2 Feb 2022 17:00:59 +0100
Message-Id: <20220202160109.108149-4-hch@lst.de>
In-Reply-To: <20220202160109.108149-1-hch@lst.de>
References: <20220202160109.108149-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Pavel Begunkov <asml.silence@gmail.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/13] dm: fold clone_bio into
	__clone_and_map_data_bio
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

Fold clone_bio into its only caller to prepare for refactoring.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 5543e18f3c3bc..9384d250a3e4e 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1190,17 +1190,22 @@ static void bio_setup_sector(struct bio *bio, sector_t sector, unsigned len)
 /*
  * Creates a bio that consists of range of complete bvecs.
  */
-static int clone_bio(struct dm_target_io *tio, struct bio *bio,
-		     sector_t sector, unsigned len)
+static int __clone_and_map_data_bio(struct clone_info *ci, struct dm_target *ti,
+				    sector_t sector, unsigned *len)
 {
-	struct bio *clone = &tio->clone;
+	struct bio *bio = ci->bio, *clone;
+	struct dm_target_io *tio;
 	int r;
 
+	tio = alloc_tio(ci, ti, 0, GFP_NOIO);
+	tio->len_ptr = len;
+
+	clone = &tio->clone;
 	__bio_clone_fast(clone, bio);
 
 	r = bio_crypt_clone(clone, bio, GFP_NOIO);
 	if (r < 0)
-		return r;
+		goto free_tio;
 
 	if (bio_integrity(bio)) {
 		if (unlikely(!dm_target_has_integrity(tio->ti->type) &&
@@ -1208,21 +1213,26 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
 			DMWARN("%s: the target %s doesn't support integrity data.",
 				dm_device_name(tio->io->md),
 				tio->ti->type->name);
-			return -EIO;
+			r = -EIO;
+			goto free_tio;
 		}
 
 		r = bio_integrity_clone(clone, bio, GFP_NOIO);
 		if (r < 0)
-			return r;
+			goto free_tio;
 	}
 
 	bio_advance(clone, to_bytes(sector - clone->bi_iter.bi_sector));
-	clone->bi_iter.bi_size = to_bytes(len);
+	clone->bi_iter.bi_size = to_bytes(*len);
 
 	if (bio_integrity(bio))
 		bio_integrity_trim(clone);
 
+	__map_bio(tio);
 	return 0;
+free_tio:
+	free_tio(tio);
+	return r;
 }
 
 static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
@@ -1313,25 +1323,6 @@ static int __send_empty_flush(struct clone_info *ci)
 	return 0;
 }
 
-static int __clone_and_map_data_bio(struct clone_info *ci, struct dm_target *ti,
-				    sector_t sector, unsigned *len)
-{
-	struct bio *bio = ci->bio;
-	struct dm_target_io *tio;
-	int r;
-
-	tio = alloc_tio(ci, ti, 0, GFP_NOIO);
-	tio->len_ptr = len;
-	r = clone_bio(tio, bio, sector, *len);
-	if (r < 0) {
-		free_tio(tio);
-		return r;
-	}
-	__map_bio(tio);
-
-	return 0;
-}
-
 static int __send_changing_extent_only(struct clone_info *ci, struct dm_target *ti,
 				       unsigned num_bios)
 {
-- 
2.30.2

