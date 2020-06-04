Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B4B3742043A
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:59:17 +0200 (CEST)
Received: by mail-wr1-f66.google.com with SMTP id t18so12297496wru.6
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:59:17 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	h188sm13340723wmh.2.2020.06.13.02.59.16
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:59:16 -0700 (PDT)
Resent-Message-ID: <20200613095914.GK4222@soda.linbit>
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
	[209.85.160.193])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3DC87420235
	for <drbd-dev@lists.linbit.com>; Thu,  4 Jun 2020 15:23:08 +0200 (CEST)
Received: by mail-qt1-f193.google.com with SMTP id c12so5113297qtq.11
	for <drbd-dev@lists.linbit.com>; Thu, 04 Jun 2020 06:23:08 -0700 (PDT)
Date: Thu, 4 Jun 2020 10:23:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kees Cook <keescook@chromium.org>
Message-ID: <20200604132306.GO6578@ziepe.ca>
References: <20200603233203.1695403-1-keescook@chromium.org>
	<20200603233203.1695403-10-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603233203.1695403-10-keescook@chromium.org>
Cc: Andy Whitcroft <apw@canonical.com>, clang-built-linux@googlegroups.com,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	x86@kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	linux-mm@kvack.org, Alexander Potapenko <glider@google.com>,
	b43-dev@lists.infradead.org, Joe Perches <joe@perches.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-clk@vger.kernel.org, drbd-dev@lists.linbit.com
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

On Wed, Jun 03, 2020 at 04:32:02PM -0700, Kees Cook wrote:
> Using uninitialized_var() is dangerous as it papers over real bugs[1]
> (or can in the future), and suppresses unrelated compiler warnings
> (e.g. "unused variable"). If the compiler thinks it is uninitialized,
> either simply initialize the variable or make compiler changes.
> 
> I preparation for removing[2] the[3] macro[4], remove all remaining
> needless uses with the following script:
> 
> git grep '\buninitialized_var\b' | cut -d: -f1 | sort -u | \
> 	xargs perl -pi -e \
> 		's/\buninitialized_var\(([^\)]+)\)/\1/g;
> 		 s:\s*/\* (GCC be quiet|to make compiler happy) \*/$::g;'
> 
> drivers/video/fbdev/riva/riva_hw.c was manually tweaked to avoid
> pathological white-space.
> 
> No outstanding warnings were found building allmodconfig with GCC 9.3.0
> for x86_64, i386, arm64, arm, powerpc, powerpc64le, s390x, mips, sparc64,
> alpha, and m68k.

At least in the infiniband part I'm confident that old gcc versions
will print warnings after this patch.

As the warnings are wrong, do we care? Should old gcc maybe just -Wno-
the warning?

Otherwise the IB bits look ok to me

Acked-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
