Return-Path: <BATV+9f6d5568987564775a8e+6744+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 52F114202D9
	for <drbd-dev@lists.linbit.com>; Wed,  9 Feb 2022 09:28:41 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, target-devel@vger.kernel.org,
	haris.iqbal@ionos.com, jinpu.wang@ionos.com, manoj@linux.ibm.com,
	mrochs@linux.ibm.com, ukrishn@linux.ibm.com
Date: Wed,  9 Feb 2022 09:28:22 +0100
Message-Id: <20220209082828.2629273-2-hch@lst.de>
In-Reply-To: <20220209082828.2629273-1-hch@lst.de>
References: <20220209082828.2629273-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com,
	linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 1/7] cxlflash: query write_zeroes limit for
	zeroing
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

The write_same and write_zeroes limits for SCSI are effectively the
same, so the current code works just fine.  But we plan to remove
REQ_OP_WRITE_SAME support, so switch to quering the write zeroes
limit for a zeroing WRITE SAME operation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/cxlflash/vlun.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/cxlflash/vlun.c b/drivers/scsi/cxlflash/vlun.c
index 01917b28cdb65..5c74dc7c22889 100644
--- a/drivers/scsi/cxlflash/vlun.c
+++ b/drivers/scsi/cxlflash/vlun.c
@@ -430,8 +430,8 @@ static int write_same16(struct scsi_device *sdev,
 	struct device *dev = &cfg->dev->dev;
 	const u32 s = ilog2(sdev->sector_size) - 9;
 	const u32 to = sdev->request_queue->rq_timeout;
-	const u32 ws_limit = blk_queue_get_max_sectors(sdev->request_queue,
-						       REQ_OP_WRITE_SAME) >> s;
+	const u32 ws_limit =
+		sdev->request_queue->limits.max_write_zeroes_sectors >> s;
 
 	cmd_buf = kzalloc(CMD_BUFSIZE, GFP_KERNEL);
 	scsi_cmd = kzalloc(MAX_COMMAND_SIZE, GFP_KERNEL);
-- 
2.30.2

