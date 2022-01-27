Return-Path: <BATV+759db8ec68a62f2c3d04+6731+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CF8C04205C6
	for <drbd-dev@lists.linbit.com>; Thu, 27 Jan 2022 07:36:00 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 27 Jan 2022 07:35:32 +0100
Message-Id: <20220127063546.1314111-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Pavel Begunkov <asml.silence@gmail.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] improve the bio cloning interface
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

this series changes the bio cloning interface to match the rest changes
to the bio allocation interface and passes the block_device and operation
to the cloning helpers.  In addition it renames the cloning helpers to
be more descriptive.

To get there it requires a bit of refactoring in the device mapper code.

Diffstat:
 Documentation/block/biodoc.rst   |    5 -
 block/bio-integrity.c            |    1 
 block/bio.c                      |  106 +++++++++++++-----------
 block/blk-crypto.c               |    1 
 block/blk-mq.c                   |    4 
 block/bounce.c                   |    3 
 drivers/block/drbd/drbd_req.c    |    5 -
 drivers/block/drbd/drbd_worker.c |    4 
 drivers/block/pktcdvd.c          |    4 
 drivers/md/bcache/request.c      |    6 -
 drivers/md/dm-cache-target.c     |   26 ++----
 drivers/md/dm-crypt.c            |   11 +-
 drivers/md/dm-zoned-target.c     |    3 
 drivers/md/dm.c                  |  167 ++++++++++++++-------------------------
 drivers/md/md-faulty.c           |    4 
 drivers/md/md-multipath.c        |    4 
 drivers/md/md.c                  |    5 -
 drivers/md/raid1.c               |   34 +++----
 drivers/md/raid10.c              |   16 +--
 drivers/md/raid5.c               |    4 
 fs/btrfs/extent_io.c             |    4 
 include/linux/bio.h              |    6 -
 22 files changed, 185 insertions(+), 238 deletions(-)
