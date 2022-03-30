Return-Path: <philipp.reisner@linbit.com>
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
	[209.85.221.172])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 58B004201B8
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2022 17:23:55 +0200 (CEST)
Received: by mail-vk1-f172.google.com with SMTP id d129so11721693vkh.13
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2022 08:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220329070618.GA20396@lst.de>
	<CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
	<20220329073254.GA20691@lst.de>
	<CADGDV=U5jwe0CZ12174cMahfD_h-GsBswWaA1VOJbHaC1nsrUw@mail.gmail.com>
	<f9d89282-3a67-ad97-149f-52325e23607c@kernel.dk>
	<CADGDV=WN2TFR6dO7ZdiQ2ijPjs+7HSsvk0ZCHsHj6ZG5t-oEdA@mail.gmail.com>
	<3c42b1ed-7c03-64e6-409e-e92247288cac@kernel.dk>
In-Reply-To: <3c42b1ed-7c03-64e6-409e-e92247288cac@kernel.dk>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Wed, 30 Mar 2022 17:23:44 +0200
Message-ID: <CADGDV=WcTSSC70yG61dazo-WyoLOzp3r+nOk-Eg2x_Ncx=3nRg@mail.gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] state of drbd in mainline
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

> > Jens, my intention is to keep it in-tree, and at some point update it.
> > Regarding your questions:
>
> That'd be great, but it's been years since there was any significant
> updates to the in-kernel drbd... I would strongly suggest that the
> in-kernel be brought closer to what people are mostly running, as it
> stands it's basically unmaintained.

The changes we worked on over many Years in the more recent drbd-9.x
branches are just too fundamental to do them in small chunks, we could
upstream bit by bit.  We need to get that reviewed in a big series.  If I
started to dump them on linux-block right away, nobody would look at it
seriously, since it would be too much.  I intend to get people from red
hat/suse assigned to do such a review. Then we will do that on linux-block,
so that everyone who cares sees what happens.

[...]
> The main discrepancy here is that there are apparently huge numbers of
> in-tree users, yet no fixes or patches at all making it to mainline.
> Either drbd is bug free and doesn't require any fixes at all, which I
> very much would doubt, or fixes aren't being sent upstream.

It is the broad consent among the users of the drbd-8.4 branch (that is what
is in-tree), is that it works for its purpose. It is for sure not bug-free,
but people are not running into bugs anymore. So, call it free of relevant
bugs, if you want.  No new features go into that branch, on purpose. To keep
it that way.

Have a look at that one real bug-fix that was identified in the last Year.
https://patchwork.kernel.org/project/linux-block/patch/20210426163032.3454129-1-christoph.boehmwalder@linbit.com/

When do you want to have that reposted to you?
right now? Just before the next merge window opens?
