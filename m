Return-Path: <jack@suse.cz>
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A630742036A
	for <drbd-dev@lists.linbit.com>; Tue,  4 Jul 2023 14:28:53 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-block@vger.kernel.org>
Date: Tue,  4 Jul 2023 14:21:28 +0200
Message-Id: <20230704122224.16257-1-jack@suse.cz>
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net,
	Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-nvme@lists.infradead.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>, dm-devel@redhat.com,
	target-devel@vger.kernel.org, linux-mtd@lists.infradead.org,
	Jack Wang <jinpu.wang@ionos.com>,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com,
	linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
	linux-scsi@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Christoph Hellwig <hch@infradead.org>,
	xen-devel@lists.xenproject.org, Gao Xiang <xiang@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-pm@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>, Chao Yu <chao@kernel.org>,
	Joern Engel <joern@lazybastard.org>,
	reiserfs-devel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-bcache@vger.kernel.org, David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>,
	linux-mm@kvack.org, Song Liu <song@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
	ocfs2-devel@oss.oracle.com, Anna Schumaker <anna@kernel.org>,
	linux-fsdevel@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Subject: [Drbd-dev] [PATCH 01/32] block: Provide blkdev_get_handle_*
	functions
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

Create struct bdev_handle that contains all parameters that need to be
passed to blkdev_put() and provide blkdev_get_handle_* functions that
return this structure instead of plain bdev pointer. This will
eventually allow us to pass one more argument to blkdev_put() without
too much hassle.

CC: Alasdair Kergon <agk@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Anna Schumaker <anna@kernel.org>
CC: Chao Yu <chao@kernel.org>
CC: Christian Borntraeger <borntraeger@linux.ibm.com>
CC: Coly Li <colyli@suse.de
CC: "Darrick J. Wong" <djwong@kernel.org>
CC: Dave Kleikamp <shaggy@kernel.org>
CC: David Sterba <dsterba@suse.com>
CC: dm-devel@redhat.com
CC: drbd-dev@lists.linbit.com
CC: Gao Xiang <xiang@kernel.org>
CC: Jack Wang <jinpu.wang@ionos.com>
CC: Jaegeuk Kim <jaegeuk@kernel.org>
CC: jfs-discussion@lists.sourceforge.net
CC: Joern Engel <joern@lazybastard.org>
CC: Joseph Qi <joseph.qi@linux.alibaba.com>
CC: Kent Overstreet <kent.overstreet@gmail.com>
CC: linux-bcache@vger.kernel.org
CC: linux-btrfs@vger.kernel.org
CC: linux-erofs@lists.ozlabs.org
CC: <linux-ext4@vger.kernel.org>
CC: linux-f2fs-devel@lists.sourceforge.net
CC: linux-mm@kvack.org
CC: linux-mtd@lists.infradead.org
CC: linux-nfs@vger.kernel.org
CC: linux-nilfs@vger.kernel.org
CC: linux-nvme@lists.infradead.org
CC: linux-pm@vger.kernel.org
CC: linux-raid@vger.kernel.org
CC: linux-s390@vger.kernel.org
CC: linux-scsi@vger.kernel.org
CC: linux-xfs@vger.kernel.org
CC: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
CC: Mike Snitzer <snitzer@kernel.org>
CC: Minchan Kim <minchan@kernel.org>
CC: ocfs2-devel@oss.oracle.com
CC: reiserfs-devel@vger.kernel.org
CC: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Song Liu <song@kernel.org>
CC: Sven Schnelle <svens@linux.ibm.com>
CC: target-devel@vger.kernel.org
CC: Ted Tso <tytso@mit.edu>
CC: Trond Myklebust <trond.myklebust@hammerspace.com>
CC: xen-devel@lists.xenproject.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c           | 47 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h | 10 +++++++++
 2 files changed, 57 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index 979e28a46b98..c75de5cac2bc 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -846,6 +846,24 @@ struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 }
 EXPORT_SYMBOL(blkdev_get_by_dev);
 
+struct bdev_handle *blkdev_get_handle_by_dev(dev_t dev, blk_mode_t mode,
+		void *holder, const struct blk_holder_ops *hops)
+{
+	struct bdev_handle *handle = kmalloc(sizeof(struct bdev_handle),
+					     GFP_KERNEL);
+	struct block_device *bdev;
+
+	if (!handle)
+		return ERR_PTR(-ENOMEM);
+	bdev = blkdev_get_by_dev(dev, mode, holder, hops);
+	if (IS_ERR(bdev))
+		return ERR_CAST(bdev);
+	handle->bdev = bdev;
+	handle->holder = holder;
+	return handle;
+}
+EXPORT_SYMBOL(blkdev_get_handle_by_dev);
+
 /**
  * blkdev_get_by_path - open a block device by name
  * @path: path to the block device to open
@@ -884,6 +902,28 @@ struct block_device *blkdev_get_by_path(const char *path, blk_mode_t mode,
 }
 EXPORT_SYMBOL(blkdev_get_by_path);
 
+struct bdev_handle *blkdev_get_handle_by_path(const char *path, blk_mode_t mode,
+		void *holder, const struct blk_holder_ops *hops)
+{
+	struct bdev_handle *handle;
+	dev_t dev;
+	int error;
+
+	error = lookup_bdev(path, &dev);
+	if (error)
+		return ERR_PTR(error);
+
+	handle = blkdev_get_handle_by_dev(dev, mode, holder, hops);
+	if (!IS_ERR(handle) && (mode & BLK_OPEN_WRITE) &&
+	    bdev_read_only(handle->bdev)) {
+		blkdev_handle_put(handle);
+		return ERR_PTR(-EACCES);
+	}
+
+	return handle;
+}
+EXPORT_SYMBOL(blkdev_get_handle_by_path);
+
 void blkdev_put(struct block_device *bdev, void *holder)
 {
 	struct gendisk *disk = bdev->bd_disk;
@@ -920,6 +960,13 @@ void blkdev_put(struct block_device *bdev, void *holder)
 }
 EXPORT_SYMBOL(blkdev_put);
 
+void blkdev_handle_put(struct bdev_handle *handle)
+{
+	blkdev_put(handle->bdev, handle->holder);
+	kfree(handle);
+}
+EXPORT_SYMBOL(blkdev_handle_put);
+
 /**
  * lookup_bdev() - Look up a struct block_device by name.
  * @pathname: Name of the block device in the filesystem.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ed44a997f629..a910e9997ddd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1471,14 +1471,24 @@ struct blk_holder_ops {
 #define sb_open_mode(flags) \
 	(BLK_OPEN_READ | (((flags) & SB_RDONLY) ? 0 : BLK_OPEN_WRITE))
 
+struct bdev_handle {
+	struct block_device *bdev;
+	void *holder;
+};
+
 struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
 struct block_device *blkdev_get_by_path(const char *path, blk_mode_t mode,
 		void *holder, const struct blk_holder_ops *hops);
+struct bdev_handle *blkdev_get_handle_by_dev(dev_t dev, blk_mode_t mode,
+		void *holder, const struct blk_holder_ops *hops);
+struct bdev_handle *blkdev_get_handle_by_path(const char *path, blk_mode_t mode,
+		void *holder, const struct blk_holder_ops *hops);
 int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 		const struct blk_holder_ops *hops);
 void bd_abort_claiming(struct block_device *bdev, void *holder);
 void blkdev_put(struct block_device *bdev, void *holder);
+void blkdev_handle_put(struct bdev_handle *handle);
 
 /* just for blk-cgroup, don't use elsewhere */
 struct block_device *blkdev_get_no_open(dev_t dev);
-- 
2.35.3

