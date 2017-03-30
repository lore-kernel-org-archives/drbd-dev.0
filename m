Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0FEE81056320
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 19:30:20 +0200 (CEST)
Date: Thu, 30 Mar 2017 19:30:20 +0200
From: "hch@lst.de" <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Message-ID: <20170330173020.GB24229@lst.de>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-13-hch@lst.de>
	<1490719722.2573.8.camel@sandisk.com>
	<20170330090201.GD12015@lst.de> <yq1h92a3hsv.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq1h92a3hsv.fsf@oracle.com>
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
Subject: Re: [Drbd-dev] [PATCH 12/23] sd: handle REQ_UNMAP
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

On Thu, Mar 30, 2017 at 11:28:32AM -0400, Martin K. Petersen wrote:
> "hch@lst.de" <hch@lst.de> writes:
> 
> Christoph,
> 
> > On Tue, Mar 28, 2017 at 04:48:55PM +0000, Bart Van Assche wrote:
> >> >  	if (sdp->no_write_same)
> >> >  		return BLKPREP_INVALID;
> >> >  	if (sdkp->ws16 || sector > 0xffffffff || nr_sectors > 0xffff)
> >> 
> >> Users can change the provisioning mode from user space from SD_LBP_WS16 into
> >> SD_LBP_WS10 so I'm not sure it's safe to skip the (sdkp->ws16 || sector >
> >> 0xffffffff || nr_sectors > 0xffff) check if REQ_UNMAP is set.
> >
> > They can, and if the device has too many sectors that will already cause
> > discard to fail,
> 
> I'm not sure I understand what you mean by that?

If you manually change the provisioning mode to WS10 on a device that
must use WRITE SAME (16) to be able to address all blocks you're already
screwed right now, and with this patch you can screw yourself through
the WRITE_ZEROES path in addition to the DISCARD path.
