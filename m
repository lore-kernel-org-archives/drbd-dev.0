Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C601C10622BA
	for <drbd-dev@lists.linbit.com>; Wed, 23 Sep 2009 13:36:59 +0200 (CEST)
Date: Wed, 23 Sep 2009 20:36:32 +0900
To: lmb@suse.de
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20090922062034.GE22732@suse.de>
References: <20090921165321.GJ8072@barkeeper1-xen.linbit>
	<20090922072617U.fujita.tomonori@lab.ntt.co.jp>
	<20090922062034.GE22732@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20090923203531C.fujita.tomonori@lab.ntt.co.jp>
Cc: hch@infradead.org, kyle@moffetthome.net, sam@ravnborg.org,
	bart.vanassche@gmail.com, neilb@suse.de, knikanth@suse.de,
	gregkh@suse.de, linux-kernel@vger.kernel.org,
	philipp.reisner@linbit.com, fujita.tomonori@lab.ntt.co.jp,
	Mauelshagen@redhat.com, James.Bottomley@suse.de,
	kosaki.motohiro@jp.fujitsu.com, jens.axboe@oracle.com,
	davej@redhat.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, arjan@infradead.org
Subject: Re: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, 22 Sep 2009 08:20:34 +0200
Lars Marowsky-Bree <lmb@suse.de> wrote:

> On 2009-09-22T07:27:21, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:
> 
> > > If it happens, once that happens, that _will_ be an ABI break.
> > 
> > You misunderstand the raid unification.
> > 
> > We will not unify the kernel<->userspace configuration interface
> > because we can't break the kernel<->userspace ABI.
> 
> I disagree here. Who says we can't over time, and with due notice?
> 
> For sure, the new ABI needs to co-exist with the old ones for a while,
> until it is proven and fully complete, but then, why can't the old one
> be marked as depreciated and phased out over 1-2 years time?

Let me know If you find a Linux storage developer who say, "Yeah, we
can remove the md ABI over 1-2 years time after the raid unification".

Seems that you have a very different idea from other kernel developers
about the stable ABI.


> > We plan to unify the multiple device frameworks, but the unified
> > framework must support the all existing ABIs.
> > 
> > So adding another 'drbd' ABI hurts us.
> 
> Even that doesn't really apply, I think. If the new framework is
> powerful enough and a super-set of everything that came before, the shim
> layer will be somewhat annoying, but harmless code.

Improving the existing framework is a proper approach.
