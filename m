Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3BCB71055F42
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 350EB1B4369
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:40 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uo3-j9RC9bDV for <drbd-dev@lists.linbit.com>;
	Thu, 26 Jul 2012 11:35:40 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 18A421B4368
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:40 +0200 (CEST)
Resent-Message-ID: <20120726093540.GQ29767@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 34CA31013803
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2012 22:12:06 +0200 (CEST)
Received: by mail-pb0-f54.google.com with SMTP id ro2so146142pbb.27
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2012 13:12:05 -0700 (PDT)
From: Kent Overstreet <koverstreet@google.com>
To: linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com
Date: Tue, 24 Jul 2012 13:11:27 -0700
Message-Id: <1343160689-12378-11-git-send-email-koverstreet@google.com>
In-Reply-To: <1343160689-12378-1-git-send-email-koverstreet@google.com>
References: <1343160689-12378-1-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, neilb@suse.de,
	Kent Overstreet <koverstreet@google.com>, mpatocka@redhat.com,
	vgoyal@redhat.com, bharrosh@panasas.com, tj@kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v4 10/12] block: Add bio_clone_kmalloc()
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
 fs/bio.c               |   13 +++++++++++++
 fs/exofs/ore.c         |    5 ++---
 include/linux/bio.h    |    1 +
 4 files changed, 17 insertions(+), 5 deletions(-)

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
diff --git a/fs/bio.c b/fs/bio.c
index fa6dee4..9d0ceb2 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -499,6 +499,19 @@ struct bio *bio_clone(struct bio *bio, gfp_t gfp_mask)
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
index 24a49d4..a8d92fc 100644
--- a/fs/exofs/ore.c
+++ b/fs/exofs/ore.c
@@ -814,8 +814,8 @@ static int _write_mirror(struct ore_io_state *ios, int cur_comp)
 			struct bio *bio;
 
 			if (per_dev != master_dev) {
-				bio = bio_kmalloc(GFP_KERNEL,
-						  master_dev->bio->bi_max_vecs);
+				bio = bio_clone_kmalloc(master_dev->bio,
+							GFP_KERNEL);
 				if (unlikely(!bio)) {
 					ORE_DBGMSG(
 					      "Failed to allocate BIO size=%u\n",
@@ -824,7 +824,6 @@ static int _write_mirror(struct ore_io_state *ios, int cur_comp)
 					goto out;
 				}
 
-				__bio_clone(bio, master_dev->bio);
 				bio->bi_bdev = NULL;
 				bio->bi_next = NULL;
 				per_dev->offset = master_dev->offset;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 9720544..e180f1d 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -221,6 +221,7 @@ extern int bio_phys_segments(struct request_queue *, struct bio *);
 
 extern void __bio_clone(struct bio *, struct bio *);
 extern struct bio *bio_clone(struct bio *, gfp_t);
+struct bio *bio_clone_kmalloc(struct bio *, gfp_t);
 
 extern void bio_init(struct bio *);
 extern void bio_reset(struct bio *);
-- 
1.7.7.3

