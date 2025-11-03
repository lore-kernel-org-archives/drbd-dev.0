Return-Path: <axboe@kernel.dk>
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com
	[209.85.166.181])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0332F16094D
	for <drbd-dev@lists.linbit.com>; Mon,  3 Nov 2025 16:16:23 +0100 (CET)
Received: by mail-il1-f181.google.com with SMTP id
	e9e14a558f8ab-4332d5be8adso9871745ab.0
	for <drbd-dev@lists.linbit.com>; Mon, 03 Nov 2025 07:16:23 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: philipp.reisner@linbit.com, Shi Hao <i.shihao.999@gmail.com>
In-Reply-To: <20251101054422.17045-1-i.shihao.999@gmail.com>
References: <20251101054422.17045-1-i.shihao.999@gmail.com>
Subject: Re: [PATCH] drbd: replace kmap() with kmap_local_page() in
	receiver path
Message-Id: <176218298119.720460.5302997686043809131.b4-ty@kernel.dk>
Date: Mon, 03 Nov 2025 08:16:21 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, lars.ellenberg@linbit.com,
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


On Sat, 01 Nov 2025 11:14:22 +0530, Shi Hao wrote:
> Use kmap_local_page() instead of kmap() to avoid
> CPU contention.
> 
> kmap() uses a global set of mapping slots that can cause contention
> between multiple CPUs, while kmap_local_page() uses per-CPU slots
> eliminating this contention. It also ensures non-sleeping operation
> and provides better cache locality.
> 
> [...]

Applied, thanks!

[1/1] drbd: replace kmap() with kmap_local_page() in receiver path
      commit: 77220f6d18a22b0b5d73b5d2156609b0aa21a7c5

Best regards,
-- 
Jens Axboe



