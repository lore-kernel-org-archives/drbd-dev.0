Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 860AD4207B4
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 17:45:12 +0200 (CEST)
Received: by mail-ed1-f66.google.com with SMTP id l24so17484949edj.8
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 08:45:12 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	le12sm10918688ejb.1.2020.10.12.08.45.11
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 12 Oct 2020 08:45:11 -0700 (PDT)
Resent-Message-ID: <20201012154509.GB2116@soda.linbit>
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6EC354204C3
	for <drbd-dev@lists.linbit.com>; Wed, 22 Jul 2020 09:09:30 +0200 (CEST)
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Message-ID: <SN4PR0401MB3598495DA5AF46CAF019BDC69B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200722062552.212200-1-hch@lst.de>
	<20200722062552.212200-3-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	Hans de Goede <hdegoede@redhat.com>, Richard,
	Minchan Kim <minchan@kernel.org>, Weinberger <richard@nod.at>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Song Liu <song@kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 02/14] drbd: remove dead code in
	device_to_statistics
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
Date: Mon, 12 Oct 2020 15:46:45 -0000

On 22/07/2020 08:28, Christoph Hellwig wrote:=0A=
> Ever since the switch to blk-mq, a lower device not use by VM=0A=
                                           in-use/used? ~^=0A=
=0A=
Also this looks like the last user of 'dev_lower_blocked' so it could=0A=
be removed from device_statistics if it's not an ABI (not sure with this=0A=
netlink stuff).=0A=
