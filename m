Return-Path: <chaitanyak@nvidia.com>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
	(mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8E3BB4201A5
	for <drbd-dev@lists.linbit.com>; Wed,  5 Oct 2022 07:17:14 +0200 (CEST)
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <ogeert@linux-m68k.org>, <linux-block@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
	<drbd-dev@lists.linbit.com>, <nbd@other.debian.org>,
	<linux-mtd@lists.infradead.org>
Date: Tue, 4 Oct 2022 22:00:15 -0700
Message-ID: <20221005050027.39591-7-kch@nvidia.com>
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
Subject: [Drbd-dev] [RFC PATCH 06/18] floppy: use init disk helper
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
 drivers/block/floppy.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index ccad3d7b3ddd..7304fd87c038 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4516,18 +4516,14 @@ static int floppy_alloc_disk(unsigned int drive, unsigned int type)
 		return PTR_ERR(disk);
 
 	blk_queue_max_hw_sectors(disk->queue, 64);
-	disk->major = FLOPPY_MAJOR;
-	disk->first_minor = TOMINOR(drive) | (type << 2);
-	disk->minors = 1;
-	disk->fops = &floppy_fops;
 	disk->flags |= GENHD_FL_NO_PART;
 	disk->events = DISK_EVENT_MEDIA_CHANGE;
+	init_disk(disk, FLOPPY_MAJOR, TOMINOR(drive) | (type << 2), 1, 0,
+			(void *)(long)drive, &floppy_fops);
 	if (type)
 		sprintf(disk->disk_name, "fd%d_type%d", drive, type);
 	else
 		sprintf(disk->disk_name, "fd%d", drive);
-	/* to be cleaned up... */
-	disk->private_data = (void *)(long)drive;
 	disk->flags |= GENHD_FL_REMOVABLE;
 
 	disks[drive][type] = disk;
-- 
2.29.0

