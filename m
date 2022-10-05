Return-Path: <chaitanyak@nvidia.com>
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
	(mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1BE9D4202EE
	for <drbd-dev@lists.linbit.com>; Wed,  5 Oct 2022 07:20:10 +0200 (CEST)
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <ogeert@linux-m68k.org>, <linux-block@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
	<drbd-dev@lists.linbit.com>, <nbd@other.debian.org>,
	<linux-mtd@lists.infradead.org>
Date: Tue, 4 Oct 2022 22:00:25 -0700
Message-ID: <20221005050027.39591-17-kch@nvidia.com>
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
Subject: [Drbd-dev] [RFC PATCH 16/18] swim3: use init disk helper
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
 drivers/block/swim3.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index da811a7da03f..3c1b92b464d1 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1221,15 +1221,11 @@ static int swim3_attach(struct macio_dev *mdev,
 	if (rc)
 		goto out_cleanup_disk;
 
-	disk->major = FLOPPY_MAJOR;
-	disk->first_minor = floppy_count;
-	disk->minors = 1;
-	disk->fops = &floppy_fops;
-	disk->private_data = fs;
 	disk->events = DISK_EVENT_MEDIA_CHANGE;
 	disk->flags |= GENHD_FL_REMOVABLE | GENHD_FL_NO_PART;
 	sprintf(disk->disk_name, "fd%d", floppy_count);
-	set_capacity(disk, 2880);
+	init_disk(swd->unit[drive].disk, FLOPPY_MAJOR, floppy_count, 1, 2880,
+			&fs, &floopy_dops);
 	rc = add_disk(disk);
 	if (rc)
 		goto out_cleanup_disk;
-- 
2.29.0

