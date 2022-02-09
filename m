Return-Path: <BATV+9f6d5568987564775a8e+6744+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1D4F94201E3
	for <drbd-dev@lists.linbit.com>; Wed,  9 Feb 2022 09:28:51 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, target-devel@vger.kernel.org,
	haris.iqbal@ionos.com, jinpu.wang@ionos.com, manoj@linux.ibm.com,
	mrochs@linux.ibm.com, ukrishn@linux.ibm.com
Date: Wed,  9 Feb 2022 09:28:25 +0100
Message-Id: <20220209082828.2629273-5-hch@lst.de>
In-Reply-To: <20220209082828.2629273-1-hch@lst.de>
References: <20220209082828.2629273-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com,
	linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 4/7] sd: remove write same support
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

There are no more end-users of REQ_OP_WRITE_SAME left, so we can start
deleting it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c     | 75 ++++---------------------------------------
 drivers/scsi/sd_zbc.c |  2 --
 2 files changed, 7 insertions(+), 70 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 2d648d27bfd71..fde2857f9bbf5 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1034,13 +1034,13 @@ static void sd_config_write_same(struct scsi_disk *sdkp)
 		 * Reporting a maximum number of blocks that is not aligned
 		 * on the device physical size would cause a large write same
 		 * request to be split into physically unaligned chunks by
-		 * __blkdev_issue_write_zeroes() and __blkdev_issue_write_same()
-		 * even if the caller of these functions took care to align the
-		 * large request. So make sure the maximum reported is aligned
-		 * to the device physical block size. This is only an optional
-		 * optimization for regular disks, but this is mandatory to
-		 * avoid failure of large write same requests directed at
-		 * sequential write required zones of host-managed ZBC disks.
+		 * __blkdev_issue_write_zeroes() even if the caller of this
+		 * functions took care to align the large request. So make sure
+		 * the maximum reported is aligned to the device physical block
+		 * size. This is only an optional optimization for regular
+		 * disks, but this is mandatory to avoid failure of large write
+		 * same requests directed at sequential write required zones of
+		 * host-managed ZBC disks.
 		 */
 		sdkp->max_ws_blocks =
 			round_down(sdkp->max_ws_blocks,
@@ -1049,68 +1049,10 @@ static void sd_config_write_same(struct scsi_disk *sdkp)
 	}
 
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
- * Will set up either WRITE SAME(10) or WRITE SAME(16) depending on
- * the preference indicated by the target device.
- **/
-static blk_status_t sd_setup_write_same_cmnd(struct scsi_cmnd *cmd)
-{
-	struct request *rq = scsi_cmd_to_rq(cmd);
-	struct scsi_device *sdp = cmd->device;
-	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
-	struct bio *bio = rq->bio;
-	u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
-	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
-	blk_status_t ret;
-
-	if (sdkp->device->no_write_same)
-		return BLK_STS_TARGET;
-
-	BUG_ON(bio_offset(bio) || bio_iovec(bio).bv_len != sdp->sector_size);
-
-	rq->timeout = SD_WRITE_SAME_TIMEOUT;
-
-	if (sdkp->ws16 || lba > 0xffffffff || nr_blocks > 0xffff) {
-		cmd->cmd_len = 16;
-		cmd->cmnd[0] = WRITE_SAME_16;
-		put_unaligned_be64(lba, &cmd->cmnd[2]);
-		put_unaligned_be32(nr_blocks, &cmd->cmnd[10]);
-	} else {
-		cmd->cmd_len = 10;
-		cmd->cmnd[0] = WRITE_SAME;
-		put_unaligned_be32(lba, &cmd->cmnd[2]);
-		put_unaligned_be16(nr_blocks, &cmd->cmnd[7]);
-	}
-
-	cmd->transfersize = sdp->sector_size;
-	cmd->allowed = sdkp->max_retries;
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
-	ret = scsi_alloc_sgtables(cmd);
-	rq->__data_len = blk_rq_bytes(rq);
-
-	return ret;
-}
-
 static blk_status_t sd_setup_flush_cmnd(struct scsi_cmnd *cmd)
 {
 	struct request *rq = scsi_cmd_to_rq(cmd);
@@ -1343,8 +1285,6 @@ static blk_status_t sd_init_command(struct scsi_cmnd *cmd)
 		}
 	case REQ_OP_WRITE_ZEROES:
 		return sd_setup_write_zeroes_cmnd(cmd);
-	case REQ_OP_WRITE_SAME:
-		return sd_setup_write_same_cmnd(cmd);
 	case REQ_OP_FLUSH:
 		return sd_setup_flush_cmnd(cmd);
 	case REQ_OP_READ:
@@ -2039,7 +1979,6 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 	switch (req_op(req)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_WRITE_ZEROES:
-	case REQ_OP_WRITE_SAME:
 	case REQ_OP_ZONE_RESET:
 	case REQ_OP_ZONE_RESET_ALL:
 	case REQ_OP_ZONE_OPEN:
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 378d071e47cbc..7f466280993bb 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -423,7 +423,6 @@ static bool sd_zbc_need_zone_wp_update(struct request *rq)
 		return true;
 	case REQ_OP_WRITE:
 	case REQ_OP_WRITE_ZEROES:
-	case REQ_OP_WRITE_SAME:
 		return blk_rq_zone_is_seq(rq);
 	default:
 		return false;
@@ -477,7 +476,6 @@ static unsigned int sd_zbc_zone_wp_update(struct scsi_cmnd *cmd,
 		rq->__sector += sdkp->zones_wp_offset[zno];
 		fallthrough;
 	case REQ_OP_WRITE_ZEROES:
-	case REQ_OP_WRITE_SAME:
 	case REQ_OP_WRITE:
 		if (sdkp->zones_wp_offset[zno] < sd_zbc_zone_sectors(sdkp))
 			sdkp->zones_wp_offset[zno] +=
-- 
2.30.2

