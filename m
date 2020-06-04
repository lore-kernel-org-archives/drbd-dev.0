Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id DFF9E420429
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:58:54 +0200 (CEST)
Received: by mail-wm1-f68.google.com with SMTP id l17so10060080wmj.0
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:58:54 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	r12sm14660615wrc.22.2020.06.13.02.58.53
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:58:53 -0700 (PDT)
Resent-Message-ID: <20200613095852.GB4222@soda.linbit>
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
	[209.85.166.194])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C743A420325
	for <drbd-dev@lists.linbit.com>; Thu,  4 Jun 2020 03:47:07 +0200 (CEST)
Received: by mail-il1-f194.google.com with SMTP id i1so3320008ils.11
	for <drbd-dev@lists.linbit.com>; Wed, 03 Jun 2020 18:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200603233203.1695403-1-keescook@chromium.org>
	<CA+icZUVZwjM9o7aNXAkYu8K2BQAajw=60varP4g+NizCqu5gRw@mail.gmail.com>
	<202006031840.E2F0D15D8B@keescook>
In-Reply-To: <202006031840.E2F0D15D8B@keescook>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Thu, 4 Jun 2020 03:46:56 +0200
Message-ID: <CA+icZUUsfZpuwfyEcbBKOf7AJF0-Ao8b1kUscpMJ+-ZdfZotsg@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Andy Whitcroft <apw@canonical.com>,
	Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	x86@kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	linux-mm@kvack.org, Alexander Potapenko <glider@google.com>,
	b43-dev@lists.infradead.org, Joe Perches <joe@perches.com>,
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

On Thu, Jun 4, 2020 at 3:44 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Jun 04, 2020 at 03:23:28AM +0200, Sedat Dilek wrote:
> > what is the base for your patchset?
>
> Hi! This was actually on Linus's latest tree (which is basically -next),
> mostly because I figured this might be a bit of an RFC but if it was
> clean enough, it might actually make the merge window (I can dream).
>
> > I would like to test on top of Linux v5.7.
> >
> > Can you place the series in your Git tree for easy fetching, please?
>
> Sure! https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git in
> the kspp/uninit/v5.7/macro branch. There were three small differences.
> I'm doing the "all my cross compilers allmodconfig" build run now, but
> figured I'd push it for you now so you didn't have to wait.
>

Hi Kees!

Thanks :-).

Regards,
- Sedat -
