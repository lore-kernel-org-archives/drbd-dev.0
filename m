Return-Path: <lars.ellenberg@linbit.com>
Received: from johann (chello212017090083.12.15.vie.surfer.at [212.17.90.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPSA id 0D90B1013803
	for <drbd-dev@lists.linbit.com>; Sun, 20 Sep 2009 21:26:03 +0200 (CEST)
Resent-Message-ID: <20090920192602.GA8824@johann>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9B0F8101284B
	for <drbd-dev@lists.linbit.com>; Sat, 19 Sep 2009 07:23:23 +0200 (CEST)
Date: Sat, 19 Sep 2009 14:14:30 +0900
To: jens.axboe@oracle.com
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20090918200803.GM23126@kernel.dk>
References: <20090917161108.GA3361@infradead.org>
	<19122.65335.126937.476968@notabene.brown>
	<20090918200803.GM23126@kernel.dk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20090919141334N.fujita.tomonori@lab.ntt.co.jp>
Cc: bart.vanassche@gmail.com, kyle@moffetthome.net, sam@ravnborg.org,
	neilb@suse.de, knikanth@suse.de, gregkh@suse.de,
	linux-kernel@vger.kernel.org, philipp.reisner@linbit.com,
	hch@infradead.org, James.Bottomley@suse.de, lmb@suse.de,
	kosaki.motohiro@jp.fujitsu.com, davej@redhat.com,
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

On Fri, 18 Sep 2009 22:08:03 +0200
Jens Axboe <jens.axboe@oracle.com> wrote:

> On Fri, Sep 18 2009, Neil Brown wrote:
> > On Thursday September 17, hch@infradead.org wrote:
> > > On Thu, Sep 17, 2009 at 10:02:45AM -0600, James Bottomley wrote:
> > > > So I think Christoph's NAK is rooted in the fact that we have a
> > > > proliferation of in-kernel RAID implementations and he's trying to
> > > > reunify them all again.
> > > > 
> > > > As part of the review, reusing the kernel RAID (and actually logging)
> > > > logic did come up and you added it to your todo list.  Perhaps expanding
> > > > on the status of that would help, since what's being looked for is that
> > > > you're not adding more work to the RAID reunification effort and that
> > > > you do have a plan and preferably a time frame for coming into sync with
> > > > it.
> > > 
> > > Yes.  RDBD has spend tons of time out of tree, and if they want to put
> > > it in now I think requiring them to do their homework is a good idea.
> > 
> > What homework?
> > 
> > If there was a sensible unifying framework in the kernel that they
> > could plug in to, then requiring them do to that might make sense.  But
> > there isn't.  You/I/We haven't created a solution (i.e. there is no
> > equivalent of the VFS for virtual block devices) and saying that
> > because we haven't they cannot merge DRBD hardly seems fair.
> > 
> > Indeed, merging DRBD must be seen as a *good* thing as we then have
> > more examples of differing requirements against which a proposed
> > solution can be measured and tested.
> > 
> > I thought the current attitude was "merge then fix".  That is what the
> > drivers/staging tree seems to be all about.  Maybe you could argue
> > that DRBD should go in to 'staging' first (though I don't think that
> > is appropriate or require myself), but keeping it out just seems
> > wrong.
> 
> FWIW, I agree with Neil here. If drbd is merge clean, lets go ahead and
> merge it. While it would be nice to offload the raid unification onto
> drbd, it's not exactly fair.

I guess that Christoph is worry about adding another user interface
for kinda device management; once we merge this, we can't fix it (for
the raid unification).

BTW, DM already has something like drbd? I thought that there is a
talk about that new target at LinuxCon.
