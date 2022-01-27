Return-Path: <neilb@suse.de>
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 140394207D1
	for <drbd-dev@lists.linbit.com>; Thu, 27 Jan 2022 03:52:38 +0100 (CET)
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@netapp.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>
Date: Thu, 27 Jan 2022 13:46:29 +1100
Message-ID: <164325106958.29787.4865219843242892726.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-ext4@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 0/9] Remove remaining parts of congestions
	tracking code.
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

Congestion hasn't been reliably tracked for quite some time.
Most MM uses of it for guiding writeback decisions were removed in 5.16.
Some other uses were removed in 17-rc1.

This series removes the remaining places that test for congestion, and
the few places which still set it.

The second patch touches a few filesystems.  I didn't think there was
much value in splitting this out by filesystems, but if maintainers
would rather I did that, I will.

The f2fs, cephfs, fuse, NFS, and block patches can go through the
respective trees proving the final patch doesn't land until after they
all do - so maybe it should be held for 5.18-rc2 if all the rest lands
by 5.18-rc1.

Thanks,
NeilBrown

---

NeilBrown (9):
      Remove inode_congested()
      Remove bdi_congested() and wb_congested() and related functions
      f2fs: change retry waiting for f2fs_write_single_data_page()
      f2f2: replace some congestion_wait() calls with io_schedule_timeout()
      cephfs: don't set/clear bdi_congestion
      fuse: don't set/clear bdi_congested
      NFS: remove congestion control.
      block/bfq-iosched.c: use "false" rather than "BLK_RW_ASYNC"
      Remove congestion tracking framework.


 block/bfq-iosched.c              |  2 +-
 drivers/block/drbd/drbd_int.h    |  3 --
 drivers/block/drbd/drbd_req.c    |  3 +-
 fs/ceph/addr.c                   | 27 ---------------
 fs/ceph/super.c                  |  2 --
 fs/ceph/super.h                  |  2 --
 fs/ext2/ialloc.c                 |  2 --
 fs/f2fs/compress.c               |  6 ++--
 fs/f2fs/data.c                   |  9 +++--
 fs/f2fs/segment.c                | 14 ++++----
 fs/f2fs/super.c                  |  8 ++---
 fs/fuse/control.c                | 17 ----------
 fs/fuse/dev.c                    |  8 -----
 fs/nfs/sysctl.c                  |  7 ----
 fs/nfs/write.c                   | 53 +----------------------------
 fs/nilfs2/segbuf.c               | 11 ------
 fs/xfs/xfs_buf.c                 |  3 --
 include/linux/backing-dev-defs.h |  8 -----
 include/linux/backing-dev.h      | 28 ----------------
 include/linux/nfs_fs.h           |  1 -
 include/linux/nfs_fs_sb.h        |  1 -
 include/trace/events/writeback.h | 28 ----------------
 mm/backing-dev.c                 | 57 --------------------------------
 mm/vmscan.c                      |  4 +--
 24 files changed, 25 insertions(+), 279 deletions(-)

--
Signature

