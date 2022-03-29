Return-Path: <philipp.reisner@linbit.com>
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
	[209.85.221.171])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BC38E420192
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2022 17:44:15 +0200 (CEST)
Received: by mail-vk1-f171.google.com with SMTP id n135so9985943vkf.6
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2022 08:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220329070618.GA20396@lst.de>
	<CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
	<20220329073254.GA20691@lst.de>
	<CADGDV=U5jwe0CZ12174cMahfD_h-GsBswWaA1VOJbHaC1nsrUw@mail.gmail.com>
	<f9d89282-3a67-ad97-149f-52325e23607c@kernel.dk>
In-Reply-To: <f9d89282-3a67-ad97-149f-52325e23607c@kernel.dk>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Tue, 29 Mar 2022 17:44:03 +0200
Message-ID: <CADGDV=WN2TFR6dO7ZdiQ2ijPjs+7HSsvk0ZCHsHj6ZG5t-oEdA@mail.gmail.com>
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

Jens, my intention is to keep it in-tree, and at some point update it.
Regarding your questions:

[...]

> - Why aren't the drbd maintainers responding to posted patches? They seem
>   to simply be ignored, and I'm left to pickup the trivial ones that look
>   fine to me. In-kernel drbd appears largely unmaintained, and has been for
>   years.

The team here has grown, we are busy. Since you started to pick up the
trivial patches yourself, I thought it is not necessary that I collect them and
send a pull request in merge-window time.

> - Even if out-of-band communication is used for in-kernel users of drbd,
>   that doesn't result in any patches or fixes that should go upstream?

This one:
https://patchwork.kernel.org/project/linux-block/patch/20210426163032.3454129-1-christoph.boehmwalder@linbit.com/
(relevant to users that have DRBD on top of md raid)

> - If there's zero activity for in-kernel drbd, all users are using the
>   out-of-tree version?

There are users of the in-tree version, some with huge fleets.
Some do not need the newer out-of-tree DRBD, and the in-tree version is a
lot easier to compile. You need coccinelle for the out-of-tree version,
and that can already be a hindering barrier for some.

> As far as I can tell, drbd upstream is stone cold dead, and has been for
> years. Why shouldn't it just get removed?

Because there are users.

> Is it just bait to get people to use an out-of-tree version?

No.

> --
> Jens Axboe
