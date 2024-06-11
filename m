Return-Path: <BATV+2fedbe304aabaf399917+7597+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A8E724205F6
	for <drbd-dev@lists.linbit.com>; Tue, 11 Jun 2024 08:26:41 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/26] nbd: move setting the cache control flags to
	__nbd_set_size
Date: Tue, 11 Jun 2024 07:19:09 +0200
Message-ID: <20240611051929.513387-10-hch@lst.de>
In-Reply-To: <20240611051929.513387-1-hch@lst.de>
References: <20240611051929.513387-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: nvdimm@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
	Song Liu <song@kernel.org>, linux-mtd@lists.infradead.org,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yu Kuai <yukuai3@huawei.com>, dm-devel@lists.linux.dev,
	linux-um@lists.infradead.org, Mike Snitzer <snitzer@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
	linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	xen-devel@lists.xenproject.org, ceph-devel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>, linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-mmc@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	virtualization@lists.linux.dev, Lars Ellenberg <lars.ellenberg@linbit.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
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

Move setting the cache control flags in nbd in preparation for moving
these flags into the queue_limits structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/nbd.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ad887d614d5b3f..44b8c671921e5c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -342,6 +342,12 @@ static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 		lim.max_hw_discard_sectors = UINT_MAX;
 	else
 		lim.max_hw_discard_sectors = 0;
+	if (!(nbd->config->flags & NBD_FLAG_SEND_FLUSH))
+		blk_queue_write_cache(nbd->disk->queue, false, false);
+	else if (nbd->config->flags & NBD_FLAG_SEND_FUA)
+		blk_queue_write_cache(nbd->disk->queue, true, true);
+	else
+		blk_queue_write_cache(nbd->disk->queue, true, false);
 	lim.logical_block_size = blksize;
 	lim.physical_block_size = blksize;
 	error = queue_limits_commit_update(nbd->disk->queue, &lim);
@@ -1286,19 +1292,10 @@ static void nbd_bdev_reset(struct nbd_device *nbd)
 
 static void nbd_parse_flags(struct nbd_device *nbd)
 {
-	struct nbd_config *config = nbd->config;
-	if (config->flags & NBD_FLAG_READ_ONLY)
+	if (nbd->config->flags & NBD_FLAG_READ_ONLY)
 		set_disk_ro(nbd->disk, true);
 	else
 		set_disk_ro(nbd->disk, false);
-	if (config->flags & NBD_FLAG_SEND_FLUSH) {
-		if (config->flags & NBD_FLAG_SEND_FUA)
-			blk_queue_write_cache(nbd->disk->queue, true, true);
-		else
-			blk_queue_write_cache(nbd->disk->queue, true, false);
-	}
-	else
-		blk_queue_write_cache(nbd->disk->queue, false, false);
 }
 
 static void send_disconnects(struct nbd_device *nbd)
-- 
2.43.0

