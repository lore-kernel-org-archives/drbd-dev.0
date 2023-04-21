Return-Path: <mcgrof@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B94884252B9
	for <drbd-dev@lists.linbit.com>; Fri, 21 Apr 2023 22:22:45 +0200 (CEST)
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, hch@infradead.org, djwong@kernel.org,
	minchan@kernel.org, senozhatsky@chromium.org
Date: Fri, 21 Apr 2023 12:58:02 -0700
Message-Id: <20230421195807.2804512-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Cc: p.raghav@samsung.com, linux-xfs@vger.kernel.org, mcgrof@kernel.org,
	da.gomez@samsung.com, patches@lists.linux.dev,
	willy@infradead.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	dm-devel@redhat.com, hare@suse.de, linux-fsdevel@vger.kernel.org,
	kbusch@kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 0/5] block: simplify with PAGE_SECTORS_SHIFT
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

Based on linux-next next-20230421.

Luis Chamberlain (5):
  dm integrity: simplify by using PAGE_SECTORS_SHIFT
  drbd: use PAGE_SECTORS_SHIFT and PAGE_SECTORS
  iomap: simplify iomap_init() with PAGE_SECTORS
  dm bufio: simplify by using PAGE_SECTORS_SHIFT
  zram: use generic PAGE_SECTORS and PAGE_SECTORS_SHIFT

 drivers/block/drbd/drbd_bitmap.c |  4 ++--
 drivers/block/zram/zram_drv.c    | 12 ++++++------
 drivers/block/zram/zram_drv.h    |  2 --
 drivers/md/dm-bufio.c            |  4 ++--
 drivers/md/dm-integrity.c        | 10 +++++-----
 fs/iomap/buffered-io.c           |  2 +-
 6 files changed, 16 insertions(+), 18 deletions(-)

-- 
2.39.2

