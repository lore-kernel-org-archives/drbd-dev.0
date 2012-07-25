Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E93AD1005438
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id DDD821B4369
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:55 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pRYz4wYmM-fI for <drbd-dev@lists.linbit.com>;
	Thu, 26 Jul 2012 11:35:55 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id BDAD71B4368
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 11:35:55 +0200 (CEST)
Resent-Message-ID: <20120726093554.GE29767@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B40061005431
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2012 00:56:26 +0200 (CEST)
Received: by pbbro2 with SMTP id ro2so2682388pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 25 Jul 2012 15:56:25 -0700 (PDT)
Date: Wed, 25 Jul 2012 15:56:20 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Boaz Harrosh <bharrosh@panasas.com>
Message-ID: <20120725225620.GA8673@moria.home.lan>
References: <1343160689-12378-1-git-send-email-koverstreet@google.com>
	<1343160689-12378-4-git-send-email-koverstreet@google.com>
	<500FD63F.7050501@panasas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <500FD63F.7050501@panasas.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	tj@kernel.org, sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v4 03/12] block: Add bio_reset()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Jul 25, 2012 at 02:19:27PM +0300, Boaz Harrosh wrote:
> On 07/24/2012 11:11 PM, Kent Overstreet wrote:
> 
> > Reusing bios is something that's been highly frowned upon in the past,
> > but driver code keeps doing it anyways. If it's going to happen anyways,
> > we should provide a generic method.
> > 
> > This'll help with getting rid of bi_destructor - drivers/block/pktcdvd.c
> > was open coding it, by doing a bio_init() and resetting bi_destructor.
> > 
> > Signed-off-by: Kent Overstreet <koverstreet@google.com>
> > ---
> >  fs/bio.c                  |   10 ++++++++++
> >  include/linux/bio.h       |    1 +
> >  include/linux/blk_types.h |    6 ++++++
> >  3 files changed, 17 insertions(+), 0 deletions(-)
> > 
> > diff --git a/fs/bio.c b/fs/bio.c
> > index 1c6c8b7..252e253 100644
> > --- a/fs/bio.c
> > +++ b/fs/bio.c
> > @@ -261,6 +261,16 @@ void bio_init(struct bio *bio)
> >  }
> >  EXPORT_SYMBOL(bio_init);
> >  
> > +void bio_reset(struct bio *bio)
> > +{
> > +	/* Clear all flags below BIO_OWNS_VEC */
> > +	unsigned long flags = bio->bi_flags & (~0UL << BIO_OWNS_VEC);
> > +
> 
> 
> Hey I have not seen these FLAGS thing before. Are these new?
> 
> Anyway. Please NO!!! for one you need to put a big fat comment
> over at flags definitions. And two what happens when one adds
> a new flag. Is it reset or not reset?
> 
> I'd rather you define a flags mask for those that need to be
> preserved, at header, plus a comment that any needed-to-be-preserved
> cross init flags, must be added to the mask.

Yeah, that's a much better idea. Do you think this is clear enough?

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
index 293547e..769799f 100644
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
+#define BIO_RESET_BITS 12	/* Flags starting here get preserved by bio_reset() */
+
 #define bio_flagged(bio, flag)	((bio)->bi_flags & (1 << (flag)))
 
 /*
