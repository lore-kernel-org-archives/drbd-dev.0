Return-Path: <BATV+b18bff4eac1ff4fd9b6a+6737+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5CBDC4201B7
	for <drbd-dev@lists.linbit.com>; Wed,  2 Feb 2022 17:01:35 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  2 Feb 2022 17:01:03 +0100
Message-Id: <20220202160109.108149-8-hch@lst.de>
In-Reply-To: <20220202160109.108149-1-hch@lst.de>
References: <20220202160109.108149-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Pavel Begunkov <asml.silence@gmail.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 07/13] dm: retun the clone bio from alloc_tio
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

Return the clone bio embedded into the tio as that is what the callers
actually want.  Similar for the free side.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a43d280e9bc54..c05b6ff1bb957 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -544,7 +544,7 @@ static void free_io(struct mapped_device *md, struct dm_io *io)
 	bio_put(&io->tio.clone);
 }
 
-static struct dm_target_io *alloc_tio(struct clone_info *ci, struct dm_target *ti,
+static struct bio *alloc_tio(struct clone_info *ci, struct dm_target *ti,
 		unsigned target_bio_nr, unsigned *len, gfp_t gfp_mask)
 {
 	struct dm_target_io *tio;
@@ -569,14 +569,14 @@ static struct dm_target_io *alloc_tio(struct clone_info *ci, struct dm_target *t
 	tio->target_bio_nr = target_bio_nr;
 	tio->len_ptr = len;
 
-	return tio;
+	return &tio->clone;
 }
 
-static void free_tio(struct dm_target_io *tio)
+static void free_tio(struct bio *clone)
 {
-	if (tio->inside_dm_io)
+	if (clone_to_tio(clone)->inside_dm_io)
 		return;
-	bio_put(&tio->clone);
+	bio_put(clone);
 }
 
 /*
@@ -932,7 +932,7 @@ static void clone_endio(struct bio *bio)
 		up(&md->swap_bios_semaphore);
 	}
 
-	free_tio(tio);
+	free_tio(bio);
 	dm_io_dec_pending(io, error);
 }
 
@@ -1166,7 +1166,7 @@ static void __map_bio(struct bio *clone)
 			struct mapped_device *md = io->md;
 			up(&md->swap_bios_semaphore);
 		}
-		free_tio(tio);
+		free_tio(clone);
 		dm_io_dec_pending(io, BLK_STS_IOERR);
 		break;
 	case DM_MAPIO_REQUEUE:
@@ -1174,7 +1174,7 @@ static void __map_bio(struct bio *clone)
 			struct mapped_device *md = io->md;
 			up(&md->swap_bios_semaphore);
 		}
-		free_tio(tio);
+		free_tio(clone);
 		dm_io_dec_pending(io, BLK_STS_DM_REQUEUE);
 		break;
 	default:
@@ -1196,17 +1196,17 @@ static int __clone_and_map_data_bio(struct clone_info *ci, struct dm_target *ti,
 				    sector_t sector, unsigned *len)
 {
 	struct bio *bio = ci->bio, *clone;
-	struct dm_target_io *tio;
 	int r;
 
-	tio = alloc_tio(ci, ti, 0, len, GFP_NOIO);
-	clone = &tio->clone;
+	clone = alloc_tio(ci, ti, 0, len, GFP_NOIO);
 
 	r = bio_crypt_clone(clone, bio, GFP_NOIO);
 	if (r < 0)
 		goto free_tio;
 
 	if (bio_integrity(bio)) {
+		struct dm_target_io *tio = clone_to_tio(clone);
+
 		if (unlikely(!dm_target_has_integrity(tio->ti->type) &&
 			     !dm_target_passes_integrity(tio->ti->type))) {
 			DMWARN("%s: the target %s doesn't support integrity data.",
@@ -1230,7 +1230,7 @@ static int __clone_and_map_data_bio(struct clone_info *ci, struct dm_target *ti,
 	__map_bio(clone);
 	return 0;
 free_tio:
-	free_tio(tio);
+	free_tio(clone);
 	return r;
 }
 
@@ -1238,31 +1238,30 @@ static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
 				struct dm_target *ti, unsigned num_bios,
 				unsigned *len)
 {
-	struct dm_target_io *tio;
+	struct bio *bio;
 	int try;
 
 	if (!num_bios)
 		return;
 
 	if (num_bios == 1) {
-		tio = alloc_tio(ci, ti, 0, len, GFP_NOIO);
-		bio_list_add(blist, &tio->clone);
+		bio = alloc_tio(ci, ti, 0, len, GFP_NOIO);
+		bio_list_add(blist, bio);
 		return;
 	}
 
 	for (try = 0; try < 2; try++) {
 		int bio_nr;
-		struct bio *bio;
 
 		if (try)
 			mutex_lock(&ci->io->md->table_devices_lock);
 		for (bio_nr = 0; bio_nr < num_bios; bio_nr++) {
-			tio = alloc_tio(ci, ti, bio_nr, len,
+			bio = alloc_tio(ci, ti, bio_nr, len,
 					try ? GFP_NOIO : GFP_NOWAIT);
-			if (!tio)
+			if (!bio)
 				break;
 
-			bio_list_add(blist, &tio->clone);
+			bio_list_add(blist, bio);
 		}
 		if (try)
 			mutex_unlock(&ci->io->md->table_devices_lock);
@@ -1270,7 +1269,7 @@ static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
 			return;
 
 		while ((bio = bio_list_pop(blist)))
-			free_tio(clone_to_tio(bio));
+			free_tio(bio);
 	}
 }
 
-- 
2.30.2

