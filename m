Return-Path: <dave.kleikamp@oracle.com>
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
	[205.220.177.32])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id DD2A5421001
	for <drbd-dev@lists.linbit.com>; Wed, 13 Oct 2021 16:38:50 +0200 (CEST)
Message-ID: <b9fdcc41-2ec5-d628-968b-0aea1091cf9a@oracle.com>
Date: Wed, 13 Oct 2021 09:13:57 -0500
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20211013051042.1065752-1-hch@lst.de>
	<20211013051042.1065752-17-hch@lst.de>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20211013051042.1065752-17-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Cc: jfs-discussion@lists.sourceforge.net, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	target-devel@vger.kernel.org, linux-mtd@lists.infradead.org,
	reiserfs-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-ext4@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	David Sterba <dsterba@suse.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Anton Altaparmakov <anton@tuxera.com>,
	linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	linux-ntfs-dev@lists.sourceforge.net, Jan Kara <jack@suse.com>,
	linux-fsdevel@vger.kernel.org,
	Phillip Lougher <phillip@squashfs.org.uk>, ntfs3@lists.linux.dev,
	linux-btrfs@vger.kernel.org
Subject: Re: [Drbd-dev] [PATCH 16/29] jfs: use bdev_nr_sectors instead of
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

On 10/13/21 12:10AM, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>

> ---
>   fs/jfs/resize.c | 2 +-
>   fs/jfs/super.c  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jfs/resize.c b/fs/jfs/resize.c
> index bde787c354fcc..51a8b22e71030 100644
> --- a/fs/jfs/resize.c
> +++ b/fs/jfs/resize.c
> @@ -199,7 +199,7 @@ int jfs_extendfs(struct super_block *sb, s64 newLVSize, int newLogSize)
>   	txQuiesce(sb);
>   
>   	/* Reset size of direct inode */
> -	sbi->direct_inode->i_size =  i_size_read(sb->s_bdev->bd_inode);
> +	sbi->direct_inode->i_size = bdev_nr_sectors(sb->s_bdev) << SECTOR_SHIFT;
>   
>   	if (sbi->mntflag & JFS_INLINELOG) {
>   		/*
> diff --git a/fs/jfs/super.c b/fs/jfs/super.c
> index 9030aeaf0f886..992870160903d 100644
> --- a/fs/jfs/super.c
> +++ b/fs/jfs/super.c
> @@ -551,7 +551,7 @@ static int jfs_fill_super(struct super_block *sb, void *data, int silent)
>   		ret = -ENOMEM;
>   		goto out_unload;
>   	}
> -	inode->i_size = i_size_read(sb->s_bdev->bd_inode);
> +	inode->i_size = bdev_nr_sectors(sb->s_bdev) << SECTOR_SHIFT;
>   	inode->i_mapping->a_ops = &jfs_metapage_aops;
>   	inode_fake_hash(inode);
>   	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
> 
