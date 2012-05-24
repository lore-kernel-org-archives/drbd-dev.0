Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8E9671005415
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 814781B4262
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:02 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GyVeDXMWtzcr for <drbd-dev@lists.linbit.com>;
	Thu, 24 May 2012 18:15:02 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 5F4771B40FA
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:02 +0200 (CEST)
Resent-Message-ID: <20120524161502.GH5734@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 63CDC1013803
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 02:03:31 +0200 (CEST)
Received: by mail-pb0-f54.google.com with SMTP id ro2so13647885pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2012 17:03:31 -0700 (PDT)
From: Kent Overstreet <koverstreet@google.com>
To: linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	dm-devel@redhat.com, linux-fsdevel@vger.kernel.org
Date: Wed, 23 May 2012 17:02:46 -0700
Message-Id: <1337817771-25038-10-git-send-email-koverstreet@google.com>
In-Reply-To: <1337817771-25038-1-git-send-email-koverstreet@google.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, neilb@suse.de,
	Kent Overstreet <koverstreet@google.com>, mpatocka@redhat.com,
	vgoyal@redhat.com, bharrosh@panasas.com, tj@kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v2 09/14] block: Add an explicit bio flag for
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
Change-Id: I040f6b501088e882a9f013d6b6e730ff04e9c1da
---
 fs/bio.c                  |    3 ++-
 include/linux/bio.h       |    5 -----
 include/linux/blk_types.h |    1 +
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/bio.c b/fs/bio.c
index fc4a168..24b1d1c 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -241,7 +241,7 @@ void bio_free(struct bio *bio, struct bio_set *bs)
 		return;
 	}
 
-	if (bio_has_allocated_vec(bio))
+	if (bio_flagged(bio, BIO_HAS_VEC))
 		bvec_free_bs(bs, bio->bi_io_vec, BIO_POOL_IDX(bio));
 
 	if (bio_integrity(bio))
@@ -312,6 +312,7 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, int nr_iovecs, struct bio_set *bs)
 			goto err_free;
 
 		nr_iovecs = bvec_nr_vecs(idx);
+		bio->bi_flags |= 1 << BIO_HAS_VEC;
 	}
 out_set:
 	bio->bi_flags |= idx << BIO_POOL_OFFSET;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 35f7c4d..8dd8cae 100644
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
index b6ddbf1..ab2252d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -101,6 +101,7 @@ struct bio {
 #define BIO_FS_INTEGRITY 9	/* fs owns integrity data, not block layer */
 #define BIO_QUIET	10	/* Make BIO Quiet */
 #define BIO_MAPPED_INTEGRITY 11/* integrity metadata has been remapped */
+#define BIO_HAS_VEC	12	/* bio_free() should free bvec */
 #define bio_flagged(bio, flag)	((bio)->bi_flags & (1 << (flag)))
 
 /*
-- 
1.7.9.3.327.g2980b

