Return-Path: <BATV+b18bff4eac1ff4fd9b6a+6737+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E64324201B6
	for <drbd-dev@lists.linbit.com>; Wed,  2 Feb 2022 17:01:31 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  2 Feb 2022 17:01:02 +0100
Message-Id: <20220202160109.108149-7-hch@lst.de>
In-Reply-To: <20220202160109.108149-1-hch@lst.de>
References: <20220202160109.108149-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Pavel Begunkov <asml.silence@gmail.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 06/13] dm: pass the bio instead of tio to
	__map_bio
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

This simplifies the callers a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 90341b7fa5809..a43d280e9bc54 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1117,11 +1117,11 @@ static noinline void __set_swap_bios_limit(struct mapped_device *md, int latch)
 	mutex_unlock(&md->swap_bios_lock);
 }
 
-static void __map_bio(struct dm_target_io *tio)
+static void __map_bio(struct bio *clone)
 {
+	struct dm_target_io *tio = clone_to_tio(clone);
 	int r;
 	sector_t sector;
-	struct bio *clone = &tio->clone;
 	struct dm_io *io = tio->io;
 	struct dm_target *ti = tio->ti;
 
@@ -1227,7 +1227,7 @@ static int __clone_and_map_data_bio(struct clone_info *ci, struct dm_target *ti,
 	if (bio_integrity(bio))
 		bio_integrity_trim(clone);
 
-	__map_bio(tio);
+	__map_bio(clone);
 	return 0;
 free_tio:
 	free_tio(tio);
@@ -1283,11 +1283,9 @@ static void __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
 	alloc_multiple_bios(&blist, ci, ti, num_bios, len);
 
 	while ((clone = bio_list_pop(&blist))) {
-		struct dm_target_io *tio = clone_to_tio(clone);
-
 		if (len)
 			bio_setup_sector(clone, ci->sector, *len);
-		__map_bio(tio);
+		__map_bio(clone);
 	}
 }
 
-- 
2.30.2

