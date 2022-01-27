Return-Path: <BATV+759db8ec68a62f2c3d04+6731+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4D25242A588
	for <drbd-dev@lists.linbit.com>; Thu, 27 Jan 2022 07:55:40 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 27 Jan 2022 07:35:44 +0100
Message-Id: <20220127063546.1314111-13-hch@lst.de>
In-Reply-To: <20220127063546.1314111-1-hch@lst.de>
References: <20220127063546.1314111-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Pavel Begunkov <asml.silence@gmail.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 12/14] dm: use bio_clone_fast in alloc_tio
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

Replace an open coded bio_clone_fast with the actual helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 5978cb87e9372..984ccafb11ea8 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -558,17 +558,13 @@ static struct bio *alloc_tio(struct clone_info *ci, struct dm_target *ti,
 			return NULL;
 		}
 	} else {
-		struct bio *clone = bio_alloc_bioset(NULL, 0, 0, gfp_mask,
-						     &ci->io->md->bs);
+		struct bio *clone = bio_clone_fast(ci->bio, gfp_mask,
+						   &ci->io->md->bs);
 		if (!clone)
 			return NULL;
 
 		tio = clone_to_tio(clone);
 		tio->inside_dm_io = false;
-		if (__bio_clone_fast(&tio->clone, ci->bio, gfp_mask) < 0) {
-			bio_put(clone);
-			return NULL;
-		}
 	}
 
 	tio->magic = DM_TIO_MAGIC;
-- 
2.30.2

