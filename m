Return-Path: <axboe@kernel.dk>
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com
	[209.85.166.179])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0A1B942095F
	for <drbd-dev@lists.linbit.com>; Thu,  1 Dec 2022 19:49:07 +0100 (CET)
Received: by mail-il1-f179.google.com with SMTP id o13so1133382ilc.7
	for <drbd-dev@lists.linbit.com>; Thu, 01 Dec 2022 10:49:07 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
In-Reply-To: <20221201110349.1282687-1-christoph.boehmwalder@linbit.com>
References: <20221201110349.1282687-1-christoph.boehmwalder@linbit.com>
Message-Id: <166992054601.851878.10906244874618547606.b4-ty@kernel.dk>
Date: Thu, 01 Dec 2022 11:49:06 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] [PATCH 0/5] Backported DRBD printk/debug improvements
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

On Thu, 01 Dec 2022 12:03:45 +0100, Christoph Böhmwalder wrote:
> Some changes to DRBD's logging infrastructure, backported from the
> out-of-tree module.
> 
> Since the two code bases have diverged so much, it is tough to preserve
> authorship information without "putting words into someone's mouth". So
> I ended up using Originally-from tags to try and encode the original
> authors of these patches.
> 
> [...]

Applied, thanks!

[1/5] drbd: unify how failed assertions are logged
      commit: c3f8974198b41965c8f62099ba97f1293561cab2
[2/5] drbd: split polymorph printk to its own file
      commit: 136160c1732e3f86afd70c19ec6d1f5e6f79a7e9
[3/5] drbd: introduce dynamic debug
      commit: aa034695971124f673d4ccdd39cd7f269904ea86
[4/5] drbd: introduce drbd_ratelimit()
      commit: e3fa02d7d420c7cfb7077cc6eeb62c886ba5ff39
[5/5] drbd: add context parameter to expect() macro
      commit: 677b367275f8729546aee918e547056a90dbdc07

Best regards,
-- 
Jens Axboe


