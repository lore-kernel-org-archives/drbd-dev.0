Return-Path: <BATV+9cf0d970ddff402c2c33+4973+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EABAC1057FD3
	for <drbd-dev@lists.linbit.com>;
	Wed,  5 Apr 2017 16:22:40 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Wed,  5 Apr 2017 16:21:46 +0200
Message-Id: <20170405142205.6477-9-hch@lst.de>
In-Reply-To: <20170405142205.6477-1-hch@lst.de>
References: <20170405142205.6477-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 08/27] dm kcopyd: switch to use
	REQ_OP_WRITE_ZEROES
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

It seems like the code currently passes whatever it was using for writes
to WRITE SAME.  Just switch it to WRITE ZEROES, although that doesn't
need any payload.

Untested, and confused by the code, maybe someone who understands it
better than me can help..

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 drivers/md/dm-kcopyd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-kcopyd.c b/drivers/md/dm-kcopyd.c
index 9e9d04cb7d51..f85846741d50 100644
--- a/drivers/md/dm-kcopyd.c
+++ b/drivers/md/dm-kcopyd.c
@@ -733,11 +733,11 @@ int dm_kcopyd_copy(struct dm_kcopyd_client *kc, struct dm_io_region *from,
 		job->pages = &zero_page_list;
 
 		/*
-		 * Use WRITE SAME to optimize zeroing if all dests support it.
+		 * Use WRITE ZEROES to optimize zeroing if all dests support it.
 		 */
-		job->rw = REQ_OP_WRITE_SAME;
+		job->rw = REQ_OP_WRITE_ZEROES;
 		for (i = 0; i < job->num_dests; i++)
-			if (!bdev_write_same(job->dests[i].bdev)) {
+			if (!bdev_write_zeroes_sectors(job->dests[i].bdev)) {
 				job->rw = WRITE;
 				break;
 			}
-- 
2.11.0

