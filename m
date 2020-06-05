Return-Path: <bounce+218ee0.be9e4a-drbd-dev=lists.linbit.com@mg.codeaurora.org>
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AE7AD42021C
	for <drbd-dev@lists.linbit.com>; Fri,  5 Jun 2020 11:24:24 +0200 (CEST)
Sender: kvalo=codeaurora.org@mg.codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Kees Cook <keescook@chromium.org>
References: <20200603233203.1695403-1-keescook@chromium.org>
	<20200603233203.1695403-5-keescook@chromium.org>
Date: Fri, 05 Jun 2020 12:18:22 +0300
In-Reply-To: <20200603233203.1695403-5-keescook@chromium.org> (Kees Cook's
	message of "Wed, 3 Jun 2020 16:31:57 -0700")
Message-ID: <87h7vpg9b5.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: text/plain
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
Subject: Re: [Drbd-dev] [PATCH 04/10] rtlwifi: rtl8192cu: Remove
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

Kees Cook <keescook@chromium.org> writes:

> Using uninitialized_var() is dangerous as it papers over real bugs[1]
> (or can in the future), and suppresses unrelated compiler warnings (e.g.
> "unused variable"). If the compiler thinks it is uninitialized, either
> simply initialize the variable or make compiler changes. As a precursor
> to removing[2] this[3] macro[4], just initialize this variable to NULL,
> and avoid sending garbage by returning.
>
> [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

To which tree should this go? If something else than wireless-drivers
tree:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

But let me know if you want me to take this.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
