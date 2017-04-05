Return-Path: <BATV+9cf0d970ddff402c2c33+4973+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B44E51057FCB
	for <drbd-dev@lists.linbit.com>;
	Wed,  5 Apr 2017 19:37:16 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Wed,  5 Apr 2017 19:21:25 +0200
Message-Id: <20170405172125.22600-28-hch@lst.de>
In-Reply-To: <20170405172125.22600-1-hch@lst.de>
References: <20170405172125.22600-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 27/27] scsi: sd: Remove LBPRZ dependency for
	discards
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

From: "Martin K. Petersen" <martin.petersen@oracle.com>

Separating discards and zeroout operations allows us to remove the LBPRZ
block zeroing constraints from discards and honor the device preferences
for UNMAP commands.

If supported by the device, we'll also choose UNMAP over one of the
WRITE SAME variants for discards.

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index acf9d17b05d8..8cf34a8e3eea 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -685,24 +685,11 @@ static void sd_config_discard(struct scsi_disk *sdkp, unsigned int mode)
 	unsigned int logical_block_size = sdkp->device->sector_size;
 	unsigned int max_blocks = 0;
 
-	/*
-	 * When LBPRZ is reported, discard alignment and granularity
-	 * must be fixed to the logical block size. Otherwise the block
-	 * layer will drop misaligned portions of the request which can
-	 * lead to data corruption. If LBPRZ is not set, we honor the
-	 * device preference.
-	 */
-	if (sdkp->lbprz) {
-		q->limits.discard_alignment = 0;
-		q->limits.discard_granularity = logical_block_size;
-	} else {
-		q->limits.discard_alignment = sdkp->unmap_alignment *
-			logical_block_size;
-		q->limits.discard_granularity =
-			max(sdkp->physical_block_size,
-			    sdkp->unmap_granularity * logical_block_size);
-	}
-
+	q->limits.discard_alignment =
+		sdkp->unmap_alignment * logical_block_size;
+	q->limits.discard_granularity =
+		max(sdkp->physical_block_size,
+		    sdkp->unmap_granularity * logical_block_size);
 	sdkp->provisioning_mode = mode;
 
 	switch (mode) {
@@ -2842,7 +2829,7 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 				sd_config_discard(sdkp, SD_LBP_WS16);
 
 		} else {	/* LBP VPD page tells us what to use */
-			if (sdkp->lbpu && sdkp->max_unmap_blocks && !sdkp->lbprz)
+			if (sdkp->lbpu && sdkp->max_unmap_blocks)
 				sd_config_discard(sdkp, SD_LBP_UNMAP);
 			else if (sdkp->lbpws)
 				sd_config_discard(sdkp, SD_LBP_WS16);
-- 
2.11.0

