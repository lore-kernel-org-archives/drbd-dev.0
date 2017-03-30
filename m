Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f174.google.com (mail-wr0-f174.google.com
	[209.85.128.174])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 79580105633D
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 12:06:43 +0200 (CEST)
Received: by mail-wr0-f174.google.com with SMTP id l43so54199466wre.1
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 03:06:43 -0700 (PDT)
Date: Thu, 30 Mar 2017 12:06:41 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20170330100641.GI5939@soda.linbit>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-23-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323143341.31549-23-hch@lst.de>
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

On Thu, Mar 23, 2017 at 10:33:40AM -0400, Christoph Hellwig wrote:
> It seems like DRBD assumes its on the wire TRIM request always zeroes data.
> Use that fact to implement REQ_OP_WRITE_ZEROES.
> 
> XXX: will need a careful audit from the drbd team!

Thanks, this one looks ok to me.

The real question for me is, will the previous one (21/23)
return != 0 (some EOPNOTSUPP or else) to DRBD in more situations than
what we have now?  Will it make an fstrim cause thinly provisioned
devices to suddenly be fully allocated?
Or does it unmap "the same" as what we have now?
Especially on top of dm-thin, but also on top of any other device.
That's something that is not really "obvious" to me yet.

Cheers,
    Lars


