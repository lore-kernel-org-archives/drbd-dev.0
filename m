Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2F66910575B7
	for <drbd-dev@lists.linbit.com>; Tue, 16 Jan 2018 09:55:52 +0100 (CET)
Received: by mail-wm0-f47.google.com with SMTP id 141so6844177wme.3
	for <drbd-dev@lists.linbit.com>; Tue, 16 Jan 2018 00:55:52 -0800 (PST)
Date: Tue, 16 Jan 2018 09:55:45 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Mike Snitzer <snitzer@redhat.com>
Message-ID: <20180116085545.GB4107@soda.linbit>
References: <20170405172125.22600-1-hch@lst.de>
	<20170405172125.22600-24-hch@lst.de>
	<alpine.LRH.2.11.1801130035010.13147@mail.ewheeler.net>
	<20180115124635.GA4107@soda.linbit>
	<20180115150738.GA20967@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115150738.GA20967@redhat.com>
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com, ejt@redhat.com,
	philipp.reisner@linbit.com, linux-block@vger.kernel.org,
	dm-devel@redhat.com, shli@kernel.org,
	Christoph Hellwig <hch@lst.de>, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 23/27] drbd: make intelligent use of
 blkdev_issue_zeroout
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

On Mon, Jan 15, 2018 at 10:07:38AM -0500, Mike Snitzer wrote:
> > See also:
> > https://www.redhat.com/archives/dm-devel/2017-March/msg00213.html
> > https://www.redhat.com/archives/dm-devel/2017-March/msg00226.html
> 
> Right, now that you mention it it is starting to ring a bell (especially
> after I read your 2nd dm-devel archive url above).

> > In tree, either dm-thin learns to do REQ_OP_WRITE_ZEROES "properly",
> > so the result in this scenario is what we expect:
> > 
> >   _: unprovisioned, not allocated, returns zero on read anyways
> >   *: provisioned, some arbitrary data
> >   0: explicitly zeroed:
> > 
> >   |gran|ular|ity |    |    |    |
> >   |****|****|____|****|
> >      to|-be-|zero|ed
> >   |**00|____|____|00**|
> > 
> > (leave unallocated blocks alone,
> >  de-allocate full blocks just like with discard,
> >  explicitly zero unaligned head and tail)
> 
> "de-allocate full blocks just like with discard" is an interesting take
> what it means for dm-thin to handle REQ_OP_WRITE_ZEROES "properly".
> 
> > Or DRBD will have to resurrect that reinvented zeroout again,
> > with exactly those semantics. I did reinvent it for a reason ;)
> 
> Yeah, I now recall dropping that line of development because it
> became "hard" (or at least harder than originally thought).
> 
> Don't people use REQ_OP_WRITE_ZEROES to initialize a portion of the
> disk?  E.g. zeroing superblocks, metadata areas, or whatever?
> 
> If we just discarded the logical extent and then a user did a partial
> write to the block, areas that a user might expect to be zeroed wouldn't
> be (at least in the case of dm-thinp if "skip_block_zeroing" is
> enabled).


Oh-kay.
So "immediately after" such an operation
("zero-out head and tail and de-alloc full blocks")
a read to that area would return all zeros, as expected.

But once you do a partial write of something to one of those
de-allocated blocks (and skip_block_zeroing is enabled,
which it likely is due to "performance"),
"magically" arbitrary old garbage data springs into existence
on the LBAs that just before read as zeros.

lvmthin lvm.conf
Would that not break a lot of other things
(any read-modify-write of "upper layers")?
Would that not even be a serious "information leak"
(old garbage of other completely unrelated LVs leaking into this one)?

But thank you for that, I start to see the problem ;-)

> No, dm-thinp doesn't have an easy way to mark an allocated block as
> containing zeroes (without actually zeroing).  I toyed with adding that
> but then realized that even if we had it it'd still require block
> zeroing be enabled.  But block zeroing is done at allocation time.  So
> we'd need to interpret the "this block is zeroes" flag to mean "on first
> write or read to this block it needs to first zero it".  Fugly to say
> the least...


Maybe have a "known zeroed block" pool, allocate only from there,
and "lazy zero" unallocated blocks, add to the known-zero pool?
Fallback to zero-on-alloc if that known-zero-pool is depleted.

Easier said than done, I know.

> But sadly, in general, this is a low priority for me, so you might do
> well to reintroduce your drbd workaround.. sorry about that :(

No problem.
I'll put that back in, and document that we strongly recommend to
NOT skip_block_zeroing in those setups.

Thanks,

    Lars

