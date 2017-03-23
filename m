Return-Path: <BATV+f1fc5bea56d51e2fc981+4960+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 265971056446
	for <drbd-dev@lists.linbit.com>; Thu, 23 Mar 2017 15:54:48 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Thu, 23 Mar 2017 10:33:21 -0400
Message-Id: <20170323143341.31549-4-hch@lst.de>
In-Reply-To: <20170323143341.31549-1-hch@lst.de>
References: <20170323143341.31549-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 03/23] sd: implement REQ_OP_WRITE_ZEROES
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c     | 45 ++++++++++++++++++++++++++++++++++++++++-----
 drivers/scsi/sd_zbc.c |  1 +
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index af632e350ab4..b6f70a09a301 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -748,7 +748,7 @@ static int sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 	return scsi_init_io(cmd);
 }
 
-static int sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd)
+static int sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd, bool unmap)
 {
 	struct scsi_device *sdp = cmd->device;
 	struct request *rq = cmd->request;
@@ -765,13 +765,14 @@ static int sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd)
 
 	cmd->cmd_len = 16;
 	cmd->cmnd[0] = WRITE_SAME_16;
-	cmd->cmnd[1] = 0x8; /* UNMAP */
+	if (unmap)
+		cmd->cmnd[1] = 0x8; /* UNMAP */
 	put_unaligned_be64(sector, &cmd->cmnd[2]);
 	put_unaligned_be32(nr_sectors, &cmd->cmnd[10]);
 
 	cmd->allowed = SD_MAX_RETRIES;
 	cmd->transfersize = data_len;
-	rq->timeout = SD_TIMEOUT;
+	rq->timeout = unmap ? SD_TIMEOUT : SD_WRITE_SAME_TIMEOUT;
 	scsi_req(rq)->resid_len = data_len;
 
 	return scsi_init_io(cmd);
@@ -801,7 +802,7 @@ static int sd_setup_write_same10_cmnd(struct scsi_cmnd *cmd, bool unmap)
 
 	cmd->allowed = SD_MAX_RETRIES;
 	cmd->transfersize = data_len;
-	rq->timeout = SD_TIMEOUT;
+	rq->timeout = unmap ? SD_TIMEOUT : SD_WRITE_SAME_TIMEOUT;
 	scsi_req(rq)->resid_len = data_len;
 
 	return scsi_init_io(cmd);
@@ -857,11 +858,39 @@ static int sd_setup_ata_trim_cmnd(struct scsi_cmnd *cmd)
 	return scsi_init_io(cmd);
 }
 
+static int sd_setup_write_zeroes_cmnd(struct scsi_cmnd *cmd)
+{
+	struct request *rq = cmd->request;
+	struct scsi_device *sdp = cmd->device;
+	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
+	u64 sector = blk_rq_pos(rq) >> (ilog2(sdp->sector_size) - 9);
+	u32 nr_sectors = blk_rq_sectors(rq) >> (ilog2(sdp->sector_size) - 9);
+
+	if (sdp->ata_trim) {
+		if (!sdp->ata_trim_zeroes_data)
+			return BLKPREP_INVALID;
+		return sd_setup_ata_trim_cmnd(cmd);
+	}
+	if (sdp->no_write_same)
+		return BLKPREP_INVALID;
+	if (sdkp->ws16 || sector > 0xffffffff || nr_sectors > 0xffff)
+		return sd_setup_write_same16_cmnd(cmd, false);
+	return sd_setup_write_same10_cmnd(cmd, false);
+}
+
 static void sd_config_write_same(struct scsi_disk *sdkp)
 {
 	struct request_queue *q = sdkp->disk->queue;
 	unsigned int logical_block_size = sdkp->device->sector_size;
 
+	if (sdkp->device->ata_trim) {
+		if (sdkp->device->ata_trim_zeroes_data)
+			sdkp->max_ws_blocks = 65535 * (512 / sizeof(__le64));
+		else
+			sdkp->max_ws_blocks = 0;
+		goto config_write_zeroes;
+	}
+
 	if (sdkp->device->no_write_same) {
 		sdkp->max_ws_blocks = 0;
 		goto out;
@@ -886,6 +915,9 @@ static void sd_config_write_same(struct scsi_disk *sdkp)
 out:
 	blk_queue_max_write_same_sectors(q, sdkp->max_ws_blocks *
 					 (logical_block_size >> 9));
+config_write_zeroes:
+	blk_queue_max_write_zeroes_sectors(q, sdkp->max_ws_blocks *
+					 (logical_block_size >> 9));
 }
 
 /**
@@ -1226,7 +1258,7 @@ static int sd_init_command(struct scsi_cmnd *cmd)
 		case SD_LBP_UNMAP:
 			return sd_setup_unmap_cmnd(cmd);
 		case SD_LBP_WS16:
-			return sd_setup_write_same16_cmnd(cmd);
+			return sd_setup_write_same16_cmnd(cmd, true);
 		case SD_LBP_WS10:
 			return sd_setup_write_same10_cmnd(cmd, true);
 		case SD_LBP_ZERO:
@@ -1236,6 +1268,8 @@ static int sd_init_command(struct scsi_cmnd *cmd)
 		default:
 			return BLKPREP_INVALID;
 		}
+	case REQ_OP_WRITE_ZEROES:
+		return sd_setup_write_zeroes_cmnd(cmd);
 	case REQ_OP_WRITE_SAME:
 		return sd_setup_write_same_cmnd(cmd);
 	case REQ_OP_FLUSH:
@@ -1876,6 +1910,7 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 
 	switch (req_op(req)) {
 	case REQ_OP_DISCARD:
+	case REQ_OP_WRITE_ZEROES:
 	case REQ_OP_WRITE_SAME:
 	case REQ_OP_ZONE_RESET:
 		if (!result) {
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 92620c8ea8ad..1994f7799fce 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -329,6 +329,7 @@ void sd_zbc_complete(struct scsi_cmnd *cmd,
 
 	switch (req_op(rq)) {
 	case REQ_OP_WRITE:
+	case REQ_OP_WRITE_ZEROES:
 	case REQ_OP_WRITE_SAME:
 	case REQ_OP_ZONE_RESET:
 
-- 
2.11.0

