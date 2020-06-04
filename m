Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E3B0142042C
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:59:25 +0200 (CEST)
Received: by mail-wr1-f65.google.com with SMTP id l11so12303224wru.0
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:59:25 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	n7sm14627990wrx.82.2020.06.13.02.59.24
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:59:24 -0700 (PDT)
Resent-Message-ID: <20200613095923.GN4222@soda.linbit>
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
	[209.85.210.67])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1B99A420235
	for <drbd-dev@lists.linbit.com>; Thu,  4 Jun 2020 21:09:44 +0200 (CEST)
Received: by mail-ot1-f67.google.com with SMTP id k15so5661273otp.8
	for <drbd-dev@lists.linbit.com>; Thu, 04 Jun 2020 12:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200603233203.1695403-1-keescook@chromium.org>
	<20200603233203.1695403-10-keescook@chromium.org>
	<20200604132306.GO6578@ziepe.ca> <202006040757.0DFC3F28E@keescook>
In-Reply-To: <202006040757.0DFC3F28E@keescook>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 4 Jun 2020 21:09:32 +0200
Message-ID: <CAMuHMdVuzvvHt3j+L+_BSPFs5RgaP3rkknEUmRvTAs5nZ9SGPA@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Andy Whitcroft <apw@canonical.com>,
	clang-built-linux <clang-built-linux@googlegroups.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	netdev <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	linux-block@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Linux MM <linux-mm@kvack.org>, Alexander Potapenko <glider@google.com>,
	b43-dev@lists.infradead.org, linux-ide@vger.kernel.org,
	Joe Perches <joe@perches.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-clk <linux-clk@vger.kernel.org>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 09/10] treewide: Remove uninitialized_var()
	usage
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

On Thu, Jun 4, 2020 at 5:01 PM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Jun 04, 2020 at 10:23:06AM -0300, Jason Gunthorpe wrote:
> > On Wed, Jun 03, 2020 at 04:32:02PM -0700, Kees Cook wrote:
> > > Using uninitialized_var() is dangerous as it papers over real bugs[1]
> > > (or can in the future), and suppresses unrelated compiler warnings
> > > (e.g. "unused variable"). If the compiler thinks it is uninitialized,
> > > either simply initialize the variable or make compiler changes.
> > >
> > > I preparation for removing[2] the[3] macro[4], remove all remaining
> > > needless uses with the following script:
> > >
> > > git grep '\buninitialized_var\b' | cut -d: -f1 | sort -u | \
> > >     xargs perl -pi -e \
> > >             's/\buninitialized_var\(([^\)]+)\)/\1/g;
> > >              s:\s*/\* (GCC be quiet|to make compiler happy) \*/$::g;'
> > >
> > > drivers/video/fbdev/riva/riva_hw.c was manually tweaked to avoid
> > > pathological white-space.
> > >
> > > No outstanding warnings were found building allmodconfig with GCC 9.3.0
> > > for x86_64, i386, arm64, arm, powerpc, powerpc64le, s390x, mips, sparc64,
> > > alpha, and m68k.
> >
> > At least in the infiniband part I'm confident that old gcc versions
> > will print warnings after this patch.
> >
> > As the warnings are wrong, do we care? Should old gcc maybe just -Wno-
> > the warning?
>
> I *think* a lot of those are from -Wmaybe-uninitialized, but Linus just
> turned that off unconditionally in v5.7:
> 78a5255ffb6a ("Stop the ad-hoc games with -Wno-maybe-initialized")
>
> I'll try to double-check with some older gcc versions. My compiler
> collection is mostly single-axis: lots of arches, not lots of versions. ;)

Nope, support for the good old gcc 4.1 was removed a while ago.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
