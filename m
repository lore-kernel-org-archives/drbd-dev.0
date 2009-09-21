Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id EAE3F101284B
	for <drbd-dev@lists.linbit.com>; Tue, 22 Sep 2009 00:27:58 +0200 (CEST)
Date: Tue, 22 Sep 2009 07:27:21 +0900
To: lars.ellenberg@linbit.com
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20090921165321.GJ8072@barkeeper1-xen.linbit>
References: <20090921144308.GG8072@barkeeper1-xen.linbit>
	<20090921165252.04e335b1@infradead.org>
	<20090921165321.GJ8072@barkeeper1-xen.linbit>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20090922072617U.fujita.tomonori@lab.ntt.co.jp>
Cc: hch@infradead.org, kyle@moffetthome.net, sam@ravnborg.org,
	bart.vanassche@gmail.com, neilb@suse.de, knikanth@suse.de,
	gregkh@suse.de, linux-kernel@vger.kernel.org,
	philipp.reisner@linbit.com, fujita.tomonori@lab.ntt.co.jp,
	Mauelshagen@redhat.com, James.Bottomley@suse.de, lmb@suse.de,
	kosaki.motohiro@jp.fujitsu.com, jens.axboe@oracle.com,
	davej@redhat.com, akpm@linux-foundation.org,
	drbd-dev@lists.linbit.com, torvalds@linux-foundation.org,
	arjan@infradead.org
Subject: Re: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, 21 Sep 2009 18:53:21 +0200
Lars Ellenberg <lars.ellenberg@linbit.com> wrote:

> On Mon, Sep 21, 2009 at 04:52:52PM +0200, Arjan van de Ven wrote:
> > On Mon, 21 Sep 2009 16:43:08 +0200
> > Lars Ellenberg <lars.ellenberg@linbit.com> wrote:
> > > We can choose whatever user-kernel interface you like,
> > > and change it with every dot release --
> > > we'd just need to add additional compat code into
> > > the drbdsetup userland binary.
> > 
> > uh no.
> > 
> > the kernel<->userspace ABI is stable.
> > we don't go about randomly changing it
> > (extending it is fine obviously)
> 
> That's not what I meant, of course that is and needs to be stable.
> Sorry, I exagerated to make a point.
> 
> Point was:
> mdadm configured md.
> dmsetup configured dm.
> drbdsetup configure drbd.
> 
> If and when "something" is done to "unify" things on the implementation
> level, it is likely to also unify the "kernel<->userspace" configuration
> interface.
> 
> If it happens, once that happens, that _will_ be an ABI break.

You misunderstand the raid unification.

We will not unify the kernel<->userspace configuration interface
because we can't break the kernel<->userspace ABI.

We plan to unify the multiple device frameworks, but the unified
framework must support the all existing ABIs.

So adding another 'drbd' ABI hurts us.
