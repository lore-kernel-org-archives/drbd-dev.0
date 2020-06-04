Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 87F84420443
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:59:58 +0200 (CEST)
Received: by mail-wm1-f68.google.com with SMTP id q25so10179452wmj.0
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:59:58 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	k12sm14335490wrn.42.2020.06.13.02.59.57
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:59:57 -0700 (PDT)
Resent-Message-ID: <20200613095955.GW4222@soda.linbit>
Received: from Galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 326CD420235
	for <drbd-dev@lists.linbit.com>; Thu,  4 Jun 2020 23:39:13 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Kees Cook <keescook@chromium.org>
In-Reply-To: <202006040728.8797FAA4@keescook>
References: <20200603233203.1695403-2-keescook@chromium.org>
	<874krr8dps.fsf@nanos.tec.linutronix.de>
	<202006040728.8797FAA4@keescook>
Date: Thu, 04 Jun 2020 23:39:05 +0200
Message-ID: <87zh9i7bpi.fsf@nanos.tec.linutronix.de>
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
Subject: Re: [Drbd-dev] [PATCH 01/10] x86/mm/numa: Remove
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
>> > -#define NODE_NOT_IN_PAGE_FLAGS
>> > +#define NODE_NOT_IN_PAGE_FLAGS 1
>> 
>> but if we ever lose the 1 then the above will silently compile the code
>> within the IS_ENABLED() section out.
>
> That's true, yes. I considered two other ways to do this:
>
> 1) smallest patch, but more #ifdef:
> 2) medium size, weird style:
>
> and 3 is what I sent: biggest, but removes #ifdef
>
> Any preference?

From a readbility POV I surely prefer #3. i"m just wary. Add a big fat
comment to the define might mitigate that, hmm?

Thanks,

        tglx
