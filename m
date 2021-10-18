Return-Path: <BATV+653fb0268b18c2e086a8+6630+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B5ADA420FBB
	for <drbd-dev@lists.linbit.com>; Mon, 18 Oct 2021 12:11:56 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Mon, 18 Oct 2021 12:11:01 +0200
Message-Id: <20211018101130.1838532-2-hch@lst.de>
In-Reply-To: <20211018101130.1838532-1-hch@lst.de>
References: <20211018101130.1838532-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net,
	Jan Kara <jack@suse.cz>, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	target-devel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
	drbd-dev@lists.linbit.com, linux-nilfs@vger.kernel.org,
	linux-scsi@vger.kernel.org, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-ext4@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
	linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
	David Sterba <dsterba@suse.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Anton Altaparmakov <anton@tuxera.com>,
	linux-block@vger.kernel.org, linux-nfs@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	linux-ntfs-dev@lists.sourceforge.net, Jan Kara <jack@suse.com>,
	linux-fsdevel@vger.kernel.org,
	Phillip Lougher <phillip@squashfs.org.uk>, ntfs3@lists.linux.dev,
	linux-btrfs@vger.kernel.org
Subject: [Drbd-dev] [PATCH 01/30] block: move the SECTOR_SIZE related
	definitions to blk_types.h
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

Ensure these are always available for inlines in the various block layer
headers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 include/linux/blk_types.h | 17 +++++++++++++++++
 include/linux/blkdev.h    | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3b967053e9f5a..dc8da0c7fa09b 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -20,6 +20,23 @@ struct cgroup_subsys_state;
 typedef void (bio_end_io_t) (struct bio *);
 struct bio_crypt_ctx;
 
+/*
+ * The basic unit of block I/O is a sector. It is used in a number of contexts
+ * in Linux (blk, bio, genhd). The size of one sector is 512 = 2**9
+ * bytes. Variables of type sector_t represent an offset or size that is a
+ * multiple of 512 bytes. Hence these two constants.
+ */
+#ifndef SECTOR_SHIFT
+#define SECTOR_SHIFT 9
+#endif
+#ifndef SECTOR_SIZE
+#define SECTOR_SIZE (1 << SECTOR_SHIFT)
+#endif
+
+#define PAGE_SECTORS_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
+#define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
+#define SECTOR_MASK		(PAGE_SECTORS - 1)
+
 struct block_device {
 	sector_t		bd_start_sect;
 	struct disk_stats __percpu *bd_stats;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 17705c970d7e1..161496d1aced0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -571,23 +571,6 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 	return bdev->bd_disk->queue;	/* this is never NULL */
 }
 
-/*
- * The basic unit of block I/O is a sector. It is used in a number of contexts
- * in Linux (blk, bio, genhd). The size of one sector is 512 = 2**9
- * bytes. Variables of type sector_t represent an offset or size that is a
- * multiple of 512 bytes. Hence these two constants.
- */
-#ifndef SECTOR_SHIFT
-#define SECTOR_SHIFT 9
-#endif
-#ifndef SECTOR_SIZE
-#define SECTOR_SIZE (1 << SECTOR_SHIFT)
-#endif
-
-#define PAGE_SECTORS_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
-#define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
-#define SECTOR_MASK		(PAGE_SECTORS - 1)
-
 #ifdef CONFIG_BLK_DEV_ZONED
 
 /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
-- 
2.30.2

