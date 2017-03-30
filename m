Return-Path: <martin.petersen@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 16DE51056320
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 17:29:38 +0200 (CEST)
To: "hch\@lst.de" <hch@lst.de>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-24-hch@lst.de>
	<1490720411.2573.11.camel@sandisk.com> <20170330090655.GF12015@lst.de>
Date: Thu, 30 Mar 2017 11:29:29 -0400
In-Reply-To: <20170330090655.GF12015@lst.de> (hch@lst.de's message of "Thu, 30
	Mar 2017 11:06:55 +0200")
Message-ID: <yq1d1cy3hra.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"snitzer@redhat.com" <snitzer@redhat.com>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	Bart Van Assche <Bart.VanAssche@sandisk.com>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
	"shli@kernel.org" <shli@kernel.org>, "agk@redhat.com" <agk@redhat.com>,
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

"hch@lst.de" <hch@lst.de> writes:

> Jens, any opinion?  I'd like to remove it too, but I fear it might
> break things.  We could deprecate it first with a warning when read
> and then remove it a few releases down the road.

I know of several apps that check this variable (as opposed to the
ioctl).

-- 
Martin K. Petersen	Oracle Linux Engineering
