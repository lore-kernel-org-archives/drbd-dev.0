Return-Path: <BATV+f1fc5bea56d51e2fc981+4960+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id ED6011058002
	for <drbd-dev@lists.linbit.com>; Thu, 23 Mar 2017 16:01:01 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Thu, 23 Mar 2017 10:33:30 -0400
Message-Id: <20170323143341.31549-13-hch@lst.de>
In-Reply-To: <20170323143341.31549-1-hch@lst.de>
References: <20170323143341.31549-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 12/23] sd: handle REQ_UNMAP
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
and the caller asks for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index b6f70a09a301..ca96bb33471b 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -871,6 +871,16 @@ static int sd_setup_write_zeroes_cmnd(struct scsi_cmnd *cmd)
 			return BLKPREP_INVALID;
 		return sd_setup_ata_trim_cmnd(cmd);
 	}
+
+	if (rq->cmd_flags & REQ_UNMAP) {
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

