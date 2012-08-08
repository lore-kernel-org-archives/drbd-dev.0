Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 59B091055F6B
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 527921B435C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:26 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id na5PHWJRO6cI for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:26 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 387B31B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:26 +0200 (CEST)
Resent-Message-ID: <20120810203326.GU31190@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C90061045C2E
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 01:58:08 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so2764796pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 16:58:06 -0700 (PDT)
Date: Wed, 8 Aug 2012 16:57:32 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120808235731.GA7262@moria.home.lan>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-3-git-send-email-koverstreet@google.com>
	<20120808220612.GA6983@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120808220612.GA6983@dhcp-172-17-108-109.mtv.corp.google.com>
Cc: axboe@kernel.dk, snitzer@redhat.com, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 02/12] dm: Use bioset's front_pad for
 dm_rq_clone_bio_info
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Aug 08, 2012 at 03:06:12PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Mon, Aug 06, 2012 at 03:08:31PM -0700, Kent Overstreet wrote:
> > Previously, dm_rq_clone_bio_info needed to be freed by the bio's
> > destructor to avoid a memory leak in the blk_rq_prep_clone() error path.
> > This gets rid of a memory allocation and means we can kill
> > dm_rq_bio_destructor.
> > 
> > Signed-off-by: Kent Overstreet <koverstreet@google.com>
> > ---
> >  drivers/md/dm.c |   31 +++++--------------------------
> >  1 files changed, 5 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > index 40b7735..4014696 100644
> > --- a/drivers/md/dm.c
> > +++ b/drivers/md/dm.c
> > @@ -92,6 +92,7 @@ struct dm_rq_target_io {
> >  struct dm_rq_clone_bio_info {
> >  	struct bio *orig;
> >  	struct dm_rq_target_io *tio;
> > +	struct bio clone;
> >  };
> ...
> > @@ -2696,7 +2674,8 @@ struct dm_md_mempools *dm_alloc_md_mempools(unsigned type, unsigned integrity)
> >  	if (!pools->tio_pool)
> >  		goto free_io_pool_and_out;
> >  
> > -	pools->bs = bioset_create(pool_size, 0);
> > +	pools->bs = bioset_create(pool_size,
> > +				  offsetof(struct dm_rq_clone_bio_info, orig));
> >  	if (!pools->bs)
> >  		goto free_tio_pool_and_out;
> 
> I do like this approach much better but this isn't something
> super-obvious.  Can we please explain what's going on?  Especially,
> the comment above dm_rq_clone_bio_info is outright misleading now.

This look better to you?

/*
 * For request-based dm - the bio clones we allocate are embedded in these
 * structs.
 *
 * We allocate these with bio_alloc_bioset, using the front_pad parameter when
 * the bioset is created - this means the bio has to come at the end of the
 * struct.
 */
struct dm_rq_clone_bio_info {
	struct bio *orig;
	struct dm_rq_target_io *tio;
	struct bio clone;
};

> Can someone more familiar review this one?  Alasdir, Mike?
> 
> Also, how was this tested?

Well, AFAICT the only request based dm target is multipath, and from the
documentation I've seen it doesn't appear to work without multipath
hardware, or at least I haven't seen it documented how. So, unless
there's another user I missed it's not been tested.

> 
> Thanks.
> 
> -- 
> tejun
