Return-Path: <axboe@kernel.dk>
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
	[209.85.215.181])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 49EE6420FE2
	for <drbd-dev@lists.linbit.com>; Thu,  7 Apr 2022 00:37:58 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id 32so1262636pgl.4
	for <drbd-dev@lists.linbit.com>; Wed, 06 Apr 2022 15:37:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: christoph.boehmwalder@linbit.com
In-Reply-To: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
References: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
Message-Id: <164928467657.11110.6351742208734304925.b4-ty@kernel.dk>
Date: Wed, 06 Apr 2022 16:37:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars.ellenberg@linbit.com, philipp.reisner@linbit.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 0/7] DRBD updates for 5.19
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

On Wed, 6 Apr 2022 21:07:08 +0200, Christoph Böhmwalder wrote:
> Mostly cosmetic changes, bound for 5.19.
> 
> Arnd Bergmann (2):
>   drbd: fix duplicate array initializer
>   drbd: address enum mismatch warnings
> 
> Cai Huoqing (2):
>   drbd: Make use of PFN_UP helper macro
>   drbd: Replace "unsigned" with "unsigned int"
> 
> [...]

Applied, thanks!

[1/7] drbd: fix duplicate array initializer
      commit: adff355a6d6602d6be7be4c98e39d1d957a7e53f
[2/7] drbd: address enum mismatch warnings
      commit: a9cb5060fabb46187c8b00ac740bc30f045baa8e
[3/7] block: drbd: drbd_receiver: Remove redundant assignment to err
      commit: c8057a1ec541f972d0ca2ab14a77bd0f6a1919e3
[4/7] drbd: Make use of PFN_UP helper macro
      commit: 25dddd7771061c0d7176d396117244e19ce30858
[5/7] drbd: Replace "unsigned" with "unsigned int"
      commit: ad94e90806ac935c91dc6f048cec6c6ec4069cec
[6/7] drdb: Switch to kvfree_rcu() API
      commit: 40dad92d68aab52919d98524eb8aa87ed23596c8
[7/7] drbd: Return true/false (not 1/0) from bool functions
      commit: c0bf7a4c2313c46f2ba14b78a622a7e32bbbb2ac

Best regards,
-- 
Jens Axboe


