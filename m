Return-Path: <BATV+653fb0268b18c2e086a8+6630+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C901A420FDF
	for <drbd-dev@lists.linbit.com>; Mon, 18 Oct 2021 12:51:13 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Mon, 18 Oct 2021 12:11:27 +0200
Message-Id: <20211018101130.1838532-28-hch@lst.de>
In-Reply-To: <20211018101130.1838532-1-hch@lst.de>
References: <20211018101130.1838532-1-hch@lst.de>
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
	Dave Kleikamp <dave.kleikamp@oracle.com>, David Sterba <dsterba@suse.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Anton Altaparmakov <anton@tuxera.com>,
	linux-block@vger.kernel.org, linux-nfs@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	linux-ntfs-dev@lists.sourceforge.net, Jan Kara <jack@suse.com>,
	linux-fsdevel@vger.kernel.org,
	Phillip Lougher <phillip@squashfs.org.uk>, ntfs3@lists.linux.dev,
	linux-btrfs@vger.kernel.org
Subject: [Drbd-dev] [PATCH 27/30] jfs: use sb_bdev_nr_blocks
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

Use the sb_bdev_nr_blocks helper instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>
---
 fs/jfs/resize.c | 3 +--
 fs/jfs/super.c  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/jfs/resize.c b/fs/jfs/resize.c
index a42dbb0d3d28a..8b9a72ae5efa7 100644
--- a/fs/jfs/resize.c
+++ b/fs/jfs/resize.c
@@ -86,8 +86,7 @@ int jfs_extendfs(struct super_block *sb, s64 newLVSize, int newLogSize)
 		goto out;
 	}
 
-	VolumeSize = i_size_read(sb->s_bdev->bd_inode) >> sb->s_blocksize_bits;
-
+	VolumeSize = sb_bdev_nr_blocks(sb);
 	if (VolumeSize) {
 		if (newLVSize > VolumeSize) {
 			printk(KERN_WARNING "jfs_extendfs: invalid size\n");
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 9241caa161163..24cbc9946e01c 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -284,8 +284,7 @@ static int parse_options(char *options, struct super_block *sb, s64 *newLVSize,
 		}
 		case Opt_resize_nosize:
 		{
-			*newLVSize = i_size_read(sb->s_bdev->bd_inode) >>
-				sb->s_blocksize_bits;
+			*newLVSize = sb_bdev_nr_blocks(sb);
 			if (*newLVSize == 0)
 				pr_err("JFS: Cannot determine volume size\n");
 			break;
-- 
2.30.2

