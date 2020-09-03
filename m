Return-Path: <BATV+0324f78733eae8ed4bec+6220+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AAB4D4250D0
	for <drbd-dev@lists.linbit.com>; Thu,  3 Sep 2020 07:59:49 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu,  3 Sep 2020 07:40:55 +0200
Message-Id: <20200903054104.228829-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	dm-devel@redhat.com, target-devel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] clean up is partition checks
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

this series add a new helepr to check if a struct block_device represents
a parition, and removes most direct access to ->bd_contained from
drivers.

Diffstat:
 Documentation/userspace-api/ioctl/hdio.rst |   24 ++++++++++++------------
 block/blk-lib.c                            |    2 +-
 block/genhd.c                              |    2 +-
 block/ioctl.c                              |    4 ++--
 block/scsi_ioctl.c                         |    2 +-
 drivers/block/drbd/drbd_main.c             |    2 --
 drivers/block/drbd/drbd_receiver.c         |    2 +-
 drivers/block/drbd/drbd_worker.c           |    2 +-
 drivers/ide/ide-ioctls.c                   |    4 ++--
 drivers/md/dm-table.c                      |    2 +-
 drivers/md/md.c                            |    9 ++++-----
 drivers/md/md.h                            |    2 +-
 drivers/mmc/core/block.c                   |    2 +-
 drivers/s390/block/dasd_ioctl.c            |    8 ++++----
 drivers/target/target_core_iblock.c        |    5 ++---
 fs/nfsd/blocklayout.c                      |    4 ++--
 include/linux/blkdev.h                     |    9 +++++++--
 kernel/trace/blktrace.c                    |    2 +-
 lib/vsprintf.c                             |    4 ++--
 19 files changed, 46 insertions(+), 45 deletions(-)
