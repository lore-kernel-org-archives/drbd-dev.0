Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1C63D1045C32
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 14:24:17 +0200 (CEST)
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so1516468wrr.8
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 05:24:17 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	u14-v6sm1445915wrs.57.2018.07.26.05.17.42
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 26 Jul 2018 05:17:42 -0700 (PDT)
Resent-Message-ID: <20180726121741.GA25507@soda.linbit>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D645D100542C
	for <drbd-dev@lists.linbit.com>; Wed, 25 Jul 2018 10:15:25 +0200 (CEST)
From: Kalle Valo <kvalo@codeaurora.org>
To: Johannes Berg <johannes@sipsolutions.net>
References: <20180724164936.37477-1-keescook@chromium.org>
	<20180724164936.37477-14-keescook@chromium.org>
	<1532503493.3223.0.camel@sipsolutions.net>
Date: Wed, 25 Jul 2018 11:05:42 +0300
In-Reply-To: <1532503493.3223.0.camel@sipsolutions.net> (Johannes Berg's
	message of "Wed, 25 Jul 2018 09:24:53 +0200")
Message-ID: <87tvong2p5.fsf@purkki.adurom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Mike Snitzer <snitzer@redhat.com>, Eric Biggers <ebiggers@google.com>,
	linux-wireless@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>, dm-devel@redhat.com,
	Jia-Ju Bai <baijiaju1990@gmail.com>,
	Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-afs@lists.infradead.org,
	Alasdair Kergon <agk@redhat.com>,
	Rabin Vincent <rabinv@axis.com>, devel@driverdev.osuosl.org,
	Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	qat-linux@intel.com, Ingo Molnar <mingo@redhat.com>,
	drbd-dev@lists.linbit.com, Kees Cook <keescook@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
	linux-block@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
	Geert Uytterhoeven <"g eert"@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-crypto@vger.kernel.org, linux-ppp@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Tim Chen <tim.c.chen@linux.intel.com>, netdev@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [Drbd-dev] [PATCH v6 13/18] wireless/lib80211: Convert from
	ahash to shash
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Johannes Berg <johannes@sipsolutions.net> writes:

> On Tue, 2018-07-24 at 09:49 -0700, Kees Cook wrote:
>> In preparing to remove all stack VLA usage from the kernel[1], this
>> removes the discouraged use of AHASH_REQUEST_ON_STACK in favor of
>> the smaller SHASH_DESC_ON_STACK by converting from ahash-wrapped-shash
>> to direct shash. By removing a layer of indirection this both improves
>> performance and reduces stack usage. The stack allocation will be made
>> a fixed size in a later patch to the crypto subsystem.
>
> I think you sent this before - it should be in net-next now.

Yup, I see it in net-next:

d17504b16ea2 wireless/lib80211: Convert from ahash to shash

-- 
Kalle Valo
