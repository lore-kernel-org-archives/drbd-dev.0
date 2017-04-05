Return-Path: <BATV+9cf0d970ddff402c2c33+4973+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CBEED1058000
	for <drbd-dev@lists.linbit.com>;
	Wed,  5 Apr 2017 19:39:38 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Wed,  5 Apr 2017 19:21:12 +0200
Message-Id: <20170405172125.22600-15-hch@lst.de>
In-Reply-To: <20170405172125.22600-1-hch@lst.de>
References: <20170405172125.22600-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 14/27] sd: implement unmapping Write Zeroes
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

Try to use a write same with unmap bit variant if the device supports it
and the caller allows for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/sd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index d8d9c0bdd93c..001593ed0444 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -803,6 +803,15 @@ static int sd_setup_write_zeroes_cmnd(struct scsi_cmnd *cmd)
 	u64 sector = blk_rq_pos(rq) >> (ilog2(sdp->sector_size) - 9);
 	u32 nr_sectors = blk_rq_sectors(rq) >> (ilog2(sdp->sector_size) - 9);
 
+	if (!(rq->cmd_flags & REQ_NOUNMAP)) {
+		switch (sdkp->provisioning_mode) {
+		case SD_LBP_WS16:
+			return sd_setup_write_same16_cmnd(cmd, true);
+		case SD_LBP_WS10:
+			return sd_setup_write_same10_cmnd(cmd, true);
+		}
+	}
+
 	if (sdp->no_write_same)
 		return BLKPREP_INVALID;
 	if (sdkp->ws16 || sector > 0xffffffff || nr_sectors > 0xffff)
-- 
2.11.0

