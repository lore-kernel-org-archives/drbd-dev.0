Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f178.google.com (mail-wr0-f178.google.com
	[209.85.128.178])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9BB1F105630C
	for <drbd-dev@lists.linbit.com>; Wed, 28 Jun 2017 10:05:51 +0200 (CEST)
Received: by mail-wr0-f178.google.com with SMTP id c11so170296728wrc.3
	for <drbd-dev@lists.linbit.com>; Wed, 28 Jun 2017 01:05:51 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	n71sm1272184wrb.62.2017.06.28.01.05.50
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 28 Jun 2017 01:05:50 -0700 (PDT)
Resent-Message-ID: <20170628080548.GA26451@soda.linbit>
Received: from mail-it0-f41.google.com (mail-it0-f41.google.com
	[209.85.214.41])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id AB4511057FDD
	for <drbd-dev@lists.linbit.com>; Wed, 28 Jun 2017 01:53:22 +0200 (CEST)
Received: by mail-it0-f41.google.com with SMTP id v202so21971057itb.0
	for <drbd-dev@lists.linbit.com>; Tue, 27 Jun 2017 16:53:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Jun 2017 16:47:37 -0700
Message-ID: <CAGXu5jK+oz7SoBKmHDjUpmZ96=keiou+75WK2or37Z8RL9jLxA@mail.gmail.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset="UTF-8"
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Linux PM list <linux-pm@vger.kernel.org>, linux-iio@vger.kernel.org,
	linux-input <linux-input@vger.kernel.org>, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Linux mtd <linux-mtd@lists.infradead.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>, linux-omap@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 0/9] Drop unnecessary static
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

On Thu, May 4, 2017 at 1:10 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> These patches fix cases where there is a static on a local variable, but
> the variable is either first initialized or never used, on every possible
> execution path through the function.  The static has no benefit, and
> dropping it reduces the code size.
>
> ---
>
>  drivers/block/drbd/drbd_nl.c            |    2 +-
>  drivers/clocksource/timer-fttmr010.c    |    2 +-
>  drivers/iio/accel/hid-sensor-accel-3d.c |    2 +-
>  drivers/mfd/max8925-i2c.c               |    2 +-
>  drivers/mfd/twl4030-irq.c               |    2 +-
>  drivers/mtd/chips/cfi_cmdset_0020.c     |    2 +-
>  drivers/mtd/maps/physmap_of_gemini.c    |    2 +-
>  drivers/power/supply/axp20x_usb_power.c |    2 +-
>  drivers/regulator/palmas-regulator.c    |    2 +-
>  9 files changed, 9 insertions(+), 9 deletions(-)

It looks like most of these were taken. I pinged the other three. Thanks!

-Kees

-- 
Kees Cook
Pixel Security
