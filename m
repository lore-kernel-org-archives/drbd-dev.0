Return-Path: <BATV+9cf0d970ddff402c2c33+4973+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B1EFE1057FD4
	for <drbd-dev@lists.linbit.com>;
	Wed,  5 Apr 2017 19:21:49 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Wed,  5 Apr 2017 19:21:04 +0200
Message-Id: <20170405172125.22600-7-hch@lst.de>
In-Reply-To: <20170405172125.22600-1-hch@lst.de>
References: <20170405172125.22600-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 06/27] dm io: discards don't take a payload
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Fix up do_region to not allocate a bio_vec for discards.  We've
got rid of the discard payload allocated by the caller years ago.

Obviously this wasn't actually harmful given how long it's been
there, but it's still good to avoid the pointless allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 drivers/md/dm-io.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index 03940bf36f6c..b808cbe22678 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -328,11 +328,17 @@ static void do_region(int op, int op_flags, unsigned region,
 		/*
 		 * Allocate a suitably sized-bio.
 		 */
-		if ((op == REQ_OP_DISCARD) || (op == REQ_OP_WRITE_SAME))
+		switch (op) {
+		case REQ_OP_DISCARD:
+			num_bvecs = 0;
+			break;
+		case REQ_OP_WRITE_SAME:
 			num_bvecs = 1;
-		else
+			break;
+		default:
 			num_bvecs = min_t(int, BIO_MAX_PAGES,
 					  dm_sector_div_up(remaining, (PAGE_SIZE >> SECTOR_SHIFT)));
+		}
 
 		bio = bio_alloc_bioset(GFP_NOIO, num_bvecs, io->client->bios);
 		bio->bi_iter.bi_sector = where->sector + (where->count - remaining);
-- 
2.11.0

