Return-Path: <neilb@suse.de>
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 91E94420060
	for <drbd-dev@lists.linbit.com>; Tue, 22 Feb 2022 04:17:50 +0100 (CET)
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
	Wu Fengguang <fengguang.wu@intel.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@netapp.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>
Date: Tue, 22 Feb 2022 14:17:17 +1100
Message-ID: <164549971112.9187.16871723439770288255.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-ext4@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 00/11] Remove remaining parts of congestion
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

Here is another refresh of my "remove congestion tracking" series.

I removed the small tweaks to read-ahead code because they raised
questions and are actually required for this series.

Everything else is the same.

Andrew: please drop the version of this that is currently in your tree
even if you don't take this.  The changes to fuse/nfs/ceph are not
appropriate and I wouldn't want them to land by mistake.

Thanks,
NeilBrown

---

NeilBrown (11):
      DOC: convert 'subsection' to 'section' in gfp.h
      MM: document and polish read-ahead code.
      MM: improve cleanup when ->readpages doesn't process all pages.
      fuse: remove reliance on bdi congestion
      nfs: remove reliance on bdi congestion
      ceph: remove reliance on bdi congestion
      Remove inode_congested()
      Remove bdi_congested() and wb_congested() and related functions
      f2fs: replace congestion_wait() calls with io_schedule_timeout()
      block/bfq-iosched.c: use "false" rather than "BLK_RW_ASYNC"
      Remove congestion tracking framework.


 Documentation/core-api/mm-api.rst |  19 ++++-
 Documentation/filesystems/vfs.rst |  16 ++--
 block/bfq-iosched.c               |   2 +-
 drivers/block/drbd/drbd_int.h     |   3 -
 drivers/block/drbd/drbd_req.c     |   3 +-
 fs/ceph/addr.c                    |  22 +++---
 fs/ceph/super.c                   |   1 +
 fs/ceph/super.h                   |   1 +
 fs/ext2/ialloc.c                  |   5 --
 fs/f2fs/compress.c                |   4 +-
 fs/f2fs/data.c                    |   3 +-
 fs/f2fs/f2fs.h                    |   6 ++
 fs/f2fs/segment.c                 |   8 +-
 fs/f2fs/super.c                   |   6 +-
 fs/fs-writeback.c                 |  37 ---------
 fs/fuse/control.c                 |  17 -----
 fs/fuse/dev.c                     |   8 --
 fs/fuse/file.c                    |  17 +++++
 fs/nfs/write.c                    |  14 +++-
 fs/nilfs2/segbuf.c                |  15 ----
 fs/xfs/xfs_buf.c                  |   3 -
 include/linux/backing-dev-defs.h  |   8 --
 include/linux/backing-dev.h       |  50 ------------
 include/linux/fs.h                |   9 ++-
 include/linux/nfs_fs_sb.h         |   1 +
 include/trace/events/writeback.h  |  28 -------
 mm/backing-dev.c                  |  57 --------------
 mm/fadvise.c                      |   5 +-
 mm/readahead.c                    | 122 ++++++++++++++++++++++++++++--
 mm/vmscan.c                       |  21 +----
 30 files changed, 212 insertions(+), 299 deletions(-)

--
Signature

