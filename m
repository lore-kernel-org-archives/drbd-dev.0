Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DC8B7105619A
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id C3F401B435E
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:32 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OvNz5EASh6Yd for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:32 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 9D6501B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:32 +0200 (CEST)
Resent-Message-ID: <20120810203332.GE31190@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A086E1045C2E
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 04:56:46 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so145359pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 19:56:44 -0700 (PDT)
Date: Wed, 8 Aug 2012 19:56:10 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120809025610.GK7262@moria.home.lan>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-12-git-send-email-koverstreet@google.com>
	<20120808232120.GK6983@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120808232120.GK6983@dhcp-172-17-108-109.mtv.corp.google.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 11/12] block: Add bio_clone_bioset()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Aug 08, 2012 at 04:21:20PM -0700, Tejun Heo wrote:
> On Mon, Aug 06, 2012 at 03:08:40PM -0700, Kent Overstreet wrote:
> > This consolidates some code, and will help in a later patch changing how
> > bio cloning works.
> 
> I think it would be better to introduce bio_clone*() functions in a
> separate patch and convert the users in a different one.
> 
> >  /**
> > - *	bio_clone	-	clone a bio
> > + *	bio_clone_bioset -	clone a bio
> >   *	@bio: bio to clone
> >   *	@gfp_mask: allocation priority
> > + *	@bs: bio_set to allocate from
> >   *
> >   * 	Like __bio_clone, only also allocates the returned bio
> >   */
> > -struct bio *bio_clone(struct bio *bio, gfp_t gfp_mask)
> > +struct bio *bio_clone_bioset(struct bio *bio, gfp_t gfp_mask,
> > +			     struct bio_set *bs)
> >  {
> > -	struct bio *b = bio_alloc(gfp_mask, bio->bi_max_vecs);
> > +	struct bio *b = bio_alloc_bioset(gfp_mask, bio->bi_max_vecs, bs);
> >  
> >  	if (!b)
> >  		return NULL;
> > @@ -485,7 +487,7 @@ struct bio *bio_clone(struct bio *bio, gfp_t gfp_mask)
> >  	if (bio_integrity(bio)) {
> >  		int ret;
> >  
> > -		ret = bio_integrity_clone(b, bio, gfp_mask, fs_bio_set);
> > +		ret = bio_integrity_clone(b, bio, gfp_mask, bs);
> >  
> >  		if (ret < 0) {
> >  			bio_put(b);
> > @@ -495,6 +497,12 @@ struct bio *bio_clone(struct bio *bio, gfp_t gfp_mask)
> >  
> >  	return b;
> >  }
> > +EXPORT_SYMBOL(bio_clone_bioset);
> > +
> > +struct bio *bio_clone(struct bio *bio, gfp_t gfp_mask)
> > +{
> > +	return bio_clone_bioset(bio, gfp_mask, fs_bio_set);
> > +}
> 
> So, bio_clone() loses its function comment.  Also, does it even make
> sense to call bio_clone() from fs_bio_set?

I'll re add the function comment if you want, just for a single line
wrapper I don't know if it's worth the cost - comments get out of date,
and they're more stuff to wade through.

> Let's say it's so, then
> what's the difference from using _kmalloc variant?

bio_kmalloc() fails if nr_iovecs > 1024, bio_alloc_bioset() fails if
nr_iovecs > 256

and bio_alloc_bioset() is mempool backed, bio_kmalloc() is not.

AFAICT that's it.
