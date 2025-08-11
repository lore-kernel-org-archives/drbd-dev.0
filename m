Return-Path: <axboe@kernel.dk>
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
	[209.85.216.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6BEAA16064E
	for <drbd-dev@lists.linbit.com>; Mon, 11 Aug 2025 16:01:45 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
	98e67ed59e1d1-321a5d6d301so912875a91.3
	for <drbd-dev@lists.linbit.com>; Mon, 11 Aug 2025 07:01:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20250605103852.23029-1-christoph.boehmwalder@linbit.com>
References: <20250605103852.23029-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: Remove the open-coded page pool
Message-Id: <175492090268.697940.16894165700096915187.b4-ty@kernel.dk>
Date: Mon, 11 Aug 2025 08:01:42 -0600
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


On Thu, 05 Jun 2025 12:38:52 +0200, Christoph Böhmwalder wrote:
> If the network stack keeps a reference for too long, DRBD keeps
> references on a higher number of pages as a consequence.
> 
> Fix all that by no longer relying on page reference counts dropping to
> an expected value. Instead, DRBD gives up its reference and lets the
> system handle everything else. While at it, remove the open-coded
> custom page pool mechanism and use the page_pool included in the
> kernel.
> 
> [...]

Applied, thanks!

[1/1] drbd: Remove the open-coded page pool
      commit: d5dd409812eca084e68208926bb629c8f708651f

Best regards,
-- 
Jens Axboe



