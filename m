Return-Path: <BATV+b18bff4eac1ff4fd9b6a+6737+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id F046A420218
	for <drbd-dev@lists.linbit.com>; Wed,  2 Feb 2022 17:56:52 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  2 Feb 2022 17:01:07 +0100
Message-Id: <20220202160109.108149-12-hch@lst.de>
In-Reply-To: <20220202160109.108149-1-hch@lst.de>
References: <20220202160109.108149-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Pavel Begunkov <asml.silence@gmail.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/13] dm: use bio_clone_fast in
	alloc_io/alloc_tio
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

Replace open coded bio_clone_fast implementations with the actual helper.
Note that the bio allocated as part of the dm_io structure in alloc_io
will only actually be used later in alloc_tio, making this earlier
cloning of the information safe.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 0f8796159379e..862564a5df74b 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -520,7 +520,7 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
 	struct dm_target_io *tio;
 	struct bio *clone;
 
-	clone = bio_alloc_bioset(NULL, 0, 0, GFP_NOIO, &md->io_bs);
+	clone = bio_clone_fast(bio, GFP_NOIO, &md->io_bs);
 
 	tio = clone_to_tio(clone);
 	tio->inside_dm_io = true;
@@ -553,8 +553,8 @@ static struct bio *alloc_tio(struct clone_info *ci, struct dm_target *ti,
 		/* the dm_target_io embedded in ci->io is available */
 		tio = &ci->io->tio;
 	} else {
-		struct bio *clone = bio_alloc_bioset(NULL, 0, 0, gfp_mask,
-						     &ci->io->md->bs);
+		struct bio *clone = bio_clone_fast(ci->bio, gfp_mask,
+						   &ci->io->md->bs);
 		if (!clone)
 			return NULL;
 
@@ -562,12 +562,6 @@ static struct bio *alloc_tio(struct clone_info *ci, struct dm_target *ti,
 		tio->inside_dm_io = false;
 	}
 
-	if (__bio_clone_fast(&tio->clone, ci->bio, gfp_mask) < 0) {
-		if (ci->io->tio.io)
-			bio_put(&tio->clone);
-		return NULL;
-	}
-
 	tio->magic = DM_TIO_MAGIC;
 	tio->io = ci->io;
 	tio->ti = ti;
-- 
2.30.2

