Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E4803100542E
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id DC6151B4262
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:28 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ONtmpr3AX4pj for <drbd-dev@lists.linbit.com>;
	Thu, 24 May 2012 18:15:28 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id BC1841B40FA
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:28 +0200 (CEST)
Resent-Message-ID: <20120524161528.GO5734@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 10281106DCE1
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 02:11:05 +0200 (CEST)
Received: by mail-pb0-f54.google.com with SMTP id ro2so13655294pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2012 17:11:05 -0700 (PDT)
From: Kent Overstreet <koverstreet@google.com>
To: linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	dm-devel@redhat.com, linux-fsdevel@vger.kernel.org
Date: Wed, 23 May 2012 17:02:41 -0700
Message-Id: <1337817771-25038-5-git-send-email-koverstreet@google.com>
In-Reply-To: <1337817771-25038-1-git-send-email-koverstreet@google.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, neilb@suse.de,
	Kent Overstreet <koverstreet@google.com>, mpatocka@redhat.com,
	vgoyal@redhat.com, bharrosh@panasas.com, tj@kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v2 04/14] block: Add bio_clone_kmalloc()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Signed-off-by: Kent Overstreet <koverstreet@google.com>
---
 drivers/block/osdblk.c |    3 +--
 drivers/block/rbd.c    |    8 ++------
 fs/bio.c               |   13 +++++++++++++
 fs/exofs/ore.c         |    5 ++---
 include/linux/bio.h    |    1 +
 5 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/block/osdblk.c b/drivers/block/osdblk.c
index 87311eb..1bbc681 100644
--- a/drivers/block/osdblk.c
+++ b/drivers/block/osdblk.c
@@ -266,11 +266,10 @@ static struct bio *bio_chain_clone(struct bio *old_chain, gfp_t gfpmask)
 	struct bio *tmp, *new_chain = NULL, *tail = NULL;
 
 	while (old_chain) {
-		tmp = bio_kmalloc(gfpmask, old_chain->bi_max_vecs);
+		tmp = bio_clone_kmalloc(old_chain, gfpmask);
 		if (!tmp)
 			goto err_out;
 
-		__bio_clone(tmp, old_chain);
 		tmp->bi_bdev = NULL;
 		gfpmask &= ~__GFP_WAIT;
 		tmp->bi_next = NULL;
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 013c7a5..5a953c6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -729,7 +729,7 @@ static struct bio *bio_chain_clone(struct bio **old, struct bio **next,
 	}
 
 	while (old_chain && (total < len)) {
-		tmp = bio_kmalloc(gfpmask, old_chain->bi_max_vecs);
+		tmp = bio_clone_kmalloc(old_chain, gfpmask);
 		if (!tmp)
 			goto err_out;
 
@@ -751,13 +751,9 @@ static struct bio *bio_chain_clone(struct bio **old, struct bio **next,
 			if (!bp)
 				goto err_out;
 
-			__bio_clone(tmp, &bp->bio1);
-
 			*next = &bp->bio2;
-		} else {
-			__bio_clone(tmp, old_chain);
+		} else
 			*next = old_chain->bi_next;
-		}
 
 		tmp->bi_bdev = NULL;
 		gfpmask &= ~__GFP_WAIT;
diff --git a/fs/bio.c b/fs/bio.c
index 4cb621f..e2c0970 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -491,6 +491,19 @@ struct bio *bio_clone(struct bio *bio, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(bio_clone);
 
+struct bio *bio_clone_kmalloc(struct bio *bio, gfp_t gfp_mask)
+{
+	struct bio *b = bio_kmalloc(gfp_mask, bio->bi_max_vecs);
+
+	if (!b)
+		return NULL;
+
+	__bio_clone(b, bio);
+
+	return b;
+}
+EXPORT_SYMBOL(bio_clone_kmalloc);
+
 /**
  *	bio_get_nr_vecs		- return approx number of vecs
  *	@bdev:  I/O target
diff --git a/fs/exofs/ore.c b/fs/exofs/ore.c
index 49cf230..95c7264 100644
--- a/fs/exofs/ore.c
+++ b/fs/exofs/ore.c
@@ -820,8 +820,8 @@ static int _write_mirror(struct ore_io_state *ios, int cur_comp)
 			struct bio *bio;
 
 			if (per_dev != master_dev) {
-				bio = bio_kmalloc(GFP_KERNEL,
-						  master_dev->bio->bi_max_vecs);
+				bio = bio_clone_kmalloc(master_dev->bio,
+							GFP_KERNEL);
 				if (unlikely(!bio)) {
 					ORE_DBGMSG(
 					      "Failed to allocate BIO size=%u\n",
@@ -830,7 +830,6 @@ static int _write_mirror(struct ore_io_state *ios, int cur_comp)
 					goto out;
 				}
 
-				__bio_clone(bio, master_dev->bio);
 				bio->bi_bdev = NULL;
 				bio->bi_next = NULL;
 				per_dev->offset = master_dev->offset;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index e068a68..b27f16b 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -225,6 +225,7 @@ extern int bio_phys_segments(struct request_queue *, struct bio *);
 extern void __bio_clone(struct bio *, struct bio *);
 extern struct bio *bio_clone_bioset(struct bio *, gfp_t, struct bio_set *bs);
 extern struct bio *bio_clone(struct bio *, gfp_t);
+struct bio *bio_clone_kmalloc(struct bio *, gfp_t);
 
 extern void bio_init(struct bio *);
 
-- 
1.7.9.3.327.g2980b

