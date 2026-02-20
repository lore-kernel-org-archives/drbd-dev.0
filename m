Return-Path: <axboe@kernel.dk>
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com
	[209.85.160.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id F3126160922
	for <drbd-dev@lists.linbit.com>; Fri, 20 Feb 2026 15:09:24 +0100 (CET)
Received: by mail-oa1-f41.google.com with SMTP id
	586e51a60fabf-4152698e745so751333fac.1
	for <drbd-dev@lists.linbit.com>; Fri, 20 Feb 2026 06:09:24 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260220113937.2691322-1-christoph.boehmwalder@linbit.com>
References: <20260220113937.2691322-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: fix null-pointer dereference on local read error
Message-Id: <177159656185.567740.9381187974299808709.b4-ty@kernel.dk>
Date: Fri, 20 Feb 2026 07:09:21 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Tuo Li <islituo@gmail.com>, drbd-dev@lists.linbit.com
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


On Fri, 20 Feb 2026 12:39:37 +0100, Christoph Böhmwalder wrote:
> In drbd_request_endio(), READ_COMPLETED_WITH_ERROR is passed to
> __req_mod() with a NULL peer_device:
> 
>   __req_mod(req, what, NULL, &m);
> 
> The READ_COMPLETED_WITH_ERROR handler then unconditionally passes this
> NULL peer_device to drbd_set_out_of_sync(), which dereferences it,
> causing a null-pointer dereference.
> 
> [...]

Applied, thanks!

[1/1] drbd: fix null-pointer dereference on local read error
      commit: 0d195d3b205ca90db30d70d09d7bb6909aac178f

Best regards,
-- 
Jens Axboe



