Return-Path: <BATV+717e4f5ff9d7c10515bf+6627+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E2C26420FAF
	for <drbd-dev@lists.linbit.com>; Fri, 15 Oct 2021 15:51:02 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Fri, 15 Oct 2021 15:26:41 +0200
Message-Id: <20211015132643.1621913-29-hch@lst.de>
In-Reply-To: <20211015132643.1621913-1-hch@lst.de>
References: <20211015132643.1621913-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net,
	Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	target-devel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
	drbd-dev@lists.linbit.com, linux-nilfs@vger.kernel.org,
	linux-scsi@vger.kernel.org, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
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
Subject: [Drbd-dev] [PATCH 28/30] ntfs: use sb_bdev_nr_blocks
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

Use the sb_bdev_nr_blocks helper instead of open coding it and clean up
ntfs_fill_super a bit by moving an assignment a little earlier that has
no negative side effects.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 fs/ntfs/super.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 0d7e948cb29c9..5ae8de09b271b 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -2772,13 +2772,12 @@ static int ntfs_fill_super(struct super_block *sb, void *opt, const int silent)
 	ntfs_debug("Set device block size to %i bytes (block size bits %i).",
 			blocksize, sb->s_blocksize_bits);
 	/* Determine the size of the device in units of block_size bytes. */
-	if (!i_size_read(sb->s_bdev->bd_inode)) {
+	vol->nr_blocks = sb_bdev_nr_blocks(sb);
+	if (!vol->nr_blocks) {
 		if (!silent)
 			ntfs_error(sb, "Unable to determine device size.");
 		goto err_out_now;
 	}
-	vol->nr_blocks = i_size_read(sb->s_bdev->bd_inode) >>
-			sb->s_blocksize_bits;
 	/* Read the boot sector and return unlocked buffer head to it. */
 	if (!(bh = read_ntfs_boot_sector(sb, silent))) {
 		if (!silent)
@@ -2816,8 +2815,7 @@ static int ntfs_fill_super(struct super_block *sb, void *opt, const int silent)
 			goto err_out_now;
 		}
 		BUG_ON(blocksize != sb->s_blocksize);
-		vol->nr_blocks = i_size_read(sb->s_bdev->bd_inode) >>
-				sb->s_blocksize_bits;
+		vol->nr_blocks = sb_bdev_nr_blocks(sb);
 		ntfs_debug("Changed device block size to %i bytes (block size "
 				"bits %i) to match volume sector size.",
 				blocksize, sb->s_blocksize_bits);
-- 
2.30.2

