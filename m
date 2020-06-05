Return-Path: <bounce+218ee0.be9e4a-drbd-dev=lists.linbit.com@mg.codeaurora.org>
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
	[104.130.122.27])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8DB48420311
	for <drbd-dev@lists.linbit.com>; Fri,  5 Jun 2020 11:26:19 +0200 (CEST)
Sender: kvalo=codeaurora.org@mg.codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Kees Cook <keescook@chromium.org>
References: <20200603233203.1695403-1-keescook@chromium.org>
	<20200603233203.1695403-4-keescook@chromium.org>
Date: Fri, 05 Jun 2020 12:20:55 +0300
In-Reply-To: <20200603233203.1695403-4-keescook@chromium.org> (Kees Cook's
	message of "Wed, 3 Jun 2020 16:31:56 -0700")
Message-ID: <87d06dg96w.fsf@tynnyri.adurom.net>
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
Subject: Re: [Drbd-dev] [PATCH 03/10] b43: Remove uninitialized_var() usage
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
> and make the (unreachable!) code do a conditional test.
>
> [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

[...]

> @@ -4256,9 +4256,13 @@ static void b43_nphy_tx_gain_table_upload(struct b43_wldev *dev)
>  			pga_gain = (table[i] >> 24) & 0xf;
>  			pad_gain = (table[i] >> 19) & 0x1f;
>  			if (b43_current_band(dev->wl) == NL80211_BAND_2GHZ)
> -				rfpwr_offset = rf_pwr_offset_table[pad_gain];
> +				rfpwr_offset = rf_pwr_offset_table
> +						? rf_pwr_offset_table[pad_gain]
> +						: 0;
>  			else
> -				rfpwr_offset = rf_pwr_offset_table[pga_gain];
> +				rfpwr_offset = rf_pwr_offset_table
> +						? rf_pwr_offset_table[pga_gain]
> +						: 0;

To me this is ugly, isn't there a better way to fix this?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
