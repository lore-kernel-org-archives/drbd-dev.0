Return-Path: <msnitzer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 08CAD1056320
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 17:38:55 +0200 (CEST)
Date: Thu, 30 Mar 2017 11:38:51 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Message-ID: <20170330153850.GA1031@redhat.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170330151257.GA910@redhat.com> <yq1lgrm3i36.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1lgrm3i36.fsf@oracle.com>
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
	philipp.reisner@linbit.com, linux-block@vger.kernel.org,
	dm-devel@redhat.com, lars.ellenberg@linbit.com, shli@kernel.org,
	Christoph Hellwig <hch@lst.de>, agk@redhat.com, drbd-dev@lists.linbit.com
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

On Thu, Mar 30 2017 at 11:22am -0400,
Martin K. Petersen <martin.petersen@oracle.com> wrote:

> Mike Snitzer <snitzer@redhat.com> writes:
> 
> > Would be very useful, particularly for testing, if
> > drivers/scsi/scsi_debug.c were updated to support WRITE ZEROES.
> 
> There is no WRITE ZEROES in SCSI. You should be able to get the right
> behavior with lbpws=1 lbprz=1.

OK, thanks.
