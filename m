Return-Path: <keescook@chromium.org>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D7BB8420385
	for <drbd-dev@lists.linbit.com>; Thu,  2 Jul 2020 17:42:20 +0200 (CEST)
Received: by mail-pl1-f196.google.com with SMTP id f2so11456519plr.8
	for <drbd-dev@lists.linbit.com>; Thu, 02 Jul 2020 08:42:20 -0700 (PDT)
Date: Thu, 2 Jul 2020 08:42:17 -0700
From: Kees Cook <keescook@chromium.org>
To: Mark Brown <broonie@kernel.org>
Message-ID: <202007020839.545A571CA4@keescook>
References: <20200620033007.1444705-1-keescook@chromium.org>
	<20200620033007.1444705-9-keescook@chromium.org>
	<20200701203920.GC3776@sirena.org.uk>
	<202007020819.318824DA@keescook>
	<20200702152335.GJ4483@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702152335.GJ4483@sirena.org.uk>
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

On Thu, Jul 02, 2020 at 04:23:35PM +0100, Mark Brown wrote:
> On Thu, Jul 02, 2020 at 08:21:40AM -0700, Kees Cook wrote:
> > On Wed, Jul 01, 2020 at 09:39:20PM +0100, Mark Brown wrote:
> 
> > > Please copy maintainers on patches :(
> 
> > Hi! Sorry about that; the CC list was giant, so I had opted for using
> > subsystem mailing lists where possible.
> 
> If you're going to err in a direction there I'd err in the direction of
> CCing the people not the list - I only saw this since I was looking for
> something else, I don't normally see stuff in the mailing list folder.

Yeah, I've gotten conflicting feedback on treewide changes:
- please CC me on only the one patch, I don't want to see everything else
- please CC me on the whole series, I want the full context for the change

I opted toward "CC me on this series", but then I get stuck when the CC
is giant. I think I may switch back to individual CCs for specific
patches, and point people to lore if they want greater context. (lore
didn't exist before...)

Thanks for the poke to make me reconsider this workflow. :)

-- 
Kees Cook
