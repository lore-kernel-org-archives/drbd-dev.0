Return-Path: <lars.ellenberg@linbit.com>
Date: Mon, 21 Sep 2009 16:43:08 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Message-ID: <20090921144308.GG8072@barkeeper1-xen.linbit>
References: <20090918200803.GM23126@kernel.dk>
	<20090919141334N.fujita.tomonori@lab.ntt.co.jp>
	<20090919220232.GB31849@suse.de>
	<20090921223815U.fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20090921223815U.fujita.tomonori@lab.ntt.co.jp>
Cc: bart.vanassche@gmail.com, kyle@moffetthome.net, sam@ravnborg.org,
	neilb@suse.de, knikanth@suse.de, gregkh@suse.de,
	linux-kernel@vger.kernel.org, philipp.reisner@linbit.com,
	hch@infradead.org, Mauelshagen@RedHat.com,
	James.Bottomley@suse.de, lmb@suse.de,
	kosaki.motohiro@jp.fujitsu.com, jens.axboe@oracle.com,
	davej@redhat.com, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Sep 21, 2009 at 10:39:42PM +0900, FUJITA Tomonori wrote:
> > Either
> > 
> > a) there's going to be a transition period during which the "old"
> > interface is supported but depreciated and scheduled to be removed (all
> > driving the new unified same back-end),
> 
> We should avoid removing the existing interface. Once we merge drbd, I
> don't think that it's a good idea to remove the drbd user interface.


the drbd user interface is presented via
low level drbdsetup
and high level drbdadm (parses configuration files,
and calls out to drbdsetup).

changing (simplifying) the in-kernel configuration can be done any time,
as long as we can write a compat layer in the user land tools,
i.e. write drbdsetup so it will accept the same command line,
and try, based on "something" (sysfs file, genetlink group, 
environment variable, whatever) the "new" kernel interface,
or the "old" one.

I don't see any issue here.

> I don't think so. It's much easier to implement something that
> supports fewer user interfaces.

We can choose whatever user-kernel interface you like,
and change it with every dot release --
we'd just need to add additional compat code into
the drbdsetup userland binary.

> > > BTW, DM already has something like drbd? I thought that there is a
> > > talk about that new target at LinuxCon.
> > 
> > dm-replicator is nowhere near as usable as DRBD, and not upstream yet
> 
> I don't think usability at this point is important. The design
> matters. dm-replicator is built on the existing framework.
> 
> And my question is, if drbd and dm-replicator will provide similar
> features, then why do we need both in mainline?

dm-replicator is not there yet, and as such has zero user base.

To actually use it in the HA clustering world, quite a lot
userland glue would have to be written, which is not there yet either.

In contrast, DRBD is used in production, in many thousands of
installations worldwide since many years.

By design, dm-replicator is more comparable to dm-raid1, with the
knowledge that several mirror legs may break independently
(resulting in one "dirty log" per mirror leg), and come back
independendly, as well as the option of adding an on-disk ring-buffer to
any mirror leg.

It is by design NOT able to do dual-active mode.

If any of you happens to be at LinuxCon,
please discuss with Heinz (Maulshagen, dm-replicator)
and Phil (Reisner, DRBD), who both are present.

Heinz' talk about replicator is scheduled today, 10:30 am, 
that would be a good opportunity, I guess.

> > either. (Further, it's another independent implementation, pursued
> > instead of unifying any of the existing ones or helping to merge drbd -
> > don't get me started on my thoughts of that.)
> 
> Again, dm-replicator is built on the existing framework instead of
> adding another 'multiple (virtual) devices' framework into mainline.

Well, not exactly.

It adds quite a bit of additional framework (to the device mapper
subsystem), before it then starts to use that additional framework
via the generic device mapper hooks.

On that same line DRBD could argue that it uses the existing generic
block layer framework, just adding a bit functionality ;)

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
