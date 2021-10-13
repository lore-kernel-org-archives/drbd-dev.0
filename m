Return-Path: <anand.jain@oracle.com>
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
	[205.220.177.32])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2B346420FCB
	for <drbd-dev@lists.linbit.com>; Wed, 13 Oct 2021 09:15:18 +0200 (CEST)
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20211013051042.1065752-1-hch@lst.de>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <6d96d52b-3a19-8e00-4089-c2483a4cdbcc@oracle.com>
Date: Wed, 13 Oct 2021 15:14:55 +0800
In-Reply-To: <20211013051042.1065752-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
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

On 13/10/2021 13:10, Christoph Hellwig wrote:
> Hi Jens,
> 
> various drivers currently poke directy at the block device inode, which
> is a bit of a mess.  This series cleans up the places that read the
> block device size to use the proper helpers.  I have separate patches
> for many of the other bd_inode uses, but this series is already big
> enough as-is,
> 
> I wondered about adding a helper for looking at the size in byte units
> to avoid the SECTOR_SHIFT shifts in various places.  But given that
> I could not come up with a good name and 


> block devices fundamentally
> work in sector size granularity I decided against that.

Yes.  However,  POV of its usage outside the block-layer, a wrapper 
helper is a lot better. No.? If you agree, how about naming it bdev_size()?

Thanks, Anand

> 
> Diffstat:
>   block/fops.c                        |    2 +-
>   drivers/block/drbd/drbd_int.h       |    3 +--
>   drivers/md/bcache/super.c           |    2 +-
>   drivers/md/bcache/util.h            |    4 ----
>   drivers/md/bcache/writeback.c       |    2 +-
>   drivers/md/dm-bufio.c               |    2 +-
>   drivers/md/dm-cache-metadata.c      |    2 +-
>   drivers/md/dm-cache-target.c        |    2 +-
>   drivers/md/dm-clone-target.c        |    2 +-
>   drivers/md/dm-dust.c                |    5 ++---
>   drivers/md/dm-ebs-target.c          |    2 +-
>   drivers/md/dm-era-target.c          |    2 +-
>   drivers/md/dm-exception-store.h     |    2 +-
>   drivers/md/dm-flakey.c              |    3 +--
>   drivers/md/dm-integrity.c           |    6 +++---
>   drivers/md/dm-linear.c              |    3 +--
>   drivers/md/dm-log-writes.c          |    4 ++--
>   drivers/md/dm-log.c                 |    2 +-
>   drivers/md/dm-mpath.c               |    2 +-
>   drivers/md/dm-raid.c                |    6 +++---
>   drivers/md/dm-switch.c              |    2 +-
>   drivers/md/dm-table.c               |    3 +--
>   drivers/md/dm-thin-metadata.c       |    2 +-
>   drivers/md/dm-thin.c                |    2 +-
>   drivers/md/dm-verity-target.c       |    3 +--
>   drivers/md/dm-writecache.c          |    2 +-
>   drivers/md/dm-zoned-target.c        |    2 +-
>   drivers/md/md.c                     |   26 +++++++++++---------------
>   drivers/mtd/devices/block2mtd.c     |    5 +++--
>   drivers/nvme/target/io-cmd-bdev.c   |    4 ++--
>   drivers/target/target_core_iblock.c |    5 +++--
>   fs/affs/super.c                     |    2 +-
>   fs/btrfs/dev-replace.c              |    2 +-
>   fs/btrfs/disk-io.c                  |    3 ++-
>   fs/btrfs/ioctl.c                    |    4 ++--
>   fs/btrfs/volumes.c                  |    7 ++++---
>   fs/buffer.c                         |    4 ++--
>   fs/cramfs/inode.c                   |    2 +-
>   fs/ext4/super.c                     |    2 +-
>   fs/fat/inode.c                      |    5 +----
>   fs/hfs/mdb.c                        |    2 +-
>   fs/hfsplus/wrapper.c                |    2 +-
>   fs/jfs/resize.c                     |    5 ++---
>   fs/jfs/super.c                      |    5 ++---
>   fs/nfs/blocklayout/dev.c            |    4 ++--
>   fs/nilfs2/ioctl.c                   |    2 +-
>   fs/nilfs2/super.c                   |    2 +-
>   fs/nilfs2/the_nilfs.c               |    3 ++-
>   fs/ntfs/super.c                     |    8 +++-----
>   fs/ntfs3/super.c                    |    3 +--
>   fs/pstore/blk.c                     |    4 ++--
>   fs/reiserfs/super.c                 |    7 ++-----
>   fs/squashfs/super.c                 |    5 +++--
>   fs/udf/lowlevel.c                   |    5 ++---
>   fs/udf/super.c                      |    9 +++------
>   include/linux/genhd.h               |    6 ++++++
>   56 files changed, 100 insertions(+), 117 deletions(-)
> 

