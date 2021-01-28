Return-Path: <prvs=655a99766=chaitanya.kulkarni@wdc.com>
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CD7B642061C
	for <drbd-dev@lists.linbit.com>; Thu, 28 Jan 2021 08:18:47 +0100 (CET)
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	dm-devel@redhat.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
	xen-devel@lists.xenproject.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
	linux-pm@vger.kernel.org, linux-mm@kvack.org
Date: Wed, 27 Jan 2021 23:10:59 -0800
Message-Id: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: shaggy@kernel.org, sergey.senozhatsky.work@gmail.com, snitzer@redhat.com,
	tiwai@suse.de, djwong@kernel.org, gustavoars@kernel.org,
	joseph.qi@linux.alibaba.com, pavel@ucw.cz,
	alex.shi@linux.alibaba.com, hch@lst.de, agk@redhat.com,
	naohiro.aota@wdc.com, sagi@grimberg.me, mark@fasheh.com,
	osandov@fb.com, ebiggers@kernel.org, ngupta@vflare.org,
	len.brown@intel.com, chaitanya.kulkarni@wdc.com,
	konrad.wilk@oracle.com, hare@suse.de, ming.lei@redhat.com,
	viro@zeniv.linux.org.uk, jefflexu@linux.alibaba.com,
	jaegeuk@kernel.org, konishi.ryusuke@gmail.com,
	bvanassche@acm.org, axboe@kernel.dk, damien.lemoal@wdc.com,
	tytso@mit.edu, akpm@linux-foundation.org,
	martin.petersen@oracle.com, rjw@rjwysocki.net,
	philipp.reisner@linbit.com, minchan@kernel.org, tj@kernel.org,
	lars.ellenberg@linbit.com, jth@kernel.org,
	asml.silence@gmail.com, jlbec@evilplan.org, roger.pau@citrix.com
Subject: [Drbd-dev] [RFC PATCH 00/34] block: introduce bio_new()
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

Hi,

This is a *compile only RFC* which adds a generic helper to initialize
the various fields of the bio that is repeated all the places in
file-systems, block layer, and drivers.

The new helper allows callers to initialize non-optional members of bio
such as bdev, sector, op, opflags, max_bvecs and gfp_mask by
encapsulating new bio allocation with bio alloc with initialization
at one place.

The objective of this RFC is to only start a discussion, this it not 
completely tested at all.

-ck                         

Chaitanya Kulkarni (34):
  block: move common code into blk_next_bio()
  block: introduce and use bio_new
  drdb: use bio_new in drdb
  drdb: use bio_new() in submit_one_flush
  xen-blkback: use bio_new
  zram: use bio_new
  dm: use bio_new in dm-log-writes
  dm-zoned: use bio_new in get_mblock_slow
  dm-zoned: use bio_new in dmz_write_mblock
  dm-zoned: use bio_new in dmz_rdwr_block
  nvmet: use bio_new in nvmet_bdev_execute_rw
  scsi: target/iblock: use bio_new
  block: use bio_new in __blkdev_direct_IO
  fs/buffer: use bio_new in submit_bh_wbc
  fscrypt: use bio_new in fscrypt_zeroout_range
  fs/direct-io: use bio_new in dio_bio_alloc
  iomap: use bio_new in iomap_dio_zero
  iomap: use bio_new in iomap_dio_bio_actor
  fs/jfs/jfs_logmgr.c: use bio_new in lbmRead
  fs/jfs/jfs_logmgr.c: use bio_new in lbmStartIO
  fs/jfs/jfs_metapage.c: use bio_new in metapage_writepage
  fs/jfs/jfs_metapage.c: use bio_new in metapage_readpage
  fs/mpage.c: use bio_new mpage_alloc
  fs/nilfs: use bio_new nilfs_alloc_seg_bio
  ocfs/cluster: use bio_new in dm-log-writes
  xfs: use bio_new in xfs_rw_bdev
  xfs: use bio_new in xfs_buf_ioapply_map
  zonefs: use bio_new
  power/swap: use bio_new in hib_submit_io
  hfsplus: use bio_new in hfsplus_submit_bio()
  iomap: use bio_new in iomap_readpage_actor
  mm: use bio_new in __swap_writepage
  mm: use bio_new in swap_readpage
  mm: add swap_bio_new common bio helper

 block/blk-lib.c                     | 34 ++++++++++-------------------
 block/blk-zoned.c                   |  4 +---
 block/blk.h                         |  5 +++--
 drivers/block/drbd/drbd_receiver.c  | 12 +++++-----
 drivers/block/xen-blkback/blkback.c | 20 +++++++++++------
 drivers/block/zram/zram_drv.c       |  5 ++---
 drivers/md/dm-log-writes.c          | 30 +++++++++----------------
 drivers/md/dm-zoned-metadata.c      | 18 +++++----------
 drivers/nvme/target/io-cmd-bdev.c   |  9 +++-----
 drivers/target/target_core_iblock.c |  5 ++---
 fs/block_dev.c                      |  6 ++---
 fs/buffer.c                         | 16 ++++++--------
 fs/crypto/bio.c                     |  5 ++---
 fs/direct-io.c                      |  6 ++---
 fs/hfsplus/wrapper.c                |  5 +----
 fs/iomap/buffered-io.c              | 12 +++++-----
 fs/iomap/direct-io.c                | 11 ++++------
 fs/jfs/jfs_logmgr.c                 | 13 ++++-------
 fs/jfs/jfs_metapage.c               | 15 +++++--------
 fs/mpage.c                          | 18 +++++----------
 fs/nilfs2/segbuf.c                  | 10 ++-------
 fs/ocfs2/cluster/heartbeat.c        |  6 ++---
 fs/xfs/xfs_bio_io.c                 |  7 ++----
 fs/xfs/xfs_buf.c                    |  6 ++---
 fs/zonefs/super.c                   |  6 ++---
 include/linux/bio.h                 | 25 +++++++++++++++++++++
 kernel/power/swap.c                 |  7 +++---
 mm/page_io.c                        | 30 +++++++++++++------------
 28 files changed, 151 insertions(+), 195 deletions(-)

-- 
2.22.1

