Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 085301005431
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:04:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id D78E51B4268
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:04:05 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eU8-+o6kJAZc for <drbd-dev@lists.linbit.com>;
	Fri, 25 May 2012 09:04:05 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id BB95D1B4206
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:04:05 +0200 (CEST)
Resent-Message-ID: <20120525070405.GP12726@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id AB3381019A78
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 01:35:37 +0200 (CEST)
Received: by pbbro2 with SMTP id ro2so1240528pbb.27
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 16:35:36 -0700 (PDT)
Date: Thu, 24 May 2012 16:35:33 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID: <20120524233532.GE22664@google.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-4-git-send-email-koverstreet@google.com>
	<20120524184507.GD27550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120524184507.GD27550@redhat.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	bharrosh@panasas.com, linux-fsdevel@vger.kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 03/14] block: Add bio_clone_bioset()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, May 24, 2012 at 02:45:07PM -0400, Vivek Goyal wrote:
> On Wed, May 23, 2012 at 05:02:40PM -0700, Kent Overstreet wrote:
> 
> [..]
> > --- a/drivers/md/dm.c
> > +++ b/drivers/md/dm.c
> > @@ -1062,26 +1062,19 @@ static struct bio *split_bvec(struct bio *bio, sector_t sector,
> >   * Creates a bio that consists of range of complete bvecs.
> >   */
> >  static struct bio *clone_bio(struct bio *bio, sector_t sector,
> > -			     unsigned short idx, unsigned short bv_count,
> > +			     unsigned short bv_count,
> >  			     unsigned int len, struct bio_set *bs)
> >  {
> >  	struct bio *clone;
> >  
> > -	clone = bio_alloc_bioset(GFP_NOIO, bio->bi_max_vecs, bs);
> > -	__bio_clone(clone, bio);
> > +	clone = bio_clone_bioset(bio, GFP_NOIO, bs);
> >  	clone->bi_sector = sector;
> > -	clone->bi_idx = idx;
> > -	clone->bi_vcnt = idx + bv_count;
> > +	clone->bi_vcnt = bv_count;
> 
> In last posting you said that you are going to backout this idx change
> because you were not sure if it is correct. 

Yeah, I distinctly remember doing that but clearly something got lost.
Sorry.

Anyways, that change shouldn't have been part of that patch, but
something has to change there for the "Only clone bio vecs that are in
use" patch.

Gonna take a stab at reworking that code, it really ought to be possible
to just replace it with my bio splitting code but the way dm is doing
the splitting is... confusing.
