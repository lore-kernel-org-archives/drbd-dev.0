Return-Path: <axboe@kernel.dk>
Received: from mail-pf0-f180.google.com (mail-pf0-f180.google.com
	[209.85.192.180])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id AB623105630C
	for <drbd-dev@lists.linbit.com>; Sat,  8 Apr 2017 19:33:37 +0200 (CEST)
Received: by mail-pf0-f180.google.com with SMTP id i5so16851661pfc.2
	for <drbd-dev@lists.linbit.com>; Sat, 08 Apr 2017 10:33:37 -0700 (PDT)
Date: Sat, 8 Apr 2017 11:26:18 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20170408172617.GA16784@kernel.dk>
References: <20170405172125.22600-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170405172125.22600-1-hch@lst.de>
Cc: linux-raid@vger.kernel.org, martin.petersen@oracle.com, snitzer@redhat.com,
	philipp.reisner@linbit.com, linux-block@vger.kernel.org,
	dm-devel@redhat.com, linux-scsi@vger.kernel.org,
	lars.ellenberg@linbit.com, shli@kernel.org, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] always use REQ_OP_WRITE_ZEROES for zeroing offload V2
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

On Wed, Apr 05 2017, Christoph Hellwig wrote:
> This series makes REQ_OP_WRITE_ZEROES the only zeroing offload
> supported by the block layer, and switches existing implementations
> of REQ_OP_DISCARD that correctly set discard_zeroes_data to it,
> removes incorrect discard_zeroes_data, and also switches WRITE SAME
> based zeroing in SCSI to this new method.
> 
> The series is against the block for-next tree.

Added for 4.12, thanks Christoph.

-- 
Jens Axboe

