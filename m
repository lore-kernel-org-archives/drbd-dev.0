Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 482BD1045C2D
	for <drbd-dev@lists.linbit.com>; Thu, 24 Sep 2009 01:38:14 +0200 (CEST)
Date: Thu, 24 Sep 2009 08:37:14 +0900
To: neilb@suse.de
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <19130.43495.807916.962040@notabene.brown>
References: <20090922062034.GE22732@suse.de>
	<20090923203531C.fujita.tomonori@lab.ntt.co.jp>
	<19130.43495.807916.962040@notabene.brown>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20090924083617J.fujita.tomonori@lab.ntt.co.jp>
Cc: hch@infradead.org, kyle@moffetthome.net, sam@ravnborg.org,
	bart.vanassche@gmail.com, knikanth@suse.de, gregkh@suse.de,
	linux-kernel@vger.kernel.org, philipp.reisner@linbit.com,
	fujita.tomonori@lab.ntt.co.jp, Mauelshagen@redhat.com,
	James.Bottomley@suse.de, lmb@suse.de,
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

On Thu, 24 Sep 2009 09:06:15 +1000
Neil Brown <neilb@suse.de> wrote:

> On Wednesday September 23, fujita.tomonori@lab.ntt.co.jp wrote:
> > On Tue, 22 Sep 2009 08:20:34 +0200
> > Lars Marowsky-Bree <lmb@suse.de> wrote:
> > 
> > > On 2009-09-22T07:27:21, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:
> > > 
> > > > > If it happens, once that happens, that _will_ be an ABI break.
> > > > 
> > > > You misunderstand the raid unification.
> > > > 
> > > > We will not unify the kernel<->userspace configuration interface
> > > > because we can't break the kernel<->userspace ABI.
> > > 
> > > I disagree here. Who says we can't over time, and with due notice?
> > > 
> > > For sure, the new ABI needs to co-exist with the old ones for a while,
> > > until it is proven and fully complete, but then, why can't the old one
> > > be marked as depreciated and phased out over 1-2 years time?
> > 
> > Let me know If you find a Linux storage developer who say, "Yeah, we
> > can remove the md ABI over 1-2 years time after the raid unification".
> 
> I would have said 3-5 years, that being about the time frame for
> enterprise releases, and it would be best if every enterprise vendor

Enterprise vendors don't pick up the latest kernel. So I think that we
need more.


> got to have a release that supported both the old and the new
> interface.  But I don't have a problem with migrating to a better ABI
> is we actually had a better ABI.
> > 
> > Seems that you have a very different idea from other kernel developers
> > about the stable ABI.
> 
> CONFIG_SYSFS_DEPRECATED_V2  seems to suggest that other kernel
> developers understand that we sometimes make mistakes and need to
> deprecate them.

Yeah, however, we can try not to make mistakes.


> However I think this is all very premature as there is even a coherent
> proposal for what unification might look like, let alone broad
> agreement or implementation.  I would *much* rather we spent our
> energies debating that than debating whether or not DRBD should get
> merged.... Maybe would should only accept votes on "Should DRBD get
> merged" from people provide constructive input to the question "what
> would a unified virtual block device model look like".
> 
> > 
> > Improving the existing framework is a proper approach.
> 
> Yes.  So let's do it.

So we should implement something like drbd on the top of dm framework,
one of the existing 'virtual device' frameworks. That would improve dm
and we could get better ideas about "what would a unified virtual
block device model look like".
