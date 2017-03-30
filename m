Return-Path: <martin.petersen@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E07101056320
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 17:28:43 +0200 (CEST)
To: "hch\@lst.de" <hch@lst.de>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-13-hch@lst.de>
	<1490719722.2573.8.camel@sandisk.com> <20170330090201.GD12015@lst.de>
Date: Thu, 30 Mar 2017 11:28:32 -0400
In-Reply-To: <20170330090201.GD12015@lst.de> (hch@lst.de's message of "Thu, 30
	Mar 2017 11:02:01 +0200")
Message-ID: <yq1h92a3hsv.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Christoph,

> On Tue, Mar 28, 2017 at 04:48:55PM +0000, Bart Van Assche wrote:
>> >  	if (sdp->no_write_same)
>> >  		return BLKPREP_INVALID;
>> >  	if (sdkp->ws16 || sector > 0xffffffff || nr_sectors > 0xffff)
>>=20
>> Users can change the provisioning mode from user space from=C2=A0SD_LBP_=
WS16 into
>> SD_LBP_WS10 so I'm not sure it's safe to skip the (sdkp->ws16 || sector >
>> 0xffffffff || nr_sectors > 0xffff) check if REQ_UNMAP is set.
>
> They can, and if the device has too many sectors that will already cause
> discard to fail,

I'm not sure I understand what you mean by that?

--=20
Martin K. Petersen	Oracle Linux Engineering
