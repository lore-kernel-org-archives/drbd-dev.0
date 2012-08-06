Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2CE0D1045C2E
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 26B561B435C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:18 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y-hc-ie01neX for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:18 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 0760C1B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:18 +0200 (CEST)
Resent-Message-ID: <20120810203317.GK31190@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8B35F103B4A4
	for <drbd-dev@lists.linbit.com>; Tue,  7 Aug 2012 00:09:15 +0200 (CEST)
Received: by mail-pb0-f54.google.com with SMTP id rp2so2275366pbb.27
	for <drbd-dev@lists.linbit.com>; Mon, 06 Aug 2012 15:09:15 -0700 (PDT)
From: Kent Overstreet <koverstreet@google.com>
To: linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com
Date: Mon,  6 Aug 2012 15:08:35 -0700
Message-Id: <1344290921-25154-7-git-send-email-koverstreet@google.com>
In-Reply-To: <1344290921-25154-1-git-send-email-koverstreet@google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, neilb@suse.de, Kent Overstreet <koverstreet@google.com>,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	tj@kernel.org, sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v5 06/12] block: Add an explicit bio flag for
	bios that own their bvec
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is for the new bio splitting code. When we split a bio, if the
split occured on a bvec boundry we reuse the bvec for the new bio. But
that means bio_free() can't free it, hence the explicit flag.

Signed-off-by: Kent Overstreet <koverstreet@google.com>
---
 fs/bio.c                  |    3 ++-
 include/linux/bio.h       |    5 -----
 include/linux/blk_types.h |    1 +
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/bio.c b/fs/bio.c
index ebc7309..ff34311 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -249,7 +249,7 @@ void bio_free(struct bio *bio)
 		return;
 	}
 
-	if (bio_has_allocated_vec(bio))
+	if (bio_flagged(bio, BIO_OWNS_VEC))
 		bvec_free_bs(bs, bio->bi_io_vec, BIO_POOL_IDX(bio));
 
 	if (bio_integrity(bio))
@@ -321,6 +321,7 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, int nr_iovecs, struct bio_set *bs)
 			goto err_free;
 
 		nr_iovecs = bvec_nr_vecs(idx);
+		bio->bi_flags |= 1 << BIO_OWNS_VEC;
 	}
 out_set:
 	bio->bi_flags |= idx << BIO_POOL_OFFSET;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 393c87e..484b96e 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -84,11 +84,6 @@ static inline void *bio_data(struct bio *bio)
 	return NULL;
 }
 
-static inline int bio_has_allocated_vec(struct bio *bio)
-{
-	return bio->bi_io_vec && bio->bi_io_vec != bio->bi_inline_vecs;
-}
-
 /*
  * will die
  */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d10c2e49..416aae4 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -113,6 +113,7 @@ struct bio {
 #define BIO_MAPPED_INTEGRITY 11/* integrity metadata has been remapped */
 
 #define BIO_RESET_BITS	12	/* Flags starting here get preserved by bio_reset() */
+#define BIO_OWNS_VEC	12	/* bio_free() should free bvec */
 
 #define bio_flagged(bio, flag)	((bio)->bi_flags & (1 << (flag)))
 
-- 
1.7.7.3

