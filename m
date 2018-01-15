Return-Path: <msnitzer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4BF8A105759C
	for <drbd-dev@lists.linbit.com>; Mon, 15 Jan 2018 16:07:55 +0100 (CET)
Date: Mon, 15 Jan 2018 10:07:38 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Eric Wheeler <drbd-dev@lists.ewheeler.net>,
	Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	martin.petersen@oracle.com, agk@redhat.com, shli@kernel.org,
	philipp.reisner@linbit.com, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org, dm-devel@redhat.com,
	linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Message-ID: <20180115150738.GA20967@redhat.com>
References: <20170405172125.22600-1-hch@lst.de>
	<20170405172125.22600-24-hch@lst.de>
	<alpine.LRH.2.11.1801130035010.13147@mail.ewheeler.net>
	<20180115124635.GA4107@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115124635.GA4107@soda.linbit>
Cc: ejt@redhat.com
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

On Mon, Jan 15 2018 at  7:46am -0500,
Lars Ellenberg <lars.ellenberg@linbit.com> wrote:
 
> As I understood it,
> blkdev_issue_zeroout() was supposed to "always try to unmap",
> deprovision, the relevant region, and zero-out any unaligned
> head or tail, just like my work around above was doing.
> 
> And that device mapper thin was "about to" learn this, "soon",
> or maybe block core would do the equivalent of my workaround
> described above.
> 
> But it then did not.
> 
> See also:
> https://www.redhat.com/archives/dm-devel/2017-March/msg00213.html
> https://www.redhat.com/archives/dm-devel/2017-March/msg00226.html

Right, now that you mention it it is starting to ring a bell (especially
after I read your 2nd dm-devel archive url above).

> I then did not follow this closely enough anymore,
> and I missed that with recent enough kernel,
> discard on DRBD on dm-thin would fully allocate.
> 
> In our out-of-tree module, we had to keep the older code for
> compat reasons, anyways. I will just re-enable our zeroout
> workaround there again.
> 
> In tree, either dm-thin learns to do REQ_OP_WRITE_ZEROES "properly",
> so the result in this scenario is what we expect:
> 
>   _: unprovisioned, not allocated, returns zero on read anyways
>   *: provisioned, some arbitrary data
>   0: explicitly zeroed:
> 
>   |gran|ular|ity |    |    |    |
>   |****|****|____|****|
>      to|-be-|zero|ed
>   |**00|____|____|00**|
> 
> (leave unallocated blocks alone,
>  de-allocate full blocks just like with discard,
>  explicitly zero unaligned head and tail)

"de-allocate full blocks just like with discard" is an interesting take
what it means for dm-thin to handle REQ_OP_WRITE_ZEROES "properly".

> Or DRBD will have to resurrect that reinvented zeroout again,
> with exactly those semantics. I did reinvent it for a reason ;)

Yeah, I now recall dropping that line of development because it
became "hard" (or at least harder than originally thought).

Don't people use REQ_OP_WRITE_ZEROES to initialize a portion of the
disk?  E.g. zeroing superblocks, metadata areas, or whatever?

If we just discarded the logical extent and then a user did a partial
write to the block, areas that a user might expect to be zeroed wouldn't
be (at least in the case of dm-thinp if "skip_block_zeroing" is
enabled).  And yes if discard passdown is enabled and the device's
discard implementation does "discard_zeroes_data" then it'd be
fine.. but there are a lot of things that need to line up for drbd's
REQ_OP_WRITE_ZEROES to "just work" (as it expects).

(now I'm just echoing the kinds of concerns I had in that 2nd dm-devel
post above).

This post from mkp is interesting:
https://www.redhat.com/archives/dm-devel/2017-March/msg00228.html

Specifically:
"You don't have a way to mark those blocks as being full of zeroes
without actually writing them?

Note that the fallback to a zeroout command is to do a regular write. So
if DM doesn't zero the blocks, the block layer is going to it."

No, dm-thinp doesn't have an easy way to mark an allocated block as
containing zeroes (without actually zeroing).  I toyed with adding that
but then realized that even if we had it it'd still require block
zeroing be enabled.  But block zeroing is done at allocation time.  So
we'd need to interpret the "this block is zeroes" flag to mean "on first
write or read to this block it needs to first zero it".  Fugly to say
the least...

I've been quite busy with other things but I can revisit all this with
Joe Thornber and see what we come up with after a 2nd discussion.

But sadly, in general, this is a low priority for me, so you might do
well to reintroduce your drbd workaround.. sorry about that :(

Mike
