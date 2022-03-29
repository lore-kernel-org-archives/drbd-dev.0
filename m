Return-Path: <axboe@kernel.dk>
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com
	[209.85.166.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E76AF4201B8
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2022 17:52:12 +0200 (CEST)
Received: by mail-io1-f42.google.com with SMTP id z7so21492991iom.1
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2022 08:52:12 -0700 (PDT)
Message-ID: <3c42b1ed-7c03-64e6-409e-e92247288cac@kernel.dk>
Date: Tue, 29 Mar 2022 09:52:07 -0600
MIME-Version: 1.0
Content-Language: en-US
To: Philipp Reisner <philipp.reisner@linbit.com>
References: <20220329070618.GA20396@lst.de>
	<CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
	<20220329073254.GA20691@lst.de>
	<CADGDV=U5jwe0CZ12174cMahfD_h-GsBswWaA1VOJbHaC1nsrUw@mail.gmail.com>
	<f9d89282-3a67-ad97-149f-52325e23607c@kernel.dk>
	<CADGDV=WN2TFR6dO7ZdiQ2ijPjs+7HSsvk0ZCHsHj6ZG5t-oEdA@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADGDV=WN2TFR6dO7ZdiQ2ijPjs+7HSsvk0ZCHsHj6ZG5t-oEdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 3/29/22 9:44 AM, Philipp Reisner wrote:
> Jens, my intention is to keep it in-tree, and at some point update it.
> Regarding your questions:

That'd be great, but it's been years since there was any significant
updates to the in-kernel drbd... I would strongly suggest that the
in-kernel be brought closer to what people are mostly running, as it
stands it's basically unmaintained.

>> - Why aren't the drbd maintainers responding to posted patches? They seem
>>   to simply be ignored, and I'm left to pickup the trivial ones that look
>>   fine to me. In-kernel drbd appears largely unmaintained, and has been for
>>   years.
> 
> The team here has grown, we are busy. Since you started to pick up the
> trivial patches yourself, I thought it is not necessary that I collect
> them and send a pull request in merge-window time.

That's just one part of it, the fact that the out-of-tree drbd has been
drifting further and further away from the in-kernel one is a big
problem. For trivial patches, I have no issue picking them up. But
silence on your side is not very helpful. Please review and ack patches.
If I see it acked, then I can easily pick it up.

>> - Even if out-of-band communication is used for in-kernel users of drbd,
>>   that doesn't result in any patches or fixes that should go upstream?
> 
> This one:
> https://patchwork.kernel.org/project/linux-block/patch/20210426163032.3454129-1-christoph.boehmwalder@linbit.com/
> (relevant to users that have DRBD on top of md raid)

That's a single patch, from a year ago. Not a strong counter point,
looks more like it's proving my case...

>> - If there's zero activity for in-kernel drbd, all users are using the
>>   out-of-tree version?
> 
> There are users of the in-tree version, some with huge fleets.
> Some do not need the newer out-of-tree DRBD, and the in-tree version is a
> lot easier to compile. You need coccinelle for the out-of-tree version,
> and that can already be a hindering barrier for some.

The main discrepancy here is that there are apparently huge numbers of
in-tree users, yet no fixes or patches at all making it to mainline.
Either drbd is bug free and doesn't require any fixes at all, which I
very much would doubt, or fixes aren't being sent upstream.

-- 
Jens Axboe

