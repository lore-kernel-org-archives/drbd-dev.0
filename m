Return-Path: <keescook@chromium.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
	[209.85.214.194])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 90A0C4203E7
	for <drbd-dev@lists.linbit.com>; Mon, 15 Jun 2020 21:32:52 +0200 (CEST)
Received: by mail-pl1-f194.google.com with SMTP id j4so3957263plk.3
	for <drbd-dev@lists.linbit.com>; Mon, 15 Jun 2020 12:32:52 -0700 (PDT)
Date: Mon, 15 Jun 2020 12:32:49 -0700
From: Kees Cook <keescook@chromium.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Message-ID: <202006151231.74D2315450@keescook>
References: <20200603233203.1695403-1-keescook@chromium.org>
	<20200603233203.1695403-6-keescook@chromium.org>
	<CAKwvOdm5zDide5RuppY_jG=r46=UMdVJBrkBqD5x=dOMTG9cZg@mail.gmail.com>
	<202006041318.B0EA9059C7@keescook>
	<CAKwvOdk3Wc1gC0UMsFZsZqQ8n_bkPjNAJo5u3nfcyXcBaZCMHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk3Wc1gC0UMsFZsZqQ8n_bkPjNAJo5u3nfcyXcBaZCMHw@mail.gmail.com>
Cc: Andy Whitcroft <apw@canonical.com>,
	clang-built-linux <clang-built-linux@googlegroups.com>,
	Saravana Kannan <saravanak@google.com>, linux-ide@vger.kernel.org,
	Network Development <netdev@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-spi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Alexander Potapenko <glider@google.com>,
	b43-dev@lists.infradead.org, Joe Perches <joe@perches.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-clk@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 05/10] ide: Remove uninitialized_var() usage
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

On Thu, Jun 04, 2020 at 01:29:44PM -0700, Nick Desaulniers wrote:
> On Thu, Jun 4, 2020 at 1:20 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Jun 04, 2020 at 12:29:17PM -0700, Nick Desaulniers wrote:
> > > On Wed, Jun 3, 2020 at 4:32 PM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > Using uninitialized_var() is dangerous as it papers over real bugs[1]
> > > > (or can in the future), and suppresses unrelated compiler warnings (e.g.
> > > > "unused variable"). If the compiler thinks it is uninitialized, either
> > > > simply initialize the variable or make compiler changes. As a precursor
> > > > to removing[2] this[3] macro[4], just remove this variable since it was
> > > > actually unused:
> > > >
> > > > drivers/ide/ide-taskfile.c:232:34: warning: unused variable 'flags' [-Wunused-variable]
> > > >         unsigned long uninitialized_var(flags);
> > > >                                         ^
> > > >
> > > > [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> > > > [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> > > > [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> > > > [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
> > > >
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > >
> > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > Thanks for the reviews!
> >
> > > Fixes ce1e518190ea ("ide: don't disable interrupts during kmap_atomic()")
> >
> > I originally avoided adding Fixes tags because I didn't want these
> > changes backported into a -stable without -Wmaybe-uninitialized
> > disabled, but in these cases (variable removal), that actually does make
> > sense. Thanks!
> 
> Saravana showed me a cool trick for quickly finding commits that
> removed a particular identifier that I find faster than `git blame` or
> vim-fugitive for the purpose of Fixes tags:
> $ git log -S <string> <file>

Ah yes, I always have to look up "-S". Good reminder!

> I've added it to our wiki:
> https://github.com/ClangBuiltLinux/linux/wiki/Command-line-tips-and-tricks#for-finding-which-commit-may-have-removed-a-string-try.
> I should update the first tip; what was your suggestion for
> constraining the search to the current remote?

Ah cool. I've updated it now. It was really to narrow to a "known set of
tags", and Linus's tree's tags always start with "v".

-- 
Kees Cook
