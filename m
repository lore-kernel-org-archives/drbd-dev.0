Return-Path: <Bart.VanAssche@sandisk.com>
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BBBA81056320
	for <drbd-dev@lists.linbit.com>; Tue, 28 Mar 2017 19:00:58 +0200 (CEST)
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "agk@redhat.com" <agk@redhat.com>, "lars.ellenberg@linbit.com"
	<lars.ellenberg@linbit.com>, "snitzer@redhat.com" <snitzer@redhat.com>,
	"hch@lst.de" <hch@lst.de>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "philipp.reisner@linbit.com"
	<philipp.reisner@linbit.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"shli@kernel.org" <shli@kernel.org>
Date: Tue, 28 Mar 2017 17:00:48 +0000
Message-ID: <1490720411.2573.11.camel@sandisk.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-24-hch@lst.de>
In-Reply-To: <20170323143341.31549-24-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <16CA47C31156C54BB5465A15C406D9BF@sandisk.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
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

On Thu, 2017-03-23 at 10:33 -0400, Christoph Hellwig wrote:
> Now that we use the proper REQ_OP_WRITE_ZEROES operation everywhere we ca=
n
> kill this hack.
>=20
> [ ... ]
>
> diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/te=
sting/sysfs-block
> index 2da04ce6aeef..dea212db9df3 100644
> --- a/Documentation/ABI/testing/sysfs-block
> +++ b/Documentation/ABI/testing/sysfs-block
> @@ -213,14 +213,8 @@ What:		/sys/block/<disk>/queue/discard_zeroes_data
>  Date:		May 2011
>  Contact:	Martin K. Petersen <martin.petersen@oracle.com>
>  Description:
> -		Devices that support discard functionality may return
> -		stale or random data when a previously discarded block
> -		is read back. This can cause problems if the filesystem
> -		expects discarded blocks to be explicitly cleared. If a
> -		device reports that it deterministically returns zeroes
> -		when a discarded area is read the discard_zeroes_data
> -		parameter will be set to one. Otherwise it will be 0 and
> -		the result of reading a discarded area is undefined.
> +		Will always return 0.  Don't rely on any specific behavior
> +		for discards, and don't read this file.
> =20
>  What:		/sys/block/<disk>/queue/write_same_max_bytes
>  Date:		January 2012
>
> [ ... ]
>
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -208,7 +208,7 @@ static ssize_t queue_discard_max_store(struct request=
_queue *q,
> =20
>  static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, c=
har *page)
>  {
> -	return queue_var_show(queue_discard_zeroes_data(q), page);
> +	return 0;
>  }

Hello Christoph,

It seems to me like the documentation in Documentation/ABI/testing/sysfs-bl=
ock
and the above code are not in sync. I think the above code will cause readi=
ng
from the discard_zeroes_data attribute to return an empty string ("") inste=
ad
of "0\n".

BTW, my personal preference is to remove this attribute entirely because ke=
eping
it will cause confusion, no matter how well we document the behavior of thi=
s
attribute.

Thanks,

Bart.=
