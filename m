Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D6148105647D
	for <drbd-dev@lists.linbit.com>; Fri, 31 Mar 2017 09:17:54 +0200 (CEST)
Date: Fri, 31 Mar 2017 09:17:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@redhat.com>
Message-ID: <20170331071753.GA3308@lst.de>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-23-hch@lst.de>
	<20170330100641.GI5939@soda.linbit> <20170330114408.GA15777@lst.de>
	<20170330134957.GA508@redhat.com> <yq1pogy3i6u.fsf@oracle.com>
	<20170330231550.GA3102@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170330231550.GA3102@redhat.com>
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
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

On Thu, Mar 30, 2017 at 07:15:50PM -0400, Mike Snitzer wrote:
> I got pretty far along with implementing the DM thinp support for
> WRITE_ZEROES in terms of thinp's DISCARD support (more of an
> implementation detail.. or so I thought).
> 
> But while discussing this effort with Jeff Moyer he asked: shouldn't the
> zeroed blocks be provisioned?  This is a fairly embarassing question not
> to be able to answer in the moment.  So I clearly need to learn what the
> overall intent of WRITE_ZEROES actually is.

It is to ensure the that the block range it's called on returns zeroes
on future reads.  Currently if REQ_UNMAP is set you may free the space
allocation, else not.

After looking at the callers I think this is the wrong way around, so
I'm going to invert the flag, so that the two callers that care that
blocks are allocated will set it instead.
