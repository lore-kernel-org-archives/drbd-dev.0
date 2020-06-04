Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 79C63420432
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:59:07 +0200 (CEST)
Received: by mail-wr1-f66.google.com with SMTP id x14so12297920wrp.2
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:59:07 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	s8sm13720523wrm.96.2020.06.13.02.59.06
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:59:06 -0700 (PDT)
Resent-Message-ID: <20200613095904.GG4222@soda.linbit>
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
	[209.85.166.68])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 32D9A420302
	for <drbd-dev@lists.linbit.com>; Thu,  4 Jun 2020 09:27:10 +0200 (CEST)
Received: by mail-io1-f68.google.com with SMTP id m81so5250193ioa.1
	for <drbd-dev@lists.linbit.com>; Thu, 04 Jun 2020 00:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200603233203.1695403-1-keescook@chromium.org>
	<20200604033347.GA3962068@ubuntu-n2-xlarge-x86>
In-Reply-To: <20200604033347.GA3962068@ubuntu-n2-xlarge-x86>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Thu, 4 Jun 2020 09:26:58 +0200
Message-ID: <CA+icZUU4Re5g3rRJ=WF3_KiCEc3CUmbH_PibTunuK_E1QskEjQ@mail.gmail.com>
To: Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Andy Whitcroft <apw@canonical.com>, Kees Cook <keescook@chromium.org>,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	x86@kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	linux-mm@kvack.org, Alexander Potapenko <glider@google.com>,
	b43-dev@lists.infradead.org,
	Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
	Joe Perches <joe@perches.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-clk@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/10] Remove uninitialized_var() macro
Reply-To: sedat.dilek@gmail.com
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

On Thu, Jun 4, 2020 at 5:33 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Jun 03, 2020 at 04:31:53PM -0700, Kees Cook wrote:
> > Using uninitialized_var() is dangerous as it papers over real bugs[1]
> > (or can in the future), and suppresses unrelated compiler warnings
> > (e.g. "unused variable"). If the compiler thinks it is uninitialized,
> > either simply initialize the variable or make compiler changes.
> >
> > As recommended[2] by[3] Linus[4], remove the macro.
> >
> > Most of the 300 uses don't cause any warnings on gcc 9.3.0, so they're in
> > a single treewide commit in this series. A few others needed to actually
> > get cleaned up, and I broke those out into individual patches.
> >
> > -Kees
> >
> > [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> > [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> > [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> > [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
> >
> > Kees Cook (10):
> >   x86/mm/numa: Remove uninitialized_var() usage
> >   drbd: Remove uninitialized_var() usage
> >   b43: Remove uninitialized_var() usage
> >   rtlwifi: rtl8192cu: Remove uninitialized_var() usage
> >   ide: Remove uninitialized_var() usage
> >   clk: st: Remove uninitialized_var() usage
> >   spi: davinci: Remove uninitialized_var() usage
> >   checkpatch: Remove awareness of uninitialized_var() macro
> >   treewide: Remove uninitialized_var() usage
> >   compiler: Remove uninitialized_var() macro
>
> I applied all of these on top of cb8e59cc8720 and ran a variety of
> builds with clang for arm32, arm64, mips, powerpc, s390, and x86_64 [1]
> and only saw one warning pop up (which was about a variable being
> unused, commented on patch 9 about it). No warnings about uninitialized
> variables came up; clang's -Wuninitialized was not impacted by
> 78a5255ffb6a ("Stop the ad-hoc games with -Wno-maybe-initialized") so it
> should have caught anything egregious.
>
> [1]: https://github.com/nathanchance/llvm-kernel-testing
>
> For the series, consider it:
>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com> [build]
>

Hi Kees,

I tried with updated version (checkpatch) of your tree and see no
(new) warnings in my build-log.

Feel free to add my...

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

Thanks.

Regards,
- Sedat -
