Return-Path: <lars.ellenberg@linbit.com>
Date: Mon, 21 Sep 2009 18:53:21 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Arjan van de Ven <arjan@infradead.org>
Message-ID: <20090921165321.GJ8072@barkeeper1-xen.linbit>
References: <20090918200803.GM23126@kernel.dk>
	<20090919141334N.fujita.tomonori@lab.ntt.co.jp>
	<20090919220232.GB31849@suse.de>
	<20090921223815U.fujita.tomonori@lab.ntt.co.jp>
	<20090921144308.GG8072@barkeeper1-xen.linbit>
	<20090921165252.04e335b1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090921165252.04e335b1@infradead.org>
Cc: hch@infradead.org, kyle@moffetthome.net, sam@ravnborg.org,
	bart.vanassche@gmail.com, neilb@suse.de, knikanth@suse.de,
	gregkh@suse.de, linux-kernel@vger.kernel.org, philipp.reisner@linbit.com,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Mauelshagen@RedHat.com, James.Bottomley@suse.de, lmb@suse.de,
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

On Mon, Sep 21, 2009 at 04:52:52PM +0200, Arjan van de Ven wrote:
> On Mon, 21 Sep 2009 16:43:08 +0200
> Lars Ellenberg <lars.ellenberg@linbit.com> wrote:
> > We can choose whatever user-kernel interface you like,
> > and change it with every dot release --
> > we'd just need to add additional compat code into
> > the drbdsetup userland binary.
> 
> uh no.
> 
> the kernel<->userspace ABI is stable.
> we don't go about randomly changing it
> (extending it is fine obviously)

That's not what I meant, of course that is and needs to be stable.
Sorry, I exagerated to make a point.

Point was:
mdadm configured md.
dmsetup configured dm.
drbdsetup configure drbd.

If and when "something" is done to "unify" things on the implementation
level, it is likely to also unify the "kernel<->userspace" configuration
interface.

If it happens, once that happens, that _will_ be an ABI break.

One way to go about it would be to just do that excellently designed and
generic and extensible and whatnot new kernel<->userspace thing, and add
the necessary compat cruft to the above mentioned configuration tools.

Doing the drbdsetup part of it would be our part,
which we would gladly accept.

Not speaking that not yet designed all-new unified config interface
is not a valid argument against DRBD inclusion.

	Lars
