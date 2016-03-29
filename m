Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id CD5A81056421
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2016 10:09:22 +0200 (CEST)
Date: Tue, 29 Mar 2016 10:09:21 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <20160329080921.GG15579@soda.linbit>
References: <1458627149-12988-1-git-send-email-ming.lei@canonical.com>
	<1458627149-12988-8-git-send-email-ming.lei@canonical.com>
	<20160329073124.GH18920@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160329073124.GH18920@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Boaz Harrosh <boaz@plexistor.com>,
	Ming Lei <ming.lei@canonical.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	xfs@oss.sgi.com, linux-block@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 7/8] block: drbd: avoid to use BIO_MAX_SIZE
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Mar 29, 2016 at 12:31:24AM -0700, Christoph Hellwig wrote:
> On Tue, Mar 22, 2016 at 02:12:28PM +0800, Ming Lei wrote:
> > drbd is the only user of BIO_MAX_SIZE, so use BIO_MAX_PAGES
> > instead.
> 
> That whole code block looks completely bogus to me, although your patch
> doesn't make it any worse.
> 
> I/O size for a network protocol shouldn't dependend on the number of
> vectors in a kernel internal structure.

That's correct.  But we needed some limit there.
Initially, up until I changed it like six years ago iirc,
the receiving side would receive into a single bio.
So limiting us to what a single bio could usually handle
seemed like a good idea at the time.

Today, we should be able to handle 128 MiB easily,
maybe more. But that would require a protocol bump
to stay backwards compatible.

The part about "architecture not supported",
if our limit (1 MiB) is bigger than the "system" limit:
Never met that in real life. Probably not even possible.
Just a paranoia on my side: what if.
If that would have happened somewhere,
on some strange architecture or configuration,
I wanted to know about that.
Best way: don't even compile.

> Well, getting rid of BIO_MAX_SIZE is worth it, so:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks,

    Lars Ellenberg

