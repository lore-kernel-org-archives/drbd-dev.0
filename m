Return-Path: <msnitzer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6C73A105633D
	for <drbd-dev@lists.linbit.com>; Mon, 27 Mar 2017 16:03:14 +0200 (CEST)
Date: Mon, 27 Mar 2017 10:03:07 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <20170327140307.GA13020@redhat.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323155410.GD1138@soda.linbit>
	<20170327091056.GB6879@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170327091056.GB6879@infradead.org>
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	shli@kernel.org, Christoph Hellwig <hch@lst.de>, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] RFC: always use REQ_OP_WRITE_ZEROES for zeroing
	offload
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

On Mon, Mar 27 2017 at  5:10am -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> It sounds like you don't want to support traditional discard at all,
> but only WRITE ZEROES.  So in many ways this series is the right way
> forward.  It would be nice if we could do a full blown
> REQ_OP_WRITE_ZEROES for dm_think that zeroes out partial blocks,
> similar to what hardware that implements WRITE SAME of zeroes
> or WRITE ZEROES would do.  I'll see if I could include that in my
> series.

By "you" I assume you're referring to Lars?  Lars' approach for discard,
when drbd is layered on dm-thinp, feels over-engineered.  Not his fault,
the way discard and zeroing got conflated certainly lends itself to
these ugly hacks.  SO I do appreciate that for anything to leverage
discard_zeroes_data it needs to be reliable.  Which runs counter to how
discard was implemented (discard may get silently dropped!)  But that is
why dm-thinp doesn't advertise dzd.  Anyway...

As for the blkdev_issue_zeroout() resorting to manually zeroing the
range, if the discard fails or dzd not supported, that certainly
requires DM thinp to implement manual zeroing of the head and tail of
the range if partial blocks are being zeroed.  So I welcome any advances
there.  It is probably something that is best left to Joe or myself to
tackle.  But I'll gladly accept patches ;)
