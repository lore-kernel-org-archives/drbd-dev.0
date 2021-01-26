Return-Path: <BATV+b7a2078c382f6036dc0e+6365+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B811742060C
	for <drbd-dev@lists.linbit.com>; Tue, 26 Jan 2021 16:08:32 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>
Date: Tue, 26 Jan 2021 15:52:36 +0100
Message-Id: <20210126145247.1964410-7-hch@lst.de>
In-Reply-To: <20210126145247.1964410-1-hch@lst.de>
References: <20210126145247.1964410-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mike Snitzer <snitzer@redhat.com>, linux-mm@kvack.org, dm-devel@redhat.com,
	drbd-dev@lists.linbit.com, Naohiro Aota <naohiro.aota@wdc.com>,
	linux-nilfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Chao Yu <chao@kernel.org>, linux-nfs@vger.kernel.org,
	Coly Li <colyli@suse.de>, linux-raid@vger.kernel.org,
	linux-bcache@vger.kernel.org, David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, linux-block@vger.kernel.org,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, linux-btrfs@vger.kernel.org
Subject: [Drbd-dev] [PATCH 06/17] dm-clone: use blkdev_issue_flush in
	commit_metadata
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

Use blkdev_issue_flush instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-clone-target.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/md/dm-clone-target.c b/drivers/md/dm-clone-target.c
index bdb255edc20043..a90bdf9b2ca6bd 100644
--- a/drivers/md/dm-clone-target.c
+++ b/drivers/md/dm-clone-target.c
@@ -85,12 +85,6 @@ struct clone {
 
 	struct dm_clone_metadata *cmd;
 
-	/*
-	 * bio used to flush the destination device, before committing the
-	 * metadata.
-	 */
-	struct bio flush_bio;
-
 	/* Region hydration hash table */
 	struct hash_table_bucket *ht;
 
@@ -1155,11 +1149,7 @@ static int commit_metadata(struct clone *clone, bool *dest_dev_flushed)
 		goto out;
 	}
 
-	bio_reset(&clone->flush_bio);
-	bio_set_dev(&clone->flush_bio, clone->dest_dev->bdev);
-	clone->flush_bio.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
-
-	r = submit_bio_wait(&clone->flush_bio);
+	r = blkdev_issue_flush(clone->dest_dev->bdev);
 	if (unlikely(r)) {
 		__metadata_operation_failed(clone, "flush destination device", r);
 		goto out;
@@ -1886,7 +1876,6 @@ static int clone_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	bio_list_init(&clone->deferred_flush_completions);
 	clone->hydration_offset = 0;
 	atomic_set(&clone->hydrations_in_flight, 0);
-	bio_init(&clone->flush_bio, NULL, 0);
 
 	clone->wq = alloc_workqueue("dm-" DM_MSG_PREFIX, WQ_MEM_RECLAIM, 0);
 	if (!clone->wq) {
@@ -1958,7 +1947,6 @@ static void clone_dtr(struct dm_target *ti)
 	struct clone *clone = ti->private;
 
 	mutex_destroy(&clone->commit_lock);
-	bio_uninit(&clone->flush_bio);
 
 	for (i = 0; i < clone->nr_ctr_args; i++)
 		kfree(clone->ctr_args[i]);
-- 
2.29.2

