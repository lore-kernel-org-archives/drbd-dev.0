Return-Path: <martin.petersen@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 54C45105645E
	for <drbd-dev@lists.linbit.com>; Fri, 31 Mar 2017 04:20:09 +0200 (CEST)
To: "hch\@lst.de" <hch@lst.de>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-13-hch@lst.de>
	<1490719722.2573.8.camel@sandisk.com> <20170330090201.GD12015@lst.de>
	<yq1h92a3hsv.fsf@oracle.com> <20170330173020.GB24229@lst.de>
Date: Thu, 30 Mar 2017 22:19:55 -0400
In-Reply-To: <20170330173020.GB24229@lst.de> (hch@lst.de's message of "Thu, 30
	Mar 2017 19:30:20 +0200")
Message-ID: <yq17f36yypg.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"snitzer@redhat.com" <snitzer@redhat.com>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	Bart Van Assche <Bart.VanAssche@sandisk.com>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
	"shli@kernel.org" <shli@kernel.org>, "agk@redhat.com" <agk@redhat.com>,
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

"hch@lst.de" <hch@lst.de> writes:

> If you manually change the provisioning mode to WS10 on a device that
> must use WRITE SAME (16) to be able to address all blocks you're already
> screwed right now, and with this patch you can screw yourself through
> the WRITE_ZEROES path in addition to the DISCARD path.

Oh, I see. We only had the LBA sanity check in place for write same, not
for discard.

-- 
Martin K. Petersen	Oracle Linux Engineering
