Return-Path: <axboe@kernel.dk>
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
	[209.85.160.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 715F216087D
	for <drbd-dev@lists.linbit.com>; Thu, 19 Feb 2026 16:22:21 +0100 (CET)
Received: by mail-oa1-f46.google.com with SMTP id
	586e51a60fabf-413c2977db8so635850fac.3
	for <drbd-dev@lists.linbit.com>; Thu, 19 Feb 2026 07:22:21 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260219142012.97756-1-christoph.boehmwalder@linbit.com>
References: <20260219142012.97756-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()
Message-Id: <177151453921.556009.15485390943324050309.b4-ty@kernel.dk>
Date: Thu, 19 Feb 2026 08:22:19 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Lars Ellenberg <lars@linbit.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
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


On Thu, 19 Feb 2026 15:20:12 +0100, Christoph Böhmwalder wrote:
> Even though we check that we "should" be able to do lc_get_cumulative()
> while holding the device->al_lock spinlock, it may still fail,
> if some other code path decided to do lc_try_lock() with bad timing.
> 
> If that happened, we logged "LOGIC BUG for enr=...",
> but still did not return an error.
> 
> [...]

Applied, thanks!

[1/1] drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()
      commit: ab140365fb62c0bdab22b2f516aff563b2559e3b

Best regards,
-- 
Jens Axboe



