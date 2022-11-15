Return-Path: <axboe@kernel.dk>
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
	[209.85.216.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5E5E542066F
	for <drbd-dev@lists.linbit.com>; Tue, 15 Nov 2022 15:53:46 +0100 (CET)
Received: by mail-pj1-f42.google.com with SMTP id b11so13543645pjp.2
	for <drbd-dev@lists.linbit.com>; Tue, 15 Nov 2022 06:53:45 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Dan Carpenter <error27@gmail.com>
In-Reply-To: <Y3Jd5iZRbNQ9w6gm@kili>
References: <Y3Jd5iZRbNQ9w6gm@kili>
Message-Id: <166852402392.12848.9236710140570124289.b4-ty@kernel.dk>
Date: Tue, 15 Nov 2022 07:53:43 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Andreas Gruenbacher <agruen@linbit.com>, kernel-janitors@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: use after free in drbd_create_device()
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

On Tue, 15 Nov 2022 16:16:43 +0300, Dan Carpenter wrote:
> The drbd_destroy_connection() frees the "connection" so use the _safe()
> iterator to prevent a use after free.
> 
> 

Applied, thanks!

[1/1] drbd: use after free in drbd_create_device()
      commit: a7a1598189228b5007369a9622ccdf587be0730f

Best regards,
-- 
Jens Axboe


