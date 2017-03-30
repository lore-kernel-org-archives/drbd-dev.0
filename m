Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0AA8D1056320
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 19:29:16 +0200 (CEST)
Date: Thu, 30 Mar 2017 19:29:15 +0200
From: "hch@lst.de" <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Message-ID: <20170330172915.GA24229@lst.de>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-24-hch@lst.de>
	<1490720411.2573.11.camel@sandisk.com>
	<20170330090655.GF12015@lst.de> <yq1d1cy3hra.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1d1cy3hra.fsf@oracle.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"snitzer@redhat.com" <snitzer@redhat.com>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	Bart Van Assche <Bart.VanAssche@sandisk.com>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
	"shli@kernel.org" <shli@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"agk@redhat.com" <agk@redhat.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 23/23] block: remove the discard_zeroes_data
	flag
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

On Thu, Mar 30, 2017 at 11:29:29AM -0400, Martin K. Petersen wrote:
> "hch@lst.de" <hch@lst.de> writes:
> 
> > Jens, any opinion?  I'd like to remove it too, but I fear it might
> > break things.  We could deprecate it first with a warning when read
> > and then remove it a few releases down the road.
> 
> I know of several apps that check this variable (as opposed to the
> ioctl).

The above was in reference to both methods..
