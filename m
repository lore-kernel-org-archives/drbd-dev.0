Return-Path: <mcgrof@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C00F7420AFF
	for <drbd-dev@lists.linbit.com>; Fri, 26 May 2023 09:33:46 +0200 (CEST)
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, hch@infradead.org, djwong@kernel.org,
	minchan@kernel.org, senozhatsky@chromium.org
Date: Fri, 26 May 2023 00:33:32 -0700
Message-Id: <20230526073336.344543-2-mcgrof@kernel.org>
In-Reply-To: <20230526073336.344543-1-mcgrof@kernel.org>
References: <20230526073336.344543-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Cc: p.raghav@samsung.com, linux-xfs@vger.kernel.org, rohan.puri@samsung.com,
	da.gomez@samsung.com, mcgrof@kernel.org, patches@lists.linux.dev,
	willy@infradead.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	dm-devel@redhat.com, hare@suse.de, linux-fsdevel@vger.kernel.org,
	rpuri.linux@gmail.com, kbusch@kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v2 1/5] block: annotate bdev_disk_changed()
	deprecation with a symbol namespace
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

This ensures no other users pop up by mistake easily and provides
us a with an easy vehicle to do the same with other routines should
we need it later.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/partitions/core.c         | 6 +-----
 drivers/block/loop.c            | 2 ++
 drivers/s390/block/dasd_genhd.c | 2 ++
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 49e0496ff23c..6f18444be4fe 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -690,11 +690,7 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
 
 	return ret;
 }
-/*
- * Only exported for loop and dasd for historic reasons.  Don't use in new
- * code!
- */
-EXPORT_SYMBOL_GPL(bdev_disk_changed);
+EXPORT_SYMBOL_NS_GPL(bdev_disk_changed, BLOCK_DEPRECATED);
 
 void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
 {
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bc31bb7072a2..50aa5b4c0c56 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -37,6 +37,8 @@
 #include <linux/spinlock.h>
 #include <uapi/linux/loop.h>
 
+MODULE_IMPORT_NS(BLOCK_DEPRECATED);
+
 /* Possible states of device */
 enum {
 	Lo_unbound,
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 998a961e1704..5ea244aec534 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -25,6 +25,8 @@
 
 #include "dasd_int.h"
 
+MODULE_IMPORT_NS(BLOCK_DEPRECATED);
+
 static unsigned int queue_depth = 32;
 static unsigned int nr_hw_queues = 4;
 
-- 
2.39.2

