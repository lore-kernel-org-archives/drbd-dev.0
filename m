Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 25387101AC7F
	for <drbd-dev@lists.linbit.com>; Mon, 21 Sep 2009 15:40:18 +0200 (CEST)
Date: Mon, 21 Sep 2009 22:39:42 +0900
To: lmb@suse.de
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20090919220232.GB31849@suse.de>
References: <20090918200803.GM23126@kernel.dk>
	<20090919141334N.fujita.tomonori@lab.ntt.co.jp>
	<20090919220232.GB31849@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20090921223815U.fujita.tomonori@lab.ntt.co.jp>
Cc: hch@infradead.org, kyle@moffetthome.net, sam@ravnborg.org,
	bart.vanassche@gmail.com, neilb@suse.de, knikanth@suse.de,
	gregkh@suse.de, linux-kernel@vger.kernel.org,
	philipp.reisner@linbit.com, fujita.tomonori@lab.ntt.co.jp,
	James.Bottomley@suse.de, kosaki.motohiro@jp.fujitsu.com,
	jens.axboe@oracle.com, davej@redhat.com,
	lars.ellenberg@linbit.com, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, 20 Sep 2009 00:02:32 +0200
Lars Marowsky-Bree <lmb@suse.de> wrote:

> On 2009-09-19T14:14:30, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:
> 
> > I guess that Christoph is worry about adding another user interface
> > for kinda device management; once we merge this, we can't fix it (for
> > the raid unification).
> 
> Why can't it be fixed?
> 
> Either
> 
> a) there's going to be a transition period during which the "old"
> interface is supported but depreciated and scheduled to be removed (all
> driving the new unified same back-end),

We should avoid removing the existing interface. Once we merge drbd, I
don't think that it's a good idea to remove the drbd user interface.


> or b) there's going to be a new kernel which requires new user-space
> tools sharp.
> 
> In either case, dm/md are affected by this, so a third interface doesn't
> really make much difference. The refactoring needs to happen in the
> back-end anyway, and that actually becomes easier when all concurrent
> implementations are present and can be reworked at the same time.

I don't think so. It's much easier to implement something that
supports fewer user interfaces.


> > BTW, DM already has something like drbd? I thought that there is a
> > talk about that new target at LinuxCon.
> 
> dm-replicator is nowhere near as usable as DRBD, and not upstream yet

I don't think usability at this point is important. The design
matters. dm-replicator is built on the existing framework.

And my question is, if drbd and dm-replicator will provide similar
features, then why do we need both in mainline?


> either. (Further, it's another independent implementation, pursued
> instead of unifying any of the existing ones or helping to merge drbd -
> don't get me started on my thoughts of that.)

Again, dm-replicator is built on the existing framework instead of
adding another 'multiple (virtual) devices' framework into mainline.
