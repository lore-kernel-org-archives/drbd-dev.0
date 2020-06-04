Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C5139420413
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:58:49 +0200 (CEST)
Received: by mail-wr1-f67.google.com with SMTP id x14so12297422wrp.2
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:58:49 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	k64sm12955727wmf.34.2020.06.13.02.58.48
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:58:48 -0700 (PDT)
Resent-Message-ID: <20200613095847.GZ4222@soda.linbit>
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
	[209.85.208.196])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 65C1442030B
	for <drbd-dev@lists.linbit.com>; Thu,  4 Jun 2020 02:50:39 +0200 (CEST)
Received: by mail-lj1-f196.google.com with SMTP id s1so5142125ljo.0
	for <drbd-dev@lists.linbit.com>; Wed, 03 Jun 2020 17:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200603233203.1695403-1-keescook@chromium.org>
	<20200603233203.1695403-11-keescook@chromium.org>
In-Reply-To: <20200603233203.1695403-11-keescook@chromium.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 4 Jun 2020 02:50:27 +0200
Message-ID: <CANiq72nJhZZ7Bc+VQpPrDjey0iD9TspbtodtGpKaZNz8NCaHww@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Cc: clang-built-linux <clang-built-linux@googlegroups.com>,
	linux-ide@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
	"maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-spi@vger.kernel.org, linux-block@vger.kernel.org,
	Andy Whitcroft <apw@canonical.com>, Linux-MM <linux-mm@kvack.org>,
	Alexander Potapenko <glider@google.com>,
	b43-dev@lists.infradead.org, Joe Perches <joe@perches.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-clk@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 10/10] compiler: Remove uninitialized_var()
	macro
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

Hi Kees,

On Thu, Jun 4, 2020 at 1:32 AM Kees Cook <keescook@chromium.org> wrote:
>
> Using uninitialized_var() is dangerous as it papers over real bugs[1]
> (or can in the future), and suppresses unrelated compiler warnings
> (e.g. "unused variable"). If the compiler thinks it is uninitialized,
> either simply initialize the variable or make compiler changes.
>
> As recommended[2] by[3] Linus[4], remove the macro.
>
> [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

+1, one less trick split between `compiler*` files.

Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
