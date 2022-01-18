Return-Path: <BATV+4fe6c3c60fc7db690b35+6722+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 59246420949
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jan 2022 08:58:00 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Tue, 18 Jan 2022 08:19:41 +0100
Message-Id: <20220118071952.1243143-9-hch@lst.de>
In-Reply-To: <20220118071952.1243143-1-hch@lst.de>
References: <20220118071952.1243143-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.co>,
	dm-devel@redhat.com, "Md . Haris Iqbal " <haris.iqbal@ionos.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org,
	Andrew Morton <akpm@linux-foundation.org>, ntfs3@lists.linux.dev,
	Jack Wang <jinpu.wang@ionos.com>, Pavel Begunkov <asml.silence@gmail.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 08/19] dm-thin: use blkdev_issue_flush instead of
	open coding it
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

Use blkdev_issue_flush, which uses an on-stack bio instead of an
opencoded version with a bio embedded into struct pool.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-thin.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 76a9c2e9aeeea..411a3f56ed90c 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -282,8 +282,6 @@ struct pool {
 	struct dm_bio_prison_cell **cell_sort_array;
 
 	mempool_t mapping_pool;
-
-	struct bio flush_bio;
 };
 
 static void metadata_operation_failed(struct pool *pool, const char *op, int r);
@@ -2906,7 +2904,6 @@ static void __pool_destroy(struct pool *pool)
 	if (pool->next_mapping)
 		mempool_free(pool->next_mapping, &pool->mapping_pool);
 	mempool_exit(&pool->mapping_pool);
-	bio_uninit(&pool->flush_bio);
 	dm_deferred_set_destroy(pool->shared_read_ds);
 	dm_deferred_set_destroy(pool->all_io_ds);
 	kfree(pool);
@@ -2987,7 +2984,6 @@ static struct pool *pool_create(struct mapped_device *pool_md,
 	pool->low_water_triggered = false;
 	pool->suspended = true;
 	pool->out_of_data_space = false;
-	bio_init(&pool->flush_bio, NULL, 0);
 
 	pool->shared_read_ds = dm_deferred_set_create();
 	if (!pool->shared_read_ds) {
@@ -3194,13 +3190,8 @@ static void metadata_low_callback(void *context)
 static int metadata_pre_commit_callback(void *context)
 {
 	struct pool *pool = context;
-	struct bio *flush_bio = &pool->flush_bio;
-
-	bio_reset(flush_bio);
-	bio_set_dev(flush_bio, pool->data_dev);
-	flush_bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 
-	return submit_bio_wait(flush_bio);
+	return blkdev_issue_flush(pool->data_dev);
 }
 
 static sector_t get_dev_size(struct block_device *bdev)
-- 
2.30.2

