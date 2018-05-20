Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5D7431011BA6
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 15:39:23 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id n10-v6so9346618wmc.1
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 06:39:23 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	k17-v6sm10198543ede.96.2018.05.23.06.39.22
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 23 May 2018 06:39:22 -0700 (PDT)
Resent-Message-ID: <20180523133921.GO499@soda.linbit>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
	[209.85.220.193])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DA9591011B96
	for <drbd-dev@lists.linbit.com>; Mon, 21 May 2018 00:33:55 +0200 (CEST)
Received: by mail-qk0-f193.google.com with SMTP id p186-v6so10520743qkd.1
	for <drbd-dev@lists.linbit.com>; Sun, 20 May 2018 15:33:55 -0700 (PDT)
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk,
	hch@infradead.org, colyli@suse.de, snitzer@redhat.com,
	darrick.wong@oracle.com, clm@fb.com, bacik@fb.com,
	linux-xfs@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-btrfs@vger.kernel.org, linux-raid@vger.kernel.org, neilb@suse.com
Date: Sun, 20 May 2018 18:25:58 -0400
Message-Id: <20180520222558.7053-13-kent.overstreet@gmail.com>
In-Reply-To: <20180520222558.7053-1-kent.overstreet@gmail.com>
References: <20180520222558.7053-1-kent.overstreet@gmail.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Subject: [Drbd-dev] [PATCH 12/12] block: Drop bioset_create()
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

All users have been converted to bioset_init()

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 block/bio.c         | 61 ++++++++++-----------------------------------
 include/linux/bio.h |  6 ++---
 2 files changed, 15 insertions(+), 52 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 0a4df92cd6..595663e028 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1908,22 +1908,26 @@ void bioset_exit(struct bio_set *bs)
 }
 EXPORT_SYMBOL(bioset_exit);
 
-void bioset_free(struct bio_set *bs)
-{
-	bioset_exit(bs);
-	kfree(bs);
-}
-EXPORT_SYMBOL(bioset_free);
-
 /**
  * bioset_init - Initialize a bio_set
+ * @bs:		pool to initialize
  * @pool_size:	Number of bio and bio_vecs to cache in the mempool
  * @front_pad:	Number of bytes to allocate in front of the returned bio
  * @flags:	Flags to modify behavior, currently %BIOSET_NEED_BVECS
  *              and %BIOSET_NEED_RESCUER
  *
- * Similar to bioset_create(), but initializes a passed-in bioset instead of
- * separately allocating it.
+ * Description:
+ *    Set up a bio_set to be used with @bio_alloc_bioset. Allows the caller
+ *    to ask for a number of bytes to be allocated in front of the bio.
+ *    Front pad allocation is useful for embedding the bio inside
+ *    another structure, to avoid allocating extra data to go with the bio.
+ *    Note that the bio must be embedded at the END of that structure always,
+ *    or things will break badly.
+ *    If %BIOSET_NEED_BVECS is set in @flags, a separate pool will be allocated
+ *    for allocating iovecs.  This pool is not needed e.g. for bio_clone_fast().
+ *    If %BIOSET_NEED_RESCUER is set, a workqueue is created which can be used to
+ *    dispatch queued requests when the mempool runs out of space.
+ *
  */
 int bioset_init(struct bio_set *bs,
 		unsigned int pool_size,
@@ -1963,45 +1967,6 @@ int bioset_init(struct bio_set *bs,
 }
 EXPORT_SYMBOL(bioset_init);
 
-/**
- * bioset_create  - Create a bio_set
- * @pool_size:	Number of bio and bio_vecs to cache in the mempool
- * @front_pad:	Number of bytes to allocate in front of the returned bio
- * @flags:	Flags to modify behavior, currently %BIOSET_NEED_BVECS
- *              and %BIOSET_NEED_RESCUER
- *
- * Description:
- *    Set up a bio_set to be used with @bio_alloc_bioset. Allows the caller
- *    to ask for a number of bytes to be allocated in front of the bio.
- *    Front pad allocation is useful for embedding the bio inside
- *    another structure, to avoid allocating extra data to go with the bio.
- *    Note that the bio must be embedded at the END of that structure always,
- *    or things will break badly.
- *    If %BIOSET_NEED_BVECS is set in @flags, a separate pool will be allocated
- *    for allocating iovecs.  This pool is not needed e.g. for bio_clone_fast().
- *    If %BIOSET_NEED_RESCUER is set, a workqueue is created which can be used to
- *    dispatch queued requests when the mempool runs out of space.
- *
- */
-struct bio_set *bioset_create(unsigned int pool_size,
-			      unsigned int front_pad,
-			      int flags)
-{
-	struct bio_set *bs;
-
-	bs = kzalloc(sizeof(*bs), GFP_KERNEL);
-	if (!bs)
-		return NULL;
-
-	if (bioset_init(bs, pool_size, front_pad, flags)) {
-		kfree(bs);
-		return NULL;
-	}
-
-	return bs;
-}
-EXPORT_SYMBOL(bioset_create);
-
 #ifdef CONFIG_BLK_CGROUP
 
 /**
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 5e472fcafa..810a8bee8f 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -410,14 +410,12 @@ static inline struct bio *bio_next_split(struct bio *bio, int sectors,
 	return bio_split(bio, sectors, gfp, bs);
 }
 
-extern int bioset_init(struct bio_set *, unsigned int, unsigned int, int flags);
-extern void bioset_exit(struct bio_set *);
-extern struct bio_set *bioset_create(unsigned int, unsigned int, int flags);
 enum {
 	BIOSET_NEED_BVECS = BIT(0),
 	BIOSET_NEED_RESCUER = BIT(1),
 };
-extern void bioset_free(struct bio_set *);
+extern int bioset_init(struct bio_set *, unsigned int, unsigned int, int flags);
+extern void bioset_exit(struct bio_set *);
 extern int biovec_init_pool(mempool_t *pool, int pool_entries);
 
 extern struct bio *bio_alloc_bioset(gfp_t, unsigned int, struct bio_set *);
-- 
2.17.0

