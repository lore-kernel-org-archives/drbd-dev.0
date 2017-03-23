Return-Path: <msnitzer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id CFF841057FAD
	for <drbd-dev@lists.linbit.com>; Thu, 23 Mar 2017 16:10:45 +0100 (CET)
Date: Thu, 23 Mar 2017 11:10:38 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20170323151037.GC17127@redhat.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-7-hch@lst.de>
	<20170323145522.GB17127@redhat.com> <20170323145651.GA31771@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323145651.GA31771@lst.de>
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	lars.ellenberg@linbit.com, shli@kernel.org, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 06/23] dm-kcopyd: switch to use
	REQ_OP_WRITE_ZEROES
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

On Thu, Mar 23 2017 at 10:56am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Mar 23, 2017 at 10:55:22AM -0400, Mike Snitzer wrote:
> > See commit 70d6c400a ("dm kcopyd: add WRITE SAME support to dm_kcopyd_zero")
> > drivers/md/dm-io.c:do_region() adjusts the WRITE SAME payload to be a
> > single page.
> > 
> > So you'd want to tweak dm-io.c accordingly for WRITE ZEROES (presummably
> > no payload?)
> 
> Yeah, I'll look into it.

Ah, your previous 05/23 patch re-uses the discard branch in
dm-io.c:do_region.  Looks correct.  So you should be good.

Not sure why you've split out the dm-kcopyd patch, likely best to just
fold it into the previous dm support patch.

I'll try your code out on my testbed, probably tomorrow, but in general
the DM code looks solid (thanks for doing it!).  But I'll take a closer
look and will report back with my Reviewed-by if all looks (and tests
out) good.

> Any good test case for verifying this code while I've got your
> attention?

DM thinp is the only consumer of dm_kcopyd_zero().  DM thinp
conservatively defaults to zeroing (but we recommend
'skip_block_zeroing' for most setups).  So anyway, just using a DM thin
device with partial thin blocksize IO (without 'skip_block_zeroing')
should get you coverage.

The device-mapper-test-suite thin tests have thinp w/ zeroing coverage
so I'll be sure to run those.
