Return-Path: <axboe@kernel.dk>
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
	[209.85.167.194])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id F16AF101AC45
	for <drbd-dev@lists.linbit.com>; Tue, 23 Jul 2019 16:02:56 +0200 (CEST)
Received: by mail-oi1-f194.google.com with SMTP id s184so32359555oie.9
	for <drbd-dev@lists.linbit.com>; Tue, 23 Jul 2019 07:02:56 -0700 (PDT)
To: Arnd Bergmann <arnd@arndb.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
References: <20190722122647.351002-1-arnd@arndb.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2675f963-6d67-7802-4f8a-eab423688419@kernel.dk>
Date: Tue, 23 Jul 2019 07:35:41 -0600
MIME-Version: 1.0
In-Reply-To: <20190722122647.351002-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Kees Cook <keescook@chromium.org>,
	Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, clang-built-linux@googlegroups.com,
	Roland Kammerer <roland.kammerer@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] [v2] drbd: dynamically allocate shash
	descriptor
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 7/22/19 6:26 AM, Arnd Bergmann wrote:
> Building with clang and KASAN, we get a warning about an overly large
> stack frame on 32-bit architectures:
> 
> drivers/block/drbd/drbd_receiver.c:921:31: error: stack frame size of 1280 bytes in function 'conn_connect'
>        [-Werror,-Wframe-larger-than=]
> 
> We already allocate other data dynamically in this function, so
> just do the same for the shash descriptor, which makes up most of
> this memory.

Applied, thanks.

-- 
Jens Axboe

