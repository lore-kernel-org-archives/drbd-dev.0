Return-Path: <gulam.mohamed@oracle.com>
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
	[205.220.165.32])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B3C7B4201AD
	for <drbd-dev@lists.linbit.com>; Wed, 21 Dec 2022 07:23:22 +0100 (CET)
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: linux-block@vger.kernel.org
Date: Wed, 21 Dec 2022 04:05:05 +0000
Message-Id: <20221221040506.1174644-1-gulam.mohamed@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: nvdimm@lists.linux.dev, shminderjit.singh@oracle.com,
	linux-kernel@vger.kernel.org, song@kernel.org,
	dm-devel@redhat.com, ira.weiny@intel.com, agk@redhat.com,
	drbd-dev@lists.linbit.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, konrad.wilk@oracle.com,
	joe.jin@oracle.com, kent.overstreet@gmail.com, ngupta@vflare.org,
	kch@nvidia.com, senozhatsky@chromium.org,
	gulam.mohamed@oracle.com, snitzer@kernel.org, colyli@suse.de,
	linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
	dan.j.williams@intel.com, axboe@kernel.dk, martin.petersen@oracle.com,
	rajesh.sivaramasubramaniom@oracle.com,
	philipp.reisner@linbit.com, junxiao.bi@oracle.com,
	minchan@kernel.org, lars.ellenberg@linbit.com
Subject: [Drbd-dev] [PATCH for-6.2/block V3 1/2] block: Data type conversion
	for IO accounting
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

Change the data type of start and end time IO accounting variables in,
block layer, from "unsigned long" to "u64". This is to enable nano-seconds
granularity, in next commit, for the devices whose latency is less than
milliseconds.

Changes from V2 to V3
=====================
1. Changed all the required variables data-type to u64 as part of this
   first patch
2. Create a new setting '2' for iostats in sysfs in next patch
3. Change the code to get the ktime values when iostat=2 in next patch

Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
---
 block/blk-core.c              | 24 ++++++++++++------------
 block/blk.h                   |  2 +-
 drivers/block/drbd/drbd_int.h |  2 +-
 drivers/block/zram/zram_drv.c |  4 ++--
 drivers/md/bcache/request.c   | 10 +++++-----
 drivers/md/dm-core.h          |  2 +-
 drivers/md/dm.c               |  2 +-
 drivers/md/md.h               |  2 +-
 drivers/md/raid1.h            |  2 +-
 drivers/md/raid10.h           |  2 +-
 drivers/md/raid5.c            |  2 +-
 drivers/nvdimm/btt.c          |  2 +-
 drivers/nvdimm/pmem.c         |  2 +-
 include/linux/blk_types.h     |  2 +-
 include/linux/blkdev.h        | 12 ++++++------
 include/linux/part_stat.h     |  2 +-
 16 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 8ab21dd01cd1..5670032fe932 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -927,13 +927,13 @@ int iocb_bio_iopoll(struct kiocb *kiocb, struct io_comp_batch *iob,
 }
 EXPORT_SYMBOL_GPL(iocb_bio_iopoll);
 
-void update_io_ticks(struct block_device *part, unsigned long now, bool end)
+void update_io_ticks(struct block_device *part, u64 now, bool end)
 {
-	unsigned long stamp;
+	u64 stamp;
 again:
 	stamp = READ_ONCE(part->bd_stamp);
-	if (unlikely(time_after(now, stamp))) {
-		if (likely(try_cmpxchg(&part->bd_stamp, &stamp, now)))
+	if (unlikely(time_after64(now, stamp))) {
+		if (likely(try_cmpxchg64(&part->bd_stamp, &stamp, now)))
 			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
 	}
 	if (part->bd_partno) {
@@ -942,9 +942,9 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 	}
 }
 
-unsigned long bdev_start_io_acct(struct block_device *bdev,
-				 unsigned int sectors, enum req_op op,
-				 unsigned long start_time)
+u64 bdev_start_io_acct(struct block_device *bdev,
+			unsigned int sectors, enum req_op op,
+			u64 start_time)
 {
 	const int sgrp = op_stat_group(op);
 
@@ -965,7 +965,7 @@ EXPORT_SYMBOL(bdev_start_io_acct);
  *
  * Returns the start time that should be passed back to bio_end_io_acct().
  */
-unsigned long bio_start_io_acct(struct bio *bio)
+u64 bio_start_io_acct(struct bio *bio)
 {
 	return bdev_start_io_acct(bio->bi_bdev, bio_sectors(bio),
 				  bio_op(bio), jiffies);
@@ -973,11 +973,11 @@ unsigned long bio_start_io_acct(struct bio *bio)
 EXPORT_SYMBOL_GPL(bio_start_io_acct);
 
 void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
-		      unsigned long start_time)
+		      u64 start_time)
 {
 	const int sgrp = op_stat_group(op);
-	unsigned long now = READ_ONCE(jiffies);
-	unsigned long duration = now - start_time;
+	u64 now = READ_ONCE(jiffies);
+	u64 duration = (unsigned long)now -(unsigned long) start_time;
 
 	part_stat_lock();
 	update_io_ticks(bdev, now, true);
@@ -987,7 +987,7 @@ void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
 }
 EXPORT_SYMBOL(bdev_end_io_acct);
 
-void bio_end_io_acct_remapped(struct bio *bio, unsigned long start_time,
+void bio_end_io_acct_remapped(struct bio *bio, u64 start_time,
 			      struct block_device *orig_bdev)
 {
 	bdev_end_io_acct(orig_bdev, bio_op(bio), start_time);
diff --git a/block/blk.h b/block/blk.h
index 8900001946c7..8997435ad4a0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -341,7 +341,7 @@ static inline bool blk_do_io_stat(struct request *rq)
 	return (rq->rq_flags & RQF_IO_STAT) && !blk_rq_is_passthrough(rq);
 }
 
-void update_io_ticks(struct block_device *part, unsigned long now, bool end);
+void update_io_ticks(struct block_device *part, u64 now, bool end);
 
 static inline void req_set_nomerge(struct request_queue *q, struct request *req)
 {
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index ae713338aa46..8e4d3b2eb99d 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -236,7 +236,7 @@ struct drbd_request {
 	struct list_head req_pending_local;
 
 	/* for generic IO accounting */
-	unsigned long start_jif;
+	u64 start_jif;
 
 	/* for DRBD internal statistics */
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 966aab902d19..da28eb83e6ed 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1581,7 +1581,7 @@ static void __zram_make_request(struct zram *zram, struct bio *bio)
 	u32 index;
 	struct bio_vec bvec;
 	struct bvec_iter iter;
-	unsigned long start_time;
+	u64 start_time;
 
 	index = bio->bi_iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
 	offset = (bio->bi_iter.bi_sector &
@@ -1662,7 +1662,7 @@ static int zram_rw_page(struct block_device *bdev, sector_t sector,
 	u32 index;
 	struct zram *zram;
 	struct bio_vec bv;
-	unsigned long start_time;
+	u64 start_time;
 
 	if (PageTransHuge(page))
 		return -ENOTSUPP;
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 39c7b607f8aa..1f9bd20dcdcf 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -476,7 +476,7 @@ struct search {
 	unsigned int		cache_missed:1;
 
 	struct block_device	*orig_bdev;
-	unsigned long		start_time;
+	u64			start_time;
 
 	struct btree_op		op;
 	struct data_insert_op	iop;
@@ -714,7 +714,7 @@ static void search_free(struct closure *cl)
 
 static inline struct search *search_alloc(struct bio *bio,
 		struct bcache_device *d, struct block_device *orig_bdev,
-		unsigned long start_time)
+		u64 start_time)
 {
 	struct search *s;
 
@@ -1065,7 +1065,7 @@ static void cached_dev_nodata(struct closure *cl)
 
 struct detached_dev_io_private {
 	struct bcache_device	*d;
-	unsigned long		start_time;
+	u64			start_time;
 	bio_end_io_t		*bi_end_io;
 	void			*bi_private;
 	struct block_device	*orig_bdev;
@@ -1094,7 +1094,7 @@ static void detached_dev_end_io(struct bio *bio)
 }
 
 static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
-		struct block_device *orig_bdev, unsigned long start_time)
+		struct block_device *orig_bdev, u64 start_time)
 {
 	struct detached_dev_io_private *ddip;
 	struct cached_dev *dc = container_of(d, struct cached_dev, disk);
@@ -1173,7 +1173,7 @@ void cached_dev_submit_bio(struct bio *bio)
 	struct block_device *orig_bdev = bio->bi_bdev;
 	struct bcache_device *d = orig_bdev->bd_disk->private_data;
 	struct cached_dev *dc = container_of(d, struct cached_dev, disk);
-	unsigned long start_time;
+	u64    start_time;
 	int rw = bio_data_dir(bio);
 
 	if (unlikely((d->c && test_bit(CACHE_SET_IO_DISABLE, &d->c->flags)) ||
diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 6c6bd24774f2..e620fd878b08 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -284,7 +284,7 @@ struct dm_io {
 	unsigned short magic;
 	blk_short_t flags;
 	spinlock_t lock;
-	unsigned long start_time;
+	u64 start_time;
 	void *data;
 	struct dm_io *next;
 	struct dm_stats_aux stats_aux;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index e1ea3a7bd9d9..011a85ea40da 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -494,7 +494,7 @@ static bool bio_is_flush_with_data(struct bio *bio)
 static void dm_io_acct(struct dm_io *io, bool end)
 {
 	struct dm_stats_aux *stats_aux = &io->stats_aux;
-	unsigned long start_time = io->start_time;
+	u64 start_time = io->start_time;
 	struct mapped_device *md = io->md;
 	struct bio *bio = io->orig_bio;
 	unsigned int sectors;
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 554a9026669a..df73c1d1d960 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -711,7 +711,7 @@ struct md_thread {
 
 struct md_io_acct {
 	struct bio *orig_bio;
-	unsigned long start_time;
+	u64 start_time;
 	struct bio bio_clone;
 };
 
diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
index ebb6788820e7..0fb5a1148745 100644
--- a/drivers/md/raid1.h
+++ b/drivers/md/raid1.h
@@ -157,7 +157,7 @@ struct r1bio {
 	sector_t		sector;
 	int			sectors;
 	unsigned long		state;
-	unsigned long		start_time;
+	u64			start_time;
 	struct mddev		*mddev;
 	/*
 	 * original bio going to /dev/mdx
diff --git a/drivers/md/raid10.h b/drivers/md/raid10.h
index 8c072ce0bc54..4cf3eec89bf3 100644
--- a/drivers/md/raid10.h
+++ b/drivers/md/raid10.h
@@ -123,7 +123,7 @@ struct r10bio {
 	sector_t		sector;	/* virtual sector number */
 	int			sectors;
 	unsigned long		state;
-	unsigned long		start_time;
+	u64			start_time;
 	struct mddev		*mddev;
 	/*
 	 * original bio going to /dev/mdx
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 7b820b81d8c2..8f4364f4bda0 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5474,7 +5474,7 @@ static void raid5_align_endio(struct bio *bi)
 	struct r5conf *conf;
 	struct md_rdev *rdev;
 	blk_status_t error = bi->bi_status;
-	unsigned long start_time = md_io_acct->start_time;
+	u64 start_time = md_io_acct->start_time;
 
 	bio_put(bi);
 
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 0297b7882e33..8fc1d5da747c 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1442,7 +1442,7 @@ static void btt_submit_bio(struct bio *bio)
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 	struct btt *btt = bio->bi_bdev->bd_disk->private_data;
 	struct bvec_iter iter;
-	unsigned long start;
+	u64 start;
 	struct bio_vec bvec;
 	int err = 0;
 	bool do_acct;
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 96e6e9a5f235..b5b7a709e1ab 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -202,7 +202,7 @@ static void pmem_submit_bio(struct bio *bio)
 	int ret = 0;
 	blk_status_t rc = 0;
 	bool do_acct;
-	unsigned long start;
+	u64 start;
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 	struct pmem_device *pmem = bio->bi_bdev->bd_disk->private_data;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 99be590f952f..d3386ac3b470 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -41,7 +41,7 @@ struct block_device {
 	sector_t		bd_start_sect;
 	sector_t		bd_nr_sectors;
 	struct disk_stats __percpu *bd_stats;
-	unsigned long		bd_stamp;
+	u64			bd_stamp;
 	bool			bd_read_only;	/* read-only policy */
 	dev_t			bd_dev;
 	atomic_t		bd_openers;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2db2ad72af0f..ca94d690d292 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1433,14 +1433,14 @@ static inline void blk_wake_io_task(struct task_struct *waiter)
 		wake_up_process(waiter);
 }
 
-unsigned long bdev_start_io_acct(struct block_device *bdev,
+u64 bdev_start_io_acct(struct block_device *bdev,
 				 unsigned int sectors, enum req_op op,
-				 unsigned long start_time);
+				 u64 start_time);
 void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
-		unsigned long start_time);
+		u64 start_time);
 
-unsigned long bio_start_io_acct(struct bio *bio);
-void bio_end_io_acct_remapped(struct bio *bio, unsigned long start_time,
+u64 bio_start_io_acct(struct bio *bio);
+void bio_end_io_acct_remapped(struct bio *bio, u64 start_time,
 		struct block_device *orig_bdev);
 
 /**
@@ -1448,7 +1448,7 @@ void bio_end_io_acct_remapped(struct bio *bio, unsigned long start_time,
  * @bio:	bio to end account for
  * @start_time:	start time returned by bio_start_io_acct()
  */
-static inline void bio_end_io_acct(struct bio *bio, unsigned long start_time)
+static inline void bio_end_io_acct(struct bio *bio, u64 start_time)
 {
 	return bio_end_io_acct_remapped(bio, start_time, bio->bi_bdev);
 }
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index abeba356bc3f..85c50235693c 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -10,7 +10,7 @@ struct disk_stats {
 	unsigned long sectors[NR_STAT_GROUPS];
 	unsigned long ios[NR_STAT_GROUPS];
 	unsigned long merges[NR_STAT_GROUPS];
-	unsigned long io_ticks;
+	u64 io_ticks;
 	local_t in_flight[2];
 };
 
-- 
2.31.1

