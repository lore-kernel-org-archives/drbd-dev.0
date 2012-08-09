Return-Path: <htejun@gmail.com>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2D0D9103B4DA
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 08:00:26 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so426106pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 23:00:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 8 Aug 2012 23:00:19 -0700
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120809060019.GA2845@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-4-git-send-email-koverstreet@google.com>
	<20120808221129.GB6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120809000711.GB7262@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120809000711.GB7262@moria.home.lan>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 03/12] block: Add bio_reset()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello,

On Wed, Aug 08, 2012 at 05:07:11PM -0700, Kent Overstreet wrote:
> > > +void bio_reset(struct bio *bio)
> > > +{
> > > +	unsigned long flags = bio->bi_flags & (~0UL << BIO_RESET_BITS);
> > 
> > How many flags are we talking about?  If there aren't too many, I'd
> > prefer explicit BIO_FLAGS_PRESERVED or whatever.
> 
> It mostly isn't actual flags that are preserved - the high bits of the
> flags are used for indicating what slab the bvec was allocated from, and
> that's the main thing that has to be preserved.
> 
> So that's why I went with defining the things that are reset instead of
> the things that are preserved.
> 
> I would prefer if bitfields were used for at least BIO_POOL_IDX, but the
> problem is flags is used as an atomic bit vector for BIO_UPTODATE.
> 
> But flags isn't treated as an atomic bit vector elsewhere -
> bio_flagged() doesn't use test_bit(), and flags are set/cleared with

Not using test_bit() may not be necessarily wrong.

> atomic bit operations in some places but not in others (probably _most_
> of them are technically safe, but... ick).

Mixing atomic and non-atomic modifications is almost always wrong tho.

Anyways, understood.  Can you *please* put some comment what bits are
being preserved across reset then?  Things like this aren't obvious at
all and need ample explanation.

Thanks.

-- 
tejun
