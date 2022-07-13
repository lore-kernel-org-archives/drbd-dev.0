Return-Path: <BATV+c1a09d14d477e25aee4e+6898+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 881DC42097E
	for <drbd-dev@lists.linbit.com>; Wed, 13 Jul 2022 08:09:02 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 13 Jul 2022 07:53:17 +0200
Message-Id: <20220713055317.1888500-10-hch@lst.de>
In-Reply-To: <20220713055317.1888500-1-hch@lst.de>
References: <20220713055317.1888500-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Song Liu <song@kernel.org>, Mark Fasheh <mark@fasheh.com>,
	linux-raid@vger.kernel.org, Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Joel Becker <jlbec@evilplan.org>, Jan Kara <jack@suse.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	linux-ext4@vger.kernel.org, Jack Wang <jinpu.wang@ionos.com>,
	ocfs2-devel@oss.oracle.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 9/9] block: remove bdevname
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

Replace the remaining calls of bdevname with snprintf using the %pg
format specifier.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c           | 23 -----------------------
 drivers/md/md.c         |  2 +-
 drivers/md/raid1.c      |  2 +-
 drivers/md/raid10.c     |  2 +-
 fs/ext4/mmp.c           |  3 ++-
 fs/jbd2/journal.c       |  6 ++++--
 include/linux/blkdev.h  |  1 -
 kernel/trace/blktrace.c |  4 ++--
 8 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9d30f159c59ac..44dfcf67ed96a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -101,29 +101,6 @@ bool set_capacity_and_notify(struct gendisk *disk, sector_t size)
 }
 EXPORT_SYMBOL_GPL(set_capacity_and_notify);
 
-/*
- * Format the device name of the indicated block device into the supplied buffer
- * and return a pointer to that same buffer for convenience.
- *
- * Note: do not use this in new code, use the %pg specifier to sprintf and
- * printk insted.
- */
-const char *bdevname(struct block_device *bdev, char *buf)
-{
-	struct gendisk *hd = bdev->bd_disk;
-	int partno = bdev->bd_partno;
-
-	if (!partno)
-		snprintf(buf, BDEVNAME_SIZE, "%s", hd->disk_name);
-	else if (isdigit(hd->disk_name[strlen(hd->disk_name)-1]))
-		snprintf(buf, BDEVNAME_SIZE, "%sp%d", hd->disk_name, partno);
-	else
-		snprintf(buf, BDEVNAME_SIZE, "%s%d", hd->disk_name, partno);
-
-	return buf;
-}
-EXPORT_SYMBOL(bdevname);
-
 static void part_stat_read_all(struct block_device *part,
 		struct disk_stats *stat)
 {
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 076255ec9ba18..4be9d81730712 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2438,7 +2438,7 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 			mdname(mddev), mddev->max_disks);
 		return -EBUSY;
 	}
-	bdevname(rdev->bdev,b);
+	snprintf(b, sizeof(b), "%pg", rdev->bdev);
 	strreplace(b, '/', '!');
 
 	rdev->mddev = mddev;
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 258d4eb2d63c3..65cd90f0b2a8b 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1240,7 +1240,7 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 		rcu_read_lock();
 		rdev = rcu_dereference(conf->mirrors[r1_bio->read_disk].rdev);
 		if (rdev)
-			bdevname(rdev->bdev, b);
+			snprintf(b, sizeof(b), "%pg", rdev->bdev);
 		else
 			strcpy(b, "???");
 		rcu_read_unlock();
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index d589f823feb11..a7dcb1bf6b0a9 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1164,7 +1164,7 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 		disk = r10_bio->devs[slot].devnum;
 		err_rdev = rcu_dereference(conf->mirrors[disk].rdev);
 		if (err_rdev)
-			bdevname(err_rdev->bdev, b);
+			snprintf(b, sizeof(b), "%pg", err_rdev->bdev);
 		else {
 			strcpy(b, "???");
 			/* This never gets dereferenced */
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index b7a850b0070b8..b221f313ded6c 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -371,7 +371,8 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	EXT4_SB(sb)->s_mmp_bh = bh;
 
 	BUILD_BUG_ON(sizeof(mmp->mmp_bdevname) < BDEVNAME_SIZE);
-	bdevname(bh->b_bdev, mmp->mmp_bdevname);
+	snprintf(mmp->mmp_bdevname, sizeof(mmp->mmp_bdevname),
+		 "%pg", bh->b_bdev);
 
 	/*
 	 * Start a kernel thread to update the MMP block periodically.
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index c0cbeeaec2d1a..9015f5fa28620 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1465,7 +1465,8 @@ journal_t *jbd2_journal_init_dev(struct block_device *bdev,
 	if (!journal)
 		return NULL;
 
-	bdevname(journal->j_dev, journal->j_devname);
+	snprintf(journal->j_devname, sizeof(journal->j_devname),
+		 "%pg", journal->j_dev);
 	strreplace(journal->j_devname, '/', '!');
 	jbd2_stats_proc_init(journal);
 
@@ -1507,7 +1508,8 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
 		return NULL;
 
 	journal->j_inode = inode;
-	bdevname(journal->j_dev, journal->j_devname);
+	snprintf(journal->j_devname, sizeof(journal->j_devname),
+		 "%pg", journal->j_dev);
 	p = strreplace(journal->j_devname, '/', '!');
 	sprintf(p, "-%lu", journal->j_inode->i_ino);
 	jbd2_stats_proc_init(journal);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 22c477fadc0f3..2775763c51b99 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1457,7 +1457,6 @@ static inline void bio_end_io_acct(struct bio *bio, unsigned long start_time)
 int bdev_read_only(struct block_device *bdev);
 int set_blocksize(struct block_device *bdev, int size);
 
-const char *bdevname(struct block_device *bdev, char *buffer);
 int lookup_bdev(const char *pathname, dev_t *dev);
 
 void blkdev_show(struct seq_file *seqf, off_t offset);
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index c584effe5fe99..4752bda1b1a0c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -736,12 +736,12 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 
 	switch (cmd) {
 	case BLKTRACESETUP:
-		bdevname(bdev, b);
+		snprintf(b, sizeof(b), "%pg", bdev);
 		ret = __blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
 		break;
 #if defined(CONFIG_COMPAT) && defined(CONFIG_X86_64)
 	case BLKTRACESETUP32:
-		bdevname(bdev, b);
+		snprintf(b, sizeof(b), "%pg", bdev);
 		ret = compat_blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
 		break;
 #endif
-- 
2.30.2

