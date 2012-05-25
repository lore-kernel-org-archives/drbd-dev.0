Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DD7801005413
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:30:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 96A3E1B4315
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:30:10 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8lrDObo5wgxl for <drbd-dev@lists.linbit.com>;
	Fri, 25 May 2012 22:30:10 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 671A81B40F5
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:30:10 +0200 (CEST)
Resent-Message-ID: <20120525203010.GK1903@soda.linbit>
Received: from mail-pz0-f54.google.com (mail-pz0-f54.google.com
	[209.85.210.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 0D98C1013804
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:26:18 +0200 (CEST)
Received: by mail-pz0-f54.google.com with SMTP id v36so2229902dad.27
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 13:26:18 -0700 (PDT)
From: Kent Overstreet <koverstreet@google.com>
To: linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	dm-devel@redhat.com, linux-fsdevel@vger.kernel.org
Date: Fri, 25 May 2012 13:25:30 -0700
Message-Id: <1337977539-16977-8-git-send-email-koverstreet@google.com>
In-Reply-To: <1337977539-16977-1-git-send-email-koverstreet@google.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, neilb@suse.de,
	Kent Overstreet <koverstreet@google.com>, mpatocka@redhat.com,
	vgoyal@redhat.com, bharrosh@panasas.com, tj@kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v3 07/16] block: Rename bio_split() ->
	bio_pair_split()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is prep work for introducing a more general bio_split()

Change-Id: Ib9c4ff691af889d26bc9ec9fb42a2f3068f34ad9

Signed-off-by: Kent Overstreet <koverstreet@google.com>
---
 drivers/block/drbd/drbd_req.c |    2 +-
 drivers/block/pktcdvd.c       |    2 +-
 drivers/block/rbd.c           |    3 ++-
 drivers/md/linear.c           |    2 +-
 drivers/md/raid0.c            |    6 +++---
 drivers/md/raid10.c           |    4 ++--
 fs/bio.c                      |    4 ++--
 include/linux/bio.h           |    2 +-
 8 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 4a0f314..1c7e3c4 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1128,7 +1128,7 @@ void drbd_make_request(struct request_queue *q, struct bio *bio)
 		const int sps = 1 << HT_SHIFT; /* sectors per slot */
 		const int mask = sps - 1;
 		const sector_t first_sectors = sps - (sect & mask);
-		bp = bio_split(bio, first_sectors);
+		bp = bio_pair_split(bio, first_sectors);
 
 		/* we need to get a "reference count" (ap_bio_cnt)
 		 * to avoid races with the disconnect/reconnect/suspend code.
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 6fe693a..12a14c0 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2467,7 +2467,7 @@ static void pkt_make_request(struct request_queue *q, struct bio *bio)
 		if (last_zone != zone) {
 			BUG_ON(last_zone != zone + pd->settings.size);
 			first_sectors = last_zone - bio->bi_sector;
-			bp = bio_split(bio, first_sectors);
+			bp = bio_pair_split(bio, first_sectors);
 			BUG_ON(!bp);
 			pkt_make_request(q, &bp->bio1);
 			pkt_make_request(q, &bp->bio2);
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 013c7a5..a0b76c6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -747,7 +747,8 @@ static struct bio *bio_chain_clone(struct bio **old, struct bio **next,
 
 			/* split the bio. We'll release it either in the next
 			   call, or it will have to be released outside */
-			bp = bio_split(old_chain, (len - total) / SECTOR_SIZE);
+			bp = bio_pair_split(old_chain,
+					    (len - total) / SECTOR_SIZE);
 			if (!bp)
 				goto err_out;
 
diff --git a/drivers/md/linear.c b/drivers/md/linear.c
index fa211d8..e860cb9 100644
--- a/drivers/md/linear.c
+++ b/drivers/md/linear.c
@@ -314,7 +314,7 @@ static void linear_make_request(struct mddev *mddev, struct bio *bio)
 
 		rcu_read_unlock();
 
-		bp = bio_split(bio, end_sector - bio->bi_sector);
+		bp = bio_pair_split(bio, end_sector - bio->bi_sector);
 
 		linear_make_request(mddev, &bp->bio1);
 		linear_make_request(mddev, &bp->bio2);
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index de63a1f..c89c8aa 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -516,11 +516,11 @@ static void raid0_make_request(struct mddev *mddev, struct bio *bio)
 		 * refuse to split for us, so we need to split it.
 		 */
 		if (likely(is_power_of_2(chunk_sects)))
-			bp = bio_split(bio, chunk_sects - (sector &
+			bp = bio_pair_split(bio, chunk_sects - (sector &
 							   (chunk_sects-1)));
 		else
-			bp = bio_split(bio, chunk_sects -
-				       sector_div(sector, chunk_sects));
+			bp = bio_pair_split(bio, chunk_sects -
+					    sector_div(sector, chunk_sects));
 		raid0_make_request(mddev, &bp->bio1);
 		raid0_make_request(mddev, &bp->bio2);
 		bio_pair_release(bp);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 3e7b154..f8b6f14 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1008,8 +1008,8 @@ static void make_request(struct mddev *mddev, struct bio * bio)
 		/* This is a one page bio that upper layers
 		 * refuse to split for us, so we need to split it.
 		 */
-		bp = bio_split(bio,
-			       chunk_sects - (bio->bi_sector & (chunk_sects - 1)) );
+		bp = bio_pair_split(bio,
+				    chunk_sects - (bio->bi_sector & (chunk_sects - 1)) );
 
 		/* Each of these 'make_request' calls will call 'wait_barrier'.
 		 * If the first succeeds but the second blocks due to the resync
diff --git a/fs/bio.c b/fs/bio.c
index 692911e..fb7607b 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -1478,7 +1478,7 @@ static void bio_pair_end_2(struct bio *bi, int err)
 /*
  * split a bio - only worry about a bio with a single page in its iovec
  */
-struct bio_pair *bio_split(struct bio *bi, int first_sectors)
+struct bio_pair *bio_pair_split(struct bio *bi, int first_sectors)
 {
 	struct bio_pair *bp = mempool_alloc(bio_split_pool, GFP_NOIO);
 
@@ -1521,7 +1521,7 @@ struct bio_pair *bio_split(struct bio *bi, int first_sectors)
 
 	return bp;
 }
-EXPORT_SYMBOL(bio_split);
+EXPORT_SYMBOL(bio_pair_split);
 
 /**
  *      bio_sector_offset - Find hardware sector offset in bio
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 9e89f5e..18ab020 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -201,7 +201,7 @@ struct bio_pair {
 	atomic_t			cnt;
 	int				error;
 };
-extern struct bio_pair *bio_split(struct bio *bi, int first_sectors);
+extern struct bio_pair *bio_pair_split(struct bio *bi, int first_sectors);
 extern void bio_pair_release(struct bio_pair *dbio);
 
 extern struct bio_set *bioset_create(unsigned int, unsigned int);
-- 
1.7.9.3.327.g2980b

