Return-Path: <BATV+625ba2f6da96caf54eae+7603+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D0F7942032B
	for <drbd-dev@lists.linbit.com>; Mon, 17 Jun 2024 08:05:54 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/26] sd: move zone limits setup out of
	sd_read_block_characteristics
Date: Mon, 17 Jun 2024 08:04:30 +0200
Message-ID: <20240617060532.127975-4-hch@lst.de>
In-Reply-To: <20240617060532.127975-1-hch@lst.de>
References: <20240617060532.127975-1-hch@lst.de>
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

Move a bit of code that sets up the zone flag and the write granularity
into sd_zbc_read_zones to be with the rest of the zoned limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c     | 21 +--------------------
 drivers/scsi/sd_zbc.c |  9 +++++++++
 2 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 664523048ce819..66f7d1e3429c86 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3312,29 +3312,10 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp,
 		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
 	}
 
-
-#ifdef CONFIG_BLK_DEV_ZONED /* sd_probe rejects ZBD devices early otherwise */
-	if (sdkp->device->type == TYPE_ZBC) {
-		lim->zoned = true;
-
-		/*
-		 * Per ZBC and ZAC specifications, writes in sequential write
-		 * required zones of host-managed devices must be aligned to
-		 * the device physical block size.
-		 */
-		lim->zone_write_granularity = sdkp->physical_block_size;
-	} else {
-		/*
-		 * Host-aware devices are treated as conventional.
-		 */
-		lim->zoned = false;
-	}
-#endif /* CONFIG_BLK_DEV_ZONED */
-
 	if (!sdkp->first_scan)
 		return;
 
-	if (lim->zoned)
+	if (sdkp->device->type == TYPE_ZBC)
 		sd_printk(KERN_NOTICE, sdkp, "Host-managed zoned block device\n");
 	else if (sdkp->zoned == 1)
 		sd_printk(KERN_NOTICE, sdkp, "Host-aware SMR disk used as regular disk\n");
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 8cc9c025017961..360ec980499529 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -601,6 +601,15 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, struct queue_limits *lim,
 	if (sdkp->device->type != TYPE_ZBC)
 		return 0;
 
+	lim->zoned = true;
+
+	/*
+	 * Per ZBC and ZAC specifications, writes in sequential write required
+	 * zones of host-managed devices must be aligned to the device physical
+	 * block size.
+	 */
+	lim->zone_write_granularity = sdkp->physical_block_size;
+
 	/* READ16/WRITE16/SYNC16 is mandatory for ZBC devices */
 	sdkp->device->use_16_for_rw = 1;
 	sdkp->device->use_10_for_rw = 0;
-- 
2.43.0

