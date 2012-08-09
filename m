Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D21FC1055F7D
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id CD0061B435C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:26 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ahWtw0010dX0 for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:26 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id B3F611B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:26 +0200 (CEST)
Resent-Message-ID: <20120810203326.GV31190@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BD9C11045C2E
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 02:07:47 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so2778561pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 17:07:45 -0700 (PDT)
Date: Wed, 8 Aug 2012 17:07:11 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120809000711.GB7262@moria.home.lan>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-4-git-send-email-koverstreet@google.com>
	<20120808221129.GB6983@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120808221129.GB6983@dhcp-172-17-108-109.mtv.corp.google.com>
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

On Wed, Aug 08, 2012 at 03:11:29PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Mon, Aug 06, 2012 at 03:08:32PM -0700, Kent Overstreet wrote:
> > Reusing bios is something that's been highly frowned upon in the past,
> > but driver code keeps doing it anyways. If it's going to happen anyways,
> > we should provide a generic method.
> > 
> > This'll help with getting rid of bi_destructor - drivers/block/pktcdvd.c
> > was open coding it, by doing a bio_init() and resetting bi_destructor.
> > 
> > v5: Add a define BIO_RESET_BITS, to be very explicit about what parts of
> > bio->bi_flags are saved.
> > 
> > Signed-off-by: Kent Overstreet <koverstreet@google.com>
> > Change-Id: I4eb2975bd678d3be811d5423d0620b08020be9ff
> 
> Please drop Change-Id.  Die gerrit die.

Bah, missed that one. 

> > +void bio_reset(struct bio *bio)
> > +{
> > +	unsigned long flags = bio->bi_flags & (~0UL << BIO_RESET_BITS);
> 
> How many flags are we talking about?  If there aren't too many, I'd
> prefer explicit BIO_FLAGS_PRESERVED or whatever.

It mostly isn't actual flags that are preserved - the high bits of the
flags are used for indicating what slab the bvec was allocated from, and
that's the main thing that has to be preserved.

So that's why I went with defining the things that are reset instead of
the things that are preserved.

I would prefer if bitfields were used for at least BIO_POOL_IDX, but the
problem is flags is used as an atomic bit vector for BIO_UPTODATE.

But flags isn't treated as an atomic bit vector elsewhere -
bio_flagged() doesn't use test_bit(), and flags are set/cleared with
atomic bit operations in some places but not in others (probably _most_
of them are technically safe, but... ick).

> 
> Thanks.
> 
> -- 
> tejun
