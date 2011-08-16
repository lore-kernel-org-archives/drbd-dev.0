Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 50C341056C51
	for <drbd-dev@lists.linbit.com>; Tue, 16 Aug 2011 21:00:44 +0200 (CEST)
Date: Tue, 16 Aug 2011 21:00:44 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20110816190044.GI3975@barkeeper1-xen.linbit>
References: <4E3BA638.9000601@ii.nl>
	<20110816130833.GD3975@barkeeper1-xen.linbit>
	<20110816152505.GA1712@garage.freebsd.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110816152505.GA1712@garage.freebsd.pl>
Subject: Re: [Drbd-dev] [PATCH] expand section on throughput tuning to
 highlight prime usecase of external metadata, florians comments applied,
 added section replacing metadata
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Aug 16, 2011 at 05:25:06PM +0200, Pawel Jakub Dawidek wrote:
> On Tue, Aug 16, 2011 at 03:08:33PM +0200, Lars Ellenberg wrote:
> > I suggest to point out that this is for _linear streaming writes_,
> > which, once they leave the covered area, need one activity log
> > transaction every 4 MiB.
> > 
> > Other, more localized, usage patterns need less AL-transactions per
> > amount of changes, and are less impacted, or virtually not at all,
> > depending on the change rate and size of the working set, and the
> > size of the activity log.
> > 
> > The impact heavily depends on the overall AL-transaction latency, which
> > is why write cache enabled controllers do much better. Even better than
> > a dedicated disk, usually, which may no longer suffer from seek time,
> > but still has access and processing time up to two orders of magnitude
> > higher than a decent write cache.
> 
> BTW. How do you ensure AL update "reached the platters"? Do you flush
> disk write cache after every AL update?

Yes, unless not supported by the lower level stack,
or explicitly disabled by the drbd configuration (no-md-flushes)


-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com
