Return-Path: <kari.argillander@gmail.com>
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
	[209.85.167.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1BB414202C4
	for <drbd-dev@lists.linbit.com>; Tue, 19 Oct 2021 03:04:19 +0200 (CEST)
Received: by mail-lf1-f51.google.com with SMTP id y26so3586686lfa.11
	for <drbd-dev@lists.linbit.com>; Mon, 18 Oct 2021 18:04:19 -0700 (PDT)
Date: Tue, 19 Oct 2021 04:04:16 +0300
From: Kari Argillander <kari.argillander@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Message-ID: <20211019010416.vgecxu6wnvwi7fii@kari-VirtualBox>
References: <20211018101130.1838532-1-hch@lst.de>
	<4a8c3a39-9cd3-5b2f-6d0f-a16e689755e6@kernel.dk>
	<20211018171843.GA3338@lst.de>
	<2f5dcf79-8419-45ff-c27c-68d43242ccfe@kernel.dk>
	<20211018174901.GA3990@lst.de>
	<e0784f3e-46c8-c90c-870b-60cc2ed7a2da@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0784f3e-46c8-c90c-870b-60cc2ed7a2da@kernel.dk>
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net,
	Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	target-devel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com,
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
Subject: Re: [Drbd-dev] don't use ->bd_inode to access the block device size
	v3
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

On Mon, Oct 18, 2021 at 11:53:08AM -0600, Jens Axboe wrote:

snip..

> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 7b0326661a1e..a967b3fb3c71 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -236,14 +236,14 @@ static inline sector_t get_start_sect(struct block_device *bdev)
>  	return bdev->bd_start_sect;
>  }
>  
> -static inline loff_t bdev_nr_bytes(struct block_device *bdev)
> +static inline sector_t bdev_nr_sectors(struct block_device *bdev)
>  {
> -	return i_size_read(bdev->bd_inode);
> +	return bdev->bd_nr_sectors;
>  }
>  
> -static inline sector_t bdev_nr_sectors(struct block_device *bdev)
> +static inline loff_t bdev_nr_bytes(struct block_device *bdev)
>  {
> -	return bdev_nr_bytes(bdev) >> SECTOR_SHIFT;
> +	return bdev_nr_setors(bdev) << SECTOR_SHIFT;

setors -> sectors

>  }
>  
>  static inline sector_t get_capacity(struct gendisk *disk)
> 
> -- 
> Jens Axboe
> 
