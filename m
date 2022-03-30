Return-Path: <axboe@kernel.dk>
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com
	[209.85.166.44])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C40B94202BA
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2022 22:21:38 +0200 (CEST)
Received: by mail-io1-f44.google.com with SMTP id r2so26125483iod.9
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2022 13:21:38 -0700 (PDT)
Message-ID: <a5fbb7f3-8b0a-eef9-6479-dedc9fc6a425@kernel.dk>
Date: Wed, 30 Mar 2022 14:21:35 -0600
MIME-Version: 1.0
Content-Language: en-US
To: "Kiselev, Oleg" <okiselev@amazon.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
References: <20220329070618.GA20396@lst.de>
	<CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
	<20220329073254.GA20691@lst.de>
	<CADGDV=U5jwe0CZ12174cMahfD_h-GsBswWaA1VOJbHaC1nsrUw@mail.gmail.com>
	<f9d89282-3a67-ad97-149f-52325e23607c@kernel.dk>
	<CADGDV=WN2TFR6dO7ZdiQ2ijPjs+7HSsvk0ZCHsHj6ZG5t-oEdA@mail.gmail.com>
	<3c42b1ed-7c03-64e6-409e-e92247288cac@kernel.dk>
	<CADGDV=WcTSSC70yG61dazo-WyoLOzp3r+nOk-Eg2x_Ncx=3nRg@mail.gmail.com>
	<7AD2D6DC-0609-42F9-A481-B6E5C0F58180@amazon.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7AD2D6DC-0609-42F9-A481-B6E5C0F58180@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Herrenschmidt, Benjamin" <benh@amazon.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, "Smith,
	Stewart" <trawets@amazon.com>, Christoph Hellwig <hch@lst.de>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
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

On 3/30/22 1:31 PM, Kiselev, Oleg wrote:
> AWS RDS is a major user of drbd.  We are probably responsible for the
> substantial percentage of drbd users in the world.  We are currently
> on drbd-8.4.  We will eventually migrate to drbd-9, but at our scale
> this isn't going to happen very soon.  
> 
> The last time we needed to patch drbd was back in 2018.  We've not
> diagnosed any reportable issues with drbd-8.4 in the past ~4 years.
> It's a stable, mature driver.   We would prefer for drbd-8 to continue
> being available in the upstream tree.  We'd also welcome drbd-9 being
> available in-tree as soon as possible: it will make life much easier
> for other AWS teams that are currently working on DRBD deployment.

Thanks for the info, that's useful and good to know. My objection was as
much about ignoring patches that are sent for drbd, I don't recall
seeing any replies to those kinds of emails in the last 3-4 years. Part
of maintaining an in-tree driver is also dealing with those in a
reasonable amount of time, and ensuring that they make it upstream. And
the one bug fix that does look important was just sent upstream only
because of this discussion, and that's been lingering for a year it
seems.

Roughly ordered by date:

https://lore.kernel.org/all/20220327070918.8465-1-xiam0nd.tong@gmail.com/
https://lore.kernel.org/all/1648436049-4335-1-git-send-email-baihaowen@meizu.com/
https://lore.kernel.org/all/YbpERiPKO4ufe1hf@pc638.lan/
https://lore.kernel.org/all/20211213223331.135412-11-keescook@chromium.org/
[PATCH 0/2] drbd: Make use of PFN_UP helper macro (only on drbd list)
https://lore.kernel.org/all/20210525065925.3978-1-lyl2019@mail.ustc.edu.cn/
https://lore.kernel.org/all/1619774456-116567-1-git-send-email-jiapeng.chong@linux.alibaba.com/
https://lore.kernel.org/all/20210426163032.3454129-1-christoph.boehmwalder@linbit.com/ (the referenced patch)
https://lore.kernel.org/all/20210402070713.4069-1-lyl2019@mail.ustc.edu.cn/ (use after free, security issue?)
https://lore.kernel.org/all/20201026215043.3893318-1-arnd@kernel.org/

This is just going back a bit, by no means an exhaustive list. Looking back
to 2016-2017 and I see zero replies in emails like the above, not one.
Everybody misses patches here and there, that's common. What isn't common
is blatantly ignoring everything for, what, 5 years?

I'm not here to babysit unmaintained drivers. linbit need to get their
act together and maintain the driver, or it will get removed.

-- 
Jens Axboe

