Return-Path: <BATV+759db8ec68a62f2c3d04+6731+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 88C964298F1
	for <drbd-dev@lists.linbit.com>; Thu, 27 Jan 2022 07:36:25 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 27 Jan 2022 07:35:41 +0100
Message-Id: <20220127063546.1314111-10-hch@lst.de>
In-Reply-To: <20220127063546.1314111-1-hch@lst.de>
References: <20220127063546.1314111-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Pavel Begunkov <asml.silence@gmail.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/14] dm: add a missing bio initialization to
	alloc_tio
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

The bio in the tio embedded into the clone_info structure is never
initialized.  This is harmless as bio_init only zeroes the structure
and assigns the vectors, but add the initialization to prepare for
refactoring the bio cloning logic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index ee2d92ec7c9fc..57f44d3a4d747 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -552,6 +552,7 @@ static struct bio *alloc_tio(struct clone_info *ci, struct dm_target *ti,
 	if (!ci->io->tio.io) {
 		/* the dm_target_io embedded in ci->io is available */
 		tio = &ci->io->tio;
+		bio_init(&tio->clone, NULL, NULL, 0, 0);
 	} else {
 		struct bio *clone = bio_alloc_bioset(NULL, 0, 0, gfp_mask,
 						     &ci->io->md->bs);
-- 
2.30.2

