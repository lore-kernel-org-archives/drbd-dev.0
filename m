Return-Path: <BATV+717e4f5ff9d7c10515bf+6627+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 9F7E6420FAD
	for <drbd-dev@lists.linbit.com>; Fri, 15 Oct 2021 15:51:01 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Fri, 15 Oct 2021 15:26:42 +0200
Message-Id: <20211015132643.1621913-30-hch@lst.de>
In-Reply-To: <20211015132643.1621913-1-hch@lst.de>
References: <20211015132643.1621913-1-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 29/30] reiserfs: use sb_bdev_nr_blocks
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
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/reiserfs/super.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 8647a00434ea4..076f9ab943060 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -1199,9 +1199,7 @@ static int reiserfs_parse_options(struct super_block *s,
 
 			if (!strcmp(arg, "auto")) {
 				/* From JFS code, to auto-get the size. */
-				*blocks =
-				    i_size_read(s->s_bdev->bd_inode) >> s->
-				    s_blocksize_bits;
+				*blocks = sb_bdev_nr_blocks(s);
 			} else {
 				*blocks = simple_strtoul(arg, &p, 0);
 				if (*p != '\0') {
-- 
2.30.2

