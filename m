Return-Path: <chaitanyak@nvidia.com>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
	(mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 25E21420960
	for <drbd-dev@lists.linbit.com>; Wed,  5 Oct 2022 07:18:23 +0200 (CEST)
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <ogeert@linux-m68k.org>, <linux-block@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
	<drbd-dev@lists.linbit.com>, <nbd@other.debian.org>,
	<linux-mtd@lists.infradead.org>
Date: Tue, 4 Oct 2022 22:00:22 -0700
Message-ID: <20221005050027.39591-14-kch@nvidia.com>
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
Subject: [Drbd-dev] [RFC PATCH 13/18] pktcdvd: use init disk helper
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
 drivers/block/pktcdvd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 4cea3b08087e..db8f4ca5c09c 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2698,13 +2698,9 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 	if (!disk)
 		goto out_mem;
 	pd->disk = disk;
-	disk->major = pktdev_major;
-	disk->first_minor = idx;
-	disk->minors = 1;
-	disk->fops = &pktcdvd_ops;
 	disk->flags = GENHD_FL_REMOVABLE | GENHD_FL_NO_PART;
 	strcpy(disk->disk_name, pd->name);
-	disk->private_data = pd;
+	init_disk(disk, pktdev_major, idx, 1, 0, pd, &pktcdvd_ops);
 
 	pd->pkt_dev = MKDEV(pktdev_major, idx);
 	ret = pkt_new_dev(pd, dev);
-- 
2.29.0

