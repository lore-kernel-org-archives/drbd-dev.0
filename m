Return-Path: <BATV+c1a09d14d477e25aee4e+6898+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 19F9A42097C
	for <drbd-dev@lists.linbit.com>; Wed, 13 Jul 2022 08:50:49 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 13 Jul 2022 07:53:08 +0200
Message-Id: <20220713055317.1888500-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Song Liu <song@kernel.org>, Mark Fasheh <mark@fasheh.com>,
	linux-raid@vger.kernel.org, Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Joel Becker <jlbec@evilplan.org>, Jan Kara <jack@suse.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	linux-ext4@vger.kernel.org, Jack Wang <jinpu.wang@ionos.com>,
	ocfs2-devel@oss.oracle.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] remove bdevname
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

this series removes the final uses and the implementation of the bdevname()
function.

Diffstat:
 block/bdev.c                        |   10 ++---
 block/blk-lib.c                     |    6 +--
 block/genhd.c                       |   23 ------------
 drivers/block/drbd/drbd_req.c       |    6 +--
 drivers/block/pktcdvd.c             |   10 +----
 drivers/block/rnbd/rnbd-srv-dev.c   |    1 
 drivers/block/rnbd/rnbd-srv-dev.h   |    1 
 drivers/block/rnbd/rnbd-srv-sysfs.c |    5 +-
 drivers/block/rnbd/rnbd-srv.c       |    9 ++---
 drivers/block/rnbd/rnbd-srv.h       |    3 -
 drivers/md/md.c                     |    2 -
 drivers/md/raid1.c                  |    2 -
 drivers/md/raid10.c                 |    2 -
 fs/ext4/mmp.c                       |    9 ++---
 fs/jbd2/journal.c                   |    6 ++-
 fs/ocfs2/cluster/heartbeat.c        |   64 ++++++++++++++++--------------------
 include/linux/blkdev.h              |    1 
 kernel/trace/blktrace.c             |    4 +-
 18 files changed, 62 insertions(+), 102 deletions(-)
