Return-Path: <axboe@kernel.dk>
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
	[209.85.221.45])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AC9BB420303
	for <drbd-dev@lists.linbit.com>; Wed, 18 Sep 2024 12:17:08 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
	ffacd0b85a97d-374c1e5fe79so4927168f8f.1
	for <drbd-dev@lists.linbit.com>; Wed, 18 Sep 2024 03:17:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, Qiu-ji Chen <chenqiuji666@gmail.com>
In-Reply-To: <20240913083504.10549-1-chenqiuji666@gmail.com>
References: <20240913083504.10549-1-chenqiuji666@gmail.com>
Subject: Re: [PATCH] drbd: Fix atomicity violation in drbd_uuid_set_bm()
Message-Id: <172665462666.8208.13856585668352326031.b4-ty@kernel.dk>
Date: Wed, 18 Sep 2024 04:17:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, baijiaju1990@gmail.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	drbd-dev@lists.linbit.com
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


On Fri, 13 Sep 2024 16:35:04 +0800, Qiu-ji Chen wrote:
> The violation of atomicity occurs when the drbd_uuid_set_bm function is
> executed simultaneously with modifying the value of
> device->ldev->md.uuid[UI_BITMAP]. Consider a scenario where, while
> device->ldev->md.uuid[UI_BITMAP] passes the validity check when its value
> is not zero, the value of device->ldev->md.uuid[UI_BITMAP] is written to
> zero. In this case, the check in drbd_uuid_set_bm might refer to the old
> value of device->ldev->md.uuid[UI_BITMAP] (before locking), which allows
> an invalid value to pass the validity check, resulting in inconsistency.
> 
> [...]

Applied, thanks!

[1/1] drbd: Fix atomicity violation in drbd_uuid_set_bm()
      commit: 2f02b5af3a4482b216e6a466edecf6ba8450fa45

Best regards,
-- 
Jens Axboe



