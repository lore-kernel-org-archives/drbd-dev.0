Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D48E31058003
	for <drbd-dev@lists.linbit.com>; Tue,  3 Oct 2017 00:06:51 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id B3B0B22555
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 18:06:50 -0400 (EDT)
Received: from localhost (unknown [124.171.54.49])
	by mail.messagingengine.com (Postfix) with ESMTPA id 197667FA5C
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 18:06:49 -0400 (EDT)
Date: Tue, 3 Oct 2017 09:06:47 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: drbd-dev@lists.linbit.com
Message-ID: <20171002220647.GC11207@eros>
References: <1506897256-14072-1-git-send-email-me@tobin.cc>
	<20171002131336.GA8989@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171002131336.GA8989@soda.linbit>
Subject: Re: [Drbd-dev] [PATCH 00/17] lru_cache: checkpatch clean ups
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

On Mon, Oct 02, 2017 at 03:13:36PM +0200, Lars Ellenberg wrote:
> On Mon, Oct 02, 2017 at 09:33:59AM +1100, Tobin C. Harding wrote:
> > Checkpatch clean ups for lib/lru_cache.c
> > 
> > This patch set is intended to test the waters as to whether DRBD
> > wants/accepts checkpatch clean ups. I know that many maintainers
> > consider such patches as code churn.
> 
> I'd consider them such.
> Probably nothing wrong with those patches, really,
> though I did not look very closely.
> 
> I'd maybe do this kind of cleanup IF I was to touch the code anyways.

Point noted, thank you.

> > I am taking a look at the DRBD code after bumping into Brian at OSSNA in LA.
> > 
> > If you do want/like checkpatch fixes I am happy to do so for drivers/block/drbd/* while I look
> > around the code base.
> > 
> > I don't know which tree you guys are working off.
> > This series applies on top of Linus' development
> > tree, commit:
> > 
> > a8c964eacb21288b2dbfa9d80cee5968a3b8fb21
> 
> Our "upstream" is out-of-tree still,
> and tries to be compatible with a wide range of kernel.org tree versions.
> We recently move the public master to github.com/LINBIT/drbd-8.4/
> and it looks in some parts quite different from the in kernel code,
> for compatilibity reasons.

cloned.

> But for this kind of cleanup stuff,
> kernel.org master is the right reference, yes.
> 
> As I said, I don't care much for "no-op" commits, and even if I'd take
> them, I'd fold them all into one "fixes for checkpatch complaints".
> 
> But don't let that keep you from "looking around the code base",
> maybe you still spot things that actually need fixing
> or can otherwise be improved.  It's not that we don't like contributors,
> it's just that contributing "white-space only changes" to C code won't
> earn you much points in my book ;-)

Thanks for your comments. Let's consider this set dropped.

thanks,
Tobin
