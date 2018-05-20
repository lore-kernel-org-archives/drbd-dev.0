Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E55A51011B9A
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 15:39:15 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id o78-v6so9420180wmg.0
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 06:39:15 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	e29-v6sm10282128edd.45.2018.05.23.06.39.14
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 23 May 2018 06:39:14 -0700 (PDT)
Resent-Message-ID: <20180523133914.GM499@soda.linbit>
Received: from mail-qt0-f195.google.com (mail-qt0-f195.google.com
	[209.85.216.195])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D4DF51011BEC
	for <drbd-dev@lists.linbit.com>; Mon, 21 May 2018 00:33:52 +0200 (CEST)
Received: by mail-qt0-f195.google.com with SMTP id e8-v6so16846486qth.0
	for <drbd-dev@lists.linbit.com>; Sun, 20 May 2018 15:33:52 -0700 (PDT)
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk,
	hch@infradead.org, colyli@suse.de, snitzer@redhat.com,
	darrick.wong@oracle.com, clm@fb.com, bacik@fb.com,
	linux-xfs@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-btrfs@vger.kernel.org, linux-raid@vger.kernel.org, neilb@suse.com
Date: Sun, 20 May 2018 18:25:56 -0400
Message-Id: <20180520222558.7053-11-kent.overstreet@gmail.com>
In-Reply-To: <20180520222558.7053-1-kent.overstreet@gmail.com>
References: <20180520222558.7053-1-kent.overstreet@gmail.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Subject: [Drbd-dev] [PATCH 10/12] btrfs: convert to
	bioset_init()/mempool_init()
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 fs/btrfs/extent_io.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e99b329002..56d32bb462 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -26,7 +26,7 @@
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
-static struct bio_set *btrfs_bioset;
+static struct bio_set btrfs_bioset;
 
 static inline bool extent_state_in_tree(const struct extent_state *state)
 {
@@ -162,20 +162,18 @@ int __init extent_io_init(void)
 	if (!extent_buffer_cache)
 		goto free_state_cache;
 
-	btrfs_bioset = bioset_create(BIO_POOL_SIZE,
-				     offsetof(struct btrfs_io_bio, bio),
-				     BIOSET_NEED_BVECS);
-	if (!btrfs_bioset)
+	if (bioset_init(&btrfs_bioset, BIO_POOL_SIZE,
+			offsetof(struct btrfs_io_bio, bio),
+			BIOSET_NEED_BVECS))
 		goto free_buffer_cache;
 
-	if (bioset_integrity_create(btrfs_bioset, BIO_POOL_SIZE))
+	if (bioset_integrity_create(&btrfs_bioset, BIO_POOL_SIZE))
 		goto free_bioset;
 
 	return 0;
 
 free_bioset:
-	bioset_free(btrfs_bioset);
-	btrfs_bioset = NULL;
+	bioset_exit(&btrfs_bioset);
 
 free_buffer_cache:
 	kmem_cache_destroy(extent_buffer_cache);
@@ -198,8 +196,7 @@ void __cold extent_io_exit(void)
 	rcu_barrier();
 	kmem_cache_destroy(extent_state_cache);
 	kmem_cache_destroy(extent_buffer_cache);
-	if (btrfs_bioset)
-		bioset_free(btrfs_bioset);
+	bioset_exit(&btrfs_bioset);
 }
 
 void extent_io_tree_init(struct extent_io_tree *tree,
@@ -2679,7 +2676,7 @@ struct bio *btrfs_bio_alloc(struct block_device *bdev, u64 first_byte)
 {
 	struct bio *bio;
 
-	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_PAGES, btrfs_bioset);
+	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_PAGES, &btrfs_bioset);
 	bio_set_dev(bio, bdev);
 	bio->bi_iter.bi_sector = first_byte >> 9;
 	btrfs_io_bio_init(btrfs_io_bio(bio));
@@ -2692,7 +2689,7 @@ struct bio *btrfs_bio_clone(struct bio *bio)
 	struct bio *new;
 
 	/* Bio allocation backed by a bioset does not fail */
-	new = bio_clone_fast(bio, GFP_NOFS, btrfs_bioset);
+	new = bio_clone_fast(bio, GFP_NOFS, &btrfs_bioset);
 	btrfs_bio = btrfs_io_bio(new);
 	btrfs_io_bio_init(btrfs_bio);
 	btrfs_bio->iter = bio->bi_iter;
@@ -2704,7 +2701,7 @@ struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs)
 	struct bio *bio;
 
 	/* Bio allocation backed by a bioset does not fail */
-	bio = bio_alloc_bioset(GFP_NOFS, nr_iovecs, btrfs_bioset);
+	bio = bio_alloc_bioset(GFP_NOFS, nr_iovecs, &btrfs_bioset);
 	btrfs_io_bio_init(btrfs_io_bio(bio));
 	return bio;
 }
@@ -2715,7 +2712,7 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
 	struct btrfs_io_bio *btrfs_bio;
 
 	/* this will never fail when it's backed by a bioset */
-	bio = bio_clone_fast(orig, GFP_NOFS, btrfs_bioset);
+	bio = bio_clone_fast(orig, GFP_NOFS, &btrfs_bioset);
 	ASSERT(bio);
 
 	btrfs_bio = btrfs_io_bio(bio);
-- 
2.17.0

