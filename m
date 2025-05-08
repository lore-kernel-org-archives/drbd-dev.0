Return-Path: <BATV+b29930b5fa9b2b8daadf+7928+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 14BBD160917
	for <drbd-dev@lists.linbit.com>; Thu,  8 May 2025 12:06:53 +0200 (CEST)
Date: Thu, 8 May 2025 03:06:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?=
	<christoph.boehmwalder@linbit.com>,
	drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Subject: Re: transferring bvecs over the network in drbd
Message-ID: <aByCPR7Ynl93qDiY@infradead.org>
References: <aBxTHl8UIwr9Ehuv@infradead.org> <aBxt3NsJcofxhV5P@grappa.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBxt3NsJcofxhV5P@grappa.linbit>
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, May 08, 2025 at 10:39:56AM +0200, Lars Ellenberg wrote:
> For async replication, we want to actually copy data into send buffer,
> we cannot have the network stack hold a reference to a page for which
> we signalled io completion already.
> 
> For sync replication we want to avoid additional data copy if possible,
> so try to use "zero copy sendpage".

I didn't even complain about having both variants :)

> 
> That's why we have two variants of what looks to be the same thing.
> 
> Why we do it that way: probably when we wrote that part,
> a better infrastructure was not available, or we were not aware of it.

Yes.  While the iov_iter and the bvec version of have been around
for a long time, drbd probably still predates them.

> Thanks for the pointers, we'll look into it.
> Using more efficient ways to do stuff sounds good.

thanks.  Note that now that ->sendpage has been replaced with the
MSG_SPLICE_PAGES flag you can actually share most code for both
variants as well.
