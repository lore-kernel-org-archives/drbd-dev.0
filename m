Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id AA7271056445
	for <drbd-dev@lists.linbit.com>; Wed,  4 May 2016 11:05:31 +0200 (CEST)
Date: Wed, 4 May 2016 11:05:30 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: David Miller <davem@davemloft.net>
Message-ID: <20160504090529.GJ16459@soda.linbit>
References: <57286F49.8050107@6wind.com>
	<1462268358-19044-1-git-send-email-nicolas.dichtel@6wind.com>
	<20160503100644.GE16459@soda.linbit>
	<20160503.120556.1317913903199470646.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160503.120556.1317913903199470646.davem@davemloft.net>
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com,
	philipp.reisner@linbit.com, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH net-next v2] block/drbd: use
	nla_put_u64_64bit()
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

On Tue, May 03, 2016 at 12:05:56PM -0400, David Miller wrote:
> From: Lars Ellenberg <lars.ellenberg@linbit.com>
> Date: Tue, 3 May 2016 12:06:44 +0200
> 
> > Please just NOT use an additional "field",
> > but always use 0 to pad.
> 
> You can't, it doesn't work.

I did, and it *did* work.
At least, it appeared to.

I'm not talking about every user of netlink out there.
That I don't know. But specifically for DRBD netlink,
from what my experiments tell me, it works just fine.

> We are adding a new field to every netlink protocol family that has
> this alignment problem.

We don't have an "alignment problem" there, btw.
Last time I checked, we did work fine without this alignment magic,
we already take care of that, yes, even on affected architectures.

On Tue, May 03, 2016 at 12:06:52PM -0400, David Miller wrote:
> From: Lars Ellenberg <lars.ellenberg@linbit.com>
> Date: Tue, 3 May 2016 12:06:44 +0200
> 
> > Whereas using some arbitrary value will be wrong,
> > and will needlessly break userland.
> 
> It cannot break userland.

It can, if those tags have been used already.
There is DRBD out-of-tree as well,
it usually is ahead of in-tree DRBD.

But yes, I could obviously check and assign and reserve some
not-yet-used tag to all of them.

I don't see why, though, given that 0 (appearently) works fine.

Can you elaborate why and how that does not work?

	Lars

