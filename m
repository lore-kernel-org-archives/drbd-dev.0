Return-Path: <axboe@kernel.dk>
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
	[209.85.215.173])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A1D83420150
	for <drbd-dev@lists.linbit.com>; Fri, 22 Dec 2023 15:18:44 +0100 (CET)
Received: by mail-pg1-f173.google.com with SMTP id
	41be03b00d2f7-5cdf90e5cdeso108766a12.1
	for <drbd-dev@lists.linbit.com>; Fri, 22 Dec 2023 06:18:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231222061909.8791-1-rdunlap@infradead.org>
References: <20231222061909.8791-1-rdunlap@infradead.org>
Message-Id: <170325472218.1024948.10134238740797741096.b4-ty@kernel.dk>
Date: Fri, 22 Dec 2023 07:18:42 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: actlog: fix kernel-doc warnings and
	spelling
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


On Thu, 21 Dec 2023 22:19:08 -0800, Randy Dunlap wrote:
> Fix all kernel-doc warnings in drbd_actlog.c:
> 
> drbd_actlog.c:963: warning: No description found for return value of 'drbd_rs_begin_io'
> drbd_actlog.c:1015: warning: Function parameter or member 'peer_device' not described in 'drbd_try_rs_begin_io'
> drbd_actlog.c:1015: warning: Excess function parameter 'device' description in 'drbd_try_rs_begin_io'
> drbd_actlog.c:1015: warning: No description found for return value of 'drbd_try_rs_begin_io'
> drbd_actlog.c:1197: warning: No description found for return value of 'drbd_rs_del_all'
> 
> [...]

Applied, thanks!

[1/1] drbd: actlog: fix kernel-doc warnings and spelling
      commit: 8aabc11c8f4e0a57661a07f985ddc8a626ef9148

Best regards,
-- 
Jens Axboe



