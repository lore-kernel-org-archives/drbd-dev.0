Return-Path: <keescook@chromium.org>
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
	[209.85.216.45])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CE024420FC8
	for <drbd-dev@lists.linbit.com>; Wed, 13 Oct 2021 08:39:27 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
	pf6-20020a17090b1d8600b0019fa884ab85so3639754pjb.5
	for <drbd-dev@lists.linbit.com>; Tue, 12 Oct 2021 23:39:27 -0700 (PDT)
Date: Tue, 12 Oct 2021 23:39:25 -0700
From: Kees Cook <keescook@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <202110122335.19348E8E8@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-1-hch@lst.de>
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
Subject: Re: [Drbd-dev] don't use ->bd_inode to access the block device size
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

On Wed, Oct 13, 2021 at 07:10:13AM +0200, Christoph Hellwig wrote:
> I wondered about adding a helper for looking at the size in byte units
> to avoid the SECTOR_SHIFT shifts in various places.  But given that
> I could not come up with a good name and block devices fundamentally
> work in sector size granularity I decided against that.

Without something like bdev_nr_bytes(), this series has 13 of 29 patches
actually _adding_ an open-coded calculation:

[PATCH 05/29] mtd/block2mtd: use bdev_nr_sectors instead of open coding it
[PATCH 06/29] nvmet: use bdev_nr_sectors instead of open coding it
[PATCH 07/29] target/iblock: use bdev_nr_sectors instead of open coding it
[PATCH 08/29] fs: use bdev_nr_sectors instead of open coding it in blkdev_max_block
[PATCH 11/29] btrfs: use bdev_nr_sectors instead of open coding it
[PATCH 16/29] jfs: use bdev_nr_sectors instead of open coding it
[PATCH 17/29] nfs/blocklayout: use bdev_nr_sectors instead of open coding it
[PATCH 18/29] nilfs2: use bdev_nr_sectors instead of open coding it
[PATCH 19/29] ntfs3: use bdev_nr_sectors instead of open coding it
[PATCH 20/29] pstore/blk: use bdev_nr_sectors instead of open coding it
[PATCH 21/29] reiserfs: use bdev_nr_sectors instead of open coding it
[PATCH 22/29] squashfs: use bdev_nr_sectors instead of open coding it
[PATCH 23/29] block: use bdev_nr_sectors instead of open coding it in blkdev_fallocate

I think it's well worth having that helper (or at least leaving these
alone). Otherwise, this is a lot of churn without a clear net benefit,
IMO.

The others look good to me, though!

-Kees

>
> Diffstat:
>  block/fops.c                        |    2 +-
>  drivers/block/drbd/drbd_int.h       |    3 +--
>  drivers/md/bcache/super.c           |    2 +-
>  drivers/md/bcache/util.h            |    4 ----
>  drivers/md/bcache/writeback.c       |    2 +-
>  drivers/md/dm-bufio.c               |    2 +-
>  drivers/md/dm-cache-metadata.c      |    2 +-
>  drivers/md/dm-cache-target.c        |    2 +-
>  drivers/md/dm-clone-target.c        |    2 +-
>  drivers/md/dm-dust.c                |    5 ++---
>  drivers/md/dm-ebs-target.c          |    2 +-
>  drivers/md/dm-era-target.c          |    2 +-
>  drivers/md/dm-exception-store.h     |    2 +-
>  drivers/md/dm-flakey.c              |    3 +--
>  drivers/md/dm-integrity.c           |    6 +++---
>  drivers/md/dm-linear.c              |    3 +--
>  drivers/md/dm-log-writes.c          |    4 ++--
>  drivers/md/dm-log.c                 |    2 +-
>  drivers/md/dm-mpath.c               |    2 +-
>  drivers/md/dm-raid.c                |    6 +++---
>  drivers/md/dm-switch.c              |    2 +-
>  drivers/md/dm-table.c               |    3 +--
>  drivers/md/dm-thin-metadata.c       |    2 +-
>  drivers/md/dm-thin.c                |    2 +-
>  drivers/md/dm-verity-target.c       |    3 +--
>  drivers/md/dm-writecache.c          |    2 +-
>  drivers/md/dm-zoned-target.c        |    2 +-
>  drivers/md/md.c                     |   26 +++++++++++---------------
>  drivers/mtd/devices/block2mtd.c     |    5 +++--
>  drivers/nvme/target/io-cmd-bdev.c   |    4 ++--
>  drivers/target/target_core_iblock.c |    5 +++--
>  fs/affs/super.c                     |    2 +-
>  fs/btrfs/dev-replace.c              |    2 +-
>  fs/btrfs/disk-io.c                  |    3 ++-
>  fs/btrfs/ioctl.c                    |    4 ++--
>  fs/btrfs/volumes.c                  |    7 ++++---
>  fs/buffer.c                         |    4 ++--
>  fs/cramfs/inode.c                   |    2 +-
>  fs/ext4/super.c                     |    2 +-
>  fs/fat/inode.c                      |    5 +----
>  fs/hfs/mdb.c                        |    2 +-
>  fs/hfsplus/wrapper.c                |    2 +-
>  fs/jfs/resize.c                     |    5 ++---
>  fs/jfs/super.c                      |    5 ++---
>  fs/nfs/blocklayout/dev.c            |    4 ++--
>  fs/nilfs2/ioctl.c                   |    2 +-
>  fs/nilfs2/super.c                   |    2 +-
>  fs/nilfs2/the_nilfs.c               |    3 ++-
>  fs/ntfs/super.c                     |    8 +++-----
>  fs/ntfs3/super.c                    |    3 +--
>  fs/pstore/blk.c                     |    4 ++--
>  fs/reiserfs/super.c                 |    7 ++-----
>  fs/squashfs/super.c                 |    5 +++--
>  fs/udf/lowlevel.c                   |    5 ++---
>  fs/udf/super.c                      |    9 +++------
>  include/linux/genhd.h               |    6 ++++++
>  56 files changed, 100 insertions(+), 117 deletions(-)

--
Kees Cook
