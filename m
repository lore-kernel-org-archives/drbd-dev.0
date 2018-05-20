Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5756B1011B97
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 15:39:13 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id n10-v6so9344989wmc.1
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 06:39:13 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	p36-v6sm10538499eda.43.2018.05.23.06.39.11
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 23 May 2018 06:39:12 -0700 (PDT)
Resent-Message-ID: <20180523133911.GL499@soda.linbit>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
	[209.85.216.193])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6EC5E1011B93
	for <drbd-dev@lists.linbit.com>; Mon, 21 May 2018 00:33:54 +0200 (CEST)
Received: by mail-qt0-f193.google.com with SMTP id h2-v6so16830903qtp.7
	for <drbd-dev@lists.linbit.com>; Sun, 20 May 2018 15:33:54 -0700 (PDT)
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk,
	hch@infradead.org, colyli@suse.de, snitzer@redhat.com,
	darrick.wong@oracle.com, clm@fb.com, bacik@fb.com,
	linux-xfs@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-btrfs@vger.kernel.org, linux-raid@vger.kernel.org, neilb@suse.com
Date: Sun, 20 May 2018 18:25:55 -0400
Message-Id: <20180520222558.7053-10-kent.overstreet@gmail.com>
In-Reply-To: <20180520222558.7053-1-kent.overstreet@gmail.com>
References: <20180520222558.7053-1-kent.overstreet@gmail.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Subject: [Drbd-dev] [PATCH 09/12] fs: convert block_dev.c to bioset_init()
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
 fs/block_dev.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7ec920e270..b550ae280f 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -272,7 +272,7 @@ struct blkdev_dio {
 	struct bio		bio;
 };
 
-static struct bio_set *blkdev_dio_pool __read_mostly;
+static struct bio_set blkdev_dio_pool;
 
 static void blkdev_bio_end_io(struct bio *bio)
 {
@@ -334,7 +334,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	    (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	bio = bio_alloc_bioset(GFP_KERNEL, nr_pages, blkdev_dio_pool);
+	bio = bio_alloc_bioset(GFP_KERNEL, nr_pages, &blkdev_dio_pool);
 	bio_get(bio); /* extra ref for the completion handler */
 
 	dio = container_of(bio, struct blkdev_dio, bio);
@@ -432,10 +432,7 @@ blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 static __init int blkdev_init(void)
 {
-	blkdev_dio_pool = bioset_create(4, offsetof(struct blkdev_dio, bio), BIOSET_NEED_BVECS);
-	if (!blkdev_dio_pool)
-		return -ENOMEM;
-	return 0;
+	return bioset_init(&blkdev_dio_pool, 4, offsetof(struct blkdev_dio, bio), BIOSET_NEED_BVECS);
 }
 module_init(blkdev_init);
 
-- 
2.17.0

