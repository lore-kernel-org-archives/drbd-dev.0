Return-Path: <mcgrof@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BCA93420AFD
	for <drbd-dev@lists.linbit.com>; Fri, 26 May 2023 09:33:45 +0200 (CEST)
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, hch@infradead.org, djwong@kernel.org,
	minchan@kernel.org, senozhatsky@chromium.org
Date: Fri, 26 May 2023 00:33:31 -0700
Message-Id: <20230526073336.344543-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Cc: p.raghav@samsung.com, linux-xfs@vger.kernel.org, rohan.puri@samsung.com,
	da.gomez@samsung.com, mcgrof@kernel.org, patches@lists.linux.dev,
	willy@infradead.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	dm-devel@redhat.com, hare@suse.de, linux-fsdevel@vger.kernel.org,
	rpuri.linux@gmail.com, kbusch@kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v2 0/5] block: simplify with PAGE_SECTORS_SHIFT
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

A bit of block drivers have their own incantations with
PAGE_SHIFT - SECTOR_SHIFT. Just simplfy and use PAGE_SECTORS_SHIFT
all over.
                                                                                                                                                                                              
Based on linux-next next-20230525.

Changes since v1:

 o keep iomap math visibly simple
 o Add tags for Reviews/acks
 o rebase onto next-20230525

Luis Chamberlain (5):
  block: annotate bdev_disk_changed() deprecation with a symbol
    namespace
  drbd: use PAGE_SECTORS_SHIFT and PAGE_SECTORS
  iomap: simplify iomap_init() with PAGE_SECTORS
  dm bufio: simplify by using PAGE_SECTORS_SHIFT
  zram: use generic PAGE_SECTORS and PAGE_SECTORS_SHIFT

 block/partitions/core.c          |  6 +-----
 drivers/block/drbd/drbd_bitmap.c |  4 ++--
 drivers/block/loop.c             |  2 ++
 drivers/block/zram/zram_drv.c    | 12 ++++++------
 drivers/block/zram/zram_drv.h    |  2 --
 drivers/md/dm-bufio.c            |  4 ++--
 drivers/s390/block/dasd_genhd.c  |  2 ++
 fs/iomap/buffered-io.c           |  2 +-
 8 files changed, 16 insertions(+), 18 deletions(-)

-- 
2.39.2

