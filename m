Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
	[209.85.128.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 94E86164D3A
	for <drbd-dev@lists.linbit.com>; Mon,  4 May 2026 11:06:00 +0200 (CEST)
Received: by mail-wm1-f52.google.com with SMTP id
	5b1f17b1804b1-48374014a77so43680605e9.3
	for <drbd-dev@lists.linbit.com>; Mon, 04 May 2026 02:06:00 -0700 (PDT)
Date: Mon, 4 May 2026 11:05:55 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 2/4] tools: ynl-gen-c: optionally emit structs and helpers
Message-ID: <afhgQgySpoxXFCn1@localhost.localdomain>
References: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
	<20260407173356.873887-3-christoph.boehmwalder@linbit.com>
	<20260412125502.3f8ff576@kernel.org>
	<adzVUdf74CVk2DwJ@localhost.localdomain>
	<20260413104939.5ef4d9dc@kernel.org>
	<ad4ox7ibZoiW-tje@localhost.localdomain>
	<20260414083548.02f76970@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260414083548.02f76970@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Donald Hunter <donald.hunter@gmail.com>,
	netdev@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
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

On Tue, Apr 14, 2026 at 08:35:48AM -0700, Jakub Kicinski wrote:
>On Tue, 14 Apr 2026 14:08:58 +0200 Christoph Böhmwalder wrote:
>> But we still need to support the current family via a compat path, and
>> I would much rather have two YNL-based families than one genl_magic and
>> one YNL-based. Carrying both sounds like a nightmare.
>>
>> So the spec proposed in this series would never actually be used to
>> generate a userspace client, if that's what you're asking. We would
>> continue to use the current libgenl-based approach, with some userspace
>> compat shims to make it work with YNL. Then, when "drbd2" comes along,
>> we could "do things properly".
>
>Let's jump to the drbd2 work.

We have a bit of a chicken-egg situation there.

The drbd2 work depends on the DRBD 9 upstreaming series, since the drbd2
netlink family will use the new DRBD 9 semantics.
However, the DRBD 9 series depends on the current DRBD module already
using YNL (or rather, *not* using genl_magic anymore).

Our plan is to convert the current family to YNL in-place first, then
incrementally add the new modern drbd2 family with DRBD 9 semantics in
another series.

How would you prefer to handle the YNL switch? If it makes it easier for
you, just committing the YNL-generated code without the generator is
fine for me. The old family is effectively frozen, so that would work.

Thanks,
Christoph
