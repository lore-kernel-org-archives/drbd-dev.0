Return-Path: <martin.petersen@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8F9B0105648F
	for <drbd-dev@lists.linbit.com>; Wed,  5 Apr 2017 13:55:49 +0200 (CEST)
To: Christoph Hellwig <hch@lst.de>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170331163313.31821-1-hch@lst.de>
	<20170331163313.31821-23-hch@lst.de>
Date: Wed, 05 Apr 2017 07:55:39 -0400
In-Reply-To: <20170331163313.31821-23-hch@lst.de> (Christoph Hellwig's message
	of "Fri, 31 Mar 2017 18:33:10 +0200")
Message-ID: <yq1fuhnrrus.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, martin.petersen@oracle.com,
	snitzer@redhat.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	linux-scsi@vger.kernel.org, lars.ellenberg@linbit.com,
	shli@kernel.org, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 22/25] block: stop using discards for zeroing
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

Christoph Hellwig <hch@lst.de> writes:

> Now that we have REQ_OP_WRITE_ZEROES implemented for all devices that
> support efficient zeroing of devices we can remove the call to

s/of devices/

> blkdev_issue_discard.  This means we only have two ways of zeroing
> left and can simply the code.

simplify

> + *  Note that this function may fail with -EOPNOTSUPP if the driver supports
> + *  efficient zeroing operation, but the device capabilities can only be
> + *  discovered by trial and error.  In this case the caller should call the
> + *  function again, and it will use the fallback path.

Maybe:

"Note that this function may fail with -EOPNOTSUPP if the driver signals
zeroing offload support but the device fails to process the command (for
some devices there is no non-destructive way to verify whether this
operation is actually supported). If -EOPNOTSUPP is returned, the caller
should retry the blkdev_issue_zeroout() and the fallback path will be
used."

Otherwise OK.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
