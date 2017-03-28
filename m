Return-Path: <Bart.VanAssche@sandisk.com>
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 574C11056320
	for <drbd-dev@lists.linbit.com>; Tue, 28 Mar 2017 19:00:55 +0200 (CEST)
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "agk@redhat.com" <agk@redhat.com>, "lars.ellenberg@linbit.com"
	<lars.ellenberg@linbit.com>, "snitzer@redhat.com" <snitzer@redhat.com>,
	"hch@lst.de" <hch@lst.de>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "philipp.reisner@linbit.com"
	<philipp.reisner@linbit.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"shli@kernel.org" <shli@kernel.org>
Date: Tue, 28 Mar 2017 16:50:47 +0000
Message-ID: <1490719834.2573.9.camel@sandisk.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-12-hch@lst.de>
In-Reply-To: <20170323143341.31549-12-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <870212604B83404C82828EFFF2BD9132@sandisk.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 11/23] block_dev: use blkdev_issue_zerout for
 hole punches
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

On Thu, 2017-03-23 at 10:33 -0400, Christoph Hellwig wrote:
> This gets us support for non-discard efficient write of zeroes (e.g. NVMe=
)
> and preparse for removing the discard_zeroes_data flag.

Hello Christoph,

"preparse" probably should have been "prepare"?

Thanks,

Bart.=
