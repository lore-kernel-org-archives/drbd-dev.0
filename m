Return-Path: <BATV+2c76b185713af36e7087+6121+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 9A1764203B3
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2020 07:24:33 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 27 May 2020 07:24:04 +0200
Message-Id: <20200527052419.403583-2-hch@lst.de>
In-Reply-To: <20200527052419.403583-1-hch@lst.de>
References: <20200527052419.403583-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-nvdimm@lists.01.org,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
	linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
	dm-devel@redhat.com, Nitin Gupta <ngupta@vflare.org>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/16] block: add disk/bio-based accounting
	helpers
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

Add two new helpers to simplify I/O accounting for bio based drivers.
Currently these drivers use the generic_start_io_acct and
generic_end_io_acct helpers which have very cumbersome calling
conventions, don't actually return the time they started accounting,
and try to deal with accounting for partitions, which can't happen
for bio based drivers.  The new helpers will be used to subsequently
replace uses of the old helpers.

The main API is the bio based wrappes in blkdev.h, but for zram
which wants to account rw_page based I/O lower level routines are
provided as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/blk-core.c       | 34 ++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 77e57c2e8d602..8973104f88d90 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1432,6 +1432,40 @@ void blk_account_io_start(struct request *rq, bool new_io)
 	part_stat_unlock();
 }
 
+unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
+		unsigned int op)
+{
+	struct hd_struct *part = &disk->part0;
+	const int sgrp = op_stat_group(op);
+	unsigned long now = READ_ONCE(jiffies);
+
+	part_stat_lock();
+	update_io_ticks(part, now, false);
+	part_stat_inc(part, ios[sgrp]);
+	part_stat_add(part, sectors[sgrp], sectors);
+	part_stat_local_inc(part, in_flight[op_is_write(op)]);
+	part_stat_unlock();
+
+	return now;
+}
+EXPORT_SYMBOL(disk_start_io_acct);
+
+void disk_end_io_acct(struct gendisk *disk, unsigned int op,
+		unsigned long start_time)
+{
+	struct hd_struct *part = &disk->part0;
+	const int sgrp = op_stat_group(op);
+	unsigned long now = READ_ONCE(jiffies);
+	unsigned long duration = now - start_time;
+
+	part_stat_lock();
+	update_io_ticks(part, now, true);
+	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
+	part_stat_local_dec(part, in_flight[op_is_write(op)]);
+	part_stat_unlock();
+}
+EXPORT_SYMBOL(disk_end_io_acct);
+
 /*
  * Steal bios from a request and add them to a bio list.
  * The request must not have been partially completed before.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7d10f4e632325..6f7ff0fa8fcf8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1892,4 +1892,32 @@ static inline void blk_wake_io_task(struct task_struct *waiter)
 		wake_up_process(waiter);
 }
 
+unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
+		unsigned int op);
+void disk_end_io_acct(struct gendisk *disk, unsigned int op,
+		unsigned long start_time);
+
+#ifdef CONFIG_BLOCK
+/**
+ * bio_start_io_acct - start I/O accounting for bio based drivers
+ * @bio:	bio to start account for
+ *
+ * Returns the start time that should be passed back to bio_end_io_acct().
+ */
+static inline unsigned long bio_start_io_acct(struct bio *bio)
+{
+	return disk_start_io_acct(bio->bi_disk, bio_sectors(bio), bio_op(bio));
+}
+
+/**
+ * bio_end_io_acct - end I/O accounting for bio based drivers
+ * @bio:	bio to end account for
+ * @start:	start time returned by bio_start_io_acct()
+ */
+static inline void bio_end_io_acct(struct bio *bio, unsigned long start_time)
+{
+	return disk_end_io_acct(bio->bi_disk, bio_op(bio), start_time);
+}
+#endif /* CONFIG_BLOCK */
+
 #endif
-- 
2.26.2

