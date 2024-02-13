Return-Path: <axboe@kernel.dk>
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com
	[209.85.166.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 94062420230
	for <drbd-dev@lists.linbit.com>; Tue, 13 Feb 2024 16:56:00 +0100 (CET)
Received: by mail-io1-f51.google.com with SMTP id
	ca18e2360f4ac-7bff2f6080aso19520339f.1
	for <drbd-dev@lists.linbit.com>; Tue, 13 Feb 2024 07:56:00 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Arnd Bergmann <arnd@kernel.org>
In-Reply-To: <20240213100354.457128-1-arnd@kernel.org>
References: <20240213100354.457128-1-arnd@kernel.org>
Subject: Re: [PATCH] drbd: fix function cast warnings in state machine
Message-Id: <170783975824.2331975.17734171438051214868.b4-ty@kernel.dk>
Date: Tue, 13 Feb 2024 08:55:58 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	"Uladzislau Rezki \(Sony\)" <urezki@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, drbd-dev@lists.linbit.com
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


On Tue, 13 Feb 2024 11:03:01 +0100, Arnd Bergmann wrote:
> There are four state machines in drbd that use a common infrastructure, with
> a cast to an incompatible function type in REMEMBER_STATE_CHANGE that clang-16
> now warns about:
> 
> drivers/block/drbd/drbd_state.c:1632:3: error: cast from 'int (*)(struct sk_buff *, unsigned int, struct drbd_resource_state_change *, enum drbd_notification_type)' to 'typeof (last_func)' (aka 'int (*)(struct sk_buff *, unsigned int, void *, enum drbd_notification_type)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>  1632 |                 REMEMBER_STATE_CHANGE(notify_resource_state_change,
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1633 |                                       resource_state_change, NOTIFY_CHANGE);
>       |                                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/block/drbd/drbd_state.c:1619:17: note: expanded from macro 'REMEMBER_STATE_CHANGE'
>  1619 |            last_func = (typeof(last_func))func; \
>       |                        ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/block/drbd/drbd_state.c:1641:4: error: cast from 'int (*)(struct sk_buff *, unsigned int, struct drbd_connection_state_change *, enum drbd_notification_type)' to 'typeof (last_func)' (aka 'int (*)(struct sk_buff *, unsigned int, void *, enum drbd_notification_type)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>  1641 |                         REMEMBER_STATE_CHANGE(notify_connection_state_change,
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1642 |                                               connection_state_change, NOTIFY_CHANGE);
>       |                                               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] drbd: fix function cast warnings in state machine
      commit: fe0b1e9a73d60f01fdc391925be74e823af7c91d

Best regards,
-- 
Jens Axboe



