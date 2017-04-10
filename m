Return-Path: <BATV+d06792d33419b921eada+4978+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EB3A91057FAD
	for <drbd-dev@lists.linbit.com>;
	Mon, 10 Apr 2017 18:08:23 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, target-devel@vger.kernel.org
Date: Mon, 10 Apr 2017 18:08:02 +0200
Message-Id: <20170410160807.23674-4-hch@lst.de>
In-Reply-To: <20170410160807.23674-1-hch@lst.de>
References: <20170410160807.23674-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com,
	linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 3/8] sd: remove write same support
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

There are no more end-users of REQ_OP_WRITE_SAME left, so we can start
deleting it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c     | 70 ---------------------------------------------------
 drivers/scsi/sd_zbc.c |  1 -
 2 files changed, 71 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 8cf34a8e3eea..a905802e927e 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -878,77 +878,10 @@ static void sd_config_write_same(struct scsi_disk *sdkp)
 		sdkp->zeroing_mode = SD_ZERO_WRITE;
 
 out:
-	blk_queue_max_write_same_sectors(q, sdkp->max_ws_blocks *
-					 (logical_block_size >> 9));
 	blk_queue_max_write_zeroes_sectors(q, sdkp->max_ws_blocks *
 					 (logical_block_size >> 9));
 }
 
-/**
- * sd_setup_write_same_cmnd - write the same data to multiple blocks
- * @cmd: command to prepare
- *
- * Will issue either WRITE SAME(10) or WRITE SAME(16) depending on
- * preference indicated by target device.
- **/
-static int sd_setup_write_same_cmnd(struct scsi_cmnd *cmd)
-{
-	struct request *rq = cmd->request;
-	struct scsi_device *sdp = cmd->device;
-	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
-	struct bio *bio = rq->bio;
-	sector_t sector = blk_rq_pos(rq);
-	unsigned int nr_sectors = blk_rq_sectors(rq);
-	unsigned int nr_bytes = blk_rq_bytes(rq);
-	int ret;
-
-	if (sdkp->device->no_write_same)
-		return BLKPREP_INVALID;
-
-	BUG_ON(bio_offset(bio) || bio_iovec(bio).bv_len != sdp->sector_size);
-
-	if (sd_is_zoned(sdkp)) {
-		ret = sd_zbc_setup_write_cmnd(cmd);
-		if (ret != BLKPREP_OK)
-			return ret;
-	}
-
-	sector >>= ilog2(sdp->sector_size) - 9;
-	nr_sectors >>= ilog2(sdp->sector_size) - 9;
-
-	rq->timeout = SD_WRITE_SAME_TIMEOUT;
-
-	if (sdkp->ws16 || sector > 0xffffffff || nr_sectors > 0xffff) {
-		cmd->cmd_len = 16;
-		cmd->cmnd[0] = WRITE_SAME_16;
-		put_unaligned_be64(sector, &cmd->cmnd[2]);
-		put_unaligned_be32(nr_sectors, &cmd->cmnd[10]);
-	} else {
-		cmd->cmd_len = 10;
-		cmd->cmnd[0] = WRITE_SAME;
-		put_unaligned_be32(sector, &cmd->cmnd[2]);
-		put_unaligned_be16(nr_sectors, &cmd->cmnd[7]);
-	}
-
-	cmd->transfersize = sdp->sector_size;
-	cmd->allowed = SD_MAX_RETRIES;
-
-	/*
-	 * For WRITE SAME the data transferred via the DATA OUT buffer is
-	 * different from the amount of data actually written to the target.
-	 *
-	 * We set up __data_len to the amount of data transferred via the
-	 * DATA OUT buffer so that blk_rq_map_sg sets up the proper S/G list
-	 * to transfer a single sector of data first, but then reset it to
-	 * the amount of data to be written right after so that the I/O path
-	 * knows how much to actually write.
-	 */
-	rq->__data_len = sdp->sector_size;
-	ret = scsi_init_io(cmd);
-	rq->__data_len = nr_bytes;
-	return ret;
-}
-
 static int sd_setup_flush_cmnd(struct scsi_cmnd *cmd)
 {
 	struct request *rq = cmd->request;
@@ -1232,8 +1165,6 @@ static int sd_init_command(struct scsi_cmnd *cmd)
 		}
 	case REQ_OP_WRITE_ZEROES:
 		return sd_setup_write_zeroes_cmnd(cmd);
-	case REQ_OP_WRITE_SAME:
-		return sd_setup_write_same_cmnd(cmd);
 	case REQ_OP_FLUSH:
 		return sd_setup_flush_cmnd(cmd);
 	case REQ_OP_READ:
@@ -1872,7 +1803,6 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 	switch (req_op(req)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_WRITE_ZEROES:
-	case REQ_OP_WRITE_SAME:
 	case REQ_OP_ZONE_RESET:
 		if (!result) {
 			good_bytes = blk_rq_bytes(req);
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 1994f7799fce..8af6c9cd30ca 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -330,7 +330,6 @@ void sd_zbc_complete(struct scsi_cmnd *cmd,
 	switch (req_op(rq)) {
 	case REQ_OP_WRITE:
 	case REQ_OP_WRITE_ZEROES:
-	case REQ_OP_WRITE_SAME:
 	case REQ_OP_ZONE_RESET:
 
 		/* Unlock the zone */
-- 
2.11.0

