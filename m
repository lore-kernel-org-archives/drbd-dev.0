Return-Path: <msnitzer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EC03B1056446
	for <drbd-dev@lists.linbit.com>; Fri, 31 Mar 2017 01:16:03 +0200 (CEST)
Date: Thu, 30 Mar 2017 19:15:50 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Message-ID: <20170330231550.GA3102@redhat.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-23-hch@lst.de>
	<20170330100641.GI5939@soda.linbit> <20170330114408.GA15777@lst.de>
	<20170330134957.GA508@redhat.com> <yq1pogy3i6u.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1pogy3i6u.fsf@oracle.com>
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
	philipp.reisner@linbit.com, linux-block@vger.kernel.org,
	dm-devel@redhat.com, shli@kernel.org,
	Christoph Hellwig <hch@lst.de>, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 22/23] drbd: implement REQ_OP_WRITE_ZEROES
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

On Thu, Mar 30 2017 at 11:20am -0400,
Martin K. Petersen <martin.petersen@oracle.com> wrote:

> Mike Snitzer <snitzer@redhat.com> writes:
> 
> > I can work on this now.  Only question I have is: should DM thinp take
> > care to zero any misaligned head and tail?  (I assume so but with all
> > the back and forth between Bart, Paolo and Martin I figured I'd ask
> > explicitly).
> 
> Yep, let's make sure our semantics match the hardware ditto.
> 
>  - So write zeroes should behave deterministically and explicitly handle
>    any blocks that can't be cleared via deprovisioning.
> 
>  - And discard can work at the discard granularity in a
>    non-deterministic fashion.

I got pretty far along with implementing the DM thinp support for
WRITE_ZEROES in terms of thinp's DISCARD support (more of an
implementation detail.. or so I thought).

But while discussing this effort with Jeff Moyer he asked: shouldn't the
zeroed blocks be provisioned?  This is a fairly embarassing question not
to be able to answer in the moment.  So I clearly need to learn what the
overall intent of WRITE_ZEROES actually is.

If it is meant as a replacement for WRITE_SAME (as hch switched dm-io
over from WRITE_SAME with a payload of 0 to WRITE_ZEROES) and for the
backing mechanism for blkdev_issue_zeroout() then I guess I have my
answer.  Unless DM thinp can guarantee that the discarded blocks will
always return zeroes (by zeroing before all partial block writes) my
discard based dm-thinp implementation of WRITE_ZEROES is a complete
throw-away (unless block zeroing is enabled.. which it never is because
performance sucks with it).  So if an upper-level of the IO stack
(e.g. ext4) were to assume that a block will _definitely_ have zeroes
then DM thinp would fall short.

This is all to say: I don't see a quick way forward on implementing
performant WRITE_ZEROES support for DM thinp.
