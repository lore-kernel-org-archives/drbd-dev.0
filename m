Return-Path: <chaitanyak@nvidia.com>
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
	(mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 335744201A5
	for <drbd-dev@lists.linbit.com>; Wed,  5 Oct 2022 07:16:24 +0200 (CEST)
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <ogeert@linux-m68k.org>, <linux-block@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
	<drbd-dev@lists.linbit.com>, <nbd@other.debian.org>,
	<linux-mtd@lists.infradead.org>
Date: Tue, 4 Oct 2022 22:00:17 -0700
Message-ID: <20221005050027.39591-9-kch@nvidia.com>
In-Reply-To: <20221005050027.39591-1-kch@nvidia.com>
References: <20221005050027.39591-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: axboe@kernel.dk, vincent.fu@samsung.com, ming.lei@redhat.com,
	kch@nvidia.com, vigneshr@ti.com, richard@nod.at,
	damien.lemoal@opensource.wdc.com, philipp.reisner@linbit.com,
	efremov@linux.com, josef@toxicpanda.com, mcgrof@kernel.org,
	haris.iqbal@ionos.com, hare@suse.de, miquel.raynal@bootlin.com,
	shinichiro.kawasaki@wdc.com, lars.ellenberg@linbit.com,
	johannes.thumshirn@wdc.com, jinpu.wang@ionos.com,
	tim@cyberelk.net, bvanassche@acm.org
Subject: [Drbd-dev] [RFC PATCH 08/18] n64cart: use init disk helper
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

Add and use the helper to initialize the common fields of struct gendisk
such as major, first_minor, minors, disk_name, private_data, and ops.
This initialization is spread all over the block drivers. This avoids
code repetation of inialization code of gendisk in current block drivers
and any future ones.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/n64cart.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/n64cart.c b/drivers/block/n64cart.c
index d914156db2d8..28b32fbe6586 100644
--- a/drivers/block/n64cart.c
+++ b/drivers/block/n64cart.c
@@ -135,14 +135,12 @@ static int __init n64cart_probe(struct platform_device *pdev)
 	if (!disk)
 		goto out;
 
-	disk->first_minor = 0;
 	disk->flags = GENHD_FL_NO_PART;
 	disk->fops = &n64cart_fops;
-	disk->private_data = &pdev->dev;
 	strcpy(disk->disk_name, "n64cart");
 
-	set_capacity(disk, size >> SECTOR_SHIFT);
 	set_disk_ro(disk, 1);
+	init_disk(disk, 0, 0, 0, size >> 9, &pdev->dev, &n64cart_fops);
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
 	blk_queue_physical_block_size(disk->queue, 4096);
-- 
2.29.0

