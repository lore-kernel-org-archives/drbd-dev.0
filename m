Return-Path: <keescook@chromium.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
	[209.85.214.194])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 796744203F8
	for <drbd-dev@lists.linbit.com>; Sat, 20 Jun 2020 17:57:08 +0200 (CEST)
Received: by mail-pl1-f194.google.com with SMTP id d8so5381379plo.12
	for <drbd-dev@lists.linbit.com>; Sat, 20 Jun 2020 08:57:08 -0700 (PDT)
Date: Sat, 20 Jun 2020 08:57:04 -0700
From: Kees Cook <keescook@chromium.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Message-ID: <202006200854.B2D8F21@keescook>
References: <20200620033007.1444705-1-keescook@chromium.org>
	<CA+icZUWpHRR7ukyepiUH1dR3r4GMi-s2crfwR5vTszdt1SUTQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWpHRR7ukyepiUH1dR3r4GMi-s2crfwR5vTszdt1SUTQw@mail.gmail.com>
Cc: Andy Whitcroft <apw@canonical.com>,
	Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	x86@kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	linux-mm@kvack.org, Alexander Potapenko <glider@google.com>,
	b43-dev@lists.infradead.org, linux-ide@vger.kernel.org,
	Joe Perches <joe@perches.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-clk@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 00/16] Remove uninitialized_var() macro
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

On Sat, Jun 20, 2020 at 09:03:34AM +0200, Sedat Dilek wrote:
> On Sat, Jun 20, 2020 at 5:30 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > v2:
> > - more special-cased fixes
> > - add reviews
> > v1: https://lore.kernel.org/lkml/20200603233203.1695403-1-keescook@chromium.org
> >
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
> > The tree is:
> > https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/uninit/macro
> >
> > -Kees
> >
> 
> Hi Kees,
> 
> thanks for doing a v2 of your patchset.
> 
> As I saw Jason Yan providing some "uninitialized_var() macro" patches
> to the MLs I pointen him to your tree "v1".

Thanks!

> BTW, I have tested your "v1" against Linux v5.7 (see [1]) - just
> yesterday with Linux v5.7.5-rc1.
> 
> Is it possible to have a v2 of this patchset on top od Linux v5.7 - if
> you do not mind.

Since it's only going to be for post-v5.8, I'm fine skipping the v5.7
testing. Mainly I'm looking at v5.8 and linux-next.

Thanks for looking at it!

-- 
Kees Cook
