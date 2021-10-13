Return-Path: <jack@suse.cz>
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 379F9421005
	for <drbd-dev@lists.linbit.com>; Wed, 13 Oct 2021 12:53:49 +0200 (CEST)
Date: Wed, 13 Oct 2021 12:43:43 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20211013104343.GF19200@quack2.suse.cz>
References: <20211013051042.1065752-1-hch@lst.de>
	<20211013051042.1065752-22-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-22-hch@lst.de>
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
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	linux-ntfs-dev@lists.sourceforge.net, Jan Kara <jack@suse.com>,
	linux-fsdevel@vger.kernel.org,
	Phillip Lougher <phillip@squashfs.org.uk>, ntfs3@lists.linux.dev,
	linux-btrfs@vger.kernel.org
Subject: Re: [Drbd-dev] [PATCH 21/29] reiserfs: use bdev_nr_sectors instead
 of open coding it
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

On Wed 13-10-21 07:10:34, Christoph Hellwig wrote:
> Use the proper helper to read the block device size and remove two
> cargo culted checks that can't be false.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/reiserfs/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
> index 58481f8d63d5b..6c9681e2809f0 100644
> --- a/fs/reiserfs/super.c
> +++ b/fs/reiserfs/super.c
> @@ -1986,8 +1986,7 @@ static int reiserfs_fill_super(struct super_block *s, void *data, int silent)
>  	 * smaller than the filesystem. If the check fails then abort and
>  	 * scream, because bad stuff will happen otherwise.
>  	 */
> -	if (s->s_bdev && s->s_bdev->bd_inode
> -	    && i_size_read(s->s_bdev->bd_inode) <
> +	if ((bdev_nr_sectors(s->s_bdev) << SECTOR_SHIFT) <
>  	    sb_block_count(rs) * sb_blocksize(rs)) {
>  		SWARN(silent, s, "", "Filesystem cannot be "
>  		      "mounted because it is bigger than the device");
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
