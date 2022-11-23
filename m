Return-Path: <axboe@kernel.dk>
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
	[209.85.216.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 704BD4252E1
	for <drbd-dev@lists.linbit.com>; Wed, 23 Nov 2022 03:39:03 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
	l22-20020a17090a3f1600b00212fbbcfb78so657990pjc.3
	for <drbd-dev@lists.linbit.com>; Tue, 22 Nov 2022 18:39:03 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
In-Reply-To: <20221122134301.69258-1-christoph.boehmwalder@linbit.com>
References: <20221122134301.69258-1-christoph.boehmwalder@linbit.com>
Message-Id: <166917114097.16835.13922325518442177029.b4-ty@kernel.dk>
Date: Tue, 22 Nov 2022 19:39:00 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 0/4] lru_cache improvements,
	DRBD license identifiers
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

On Tue, 22 Nov 2022 14:42:57 +0100, Christoph Böhmwalder wrote:
> Here are some improvements to the lru_cache; mostly just cleanups that
> we missed to send upstream over the years.
> 
> The last patch makes the SPDX license headers in DRBD consistent so
> that they all represent GPL 2.0.
> 
> Christoph Böhmwalder (2):
>   lru_cache: remove compiled out code
>   drbd: use consistent license
> 
> [...]

Applied, thanks!

[1/4] lru_cache: use atomic operations when accessing lc->flags, always
      commit: f2d03d89615ef65b5dff3aae6581df0b5fcbaa3b
[2/4] lru_cache: remove compiled out code
      commit: 9933438430b3b787f96bb434b4490b0dda59c9b3
[3/4] lru_cache: remove unused lc_private, lc_set, lc_index_of
      commit: 2cd10a496a86787367716b684dadfecbb594095b
[4/4] drbd: use consistent license
      commit: 93c68cc46a070775cc6675e3543dd909eb9f6c9e

Best regards,
-- 
Jens Axboe


