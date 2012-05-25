Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B944010003D2
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:30:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 8EC4E1B4351
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:30:08 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hq1RpZrRxjla for <drbd-dev@lists.linbit.com>;
	Fri, 25 May 2012 22:30:08 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 52F1C1B40F5
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:30:08 +0200 (CEST)
Resent-Message-ID: <20120525203008.GG1903@soda.linbit>
Received: from mail-pz0-f54.google.com (mail-pz0-f54.google.com
	[209.85.210.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 502281012A92
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:26:15 +0200 (CEST)
Received: by dadv36 with SMTP id v36so2229995dad.27
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 13:26:13 -0700 (PDT)
From: Kent Overstreet <koverstreet@google.com>
To: linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	dm-devel@redhat.com, linux-fsdevel@vger.kernel.org
Date: Fri, 25 May 2012 13:25:26 -0700
Message-Id: <1337977539-16977-4-git-send-email-koverstreet@google.com>
In-Reply-To: <1337977539-16977-1-git-send-email-koverstreet@google.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, neilb@suse.de,
	Kent Overstreet <koverstreet@google.com>, mpatocka@redhat.com,
	vgoyal@redhat.com, bharrosh@panasas.com, tj@kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v3 03/16] block: Add bio_reset()
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

Signed-off-by: Kent Overstreet <koverstreet@google.com>
Change-Id: Ib0a43dfcb3f6c22a54da513d4a86be544b5ffd95
---
 fs/bio.c                  |    8 ++++++++
 include/linux/bio.h       |    1 +
 include/linux/blk_types.h |    6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/fs/bio.c b/fs/bio.c
index 3667cef..240da21 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -259,6 +259,14 @@ void bio_init(struct bio *bio)
 }
 EXPORT_SYMBOL(bio_init);
 
+void bio_reset(struct bio *bio)
+{
+	memset(bio, 0, BIO_RESET_BYTES);
+	bio->bi_flags = 1 << BIO_UPTODATE;
+
+}
+EXPORT_SYMBOL(bio_reset);
+
 /**
  * bio_alloc_bioset - allocate a bio for I/O
  * @gfp_mask:   the GFP_ mask given to the slab allocator
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 4d94eb8..e5c2504 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -226,6 +226,7 @@ extern void __bio_clone(struct bio *, struct bio *);
 extern struct bio *bio_clone(struct bio *, gfp_t);
 
 extern void bio_init(struct bio *);
+extern void bio_reset(struct bio *);
 
 extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index dc0e399..6b7daf3 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -57,6 +57,10 @@ struct bio {
 	unsigned int		bi_seg_front_size;
 	unsigned int		bi_seg_back_size;
 
+	/*
+	 * Everything starting with bi_max_vecs will be preserved by bio_reset()
+	 */
+
 	unsigned int		bi_max_vecs;	/* max bvl_vecs we can hold */
 
 	atomic_t		bi_cnt;		/* pin count */
@@ -83,6 +87,8 @@ struct bio {
 	struct bio_vec		bi_inline_vecs[0];
 };
 
+#define BIO_RESET_BYTES		offsetof(struct bio, bi_max_vecs)
+
 /*
  * bio flags
  */
-- 
1.7.9.3.327.g2980b

