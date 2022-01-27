Return-Path: <BATV+759db8ec68a62f2c3d04+6731+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 315E1420623
	for <drbd-dev@lists.linbit.com>; Thu, 27 Jan 2022 07:36:09 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 27 Jan 2022 07:35:36 +0100
Message-Id: <20220127063546.1314111-5-hch@lst.de>
In-Reply-To: <20220127063546.1314111-1-hch@lst.de>
References: <20220127063546.1314111-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Pavel Begunkov <asml.silence@gmail.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 04/14] dm: fold __send_duplicate_bios into
	__clone_and_map_simple_bio
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

Fold __send_duplicate_bios into its only caller to prepare for
refactoring.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index e1356a4ce0393..b3b60918206b5 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1273,29 +1273,24 @@ static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
 	}
 }
 
-static void __clone_and_map_simple_bio(struct clone_info *ci,
-					   struct dm_target_io *tio, unsigned *len)
-{
-	struct bio *clone = &tio->clone;
-
-	tio->len_ptr = len;
-
-	__bio_clone_fast(clone, ci->bio);
-	if (len)
-		bio_setup_sector(clone, ci->sector, *len);
-	__map_bio(tio);
-}
-
 static void __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
 				  unsigned num_bios, unsigned *len)
 {
 	struct bio_list blist = BIO_EMPTY_LIST;
-	struct bio *bio;
+	struct bio *clone;
 
 	alloc_multiple_bios(&blist, ci, ti, num_bios);
 
-	while ((bio = bio_list_pop(&blist)))
-		__clone_and_map_simple_bio(ci, clone_to_tio(bio), len);
+	while ((clone = bio_list_pop(&blist))) {
+		struct dm_target_io *tio = clone_to_tio(clone);
+
+		tio->len_ptr = len;
+
+		__bio_clone_fast(clone, ci->bio);
+		if (len)
+			bio_setup_sector(clone, ci->sector, *len);
+		__map_bio(tio);
+	}
 }
 
 static int __send_empty_flush(struct clone_info *ci)
-- 
2.30.2

