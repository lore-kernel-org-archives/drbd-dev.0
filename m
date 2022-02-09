Return-Path: <BATV+9f6d5568987564775a8e+6744+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 89F3742006B
	for <drbd-dev@lists.linbit.com>; Wed,  9 Feb 2022 09:28:37 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, target-devel@vger.kernel.org,
	haris.iqbal@ionos.com, jinpu.wang@ionos.com, manoj@linux.ibm.com,
	mrochs@linux.ibm.com, ukrishn@linux.ibm.com
Date: Wed,  9 Feb 2022 09:28:21 +0100
Message-Id: <20220209082828.2629273-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com,
	linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] remove REQ_OP_WRITE_SAME v2
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

Now that we are using REQ_OP_WRITE_ZEROES for all zeroing needs in the
kernel there is very little use left for REQ_OP_WRITE_SAME.  We only
have two callers left, and both just export optional protocol features
to remote systems: DRBD and the target code.

For the target code the only real use case was zeroing offload, which
is kept with this series, and for DRBD I suspect the same based on the
usage.

    git://git.infradead.org/users/hch/block.git delete-write-same

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/delete-write-same

Changes since v2:
 - split up
 - rebased ontop of five years of kernel change, including the totally
   pointless addition of REQ_OP_WRITE_SAME in rnbd

Changes from RFC:
 - add zeroing offload for the SCSI target.

Diffstat:
 block/blk-core.c                   |   13 -----
 block/blk-lib.c                    |   91 -------------------------------------
 block/blk-merge.c                  |   40 ----------------
 block/blk-settings.c               |   16 ------
 block/blk-sysfs.c                  |    8 ---
 block/blk-zoned.c                  |    1 
 block/blk.h                        |    1 
 block/bounce.c                     |    3 -
 drivers/block/drbd/drbd_main.c     |   31 +-----------
 drivers/block/drbd/drbd_nl.c       |   72 -----------------------------
 drivers/block/drbd/drbd_receiver.c |   47 ++-----------------
 drivers/block/drbd/drbd_req.c      |    1 
 drivers/block/drbd/drbd_worker.c   |    5 --
 drivers/block/rnbd/rnbd-clt.c      |    7 --
 drivers/block/rnbd/rnbd-clt.h      |    1 
 drivers/block/rnbd/rnbd-proto.h    |    6 --
 drivers/block/rnbd/rnbd-srv.c      |    3 -
 drivers/md/dm-core.h               |    1 
 drivers/md/dm-crypt.c              |    1 
 drivers/md/dm-ebs-target.c         |    1 
 drivers/md/dm-io.c                 |   22 --------
 drivers/md/dm-linear.c             |    1 
 drivers/md/dm-mpath.c              |    1 
 drivers/md/dm-rq.c                 |    3 -
 drivers/md/dm-stripe.c             |    4 -
 drivers/md/dm-table.c              |   29 -----------
 drivers/md/dm-zone.c               |    4 -
 drivers/md/dm.c                    |   15 ------
 drivers/md/md-linear.c             |    1 
 drivers/md/md-multipath.c          |    1 
 drivers/md/md.h                    |    7 --
 drivers/md/raid0.c                 |    2 
 drivers/md/raid1.c                 |    4 -
 drivers/md/raid10.c                |    1 
 drivers/md/raid5.c                 |    1 
 drivers/scsi/cxlflash/vlun.c       |    4 -
 drivers/scsi/sd.c                  |   75 ++----------------------------
 drivers/scsi/sd_zbc.c              |    2 
 include/linux/bio.h                |    3 -
 include/linux/blk_types.h          |    2 
 include/linux/blkdev.h             |   19 -------
 include/linux/device-mapper.h      |    6 --
 kernel/trace/blktrace.c            |    1 
 43 files changed, 30 insertions(+), 527 deletions(-)
