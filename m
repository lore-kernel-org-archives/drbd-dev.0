Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 96308103B4B1
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 905801B435E
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:15 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sivs-UjSGVck for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:15 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 70F231B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:15 +0200 (CEST)
Resent-Message-ID: <20120810203315.GH31190@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 81C94100542F
	for <drbd-dev@lists.linbit.com>; Tue,  7 Aug 2012 00:09:10 +0200 (CEST)
Received: by mail-pb0-f54.google.com with SMTP id rp2so2275323pbb.27
	for <drbd-dev@lists.linbit.com>; Mon, 06 Aug 2012 15:09:10 -0700 (PDT)
From: Kent Overstreet <koverstreet@google.com>
To: linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com
Date: Mon,  6 Aug 2012 15:08:32 -0700
Message-Id: <1344290921-25154-4-git-send-email-koverstreet@google.com>
In-Reply-To: <1344290921-25154-1-git-send-email-koverstreet@google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, neilb@suse.de, Kent Overstreet <koverstreet@google.com>,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	tj@kernel.org, sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v5 03/12] block: Add bio_reset()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Reusing bios is something that's been highly frowned upon in the past,
but driver code keeps doing it anyways. If it's going to happen anyways,
we should provide a generic method.

This'll help with getting rid of bi_destructor - drivers/block/pktcdvd.c
was open coding it, by doing a bio_init() and resetting bi_destructor.

v5: Add a define BIO_RESET_BITS, to be very explicit about what parts of
bio->bi_flags are saved.

Signed-off-by: Kent Overstreet <koverstreet@google.com>
Change-Id: I4eb2975bd678d3be811d5423d0620b08020be9ff
---
 fs/bio.c                  |    9 +++++++++
 include/linux/bio.h       |    1 +
 include/linux/blk_types.h |    9 +++++++++
 3 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/fs/bio.c b/fs/bio.c
index 1c6c8b7..c7f3442 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -261,6 +261,15 @@ void bio_init(struct bio *bio)
 }
 EXPORT_SYMBOL(bio_init);
 
+void bio_reset(struct bio *bio)
+{
+	unsigned long flags = bio->bi_flags & (~0UL << BIO_RESET_BITS);
+
+	memset(bio, 0, BIO_RESET_BYTES);
+	bio->bi_flags = flags|(1 << BIO_UPTODATE);
+}
+EXPORT_SYMBOL(bio_reset);
+
 /**
  * bio_alloc_bioset - allocate a bio for I/O
  * @gfp_mask:   the GFP_ mask given to the slab allocator
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 2643589..ba60319 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -226,6 +226,7 @@ extern void __bio_clone(struct bio *, struct bio *);
 extern struct bio *bio_clone(struct bio *, gfp_t);
 
 extern void bio_init(struct bio *);
+extern void bio_reset(struct bio *);
 
 extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 293547e..401c573 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -59,6 +59,10 @@ struct bio {
 	unsigned int		bi_seg_front_size;
 	unsigned int		bi_seg_back_size;
 
+	/*
+	 * Everything starting with bi_max_vecs will be preserved by bio_reset()
+	 */
+
 	unsigned int		bi_max_vecs;	/* max bvl_vecs we can hold */
 
 	atomic_t		bi_cnt;		/* pin count */
@@ -93,6 +97,8 @@ struct bio {
 	struct bio_vec		bi_inline_vecs[0];
 };
 
+#define BIO_RESET_BYTES		offsetof(struct bio, bi_max_vecs)
+
 /*
  * bio flags
  */
@@ -108,6 +114,9 @@ struct bio {
 #define BIO_FS_INTEGRITY 9	/* fs owns integrity data, not block layer */
 #define BIO_QUIET	10	/* Make BIO Quiet */
 #define BIO_MAPPED_INTEGRITY 11/* integrity metadata has been remapped */
+
+#define BIO_RESET_BITS	12	/* Flags starting here get preserved by bio_reset() */
+
 #define bio_flagged(bio, flag)	((bio)->bi_flags & (1 << (flag)))
 
 /*
-- 
1.7.7.3

