Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7A33D42041E
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:58:47 +0200 (CEST)
Received: by mail-wr1-f65.google.com with SMTP id x14so12297371wrp.2
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:58:47 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	l1sm15647064wrb.31.2020.06.13.02.58.46
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:58:46 -0700 (PDT)
Resent-Message-ID: <20200613095844.GY4222@soda.linbit>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E8CC3420302
	for <drbd-dev@lists.linbit.com>; Thu,  4 Jun 2020 02:00:36 +0200 (CEST)
Received: by mail-pl1-f196.google.com with SMTP id n2so1382747pld.13
	for <drbd-dev@lists.linbit.com>; Wed, 03 Jun 2020 17:00:36 -0700 (PDT)
To: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
References: <20200603233203.1695403-1-keescook@chromium.org>
	<20200603233203.1695403-11-keescook@chromium.org>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <8882ca16-5192-a519-d5a8-02371fbb28cb@acm.org>
Date: Wed, 3 Jun 2020 17:00:31 -0700
MIME-Version: 1.0
In-Reply-To: <20200603233203.1695403-11-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Andy Whitcroft <apw@canonical.com>, clang-built-linux@googlegroups.com,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	x86@kernel.org, linux-wireless@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-block@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	linux-mm@kvack.org, Alexander Potapenko <glider@google.com>,
	b43-dev@lists.infradead.org, Joe Perches <joe@perches.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-clk@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 10/10] compiler: Remove uninitialized_var()
	macro
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

On 2020-06-03 16:32, Kees Cook wrote:
> Using uninitialized_var() is dangerous as it papers over real bugs[1]
> (or can in the future), and suppresses unrelated compiler warnings
> (e.g. "unused variable"). If the compiler thinks it is uninitialized,
> either simply initialize the variable or make compiler changes.

Thank you for having done this work!

Reviewed-by: Bart van Assche <bvanassche@acm.org>
