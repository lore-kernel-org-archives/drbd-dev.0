Return-Path: <neilb@suse.de>
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6D7FD4202B8
	for <drbd-dev@lists.linbit.com>; Tue, 22 Feb 2022 04:19:17 +0100 (CET)
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
Message-ID: <164549983737.9187.2627117501000365074.stgit@noble.brown>
In-Reply-To: <164549971112.9187.16871723439770288255.stgit@noble.brown>
References: <164549971112.9187.16871723439770288255.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-ext4@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 04/11] fuse: remove reliance on bdi congestion
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

The bdi congestion tracking in not widely used and will be removed.

Fuse is one of a small number of filesystems that uses it, setting both
the sync (read) and async (write) congestion flags at what it determines
are appropriate times.

The only remaining effect of the sync flag is to cause read-ahead to be
skipped.
The only remaining effect of the async flag is to cause (some)
WB_SYNC_NONE writes to be skipped.

So instead of setting the flags, change:
 - .readahead to stop when it has submitted all non-async pages
    for read.
 - .writepages to do nothing if WB_SYNC_NONE and the flag would be set
 - .writepage to return AOP_WRITEPAGE_ACTIVATE if WB_SYNC_NONE
    and the flag would be set.

The writepages change causes a behavioural change in that pageout() can
now return PAGE_ACTIVATE instead of PAGE_KEEP, so SetPageActive() will
be called on the page which (I think) will further delay the next attempt
at writeout.  This might be a good thing.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/fuse/control.c |   17 -----------------
 fs/fuse/dev.c     |    8 --------
 fs/fuse/file.c    |   17 +++++++++++++++++
 3 files changed, 17 insertions(+), 25 deletions(-)

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
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 829094451774..94747bac3489 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -966,6 +966,14 @@ static void fuse_readahead(struct readahead_control *rac)
 		struct fuse_io_args *ia;
 		struct fuse_args_pages *ap;
 
+		if (fc->num_background >= fc->congestion_threshold &&
+		    rac->ra->async_size >= readahead_count(rac))
+			/*
+			 * Congested and only async pages left, so skip the
+			 * rest.
+			 */
+			break;
+
 		nr_pages = readahead_count(rac) - nr_pages;
 		if (nr_pages > max_pages)
 			nr_pages = max_pages;
@@ -1958,6 +1966,7 @@ static int fuse_writepage_locked(struct page *page)
 
 static int fuse_writepage(struct page *page, struct writeback_control *wbc)
 {
+	struct fuse_conn *fc = get_fuse_conn(page->mapping->host);
 	int err;
 
 	if (fuse_page_is_writeback(page->mapping->host, page->index)) {
@@ -1973,6 +1982,10 @@ static int fuse_writepage(struct page *page, struct writeback_control *wbc)
 		return 0;
 	}
 
+	if (wbc->sync_mode == WB_SYNC_NONE &&
+	    fc->num_background >= fc->congestion_threshold)
+		return AOP_WRITEPAGE_ACTIVATE;
+
 	err = fuse_writepage_locked(page);
 	unlock_page(page);
 
@@ -2226,6 +2239,10 @@ static int fuse_writepages(struct address_space *mapping,
 	if (fuse_is_bad(inode))
 		goto out;
 
+	if (wbc->sync_mode == WB_SYNC_NONE &&
+	    fc->num_background >= fc->congestion_threshold)
+		return 0;
+
 	data.inode = inode;
 	data.wpa = NULL;
 	data.ff = NULL;


