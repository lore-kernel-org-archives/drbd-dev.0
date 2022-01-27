Return-Path: <neilb@suse.de>
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7A7BE42087D
	for <drbd-dev@lists.linbit.com>; Thu, 27 Jan 2022 03:57:37 +0100 (CET)
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
Message-ID: <164325158956.29787.7016948342209980097.stgit@noble.brown>
In-Reply-To: <164325106958.29787.4865219843242892726.stgit@noble.brown>
References: <164325106958.29787.4865219843242892726.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-ext4@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 3/9] f2fs: change retry waiting for
 f2fs_write_single_data_page()
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

f2fs_write_single_data_page() can return -EAGAIN if it cannot get
the cp_rwsem lock - it holds a page lock and so cannot wait for it.

Some code which calls f2fs_write_single_data_page() use
congestion_wait() and then tries again.  congestion_wait() doesn't do
anything useful as congestion is no longer tracked.  So this is just a
simple sleep.

A better approach is it wait until the cp_rwsem lock can be taken - then
try again.  There is certainly no point trying again *before* the lock
can be taken.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/f2fs/compress.c |    6 +++---
 fs/f2fs/data.c     |    9 ++++++---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d0c3aeba5945..58ff7f4b296c 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1505,9 +1505,9 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 				if (IS_NOQUOTA(cc->inode))
 					return 0;
 				ret = 0;
-				cond_resched();
-				congestion_wait(BLK_RW_ASYNC,
-						DEFAULT_IO_TIMEOUT);
+				/* Wait until we can get the lock, then try again. */
+				f2fs_lock_op(F2FS_I_SB(cc->inode));
+				f2fs_unlock_op(F2FS_I_SB(cc->inode));
 				goto retry_write;
 			}
 			return ret;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8c417864c66a..1d2341163e2c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3047,9 +3047,12 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				} else if (ret == -EAGAIN) {
 					ret = 0;
 					if (wbc->sync_mode == WB_SYNC_ALL) {
-						cond_resched();
-						congestion_wait(BLK_RW_ASYNC,
-							DEFAULT_IO_TIMEOUT);
+						/* Wait until we can get the
+						 * lock, then try again.
+						 */
+						f2fs_lock_op(F2FS_I_SB(mapping->host));
+						f2fs_unlock_op(F2FS_I_SB(mapping->host));
+
 						goto retry_write;
 					}
 					goto next;


