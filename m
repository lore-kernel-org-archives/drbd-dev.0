Return-Path: <msnitzer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 020BD1056446
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 15:50:01 +0200 (CEST)
Date: Thu, 30 Mar 2017 09:49:57 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20170330134957.GA508@redhat.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-23-hch@lst.de>
	<20170330100641.GI5939@soda.linbit> <20170330114408.GA15777@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170330114408.GA15777@lst.de>
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	shli@kernel.org, agk@redhat.com, drbd-dev@lists.linbit.com
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

On Thu, Mar 30 2017 at  7:44am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Mar 30, 2017 at 12:06:41PM +0200, Lars Ellenberg wrote:
> 
> > Will it make an fstrim cause thinly provisioned
> > devices to suddenly be fully allocated?
> 
> Not for SCSI devices.  Yes for dm-thinp until it implements
> REQ_OP_WRITE_ZEROES, which will hopefully be soon.

I can work on this now.  Only question I have is: should DM thinp take
care to zero any misaligned head and tail?  (I assume so but with all
the back and forth between Bart, Paolo and Martin I figured I'd ask
explicitly).
