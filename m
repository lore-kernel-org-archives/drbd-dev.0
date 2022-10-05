Return-Path: <chaitanyak@nvidia.com>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
	(mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 361744202F3
	for <drbd-dev@lists.linbit.com>; Wed,  5 Oct 2022 07:16:46 +0200 (CEST)
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <ogeert@linux-m68k.org>, <linux-block@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
	<drbd-dev@lists.linbit.com>, <nbd@other.debian.org>,
	<linux-mtd@lists.infradead.org>
Date: Tue, 4 Oct 2022 22:00:10 -0700
Message-ID: <20221005050027.39591-2-kch@nvidia.com>
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
Subject: [Drbd-dev] [RFC PATCH 01/18] block: add and use init disk helper
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
 block/genhd.c                 | 13 +++++++++++++
 drivers/block/null_blk/main.c | 12 ++++--------
 include/linux/blkdev.h        |  5 +++++
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 514395361d7c..701309a7388e 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1470,3 +1470,16 @@ void inc_diskseq(struct gendisk *disk)
 {
 	disk->diskseq = atomic64_inc_return(&diskseq);
 }
+
+void init_disk(struct gendisk *disk, int major, int first_minor,
+		int minors, sector_t sectors, void *private_data,
+		const struct block_device_operations *fops)
+{
+	disk->major = major;
+	disk->first_minor = first_minor;
+	disk->minors = minors;
+	set_capacity(disk, sectors);
+	disk->private_data = private_data;
+	disk->fops = fops;
+}
+EXPORT_SYMBOL_GPL(init_disk);
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 1f154f92f4c2..d31085c94fd3 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1871,18 +1871,14 @@ static int init_driver_queues(struct nullb *nullb)
 static int null_gendisk_register(struct nullb *nullb)
 {
 	sector_t size = ((sector_t)nullb->dev->size * SZ_1M) >> SECTOR_SHIFT;
+	const struct block_device_operations *fops;
 	struct gendisk *disk = nullb->disk;
 
-	set_capacity(disk, size);
-
-	disk->major		= null_major;
-	disk->first_minor	= nullb->index;
-	disk->minors		= 1;
 	if (queue_is_mq(nullb->q))
-		disk->fops		= &null_rq_ops;
+		fops		= &null_rq_ops;
 	else
-		disk->fops		= &null_bio_ops;
-	disk->private_data	= nullb;
+		fops		= &null_bio_ops;
+	init_disk(disk, null_major, nullb->index, 1, size, nullb, fops);
 	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
 
 	if (nullb->dev->zoned) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 49373d002631..cb9db857f890 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -757,6 +757,11 @@ static inline int __must_check add_disk(struct gendisk *disk)
 {
 	return device_add_disk(NULL, disk, NULL);
 }
+
+void init_disk(struct gendisk *disk, int major, int first_minor,
+		int minors, sector_t sectors, void *private_data,
+		const struct block_device_operations *fops);
+
 void del_gendisk(struct gendisk *gp);
 void invalidate_disk(struct gendisk *disk);
 void set_disk_ro(struct gendisk *disk, bool read_only);
-- 
2.29.0

