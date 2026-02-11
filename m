Return-Path: <axboe@kernel.dk>
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
	[209.85.210.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 42B72163029
	for <drbd-dev@lists.linbit.com>; Wed, 11 Feb 2026 18:36:21 +0100 (CET)
Received: by mail-ot1-f43.google.com with SMTP id
	46e09a7af769-7cfd65ea639so1472298a34.0
	for <drbd-dev@lists.linbit.com>; Wed, 11 Feb 2026 09:36:21 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260205173928.3166880-2-christoph.boehmwalder@linbit.com>
References: <20260205173928.3166880-2-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: always set BLK_FEAT_STABLE_WRITES
Message-Id: <177083138009.157276.14024749739595076725.b4-ty@kernel.dk>
Date: Wed, 11 Feb 2026 10:36:20 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
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


On Thu, 05 Feb 2026 18:39:29 +0100, Christoph Böhmwalder wrote:
> DRBD requires stable pages because it may read the same bio data
> multiple times for local disk I/O and network transmission, and in
> some cases for calculating checksums.
> 
> The BLK_FEAT_STABLE_WRITES flag is set when the device is first
> created, but blk_set_stacking_limits() clears it whenever a
> backing device is attached. In some cases the flag may be
> inherited from the backing device, but we want it to be enabled
> at all times.
> 
> [...]

Applied, thanks!

[1/1] drbd: always set BLK_FEAT_STABLE_WRITES
      commit: 2ebc8d600fb907fa6b1e7095c0b6d84fc47e91ea

Best regards,
-- 
Jens Axboe



