Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 45CB7420BB1
	for <drbd-dev@lists.linbit.com>; Thu, 10 Feb 2022 06:51:53 +0100 (CET)
Date: Thu, 10 Feb 2022 06:51:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Message-ID: <20220210055151.GA3491@lst.de>
References: <20220209082828.2629273-1-hch@lst.de>
	<yq1wni3sz4k.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1wni3sz4k.fsf@ca-mkp.ca.oracle.com>
Cc: axboe@kernel.dk, manoj@linux.ibm.com, linux-scsi@vger.kernel.org,
	philipp.reisner@linbit.com, linux-block@vger.kernel.org,
	dm-devel@redhat.com, target-devel@vger.kernel.org,
	haris.iqbal@ionos.com, ukrishn@linux.ibm.com,
	lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com,
	jinpu.wang@ionos.com, Christoph Hellwig <hch@lst.de>, mrochs@linux.ibm.com
Subject: Re: [Drbd-dev] remove REQ_OP_WRITE_SAME v2
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Feb 09, 2022 at 01:00:26PM -0500, Martin K. Petersen wrote:
> 
> Christoph,
> 
> > Now that we are using REQ_OP_WRITE_ZEROES for all zeroing needs in the
> > kernel there is very little use left for REQ_OP_WRITE_SAME.  We only
> > have two callers left, and both just export optional protocol features
> > to remote systems: DRBD and the target code.
> 
> No particular objections from me. I had a half-baked series to do the
> same thing.
> 
> One thing I would like is to either pull this series through SCSI or do
> the block pieces in a post merge branch because I'm about to post my
> discard/zeroing rework and that's going to clash with your changes.

I'd be fine with taking this through the SCSI tree.  Or we can wait
another merge window to make your life easier.
