Return-Path: <chaitanyak@nvidia.com>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
	(mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D77804202F3
	for <drbd-dev@lists.linbit.com>; Wed,  5 Oct 2022 07:18:13 +0200 (CEST)
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <ogeert@linux-m68k.org>, <linux-block@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
	<drbd-dev@lists.linbit.com>, <nbd@other.debian.org>,
	<linux-mtd@lists.infradead.org>
Date: Tue, 4 Oct 2022 22:00:21 -0700
Message-ID: <20221005050027.39591-13-kch@nvidia.com>
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
Subject: [Drbd-dev] [RFC PATCH 12/18] pf: use init disk helper
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
 drivers/block/paride/pf.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index eec1b9fde245..2950642402a8 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -937,15 +937,11 @@ static int __init pf_init_unit(struct pf_unit *pf, bool autoprobe, int port,
 		ret = PTR_ERR(disk);
 		goto out_free_tag_set;
 	}
-	disk->major = major;
-	disk->first_minor = pf - units;
-	disk->minors = 1;
 	strcpy(disk->disk_name, pf->name);
-	disk->fops = &pf_fops;
 	disk->flags |= GENHD_FL_NO_PART;
 	disk->events = DISK_EVENT_MEDIA_CHANGE;
-	disk->private_data = pf;
 
+	init_disk(disk, major, pf - units, 1, 0, pf, &pf_ops);
 	blk_queue_max_segments(disk->queue, cluster);
 	blk_queue_bounce_limit(disk->queue, BLK_BOUNCE_HIGH);
 
-- 
2.29.0

