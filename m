Return-Path: <chaitanyak@nvidia.com>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
	(mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B45F742037C
	for <drbd-dev@lists.linbit.com>; Wed,  5 Oct 2022 07:18:44 +0200 (CEST)
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <ogeert@linux-m68k.org>, <linux-block@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
	<drbd-dev@lists.linbit.com>, <nbd@other.debian.org>,
	<linux-mtd@lists.infradead.org>
Date: Tue, 4 Oct 2022 22:00:23 -0700
Message-ID: <20221005050027.39591-15-kch@nvidia.com>
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
Subject: [Drbd-dev] [RFC PATCH 14/18] rnbd-clt: use init disk helper
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
 drivers/block/rnbd/rnbd-clt.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 78334da74d8b..4f29364a6f4d 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1369,12 +1369,7 @@ static int rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev,
 {
 	int err;
 
-	dev->gd->major		= rnbd_client_major;
-	dev->gd->first_minor	= idx << RNBD_PART_BITS;
-	dev->gd->minors		= 1 << RNBD_PART_BITS;
-	dev->gd->fops		= &rnbd_client_ops;
 	dev->gd->queue		= dev->queue;
-	dev->gd->private_data	= dev;
 	snprintf(dev->gd->disk_name, sizeof(dev->gd->disk_name), "rnbd%d",
 		 idx);
 	pr_debug("disk_name=%s, capacity=%llu\n",
@@ -1382,7 +1377,9 @@ static int rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev,
 		 le64_to_cpu(rsp->nsectors) *
 		 (le16_to_cpu(rsp->logical_block_size) / SECTOR_SIZE));
 
-	set_capacity(dev->gd, le64_to_cpu(rsp->nsectors));
+	init_disk(dev->gd, rnbd_client_major, idx << RNBD_PART_BITS,
+			1 << RNBD_PART_BITS, le64_to_cpu(rsp->nsectors), dev,
+			&rnbd_client_ops);
 
 	if (dev->access_mode == RNBD_ACCESS_RO)
 		set_disk_ro(dev->gd, true);
-- 
2.29.0

