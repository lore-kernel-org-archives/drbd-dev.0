Return-Path: <chaitanyak@nvidia.com>
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
	(mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7E441420962
	for <drbd-dev@lists.linbit.com>; Wed,  5 Oct 2022 07:18:54 +0200 (CEST)
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <ogeert@linux-m68k.org>, <linux-block@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
	<drbd-dev@lists.linbit.com>, <nbd@other.debian.org>,
	<linux-mtd@lists.infradead.org>
Date: Tue, 4 Oct 2022 22:00:19 -0700
Message-ID: <20221005050027.39591-11-kch@nvidia.com>
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
Subject: [Drbd-dev] [RFC PATCH 10/18] pcd: use init disk helper
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
 drivers/block/paride/pcd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index a5ab40784119..4474fd28a6de 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -923,15 +923,12 @@ static int pcd_init_unit(struct pcd_unit *cd, bool autoprobe, int port,
 	cd->info.speed = 0;
 	cd->info.capacity = 1;
 	cd->info.mask = 0;
-	disk->major = major;
-	disk->first_minor = unit;
-	disk->minors = 1;
 	strcpy(disk->disk_name, cd->name);	/* umm... */
-	disk->fops = &pcd_bdops;
 	disk->flags |= GENHD_FL_NO_PART;
 	disk->events = DISK_EVENT_MEDIA_CHANGE;
 	disk->event_flags = DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE;
 
+	init_disk(disk, major, unit, 1, 0, NULL, &pcd_bdops);
 	if (!pi_init(cd->pi, autoprobe, port, mode, unit, protocol, delay,
 			pcd_buffer, PI_PCD, verbose, cd->name)) {
 		ret = -ENODEV;
-- 
2.29.0

