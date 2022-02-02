Return-Path: <BATV+b18bff4eac1ff4fd9b6a+6737+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D348A420181
	for <drbd-dev@lists.linbit.com>; Wed,  2 Feb 2022 17:01:29 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  2 Feb 2022 17:01:01 +0100
Message-Id: <20220202160109.108149-6-hch@lst.de>
In-Reply-To: <20220202160109.108149-1-hch@lst.de>
References: <20220202160109.108149-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Pavel Begunkov <asml.silence@gmail.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/13] dm: move cloning the bio into alloc_tio
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

Move the call to __bio_clone_fast and the assignment of ->len_ptr from
the callers into alloc_tio to prepare for changes to the bio clone API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 2527b287ead0f..90341b7fa5809 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -545,7 +545,7 @@ static void free_io(struct mapped_device *md, struct dm_io *io)
 }
 
 static struct dm_target_io *alloc_tio(struct clone_info *ci, struct dm_target *ti,
-				      unsigned target_bio_nr, gfp_t gfp_mask)
+		unsigned target_bio_nr, unsigned *len, gfp_t gfp_mask)
 {
 	struct dm_target_io *tio;
 
@@ -561,11 +561,13 @@ static struct dm_target_io *alloc_tio(struct clone_info *ci, struct dm_target *t
 		tio = clone_to_tio(clone);
 		tio->inside_dm_io = false;
 	}
+	__bio_clone_fast(&tio->clone, ci->bio);
 
 	tio->magic = DM_TIO_MAGIC;
 	tio->io = ci->io;
 	tio->ti = ti;
 	tio->target_bio_nr = target_bio_nr;
+	tio->len_ptr = len;
 
 	return tio;
 }
@@ -1197,11 +1199,8 @@ static int __clone_and_map_data_bio(struct clone_info *ci, struct dm_target *ti,
 	struct dm_target_io *tio;
 	int r;
 
-	tio = alloc_tio(ci, ti, 0, GFP_NOIO);
-	tio->len_ptr = len;
-
+	tio = alloc_tio(ci, ti, 0, len, GFP_NOIO);
 	clone = &tio->clone;
-	__bio_clone_fast(clone, bio);
 
 	r = bio_crypt_clone(clone, bio, GFP_NOIO);
 	if (r < 0)
@@ -1236,7 +1235,8 @@ static int __clone_and_map_data_bio(struct clone_info *ci, struct dm_target *ti,
 }
 
 static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
-				struct dm_target *ti, unsigned num_bios)
+				struct dm_target *ti, unsigned num_bios,
+				unsigned *len)
 {
 	struct dm_target_io *tio;
 	int try;
@@ -1245,7 +1245,7 @@ static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
 		return;
 
 	if (num_bios == 1) {
-		tio = alloc_tio(ci, ti, 0, GFP_NOIO);
+		tio = alloc_tio(ci, ti, 0, len, GFP_NOIO);
 		bio_list_add(blist, &tio->clone);
 		return;
 	}
@@ -1257,7 +1257,8 @@ static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
 		if (try)
 			mutex_lock(&ci->io->md->table_devices_lock);
 		for (bio_nr = 0; bio_nr < num_bios; bio_nr++) {
-			tio = alloc_tio(ci, ti, bio_nr, try ? GFP_NOIO : GFP_NOWAIT);
+			tio = alloc_tio(ci, ti, bio_nr, len,
+					try ? GFP_NOIO : GFP_NOWAIT);
 			if (!tio)
 				break;
 
@@ -1279,14 +1280,11 @@ static void __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
 	struct bio_list blist = BIO_EMPTY_LIST;
 	struct bio *clone;
 
-	alloc_multiple_bios(&blist, ci, ti, num_bios);
+	alloc_multiple_bios(&blist, ci, ti, num_bios, len);
 
 	while ((clone = bio_list_pop(&blist))) {
 		struct dm_target_io *tio = clone_to_tio(clone);
 
-		tio->len_ptr = len;
-
-		__bio_clone_fast(clone, ci->bio);
 		if (len)
 			bio_setup_sector(clone, ci->sector, *len);
 		__map_bio(tio);
-- 
2.30.2

