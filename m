Return-Path: <keescook@chromium.org>
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
	[209.85.215.175])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 97969420FEA
	for <drbd-dev@lists.linbit.com>; Wed, 13 Oct 2021 08:16:13 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id a73so1351643pge.0
	for <drbd-dev@lists.linbit.com>; Tue, 12 Oct 2021 23:16:13 -0700 (PDT)
Date: Tue, 12 Oct 2021 23:16:11 -0700
From: Kees Cook <keescook@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <202110122315.7CFF5F6@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
	<20211013051042.1065752-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-13-hch@lst.de>
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net,
	Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	target-devel@vger.kernel.org, linux-mtd@lists.infradead.org,
	reiserfs-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-ext4@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Coly Li <colyli@suse.de>, linux-raid@vger.kernel.org,
	linux-bcache@vger.kernel.org, David Sterba <dsterba@suse.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Anton Altaparmakov <anton@tuxera.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	linux-ntfs-dev@lists.sourceforge.net, Jan Kara <jack@suse.com>,
	linux-fsdevel@vger.kernel.org,
	Phillip Lougher <phillip@squashfs.org.uk>, ntfs3@lists.linux.dev,
	linux-btrfs@vger.kernel.org
Subject: Re: [Drbd-dev] [PATCH 12/29] cramfs: use bdev_nr_sectors instead of
 open coding it
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

On Wed, Oct 13, 2021 at 07:10:25AM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/cramfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index 2be65269a987c..3e44cc3ed0543 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -209,7 +209,7 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
>  		return read_buffers[i] + blk_offset;
>  	}
>  
> -	devsize = mapping->host->i_size >> PAGE_SHIFT;
> +	devsize = bdev_nr_sectors(sb->s_bdev) >> (PAGE_SHIFT - SECTOR_SHIFT);

I find this less readable than "bytes >> PAGE_SHIFT". I'd suggest this
use a new bdev_nr_bytes() helper.

-- 
Kees Cook
