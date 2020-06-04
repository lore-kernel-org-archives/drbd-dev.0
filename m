Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0698B420435
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:59:15 +0200 (CEST)
Received: by mail-wr1-f65.google.com with SMTP id t18so12297422wru.6
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:59:15 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	s18sm16821666wra.85.2020.06.13.02.59.13
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:59:14 -0700 (PDT)
Resent-Message-ID: <20200613095912.GJ4222@soda.linbit>
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
	[209.85.208.195])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B4B6B420235
	for <drbd-dev@lists.linbit.com>; Thu,  4 Jun 2020 13:41:19 +0200 (CEST)
Received: by mail-lj1-f195.google.com with SMTP id z18so6797526lji.12
	for <drbd-dev@lists.linbit.com>; Thu, 04 Jun 2020 04:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200603233203.1695403-2-keescook@chromium.org>
	<874krr8dps.fsf@nanos.tec.linutronix.de>
In-Reply-To: <874krr8dps.fsf@nanos.tec.linutronix.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 4 Jun 2020 13:41:07 +0200
Message-ID: <CANiq72kLqvriYmMkdD3yU+xJwbn-68Eiu-fTNtC+Lb+1ZRM75g@mail.gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Cc: Kees Cook <keescook@chromium.org>, linux-ide@vger.kernel.org,
	Network Development <netdev@vger.kernel.org>,
	"maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-spi@vger.kernel.org, linux-block@vger.kernel.org,
	Andy Whitcroft <apw@canonical.com>, Linux-MM <linux-mm@kvack.org>,
	Alexander Potapenko <glider@google.com>, b43-dev@lists.infradead.org,
	clang-built-linux <clang-built-linux@googlegroups.com>,
	Joe Perches <joe@perches.com>,
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

On Thu, Jun 4, 2020 at 9:58 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> but if we ever lose the 1 then the above will silently compile the code
> within the IS_ENABLED() section out.

Yeah, I believe `IS_ENABLED()` is only meant for Kconfig symbols, not
macro defs in general. A better option would be `__is_defined()` which
works for defined-to-nothing too.

Cheers,
Miguel
