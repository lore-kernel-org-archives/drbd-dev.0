Return-Path: <chaitanyak@nvidia.com>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
	(mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5591B420668
	for <drbd-dev@lists.linbit.com>; Wed,  5 Oct 2022 07:16:52 +0200 (CEST)
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <ogeert@linux-m68k.org>, <linux-block@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
	<drbd-dev@lists.linbit.com>, <nbd@other.debian.org>,
	<linux-mtd@lists.infradead.org>
Date: Tue, 4 Oct 2022 22:00:16 -0700
Message-ID: <20221005050027.39591-8-kch@nvidia.com>
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
Subject: [Drbd-dev] [RFC PATCH 07/18] loop: use init disk helper
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
 drivers/block/loop.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ad92192c7d61..82cdb57ecd18 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2023,15 +2023,12 @@ static int loop_add(int i)
 	spin_lock_init(&lo->lo_work_lock);
 	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
 	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
-	disk->major		= LOOP_MAJOR;
-	disk->first_minor	= i << part_shift;
-	disk->minors		= 1 << part_shift;
-	disk->fops		= &lo_fops;
-	disk->private_data	= lo;
 	disk->queue		= lo->lo_queue;
 	disk->events		= DISK_EVENT_MEDIA_CHANGE;
 	disk->event_flags	= DISK_EVENT_FLAG_UEVENT;
 	sprintf(disk->disk_name, "loop%d", i);
+	init_disk(disk, LOOP_MAJOR, i << part_shift, 1 << part_shift, 0, lo,
+			&lo_fops);
 	/* Make this loop device reachable from pathname. */
 	err = add_disk(disk);
 	if (err)
-- 
2.29.0

