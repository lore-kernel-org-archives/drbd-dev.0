Return-Path: <BATV+2fedbe304aabaf399917+7597+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id ED52A4207E1
	for <drbd-dev@lists.linbit.com>; Tue, 11 Jun 2024 08:29:49 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: move features flags into queue_limits
Date: Tue, 11 Jun 2024 07:19:00 +0200
Message-ID: <20240611051929.513387-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: nvdimm@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
	Song Liu <song@kernel.org>, linux-mtd@lists.infradead.org,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yu Kuai <yukuai3@huawei.com>, dm-devel@lists.linux.dev,
	linux-um@lists.infradead.org, Mike Snitzer <snitzer@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
	linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	xen-devel@lists.xenproject.org, ceph-devel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>, linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-mmc@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	virtualization@lists.linux.dev, Lars Ellenberg <lars.ellenberg@linbit.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
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

Hi all,

this is the third and last major series to convert settings to
queue_limits for this merge window.  After a bunch of prep patches to
get various drivers in shape, it moves all the queue_flags that specify
driver controlled features into the queue limits so that they can be
set atomically and are separated from the blk-mq internal flags.

Note that I've only Cc'ed the maintainers for drivers with non-mechanical
changes as the Cc list is already huge.

This series sits on top of the "convert the SCSI ULDs to the atomic queue
limits API v2" and "move integrity settings to queue_limits v2" series.

A git tree is available here:

    git://git.infradead.org/users/hch/block.git block-limit-flags

Gitweb:

    http://git.infradead.org/?p=users/hch/block.git;a=shortlog;h=refs/heads/block-limit-flags

Diffstat:
 Documentation/block/writeback_cache_control.rst |   67 +++++---
 arch/m68k/emu/nfblock.c                         |    1 
 arch/um/drivers/ubd_kern.c                      |    3 
 arch/xtensa/platforms/iss/simdisk.c             |    5 
 block/blk-core.c                                |    7 
 block/blk-flush.c                               |   36 ++--
 block/blk-mq-debugfs.c                          |   13 -
 block/blk-mq.c                                  |   42 +++--
 block/blk-settings.c                            |   46 ++----
 block/blk-sysfs.c                               |  118 ++++++++-------
 block/blk-wbt.c                                 |    4 
 block/blk.h                                     |    2 
 drivers/block/amiflop.c                         |    5 
 drivers/block/aoe/aoeblk.c                      |    1 
 drivers/block/ataflop.c                         |    5 
 drivers/block/brd.c                             |    6 
 drivers/block/drbd/drbd_main.c                  |    6 
 drivers/block/floppy.c                          |    3 
 drivers/block/loop.c                            |   79 +++++-----
 drivers/block/mtip32xx/mtip32xx.c               |    2 
 drivers/block/n64cart.c                         |    2 
 drivers/block/nbd.c                             |   24 +--
 drivers/block/null_blk/main.c                   |   13 -
 drivers/block/null_blk/zoned.c                  |    3 
 drivers/block/pktcdvd.c                         |    1 
 drivers/block/ps3disk.c                         |    8 -
 drivers/block/rbd.c                             |   12 -
 drivers/block/rnbd/rnbd-clt.c                   |   14 -
 drivers/block/sunvdc.c                          |    1 
 drivers/block/swim.c                            |    5 
 drivers/block/swim3.c                           |    5 
 drivers/block/ublk_drv.c                        |   21 +-
 drivers/block/virtio_blk.c                      |   37 ++--
 drivers/block/xen-blkfront.c                    |   33 +---
 drivers/block/zram/zram_drv.c                   |    6 
 drivers/cdrom/gdrom.c                           |    1 
 drivers/md/bcache/super.c                       |    9 -
 drivers/md/dm-table.c                           |  181 +++++-------------------
 drivers/md/dm-zone.c                            |    2 
 drivers/md/dm-zoned-target.c                    |    2 
 drivers/md/dm.c                                 |   13 -
 drivers/md/md.c                                 |   40 -----
 drivers/md/raid5.c                              |    6 
 drivers/mmc/core/block.c                        |   42 ++---
 drivers/mmc/core/queue.c                        |   20 +-
 drivers/mmc/core/queue.h                        |    3 
 drivers/mtd/mtd_blkdevs.c                       |    9 -
 drivers/nvdimm/btt.c                            |    4 
 drivers/nvdimm/pmem.c                           |   14 -
 drivers/nvme/host/core.c                        |   33 ++--
 drivers/nvme/host/multipath.c                   |   24 ---
 drivers/nvme/host/zns.c                         |    3 
 drivers/s390/block/dasd_genhd.c                 |    1 
 drivers/s390/block/dcssblk.c                    |    2 
 drivers/s390/block/scm_blk.c                    |    5 
 drivers/scsi/iscsi_tcp.c                        |    8 -
 drivers/scsi/scsi_lib.c                         |    5 
 drivers/scsi/sd.c                               |   60 +++----
 drivers/scsi/sd.h                               |    7 
 drivers/scsi/sd_zbc.c                           |   17 +-
 include/linux/blkdev.h                          |  119 +++++++++++----
 61 files changed, 556 insertions(+), 710 deletions(-)
