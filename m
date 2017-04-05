Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4476C105647D
	for <drbd-dev@lists.linbit.com>; Wed,  5 Apr 2017 14:08:26 +0200 (CEST)
Date: Wed, 5 Apr 2017 14:08:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Message-ID: <20170405120826.GA2275@lst.de>
References: <20170331163313.31821-1-hch@lst.de> <yq1vaqjt74b.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1vaqjt74b.fsf@oracle.com>
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
	snitzer@redhat.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	lars.ellenberg@linbit.com, shli@kernel.org,
	Christoph Hellwig <hch@lst.de>, agk@redhat.com, drbd-dev@lists.linbit.com
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

On Wed, Apr 05, 2017 at 07:40:36AM -0400, Martin K. Petersen wrote:
> > This series makes REQ_OP_WRITE_ZEROES the only zeroing offload
> > supported by the block layer, and switches existing implementations
> > of REQ_OP_DISCARD that correctly set discard_zeroes_data to it,
> > removes incorrect discard_zeroes_data, and also switches WRITE SAME
> > based zeroing in SCSI to this new method.
> 
> Very, very nice. I think this is the correct approach.
> 
> I'm going to send two follow-up patches that allow us to use UNMAP for
> discards and WRITE SAME w/ UNMAP for zeroout. That appears to be the
> preferred configuration for most storage devices.

Thanks, I'll resend it with your nitpicks fixed, your follow on
patches tacked on and the various reviewed-by tags in a bit.
