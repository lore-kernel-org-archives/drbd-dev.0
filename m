Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 585D01056471
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2016 17:51:44 +0100 (CET)
Date: Wed, 9 Nov 2016 17:51:43 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Richard Weinberger <richard@nod.at>
Message-ID: <20161109165143.GN1382@soda.linbit>
References: <1478601789-15060-1-git-send-email-richard@nod.at>
	<1478601789-15060-1-git-send-email-richard@nod.at>
	<497abc52-093f-17ea-5fb5-645030a23a01@nod.at>
	<20161108165204.GC2834@kernel.dk>
	<20161109153209.GK1382@soda.linbit>
	<af05f705-1d2a-6296-ff53-ec047d7fefee@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af05f705-1d2a-6296-ff53-ec047d7fefee@nod.at>
Cc: Jens Axboe <axboe@kernel.dk>, wolfgang.glas@iteg.at,
	christoph.lechleitner@iteg.at, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, philipp.reisner@linbit.com,
	viro@zeniv.linux.org.uk, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: Fix kernel_sendmsg() usage
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

On Wed, Nov 09, 2016 at 04:47:15PM +0100, Richard Weinberger wrote:
> > Should I sent two patches, one that applies to 4.5 and later,
> > and one that applies to 2.6.33 ... 4.4, or are you or stable
> > willing to resolve the trivial "missing comment block" conflict yourself?
> 
> BTW: Why did you drop the "Fixes:" tag too?
> 

By accident, probably.

I'm ok with you guys just using the original, if you prefer, just let me
know.  It's the fix, that's important, not how much noise we can make
about that oneliner.

	Lars

