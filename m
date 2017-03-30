Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0B1071056320
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 10:59:52 +0200 (CEST)
Date: Thu, 30 Mar 2017 10:59:52 +0200
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Message-ID: <20170330085952.GC12015@lst.de>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-12-hch@lst.de>
	<1490719834.2573.9.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490719834.2573.9.camel@sandisk.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"snitzer@redhat.com" <snitzer@redhat.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
	"shli@kernel.org" <shli@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"agk@redhat.com" <agk@redhat.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 11/23] block_dev: use blkdev_issue_zerout for
	hole	punches
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

On Tue, Mar 28, 2017 at 04:50:47PM +0000, Bart Van Assche wrote:
> On Thu, 2017-03-23 at 10:33 -0400, Christoph Hellwig wrote:
> > This gets us support for non-discard efficient write of zeroes (e.g. NVMe)
> > and preparse for removing the discard_zeroes_data flag.
> 
> Hello Christoph,
> 
> "preparse" probably should have been "prepare"?

Yes, fixed.
