Return-Path: <prvs=646552d04=chaitanya.kulkarni@wdc.com>
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A91A6420231
	for <drbd-dev@lists.linbit.com>; Tue, 19 Jan 2021 06:12:18 +0100 (CET)
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	cluster-devel@redhat.com
Date: Mon, 18 Jan 2021 21:05:54 -0800
Message-Id: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Cc: shaggy@kernel.org, jfs-discussion@lists.sourceforge.net, snitzer@redhat.com,
	gustavo@embeddedor.com, clm@fb.com, dm-devel@redhat.com,
	adilger.kernel@dilger.ca, hch@lst.de, agk@redhat.com,
	naohiro.aota@wdc.com, sagi@grimberg.me, darrick.wong@oracle.com,
	osandov@fb.com, kent.overstreet@gmail.com,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	josef@toxicpanda.com, efremov@linux.com, colyli@suse.de,
	tj@kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com,
	bvanassche@acm.org, agruenba@redhat.com, axboe@kernel.dk,
	damien.lemoal@wdc.com, tytso@mit.edu, martin.petersen@oracle.com,
	song@kernel.org, philipp.reisner@linbit.com,
	jefflexu@linux.alibaba.com, rpeterso@redhat.com,
	lars.ellenberg@linbit.com, jth@kernel.org, asml.silence@gmail.com
Subject: [Drbd-dev] [RFC PATCH 00/37] block: introduce bio_init_fields()
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

The new helper allows callers to initialize various members such as
bdev, sector, private, end io callback, io priority, and write hints.

The objective of this RFC is to only start a discussion, this it not 
completely tested at all.                                                                                                            
Following diff shows code level benefits of this helper :-
 38 files changed, 124 insertions(+), 236 deletions(-)

-ck

Chaitanya Kulkarni (37):
  block: introduce bio_init_fields() helper
  fs: use bio_init_fields in block_dev
  btrfs: use bio_init_fields in disk-io
  btrfs: use bio_init_fields in volumes
  ext4: use bio_init_fields in page_io
  gfs2: use bio_init_fields in lops
  gfs2: use bio_init_fields in meta_io
  gfs2: use bio_init_fields in ops_fstype
  iomap: use bio_init_fields in buffered-io
  iomap: use bio_init_fields in direct-io
  jfs: use bio_init_fields in logmgr
  zonefs: use bio_init_fields in append
  drdb: use bio_init_fields in actlog
  drdb: use bio_init_fields in bitmap
  drdb: use bio_init_fields in receiver
  floppy: use bio_init_fields
  pktcdvd: use bio_init_fields
  bcache: use bio_init_fields in journal
  bcache: use bio_init_fields in super
  bcache: use bio_init_fields in writeback
  dm-bufio: use bio_init_fields
  dm-crypt: use bio_init_fields
  dm-zoned: use bio_init_fields metadata
  dm-zoned: use bio_init_fields target
  dm-zoned: use bio_init_fields
  dm log writes: use bio_init_fields
  nvmet: use bio_init_fields in bdev-ns
  target: use bio_init_fields in iblock
  btrfs: use bio_init_fields in scrub
  fs: use bio_init_fields in buffer
  eros: use bio_init_fields in data
  eros: use bio_init_fields in zdata
  jfs: use bio_init_fields in metadata
  nfs: use bio_init_fields in blocklayout
  ocfs: use bio_init_fields in heartbeat
  xfs: use bio_init_fields in xfs_buf
  xfs: use bio_init_fields in xfs_log

 block/blk-lib.c                     | 13 +++++--------
 drivers/block/drbd/drbd_actlog.c    |  5 +----
 drivers/block/drbd/drbd_bitmap.c    |  5 +----
 drivers/block/drbd/drbd_receiver.c  | 11 +++--------
 drivers/block/floppy.c              |  5 +----
 drivers/block/pktcdvd.c             | 12 ++++--------
 drivers/md/bcache/journal.c         | 21 ++++++++-------------
 drivers/md/bcache/super.c           | 19 +++++--------------
 drivers/md/bcache/writeback.c       | 14 ++++++--------
 drivers/md/dm-bufio.c               |  5 +----
 drivers/md/dm-crypt.c               |  4 +---
 drivers/md/dm-log-writes.c          | 21 ++++++---------------
 drivers/md/dm-zoned-metadata.c      | 15 +++++----------
 drivers/md/dm-zoned-target.c        |  9 +++------
 drivers/md/md.c                     |  6 ++----
 drivers/nvme/target/io-cmd-bdev.c   |  4 +---
 drivers/target/target_core_iblock.c | 11 +++--------
 fs/block_dev.c                      | 17 +++++------------
 fs/btrfs/disk-io.c                  | 11 ++++-------
 fs/btrfs/scrub.c                    |  6 ++----
 fs/btrfs/volumes.c                  |  4 +---
 fs/buffer.c                         |  7 ++-----
 fs/erofs/data.c                     |  6 ++----
 fs/erofs/zdata.c                    |  9 +++------
 fs/ext4/page-io.c                   |  6 ++----
 fs/gfs2/lops.c                      |  6 ++----
 fs/gfs2/meta_io.c                   |  5 ++---
 fs/gfs2/ops_fstype.c                |  7 ++-----
 fs/iomap/buffered-io.c              |  5 ++---
 fs/iomap/direct-io.c                | 15 +++++----------
 fs/jfs/jfs_logmgr.c                 | 16 ++++------------
 fs/jfs/jfs_metapage.c               | 16 +++++++---------
 fs/nfs/blocklayout/blocklayout.c    |  8 ++------
 fs/ocfs2/cluster/heartbeat.c        |  4 +---
 fs/xfs/xfs_buf.c                    |  6 ++----
 fs/xfs/xfs_log.c                    |  6 ++----
 fs/zonefs/super.c                   |  7 +++----
 include/linux/bio.h                 | 13 +++++++++++++
 38 files changed, 124 insertions(+), 236 deletions(-)

-- 
2.22.1

