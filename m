Return-Path: <axboe@kernel.dk>
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
	[209.85.216.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3AAEF4203AB
	for <drbd-dev@lists.linbit.com>; Fri, 13 Jan 2023 21:44:09 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
	w4-20020a17090ac98400b002186f5d7a4cso28187343pjt.0
	for <drbd-dev@lists.linbit.com>; Fri, 13 Jan 2023 12:44:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
References: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
Message-Id: <167364264790.13167.1164501758187135700.b4-ty@kernel.dk>
Date: Fri, 13 Jan 2023 13:44:07 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RESEND PATCH 0/8] Miscellaneous DRBD reorganization
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


On Fri, 13 Jan 2023 13:35:30 +0100, Christoph Böhmwalder wrote:
> Some more mostly trivial "alignment patches" to (slowly but surely)
> move further in the direction of re-upstreaming DRBD.
> 
> These should be fairly uncontroversial.
> 
> Andreas Gruenbacher (1):
>   drbd: drbd_insert_interval(): Clarify comment
> 
> [...]

Applied, thanks!

[1/8] drbd: adjust drbd_limits license header
      commit: f4095e7643c0fd00f1c125388d6d83d60875d489
[2/8] drbd: fix DRBD_VOLUME_MAX 65535 -> 65534
      commit: f7fb0227ae90fff4d09d969c353e8a30f2e0edcc
[3/8] drbd: make limits unsigned
      commit: 4e5ebce4a5dde36316a78550c9f7b97a9e03302b
[4/8] drbd: remove unnecessary assignment in vli_encode_bits
      commit: 93a8026b0d7161597437eb2d87ceac4f194991c4
[5/8] drbd: remove macros using require_context
      commit: 00f0c8eccb383782621c74e5bd2ce9b4b8dbad5a
[6/8] MAINTAINERS: add drbd headers
      commit: 463afd417b268d18d3c83ec0851e978dd12daaa2
[7/8] drbd: interval tree: make removing an "empty" interval a no-op
      commit: 6928e2f7919aa3cd4e31aba5b16f6f212df2bb35
[8/8] drbd: drbd_insert_interval(): Clarify comment
      commit: 2b0802d1ac9333d060312b22e9d898614253adcf

Best regards,
-- 
Jens Axboe



