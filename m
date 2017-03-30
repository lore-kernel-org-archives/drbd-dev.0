Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f170.google.com (mail-wr0-f170.google.com
	[209.85.128.170])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5E981105633D
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 14:50:40 +0200 (CEST)
Received: by mail-wr0-f170.google.com with SMTP id w11so58283092wrc.3
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 05:50:40 -0700 (PDT)
Date: Thu, 30 Mar 2017 14:50:34 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20170330125034.GJ5939@soda.linbit>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-23-hch@lst.de>
	<20170330100641.GI5939@soda.linbit> <20170330114408.GA15777@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170330114408.GA15777@lst.de>
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, martin.petersen@oracle.com,
	snitzer@redhat.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	linux-scsi@vger.kernel.org, shli@kernel.org, agk@redhat.com,
	drbd-dev@lists.linbit.com
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

On Thu, Mar 30, 2017 at 01:44:09PM +0200, Christoph Hellwig wrote:
> On Thu, Mar 30, 2017 at 12:06:41PM +0200, Lars Ellenberg wrote:
> > On Thu, Mar 23, 2017 at 10:33:40AM -0400, Christoph Hellwig wrote:
> > > It seems like DRBD assumes its on the wire TRIM request always zeroes data.
> > > Use that fact to implement REQ_OP_WRITE_ZEROES.
> > > 
> > > XXX: will need a careful audit from the drbd team!
> > 
> > Thanks, this one looks ok to me.
> 
> So the DRBD protocol requires the TRIM operation to always zero?

"users" (both as in submitting entities, and people using DRBD)
expect that DRBD guarantees replicas to be identical after whatever
operations have been completed by all replicas.

Which means that for trim/discard/unmap, we can only expose that to
upper layers (or use it for internal purposes) if the operation has
a well defined, and on all backends identical, result.

Short answer: Yes.

> > The real question for me is, will the previous one (21/23)
> > return != 0 (some EOPNOTSUPP or else) to DRBD in more situations than
> > what we have now?
> 
> No, blkdev_issue_zeroout should never return -EOPNOTSUPP.
> 
> > Will it make an fstrim cause thinly provisioned
> > devices to suddenly be fully allocated?
> 
> Not for SCSI devices.  Yes for dm-thinp until it implements
> REQ_OP_WRITE_ZEROES, which will hopefully be soon.

"good enough for me" ;-)

Thanks,

    Lars

