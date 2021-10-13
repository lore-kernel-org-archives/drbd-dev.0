Return-Path: <BATV+5200d22377f13f7bc369+6625+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id F1CF4420FCD
	for <drbd-dev@lists.linbit.com>; Wed, 13 Oct 2021 07:27:44 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 13 Oct 2021 07:10:24 +0200
Message-Id: <20211013051042.1065752-12-hch@lst.de>
In-Reply-To: <20211013051042.1065752-1-hch@lst.de>
References: <20211013051042.1065752-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net,
	Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	target-devel@vger.kernel.org, linux-mtd@lists.infradead.org,
	reiserfs-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-ext4@vger.kernel.org, Kees Cook <keescook@chromium.org>,
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
Subject: [Drbd-dev] [PATCH 11/29] btrfs: use bdev_nr_sectors instead of open
	coding it
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

Use the proper helper to read the block device size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/dev-replace.c | 2 +-
 fs/btrfs/disk-io.c     | 3 ++-
 fs/btrfs/ioctl.c       | 4 ++--
 fs/btrfs/volumes.c     | 7 ++++---
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index d029be40ea6f0..67799b3132120 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -283,7 +283,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	}
 
 
-	if (i_size_read(bdev->bd_inode) <
+	if ((bdev_nr_sectors(bdev) << SECTOR_SHIFT) <
 	    btrfs_device_get_total_bytes(srcdev)) {
 		btrfs_err(fs_info,
 			  "target device is smaller than source device!");
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 355ea88d5c5f7..07983f7e66e9f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3740,7 +3740,8 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 	else if (ret)
 		return ERR_PTR(ret);
 
-	if (bytenr + BTRFS_SUPER_INFO_SIZE >= i_size_read(bdev->bd_inode))
+	if (bytenr + BTRFS_SUPER_INFO_SIZE >=
+	    (bdev_nr_sectors(bdev) << SECTOR_SHIFT))
 		return ERR_PTR(-EINVAL);
 
 	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index cc61813213d83..5e6589b6ad8e4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1730,7 +1730,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 	}
 
 	if (!strcmp(sizestr, "max"))
-		new_size = device->bdev->bd_inode->i_size;
+		new_size = bdev_nr_sectors(device->bdev) << SECTOR_SHIFT;
 	else {
 		if (sizestr[0] == '-') {
 			mod = -1;
@@ -1771,7 +1771,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 		ret = -EINVAL;
 		goto out_finish;
 	}
-	if (new_size > device->bdev->bd_inode->i_size) {
+	if (new_size > (bdev_nr_sectors(device->bdev) << SECTOR_SHIFT)) {
 		ret = -EFBIG;
 		goto out_finish;
 	}
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2ec3b8ac8fa35..11c5f9ec02511 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1286,7 +1286,7 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
 	pgoff_t index;
 
 	/* make sure our super fits in the device */
-	if (bytenr + PAGE_SIZE >= i_size_read(bdev->bd_inode))
+	if (bytenr + PAGE_SIZE >= (bdev_nr_sectors(bdev) << SECTOR_SHIFT))
 		return ERR_PTR(-EINVAL);
 
 	/* make sure our super fits in the page */
@@ -2610,7 +2610,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	device->io_width = fs_info->sectorsize;
 	device->io_align = fs_info->sectorsize;
 	device->sector_size = fs_info->sectorsize;
-	device->total_bytes = round_down(i_size_read(bdev->bd_inode),
+	device->total_bytes = round_down(bdev_nr_sectors(bdev) << SECTOR_SHIFT,
 					 fs_info->sectorsize);
 	device->disk_total_bytes = device->total_bytes;
 	device->commit_total_bytes = device->total_bytes;
@@ -7236,7 +7236,8 @@ static int read_one_dev(struct extent_buffer *leaf,
 
 	fill_device_from_item(leaf, dev_item, device);
 	if (device->bdev) {
-		u64 max_total_bytes = i_size_read(device->bdev->bd_inode);
+		u64 max_total_bytes =
+			bdev_nr_sectors(device->bdev) << SECTOR_SHIFT;
 
 		if (device->total_bytes > max_total_bytes) {
 			btrfs_err(fs_info,
-- 
2.30.2

