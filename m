Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 61FB81005420
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:04:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 5BC2F1B4262
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:04:01 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id arla7xIQ+0QB for <drbd-dev@lists.linbit.com>;
	Fri, 25 May 2012 09:04:01 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 37E4E1B4206
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:04:01 +0200 (CEST)
Resent-Message-ID: <20120525070401.GL12726@soda.linbit>
Received: from mail-pz0-f54.google.com (mail-pz0-f54.google.com
	[209.85.210.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9754F1013803
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 23:27:28 +0200 (CEST)
Received: by dadv36 with SMTP id v36so402508dad.27
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 14:27:26 -0700 (PDT)
Date: Thu, 24 May 2012 14:27:23 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Boaz Harrosh <bharrosh@panasas.com>
Message-ID: <20120524212723.GA22664@google.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-12-git-send-email-koverstreet@google.com>
	<4FBE6823.50904@panasas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FBE6823.50904@panasas.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	vgoyal@redhat.com, yehuda@hq.newdream.net,
	linux-fsdevel@vger.kernel.org, sage@newdream.net, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 11/14] block: Rework bio splitting
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, May 24, 2012 at 07:56:03PM +0300, Boaz Harrosh wrote:
> Again could you please take this bio_split and just put
> it down below the implementation of bio_pair_split. This way
> we can better review what the changes actually are. Now it
> is a complete mess in the diff, where the deleted lines of the
> bio_pair_release are in between the new lines of bio_split().
> Please ???

Ahh, I saw that comment but I missed what it was that you wanted me to
reorder. Will do.

> 
> > +struct bio *bio_split(struct bio *bio, int sectors,
> > +		      gfp_t gfp, struct bio_set *bs)
> >  {
> 
> 
> 
> 
> This is a freaking important and capable exported function.
> Could you please put some comment on what it does and what are
> it's limitation.

Yeah, I'll do that.

> For example the returned bio is the beginning of the chain
> and the original is the reminder, right?

Yes. 

> 
> > -	if (atomic_dec_and_test(&bp->cnt)) {
> > -		struct bio *master = bp->bio1.bi_private;
> > +	unsigned idx, vcnt = 0, nbytes = sectors << 9;
> > +	struct bio_vec *bv;
> > +	struct bio *ret = NULL;
> > +
> > +	BUG_ON(sectors <= 0);
> > +
> > +	/*
> > +	 * If we're being called from underneath generic_make_request() and we
> > +	 * already allocated any bios from this bio set, we risk deadlock if we
> > +	 * use the mempool. So instead, we possibly fail and let the caller punt
> > +	 * to workqueue or somesuch and retry in a safe context.
> > +	 */
> > +	if (current->bio_list)
> > +		gfp &= ~__GFP_WAIT;
> 
> 
> 
> 
> Is this true also when @bio is not from @bs ?

Yes. Not masking out __GFP_WAIT would only be safe if you could
guarantee that you never tried to split a bio more than once (from the
same bio set), and IMO that'd be a terrible thing to rely on.

> 
> Is it at all supported when they are not the same?

When what's not the same?

> 
> Are kmalloc bios not split-able?

They are.

> 
> Please put answer to these in above comment.
> 
> In the split you have a single bio with or without bvects allocation
> should you not let the caller make sure not to set __GFP_WAIT.
> 
> For me, inspecting current->bio_list is out of context and a complete
> hack. The caller should take care of it, which has more context.

I agree that it is hacky, but shifting the responsibility onto the
caller would IMO be much more likely to lead to buggy code in the
future (and those deadlocks are not going to be easy to track down).

It might be better to mask out __GFP_WAIT in bio_alloc_bioset(), I'm not
sure.

> For example I might want to use split from OSD code where I do
> not use an elevator at all, and current->bio_list could belong
> to a completely different device. (Maybe)

Doesn't matter. If you allocate a split, it won't free itself until the
IO is submitted and completes; current->bio_list != NULL the bio cannot
complete until you return.

> I don't see below any references taken by "ret" on @bio.
> What protects us from @bio not been freed before "ret" ?
> 
> If it's the caller responsibility please say so in
> comment above 

Yeah, caller responsibility. Will do.

> 
> > +		} else if (nbytes < bv->bv_len) {
> > +			ret = bio_alloc_bioset(gfp, ++vcnt, bs);
> > +			if (!ret)
> > +				return NULL;
> 
> 
> 
> 
> We could in this case save and only allocate one more bio with a single
> bio_vec and chain it to the end.

I thought about that, but this works for now - my preferred solution is
to make bi_io_vec immutable (that'll require a bi_bvec_offset field in
struct bio, and the end result is we'd be able to split mid bvec and
share the bvec with both bios).

> 
> And if you change it around, where the reminder is "ret" and the
> beginning of the chain is left @bio. you wouldn't even need the
> extra bio. (Trim the last and a single-bvec bio holds the reminder + remainder-chain)

Don't follow... If you're processing a bio starting from the smallest
sector though, you want the split to be the front of the bio otherwise
if you split multiple times you'll try to split a split, and deadlock.
