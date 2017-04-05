Return-Path: <martin.petersen@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 330F6105633D
	for <drbd-dev@lists.linbit.com>; Wed,  5 Apr 2017 13:40:49 +0200 (CEST)
To: Christoph Hellwig <hch@lst.de>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170331163313.31821-1-hch@lst.de>
Date: Wed, 05 Apr 2017 07:40:36 -0400
In-Reply-To: <20170331163313.31821-1-hch@lst.de> (Christoph Hellwig's message
	of "Fri, 31 Mar 2017 18:32:48 +0200")
Message-ID: <yq1vaqjt74b.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, martin.petersen@oracle.com,
	snitzer@redhat.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	linux-scsi@vger.kernel.org, lars.ellenberg@linbit.com,
	shli@kernel.org, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] always use REQ_OP_WRITE_ZEROES for zeroing offload
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

Christoph,

> This series makes REQ_OP_WRITE_ZEROES the only zeroing offload
> supported by the block layer, and switches existing implementations
> of REQ_OP_DISCARD that correctly set discard_zeroes_data to it,
> removes incorrect discard_zeroes_data, and also switches WRITE SAME
> based zeroing in SCSI to this new method.

Very, very nice. I think this is the correct approach.

I'm going to send two follow-up patches that allow us to use UNMAP for
discards and WRITE SAME w/ UNMAP for zeroout. That appears to be the
preferred configuration for most storage devices.

-- 
Martin K. Petersen	Oracle Linux Engineering
