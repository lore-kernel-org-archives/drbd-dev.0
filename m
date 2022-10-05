Return-Path: <chaitanyak@nvidia.com>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
	(mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 668674201A5
	for <drbd-dev@lists.linbit.com>; Wed,  5 Oct 2022 07:16:29 +0200 (CEST)
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <ogeert@linux-m68k.org>, <linux-block@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
	<drbd-dev@lists.linbit.com>, <nbd@other.debian.org>,
	<linux-mtd@lists.infradead.org>
Date: Tue, 4 Oct 2022 22:00:11 -0700
Message-ID: <20221005050027.39591-3-kch@nvidia.com>
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
Subject: [Drbd-dev] [RFC PATCH 02/18] nfblock: use init disk helper
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
 arch/m68k/emu/nfblock.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/emu/nfblock.c b/arch/m68k/emu/nfblock.c
index a708fbd5a844..81d3d3edace6 100644
--- a/arch/m68k/emu/nfblock.c
+++ b/arch/m68k/emu/nfblock.c
@@ -121,13 +121,9 @@ static int __init nfhd_init_one(int id, u32 blocks, u32 bsize)
 	if (!dev->disk)
 		goto free_dev;
 
-	dev->disk->major = major_num;
-	dev->disk->first_minor = dev_id * 16;
-	dev->disk->minors = 16;
-	dev->disk->fops = &nfhd_ops;
-	dev->disk->private_data = dev;
+	init_disk(dev->disk, major_num, dev_id * 16, 16,
+			(sector_t)blocks * (bsize / 512), dev, &nfhd_ops);
 	sprintf(dev->disk->disk_name, "nfhd%u", dev_id);
-	set_capacity(dev->disk, (sector_t)blocks * (bsize / 512));
 	blk_queue_logical_block_size(dev->disk->queue, bsize);
 	err = add_disk(dev->disk);
 	if (err)
-- 
2.29.0

