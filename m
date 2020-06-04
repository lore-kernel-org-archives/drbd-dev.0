Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E5E11420431
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:59:04 +0200 (CEST)
Received: by mail-wm1-f66.google.com with SMTP id b82so1527387wmb.1
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:59:04 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	j11sm13422593wru.69.2020.06.13.02.59.03
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:59:03 -0700 (PDT)
Resent-Message-ID: <20200613095902.GF4222@soda.linbit>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 62E98420235
	for <drbd-dev@lists.linbit.com>; Thu,  4 Jun 2020 06:45:16 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200603233203.1695403-7-keescook@chromium.org>
References: <20200603233203.1695403-1-keescook@chromium.org>
	<20200603233203.1695403-7-keescook@chromium.org>
From: Stephen Boyd <sboyd@kernel.org>
To: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Date: Wed, 03 Jun 2020 21:38:36 -0700
Message-ID: <159124551620.69627.18245138803269803785@swboyd.mtv.corp.google.com>
Cc: Andy Whitcroft <apw@canonical.com>, Kees Cook <keescook@chromium.org>,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	x86@kernel.org, linux-wireless@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-block@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	linux-mm@kvack.org, Alexander Potapenko <glider@google.com>,
	b43-dev@lists.infradead.org, clang-built-linux@googlegroups.com,
	Joe Perches <joe@perches.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-clk@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 06/10] clk: st: Remove uninitialized_var()
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

Quoting Kees Cook (2020-06-03 16:31:59)
> Using uninitialized_var() is dangerous as it papers over real bugs[1]
> (or can in the future), and suppresses unrelated compiler warnings (e.g.
> "unused variable"). If the compiler thinks it is uninitialized, either
> simply initialize the variable or make compiler changes. As a precursor
> to removing[2] this[3] macro[4], just remove this variable since it was
> actually unused:
>=20
> drivers/clk/st/clkgen-fsyn.c: In function \u2018quadfs_set_rate\u2019:
> drivers/clk/st/clkgen-fsyn.c:793:6: warning: unused variable \u2018i\u201=
9 [-Wunused-variable]
>   793 |  int i;
>       |      ^
>=20
> [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.co=
m/
> [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=3D1TGqCR5vQkCzWJ0QxK6Cern=
OU6eedsudAixw@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz=
9knmPuXhOeg@mail.gmail.com/
> [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=3DyVJu65TpLg=
N_ybYNv0VEOKA@mail.gmail.com/
>=20
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
