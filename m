Return-Path: <BATV+3075c4dbfe213c24d6b2+7491+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 88BE6420605
	for <drbd-dev@lists.linbit.com>; Mon, 26 Feb 2024 12:27:25 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>, Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 03/16] dm: use queue_limits_set
Date: Mon, 26 Feb 2024 11:29:51 +0100
Message-Id: <20240226103004.281412-4-hch@lst.de>
In-Reply-To: <20240226103004.281412-1-hch@lst.de>
References: <20240226103004.281412-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org, drbd-dev@lists.linbit.com
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

Use queue_limits_set which validates the limits and takes care of
updating the readahead settings instead of directly assigning them to
the queue.  For that make sure all limits are actually updated before
the assignment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c  |  2 +-
 drivers/md/dm-table.c | 27 ++++++++++++---------------
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 865fe4ebbf9b83..13865a9f89726c 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -267,7 +267,7 @@ int queue_limits_commit_update(struct request_queue *q,
 EXPORT_SYMBOL_GPL(queue_limits_commit_update);
 
 /**
- * queue_limits_commit_set - apply queue limits to queue
+ * queue_limits_set - apply queue limits to queue
  * @q:		queue to update
  * @lim:	limits to apply
  *
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 41f1d731ae5ac2..88114719fe187a 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1963,26 +1963,27 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	bool wc = false, fua = false;
 	int r;
 
-	/*
-	 * Copy table's limits to the DM device's request_queue
-	 */
-	q->limits = *limits;
-
 	if (dm_table_supports_nowait(t))
 		blk_queue_flag_set(QUEUE_FLAG_NOWAIT, q);
 	else
 		blk_queue_flag_clear(QUEUE_FLAG_NOWAIT, q);
 
 	if (!dm_table_supports_discards(t)) {
-		q->limits.max_discard_sectors = 0;
-		q->limits.max_hw_discard_sectors = 0;
-		q->limits.discard_granularity = 0;
-		q->limits.discard_alignment = 0;
-		q->limits.discard_misaligned = 0;
+		limits->max_hw_discard_sectors = 0;
+		limits->discard_granularity = 0;
+		limits->discard_alignment = 0;
+		limits->discard_misaligned = 0;
 	}
 
+	if (!dm_table_supports_write_zeroes(t))
+		limits->max_write_zeroes_sectors = 0;
+
 	if (!dm_table_supports_secure_erase(t))
-		q->limits.max_secure_erase_sectors = 0;
+		limits->max_secure_erase_sectors = 0;
+
+	r = queue_limits_set(q, limits);
+	if (r)
+		return r;
 
 	if (dm_table_supports_flush(t, (1UL << QUEUE_FLAG_WC))) {
 		wc = true;
@@ -2007,9 +2008,6 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	else
 		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
 
-	if (!dm_table_supports_write_zeroes(t))
-		q->limits.max_write_zeroes_sectors = 0;
-
 	dm_table_verify_integrity(t);
 
 	/*
@@ -2047,7 +2045,6 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	}
 
 	dm_update_crypto_profile(q, t);
-	disk_update_readahead(t->md->disk);
 
 	/*
 	 * Check for request-based device is left to
-- 
2.39.2

