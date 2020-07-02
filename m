Return-Path: <keescook@chromium.org>
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
	[209.85.216.67])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 424764203EA
	for <drbd-dev@lists.linbit.com>; Thu,  2 Jul 2020 17:21:42 +0200 (CEST)
Received: by mail-pj1-f67.google.com with SMTP id gc15so4209949pjb.0
	for <drbd-dev@lists.linbit.com>; Thu, 02 Jul 2020 08:21:42 -0700 (PDT)
Date: Thu, 2 Jul 2020 08:21:40 -0700
From: Kees Cook <keescook@chromium.org>
To: Mark Brown <broonie@kernel.org>
Message-ID: <202007020819.318824DA@keescook>
References: <20200620033007.1444705-1-keescook@chromium.org>
	<20200620033007.1444705-9-keescook@chromium.org>
	<20200701203920.GC3776@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701203920.GC3776@sirena.org.uk>
Cc: Andy Whitcroft <apw@canonical.com>, linux-wireless@vger.kernel.org,
	clang-built-linux@googlegroups.com, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, x86@kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	linux-mm@kvack.org, Alexander Potapenko <glider@google.com>,
	b43-dev@lists.infradead.org, linux-ide@vger.kernel.org,
	Joe Perches <joe@perches.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-clk@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 08/16] spi: davinci: Remove
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

On Wed, Jul 01, 2020 at 09:39:20PM +0100, Mark Brown wrote:
> On Fri, Jun 19, 2020 at 08:29:59PM -0700, Kees Cook wrote:
> > Using uninitialized_var() is dangerous as it papers over real bugs[1]
> > (or can in the future), and suppresses unrelated compiler warnings (e.g.
> > "unused variable"). If the compiler thinks it is uninitialized, either
> > simply initialize the variable or make compiler changes. As a precursor
> > to removing[2] this[3] macro[4], just remove this variable since it was
> > actually unused:
> 
> Please copy maintainers on patches :(

Hi! Sorry about that; the CC list was giant, so I had opted for using
subsystem mailing lists where possible.

> Acked-by: Mark Brown <broonie@kernel.org>

Thanks!

-- 
Kees Cook
