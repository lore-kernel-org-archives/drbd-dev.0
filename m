Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 43F6C4203F4
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:59:20 +0200 (CEST)
Received: by mail-wm1-f67.google.com with SMTP id r9so10052968wmh.2
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:59:20 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	f71sm11867290wmf.22.2020.06.13.02.59.18
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:59:19 -0700 (PDT)
Resent-Message-ID: <20200613095917.GL4222@soda.linbit>
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
	[209.85.208.194])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3F94C420235
	for <drbd-dev@lists.linbit.com>; Thu,  4 Jun 2020 17:22:27 +0200 (CEST)
Received: by mail-lj1-f194.google.com with SMTP id m18so7797886ljo.5
	for <drbd-dev@lists.linbit.com>; Thu, 04 Jun 2020 08:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200603233203.1695403-2-keescook@chromium.org>
	<874krr8dps.fsf@nanos.tec.linutronix.de>
	<CANiq72kLqvriYmMkdD3yU+xJwbn-68Eiu-fTNtC+Lb+1ZRM75g@mail.gmail.com>
	<202006040745.525ECD1@keescook>
In-Reply-To: <202006040745.525ECD1@keescook>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 4 Jun 2020 17:22:15 +0200
Message-ID: <CANiq72mHhzfPMGbBn=NZfqLeejPG+t=GN++NJ-L0hg-2x4UPag@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Cc: clang-built-linux <clang-built-linux@googlegroups.com>,
	linux-ide@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	"maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-spi@vger.kernel.org, linux-block@vger.kernel.org,
	Andy Whitcroft <apw@canonical.com>, Linux-MM <linux-mm@kvack.org>,
	Alexander Potapenko <glider@google.com>,
	b43-dev@lists.infradead.org, Joe Perches <joe@perches.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-clk@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 01/10] x86/mm/numa: Remove
	uninitialized_var() usage
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

On Thu, Jun 4, 2020 at 4:56 PM Kees Cook <keescook@chromium.org> wrote:
>
> Er? That's not what it looked like to me:
>
> #define IS_BUILTIN(option) __is_defined(option)
> #define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
>
> But just to be sure, I just tested in with a real build:
>
> [    3.242160] IS_ENABLED(TEST_UNDEF) false
> [    3.242691] __is_defined(TEST_UNDEF) false
> [    3.243240] IS_ENABLED(TEST_VALUE_EMPTY) false
> [    3.243794] __is_defined(TEST_VALUE_EMPTY) false
> [    3.244353] IS_ENABLED(TEST_VALUE_1) true
> [    3.244848] __is_defined(TEST_VALUE_1) true
>
> and nope, it only works with a defined value present.

You are right, it follows the Kconfig logic, returning false for
defined-but-to-0 too.

We should probably add an `IS_DEFINED()` macro kernel-wide for this
(and add it to the `coding-guidelines.rst` since `IS_ENABLED()` is
mentioned there, with a warning not to mix it with `__is_defined()`
which looks it was only intended as an implementation detail for
`include/linux/kconfig.h`).

CC'ing Masahiro by the way.

Cheers,
Miguel
