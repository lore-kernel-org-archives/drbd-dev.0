Return-Path: <bounce+218ee0.be9e4a-drbd-dev=lists.linbit.com@mg.codeaurora.org>
Received: from mail29.static.mailgun.info (mail29.static.mailgun.info
	[104.130.122.29])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 15CE24200D7
	for <drbd-dev@lists.linbit.com>; Wed, 15 Jul 2020 12:42:30 +0200 (CEST)
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200620033007.1444705-5-keescook@chromium.org>
References: <20200620033007.1444705-5-keescook@chromium.org>
To: Kees Cook <keescook@chromium.org>
Message-Id: <20200715103701.3EE01C433AF@smtp.codeaurora.org>
Date: Wed, 15 Jul 2020 10:37:01 +0000 (UTC)
Cc: Andy Whitcroft <apw@canonical.com>, Kees Cook <keescook@chromium.org>,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	x86@kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	clang-built-linux@googlegroups.com, linux-mm@kvack.org,
	Alexander Potapenko <glider@google.com>,
	b43-dev@lists.infradead.org, linux-ide@vger.kernel.org,
	Joe Perches <joe@perches.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-clk@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 04/16] b43: Remove uninitialized_var()
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

Kees Cook <keescook@chromium.org> wrote:

> Using uninitialized_var() is dangerous as it papers over real bugs[1]
> (or can in the future), and suppresses unrelated compiler warnings (e.g.
> "unused variable"). If the compiler thinks it is uninitialized, either
> simply initialize the variable or make compiler changes. As a precursor
> to removing[2] this[3] macro[4], just initialize this variable to NULL.
> No later NULL deref is possible due to the early returns outside of the
> (phy->rev >= 7 && phy->rev < 19) case, which explicitly tests for NULL.
> 
> [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
> 
> Fixes: 58619b14d106 ("b43: move under broadcom vendor directory")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

2 patches applied to wireless-drivers-next.git, thanks.

800e7a205a0f b43: Remove uninitialized_var() usage
f8279dad4e36 rtlwifi: rtl8192cu: Remove uninitialized_var() usage

-- 
https://patchwork.kernel.org/patch/11615573/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

