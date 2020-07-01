Return-Path: <BATV+501e1de201b53739768b+6156+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7EC094203F5
	for <drbd-dev@lists.linbit.com>; Wed,  1 Jul 2020 11:24:02 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  1 Jul 2020 11:06:18 +0200
Message-Id: <20200701090622.3354860-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, dm-devel@redhat.com,
	Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
	linux-btrfs@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] remove dead bdi congestion leftovers
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

we have a lot of bdi congestion related code that is left around without
any use.  This series removes it in preparation of sorting out the bdi
lifetime rules properly.

Diffstat:
 block/blk-cgroup.c               |   19 ----
 drivers/block/drbd/drbd_main.c   |   59 --------------
 drivers/block/drbd/drbd_proc.c   |    1 
 drivers/md/bcache/request.c      |   43 ----------
 drivers/md/bcache/super.c        |    1 
 drivers/md/dm-cache-target.c     |   19 ----
 drivers/md/dm-clone-target.c     |   15 ---
 drivers/md/dm-era-target.c       |   15 ---
 drivers/md/dm-raid.c             |   12 --
 drivers/md/dm-table.c            |   37 ---------
 drivers/md/dm-thin.c             |   16 ---
 drivers/md/dm.c                  |   33 --------
 drivers/md/dm.h                  |    1 
 drivers/md/md-linear.c           |   24 -----
 drivers/md/md-multipath.c        |   23 -----
 drivers/md/md.c                  |   23 -----
 drivers/md/md.h                  |    4 
 drivers/md/raid0.c               |   16 ---
 drivers/md/raid1.c               |   31 -------
 drivers/md/raid10.c              |   26 ------
 drivers/md/raid5.c               |   25 ------
 fs/btrfs/disk-io.c               |   23 -----
 include/linux/backing-dev-defs.h |   43 ----------
 include/linux/backing-dev.h      |   22 -----
 include/linux/blk-cgroup.h       |    6 -
 include/linux/device-mapper.h    |   11 --
 mm/backing-dev.c                 |  157 +++------------------------------------
 27 files changed, 20 insertions(+), 685 deletions(-)
