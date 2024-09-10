Return-Path: <axboe@kernel.dk>
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
	[209.85.214.172])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 85C3F420239
	for <drbd-dev@lists.linbit.com>; Tue, 10 Sep 2024 03:21:34 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
	d9443c01a7336-2054e22ce3fso1932205ad.2
	for <drbd-dev@lists.linbit.com>; Mon, 09 Sep 2024 18:21:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Mikhail Lobanov <m.lobanov@rosalinux.ru>
In-Reply-To: <20240909133740.84297-1-m.lobanov@rosalinux.ru>
References: <20240909133740.84297-1-m.lobanov@rosalinux.ru>
Subject: Re: [PATCH] drbd: Add NULL check for net_conf to prevent
	dereference in state validation
Message-Id: <172593129267.13781.9847171739560045999.b4-ty@kernel.dk>
Date: Mon, 09 Sep 2024 19:21:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: lvc-project@linuxtesting.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
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


On Mon, 09 Sep 2024 09:37:36 -0400, Mikhail Lobanov wrote:
> If the net_conf pointer is NULL and the code attempts to access its
> fields without a check, it will lead to a null pointer dereference.
> Add a NULL check before dereferencing the pointer.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 
> [...]

Applied, thanks!

[1/1] drbd: Add NULL check for net_conf to prevent dereference in state validation
      commit: de068f4741781bbba0568b44b41d51da0feef6f9

Best regards,
-- 
Jens Axboe



