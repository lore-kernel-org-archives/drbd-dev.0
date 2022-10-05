Return-Path: <chaitanyak@nvidia.com>
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
	(mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 036D24206CF
	for <drbd-dev@lists.linbit.com>; Wed,  5 Oct 2022 07:17:40 +0200 (CEST)
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <ogeert@linux-m68k.org>, <linux-block@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
	<drbd-dev@lists.linbit.com>, <nbd@other.debian.org>,
	<linux-mtd@lists.infradead.org>
Date: Tue, 4 Oct 2022 22:00:13 -0700
Message-ID: <20221005050027.39591-5-kch@nvidia.com>
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
Subject: [Drbd-dev] [RFC PATCH 04/18] brd: use init disk helper
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
 drivers/block/ataflop.c | 8 ++------
 drivers/block/brd.c     | 9 ++-------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 9deb4df6bdb8..cd70f7b329c4 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1997,15 +1997,11 @@ static int ataflop_alloc_disk(unsigned int drive, unsigned int type)
 	if (IS_ERR(disk))
 		return PTR_ERR(disk);
 
-	disk->major = FLOPPY_MAJOR;
-	disk->first_minor = drive + (type << 2);
-	disk->minors = 1;
 	sprintf(disk->disk_name, "fd%d", drive);
-	disk->fops = &floppy_fops;
 	disk->flags |= GENHD_FL_NO_PART;
 	disk->events = DISK_EVENT_MEDIA_CHANGE;
-	disk->private_data = &unit[drive];
-	set_capacity(disk, MAX_DISK_SIZE * 2);
+	init_disk(disk, FLOPPY_MAJOR, drive + (type << 2), 1,
+			MAX_DISK_SIZE * 2, &unit[drive], &floppy_fops);
 
 	unit[drive].disk[type] = disk;
 	return 0;
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 20acc4a1fd6d..f60fda36a813 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -392,14 +392,9 @@ static int brd_alloc(int i)
 	if (!disk)
 		goto out_free_dev;
 
-	disk->major		= RAMDISK_MAJOR;
-	disk->first_minor	= i * max_part;
-	disk->minors		= max_part;
-	disk->fops		= &brd_fops;
-	disk->private_data	= brd;
 	strscpy(disk->disk_name, buf, DISK_NAME_LEN);
-	set_capacity(disk, rd_size * 2);
-	
+	init_disk(disk, RAMDISK_MAJOR, i * max_part, max_part, rd_size * 2,
+			brd, &brd_fops);
 	/*
 	 * This is so fdisk will align partitions on 4k, because of
 	 * direct_access API needing 4k alignment, returning a PFN
-- 
2.29.0

