Return-Path: <chaitanyak@nvidia.com>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
	(mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 350FE42037C
	for <drbd-dev@lists.linbit.com>; Wed,  5 Oct 2022 07:16:50 +0200 (CEST)
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <ogeert@linux-m68k.org>, <linux-block@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
	<drbd-dev@lists.linbit.com>, <nbd@other.debian.org>,
	<linux-mtd@lists.infradead.org>
Date: Tue, 4 Oct 2022 22:00:12 -0700
Message-ID: <20221005050027.39591-4-kch@nvidia.com>
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
Subject: [Drbd-dev] [RFC PATCH 03/18] amiflop: use init disk helper
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
 drivers/block/amiflop.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 4c8b2ba579ee..40f220fd61a7 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1786,18 +1786,14 @@ static int fd_alloc_disk(int drive, int system)
 	if (IS_ERR(disk))
 		return PTR_ERR(disk);
 
-	disk->major = FLOPPY_MAJOR;
-	disk->first_minor = drive + system;
-	disk->minors = 1;
-	disk->fops = &floppy_fops;
 	disk->flags |= GENHD_FL_NO_PART;
 	disk->events = DISK_EVENT_MEDIA_CHANGE;
 	if (system)
 		sprintf(disk->disk_name, "fd%d_msdos", drive);
 	else
 		sprintf(disk->disk_name, "fd%d", drive);
-	disk->private_data = &unit[drive];
-	set_capacity(disk, 880 * 2);
+	init_disk(disk, FLOPPY_MAJOR, drive + system, 1, 880 * 2, &unit[drive],
+			&floppy_fops);
 
 	unit[drive].gendisk[system] = disk;
 	err = add_disk(disk);
-- 
2.29.0

