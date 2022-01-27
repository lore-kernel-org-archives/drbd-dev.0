Return-Path: <neilb@suse.de>
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 80FD7420FED
	for <drbd-dev@lists.linbit.com>; Thu, 27 Jan 2022 03:58:42 +0100 (CET)
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
Message-ID: <164325158958.29787.9472805850412952920.stgit@noble.brown>
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
Subject: [Drbd-dev] [PATCH 6/9] fuse: don't set/clear bdi_congested
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

The bid congestion framework is no longer used to manage writeout etc,
so drop updating it in fuse.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/fuse/control.c |   17 -----------------
 fs/fuse/dev.c     |    8 --------
 2 files changed, 25 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 000d2e5627e9..7cede9a3bc96 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -164,7 +164,6 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
 {
 	unsigned val;
 	struct fuse_conn *fc;
-	struct fuse_mount *fm;
 	ssize_t ret;
 
 	ret = fuse_conn_limit_write(file, buf, count, ppos, &val,
@@ -178,22 +177,6 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
 	down_read(&fc->killsb);
 	spin_lock(&fc->bg_lock);
 	fc->congestion_threshold = val;
-
-	/*
-	 * Get any fuse_mount belonging to this fuse_conn; s_bdi is
-	 * shared between all of them
-	 */
-
-	if (!list_empty(&fc->mounts)) {
-		fm = list_first_entry(&fc->mounts, struct fuse_mount, fc_entry);
-		if (fc->num_background < fc->congestion_threshold) {
-			clear_bdi_congested(fm->sb->s_bdi, BLK_RW_SYNC);
-			clear_bdi_congested(fm->sb->s_bdi, BLK_RW_ASYNC);
-		} else {
-			set_bdi_congested(fm->sb->s_bdi, BLK_RW_SYNC);
-			set_bdi_congested(fm->sb->s_bdi, BLK_RW_ASYNC);
-		}
-	}
 	spin_unlock(&fc->bg_lock);
 	up_read(&fc->killsb);
 	fuse_conn_put(fc);
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index cd54a529460d..e1b4a846c90d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -315,10 +315,6 @@ void fuse_request_end(struct fuse_req *req)
 				wake_up(&fc->blocked_waitq);
 		}
 
-		if (fc->num_background == fc->congestion_threshold && fm->sb) {
-			clear_bdi_congested(fm->sb->s_bdi, BLK_RW_SYNC);
-			clear_bdi_congested(fm->sb->s_bdi, BLK_RW_ASYNC);
-		}
 		fc->num_background--;
 		fc->active_background--;
 		flush_bg_queue(fc);
@@ -540,10 +536,6 @@ static bool fuse_request_queue_background(struct fuse_req *req)
 		fc->num_background++;
 		if (fc->num_background == fc->max_background)
 			fc->blocked = 1;
-		if (fc->num_background == fc->congestion_threshold && fm->sb) {
-			set_bdi_congested(fm->sb->s_bdi, BLK_RW_SYNC);
-			set_bdi_congested(fm->sb->s_bdi, BLK_RW_ASYNC);
-		}
 		list_add_tail(&req->list, &fc->bg_queue);
 		flush_bg_queue(fc);
 		queued = true;


