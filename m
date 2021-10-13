Return-Path: <keescook@chromium.org>
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
	[209.85.216.45])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 03700420004
	for <drbd-dev@lists.linbit.com>; Wed, 13 Oct 2021 08:27:44 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id ls18so1389639pjb.3
	for <drbd-dev@lists.linbit.com>; Tue, 12 Oct 2021 23:27:44 -0700 (PDT)
Date: Tue, 12 Oct 2021 23:27:42 -0700
From: Kees Cook <keescook@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <202110122319.3029AE5AA@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
	<20211013051042.1065752-25-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-25-hch@lst.de>
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
Subject: Re: [Drbd-dev] [PATCH 24/29] block: add a sb_bdev_nr_blocks helper
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

On Wed, Oct 13, 2021 at 07:10:37AM +0200, Christoph Hellwig wrote:
> Add a helper to return the size of sb->s_bdev in sb->s_blocksize_bits
> based unites.  Note that SECTOR_SHIFT has to be open coded due to
> include dependency issues for now, but I have a plan to sort that out
> eventually.

Wouldn't that just need a quick lift into a new header file to be
included by genhd.h, blkev.h, and:

drivers/mtd/ssfdc.c:#define SECTOR_SHIFT                9
fs/hfsplus/hfsplus_raw.h:#define HFSPLUS_SECTOR_SHIFT         9

I think that's worth doing at some point in this series since genhd.h
already has existing open-coded "9"s. And, really, a *lot* of other
places too:

$ git grep -E '(<<|>>) 9' | grep -E '\b(block|blk|sector|bdev)\b' | wc -l
240

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/genhd.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 082a3e5fd8fa1..6eaef8fa78bcd 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -245,6 +245,12 @@ static inline sector_t get_capacity(struct gendisk *disk)
>  	return bdev_nr_sectors(disk->part0);
>  }
>  
> +static inline u64 sb_bdev_nr_blocks(struct super_block *sb)
> +{
> +	return bdev_nr_sectors(sb->s_bdev) >>
> +		(sb->s_blocksize_bits - 9 /* SECTOR_SHIFT */);
> +}
> +
>  int bdev_disk_changed(struct gendisk *disk, bool invalidate);
>  void blk_drop_partitions(struct gendisk *disk);
>  
> -- 
> 2.30.2
> 

-- 
Kees Cook
