Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 25ADF1057FE5
	for <drbd-dev@lists.linbit.com>; Fri,  5 May 2017 13:32:11 +0200 (CEST)
Received: by mail-wm0-f53.google.com with SMTP id w64so21232158wma.0
	for <drbd-dev@lists.linbit.com>; Fri, 05 May 2017 04:32:11 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100])
	by smtp.gmail.com with ESMTPSA id 7sm3755241wrs.69.2017.05.05.04.32.10
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 May 2017 04:32:10 -0700 (PDT)
Resent-Message-ID: <20170505113209.GG28116@soda.linbit>
Received: from mail3-relais-sop.national.inria.fr
	(mail3-relais-sop.national.inria.fr [192.134.164.104])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 39F991057FCC
	for <drbd-dev@lists.linbit.com>; Thu,  4 May 2017 22:45:37 +0200 (CEST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: linux-pm@vger.kernel.org
Date: Thu,  4 May 2017 22:10:45 +0200
Message-Id: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
Cc: Lars-Peter Clausen <lars@metafoo.de>, keescook@chromium.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>, linux-omap@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 0/9] Drop unnecessary static
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

These patches fix cases where there is a static on a local variable, but
the variable is either first initialized or never used, on every possible
execution path through the function.  The static has no benefit, and
dropping it reduces the code size.

---

 drivers/block/drbd/drbd_nl.c            |    2 +-
 drivers/clocksource/timer-fttmr010.c    |    2 +-
 drivers/iio/accel/hid-sensor-accel-3d.c |    2 +-
 drivers/mfd/max8925-i2c.c               |    2 +-
 drivers/mfd/twl4030-irq.c               |    2 +-
 drivers/mtd/chips/cfi_cmdset_0020.c     |    2 +-
 drivers/mtd/maps/physmap_of_gemini.c    |    2 +-
 drivers/power/supply/axp20x_usb_power.c |    2 +-
 drivers/regulator/palmas-regulator.c    |    2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)
