Return-Path: <BATV+d9f98309abae8ab29895+6175+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B44F44203D2
	for <drbd-dev@lists.linbit.com>; Mon, 20 Jul 2020 09:52:02 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Mon, 20 Jul 2020 09:51:34 +0200
Message-Id: <20200720075148.172156-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-raid@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] bdi cleanups
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

Hi Jens,

this series contains a bunch of different BDI cleanups.  The biggest item
is to isolate block drivers from the BDI in preparation of changing the
lifetime of the block device BDI in a follow up series.

Note that this is based on top of the
"a fix and two cleanups around blk_stack_limits" series sent earlier.

Diffstat:
 block/blk-core.c              |    2 
 block/blk-integrity.c         |    4 
 block/blk-mq-debugfs.c        |    1 
 block/blk-settings.c          |    5 
 block/blk-sysfs.c             |  270 ++++++++++--------------------------------
 block/genhd.c                 |   13 +-
 drivers/block/aoe/aoeblk.c    |    2 
 drivers/block/brd.c           |    1 
 drivers/block/drbd/drbd_nl.c  |   18 --
 drivers/block/drbd/drbd_req.c |    4 
 drivers/block/rbd.c           |    2 
 drivers/block/zram/zram_drv.c |   17 --
 drivers/md/bcache/super.c     |    4 
 drivers/md/dm-table.c         |    9 -
 drivers/md/raid0.c            |   16 --
 drivers/md/raid10.c           |   46 ++-----
 drivers/md/raid5.c            |   31 ++--
 drivers/mmc/core/queue.c      |    3 
 drivers/nvdimm/btt.c          |    2 
 drivers/nvdimm/pmem.c         |    1 
 drivers/nvme/host/core.c      |    3 
 drivers/nvme/host/multipath.c |    9 -
 drivers/scsi/iscsi_tcp.c      |    4 
 fs/9p/vfs_file.c              |    2 
 fs/9p/vfs_super.c             |    4 
 fs/afs/super.c                |    1 
 fs/btrfs/disk-io.c            |    2 
 fs/fs-writeback.c             |    7 -
 fs/fuse/inode.c               |    4 
 fs/namei.c                    |    4 
 fs/nfs/super.c                |    9 -
 fs/super.c                    |    2 
 include/linux/backing-dev.h   |   76 +----------
 include/linux/blkdev.h        |    3 
 include/linux/drbd.h          |    1 
 include/linux/fs.h            |    2 
 mm/backing-dev.c              |   13 --
 mm/filemap.c                  |    4 
 mm/memcontrol.c               |    2 
 mm/memory-failure.c           |    2 
 mm/migrate.c                  |    2 
 mm/mmap.c                     |    2 
 mm/page-writeback.c           |   18 +-
 mm/page_io.c                  |    7 -
 mm/swapfile.c                 |    4 
 45 files changed, 180 insertions(+), 458 deletions(-)
