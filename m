Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0199.hostedemail.com
	[216.40.44.199])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 87A9C420302
	for <drbd-dev@lists.linbit.com>; Thu,  4 Jun 2020 02:02:33 +0200 (CEST)
Message-ID: <ff9087b0571e1fc499bd8a4c9fd99bfc0357f245.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Date: Wed, 03 Jun 2020 17:02:29 -0700
In-Reply-To: <20200603233203.1695403-9-keescook@chromium.org>
References: <20200603233203.1695403-1-keescook@chromium.org>
	<20200603233203.1695403-9-keescook@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: clang-built-linux@googlegroups.com, linux-ide@vger.kernel.org,
	netdev@vger.kernel.org, x86@kernel.org,
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	linux-mm@kvack.org, Alexander Potapenko <glider@google.com>,
	b43-dev@lists.infradead.org, Andy Whitcroft <apw@canonical.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-clk@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 08/10] checkpatch: Remove awareness of
 uninitialized_var() macro
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

On Wed, 2020-06-03 at 16:32 -0700, Kees Cook wrote:
> Using uninitialized_var() is dangerous as it papers over real bugs[1]
> (or can in the future), and suppresses unrelated compiler warnings
> (e.g. "unused variable"). If the compiler thinks it is uninitialized,
> either simply initialize the variable or make compiler changes.
> 
> In preparation for removing[2] the[3] macro[4], effectively revert
> commit 16b7f3c89907 ("checkpatch: avoid warning about uninitialized_var()")
> and remove all remaining mentions of uninitialized_var().
> 
> [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

nack.  see below.

I'd prefer a simple revert, but it shouldn't
be done here.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -4075,7 +4074,7 @@ sub process {
>  		}
>  
>  # check for function declarations without arguments like "int foo()"
> -		if ($line =~ /(\b$Type\s*$Ident)\s*\(\s*\)/) {
> +		if ($line =~ /(\b$Type\s+$Ident)\s*\(\s*\)/) {

This isn't right because $Type includes a possible trailing *
where there isn't a space between $Type and $Ident

e.g.:	int *bar(void);

Other than that, fine by me...


