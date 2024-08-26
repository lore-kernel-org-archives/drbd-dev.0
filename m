Return-Path: <axboe@kernel.dk>
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com
	[209.85.166.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id F396D420618
	for <drbd-dev@lists.linbit.com>; Mon, 26 Aug 2024 15:19:56 +0200 (CEST)
Received: by mail-io1-f51.google.com with SMTP id
	ca18e2360f4ac-81fd520fe0dso159081339f.3
	for <drbd-dev@lists.linbit.com>; Mon, 26 Aug 2024 06:19:56 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <d5322ef88d1d6f544963ee277cb0b427da8dceef.1724602922.git.christophe.jaillet@wanadoo.fr>
References: <d5322ef88d1d6f544963ee277cb0b427da8dceef.1724602922.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] drbd: Remove an unused field in struct drbd_device
Message-Id: <172467839482.162646.6496919978142098172.b4-ty@kernel.dk>
Date: Mon, 26 Aug 2024 07:19:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org,
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


On Sun, 25 Aug 2024 18:22:23 +0200, Christophe JAILLET wrote:
> 'next_barrier_nr' is not used in this driver. Remove it.
> 
> It was already part of the original commit b411b3637fa7 ("The DRBD driver")
> Apparently, it has never been used.
> 
> 

Applied, thanks!

[1/1] drbd: Remove an unused field in struct drbd_device
      commit: 87599eddc25ac03647ab76221523c6485e7594b1

Best regards,
-- 
Jens Axboe



