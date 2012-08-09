Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9087D1056191
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 5E6E11B435E
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:31 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JtmKCP23s4Gy for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:31 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 325BA1B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:31 +0200 (CEST)
Resent-Message-ID: <20120810203331.GC31190@soda.linbit>
Received: from mail-yx0-f182.google.com (mail-yx0-f182.google.com
	[209.85.213.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7D22B1045C2E
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 03:57:39 +0200 (CEST)
Received: by yenl7 with SMTP id l7so2272096yen.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 18:57:38 -0700 (PDT)
Date: Wed, 8 Aug 2012 18:57:04 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120809015704.GI7262@moria.home.lan>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-11-git-send-email-koverstreet@google.com>
	<20120808231552.GJ6983@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120808231552.GJ6983@dhcp-172-17-108-109.mtv.corp.google.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 10/12] block: Add bio_clone_kmalloc()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Aug 08, 2012 at 04:15:52PM -0700, Tejun Heo wrote:
> On Mon, Aug 06, 2012 at 03:08:39PM -0700, Kent Overstreet wrote:
> 
> How about the following?
> 
> There was no API to kmalloc bio and clone and osdblk was using
> explicit bio_kmalloc() + __bio_clone().  (my guess here) As this is
> inconvenient and there will be more users of it in the future, add
> bio_clone_kmalloc() and use it in osdblk.

Adding that.

> 
> > Acked-by: Boaz Harrosh <bharrosh@panasas.com>
> > Signed-off-by: Kent Overstreet <koverstreet@google.com>
> > ---
> >  drivers/block/osdblk.c |    3 +--
> >  fs/bio.c               |   13 +++++++++++++
> >  fs/exofs/ore.c         |    5 ++---
> >  include/linux/bio.h    |    1 +
> >  4 files changed, 17 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/block/osdblk.c b/drivers/block/osdblk.c
> > index 87311eb..1bbc681 100644
> > --- a/drivers/block/osdblk.c
> > +++ b/drivers/block/osdblk.c
> > @@ -266,11 +266,10 @@ static struct bio *bio_chain_clone(struct bio *old_chain, gfp_t gfpmask)
> >  	struct bio *tmp, *new_chain = NULL, *tail = NULL;
> >  
> >  	while (old_chain) {
> > -		tmp = bio_kmalloc(gfpmask, old_chain->bi_max_vecs);
> > +		tmp = bio_clone_kmalloc(old_chain, gfpmask);
> >  		if (!tmp)
> >  			goto err_out;
> >  
> > -		__bio_clone(tmp, old_chain);
> >  		tmp->bi_bdev = NULL;
> >  		gfpmask &= ~__GFP_WAIT;
> >  		tmp->bi_next = NULL;
> > diff --git a/fs/bio.c b/fs/bio.c
> > index f0c865b..77b9313 100644
> > --- a/fs/bio.c
> > +++ b/fs/bio.c
> > @@ -497,6 +497,19 @@ struct bio *bio_clone(struct bio *bio, gfp_t gfp_mask)
> >  }
> >  EXPORT_SYMBOL(bio_clone);
> >  
> 
> /**
> 
> PLEASE.
> 
> > +struct bio *bio_clone_kmalloc(struct bio *bio, gfp_t gfp_mask)
> > +{
> > +	struct bio *b = bio_kmalloc(gfp_mask, bio->bi_max_vecs);
> 
> Can't we use %NULL bioset as an indication to allocate from kmalloc
> instead of duping interfaces like this?

The two aren't mutually exclusive - but using BIO_KMALLOC_POOL instead
of separate interfaces is an excellent idea, I'll do that.

That means bio_clone_kmalloc will just become:

static inline struct bio *bio_clone_kmalloc(struct bio *bio,
					    gfp_t gfp_mask)
{
	return bio_clone_bioset(bio, gfp_mask, BIO_KMALLOC_POOL)
}

(or maybe NULL there, I think using NULL for the interface makes sense,
I just don't want to use it for bi_pool).

Do you still want the /** for a one line wrapper like that?


> 
> Thanks.
> 
> -- 
> tejun
