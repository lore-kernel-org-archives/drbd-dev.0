Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [93.163.65.50])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 68B64101284B
	for <drbd-dev@lists.linbit.com>; Fri, 18 Sep 2009 22:16:59 +0200 (CEST)
Date: Fri, 18 Sep 2009 22:08:03 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Neil Brown <neilb@suse.de>
Message-ID: <20090918200803.GM23126@kernel.dk>
References: <200909151645.14256.philipp.reisner@linbit.com>
	<20090915231931.GB7636@infradead.org>
	<20090917081251.GC8045@barkeeper1-xen.linbit>
	<1253203365.7845.14.camel@mulgrave.site>
	<20090917161108.GA3361@infradead.org>
	<19122.65335.126937.476968@notabene.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19122.65335.126937.476968@notabene.brown>
Cc: Bart Van Assche <bart.vanassche@gmail.com>,
	Kyle Moffett <kyle@moffetthome.net>, Sam Ravnborg <sam@ravnborg.org>,
	Nikanth Karthikesan <knikanth@suse.de>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	James Bottomley <James.Bottomley@suse.de>,
	Lars Marowsky-Bree <lmb@suse.de>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Dave Jones <davej@redhat.com>, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Sep 18 2009, Neil Brown wrote:
> On Thursday September 17, hch@infradead.org wrote:
> > On Thu, Sep 17, 2009 at 10:02:45AM -0600, James Bottomley wrote:
> > > So I think Christoph's NAK is rooted in the fact that we have a
> > > proliferation of in-kernel RAID implementations and he's trying to
> > > reunify them all again.
> > > 
> > > As part of the review, reusing the kernel RAID (and actually logging)
> > > logic did come up and you added it to your todo list.  Perhaps expanding
> > > on the status of that would help, since what's being looked for is that
> > > you're not adding more work to the RAID reunification effort and that
> > > you do have a plan and preferably a time frame for coming into sync with
> > > it.
> > 
> > Yes.  RDBD has spend tons of time out of tree, and if they want to put
> > it in now I think requiring them to do their homework is a good idea.
> 
> What homework?
> 
> If there was a sensible unifying framework in the kernel that they
> could plug in to, then requiring them do to that might make sense.  But
> there isn't.  You/I/We haven't created a solution (i.e. there is no
> equivalent of the VFS for virtual block devices) and saying that
> because we haven't they cannot merge DRBD hardly seems fair.
> 
> Indeed, merging DRBD must be seen as a *good* thing as we then have
> more examples of differing requirements against which a proposed
> solution can be measured and tested.
> 
> I thought the current attitude was "merge then fix".  That is what the
> drivers/staging tree seems to be all about.  Maybe you could argue
> that DRBD should go in to 'staging' first (though I don't think that
> is appropriate or require myself), but keeping it out just seems
> wrong.

FWIW, I agree with Neil here. If drbd is merge clean, lets go ahead and
merge it. While it would be nice to offload the raid unification onto
drbd, it's not exactly fair.

-- 
Jens Axboe

