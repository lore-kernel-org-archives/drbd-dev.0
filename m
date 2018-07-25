Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CF7721045C30
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 14:17:51 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so1780668wmc.2
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 05:17:51 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	q140-v6sm2481793wmb.35.2018.07.26.05.17.50
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 26 Jul 2018 05:17:51 -0700 (PDT)
Resent-Message-ID: <20180726121750.GC25507@soda.linbit>
Received: from mail-yb0-f193.google.com (mail-yb0-f193.google.com
	[209.85.213.193])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 544691005433
	for <drbd-dev@lists.linbit.com>; Wed, 25 Jul 2018 20:08:30 +0200 (CEST)
Received: by mail-yb0-f193.google.com with SMTP id s8-v6so3333310ybe.8
	for <drbd-dev@lists.linbit.com>; Wed, 25 Jul 2018 11:08:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gVDotjufLKUW0YuQu2vA4fmU_gqia=ZA4DocW4XHxx0w@mail.gmail.com>
References: <20180724164936.37477-1-keescook@chromium.org>
	<20180724164936.37477-11-keescook@chromium.org>
	<CAJZ5v0gVDotjufLKUW0YuQu2vA4fmU_gqia=ZA4DocW4XHxx0w@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 25 Jul 2018 11:01:47 -0700
Message-ID: <CAGXu5j+NPCc2hq5x7JUwgKYvY6zKN28YdtHbHVapnpgC3GwCsg@mail.gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Mike Snitzer <snitzer@redhat.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"open list:NETWORKING DRIVERS \(WIRELESS\)"
	<linux-wireless@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>,
	device-mapper development <dm-devel@redhat.com>,
	Jia-Ju Bai <baijiaju1990@gmail.com>,
	Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-afs@lists.infradead.org,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com,
	"open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	the arch/x86 maintainers <x86@kernel.org>, qat-linux@intel.com,
	Ingo Molnar <mingo@redhat.com>, Eric Biggers <ebiggers@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rabin Vincent <rabinv@axis.com>, Arnd Bergmann <arnd@arndb.de>,
	Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
	linux-block <linux-block@vger.kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-crypto <linux-crypto@vger.kernel.org>, linux-ppp@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Tim Chen <tim.c.chen@linux.intel.com>, netdev <netdev@vger.kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [Drbd-dev] [PATCH v6 10/18] x86/power/64: Remove VLA usage
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

On Wed, Jul 25, 2018 at 4:32 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Jul 24, 2018 at 6:49 PM, Kees Cook <keescook@chromium.org> wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> removes the discouraged use of AHASH_REQUEST_ON_STACK by switching to
>> shash directly and allocating the descriptor in heap memory (which should
>> be fine: the tfm has already been allocated there too).
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Acked-by: Pavel Machek <pavel@ucw.cz>
>
> I think I can queue this up if there are no objections from others.
>
> Do you want me to do that?

Sure thing. It looks like the other stand-alone patches like this one
are getting taken into the non-crypto trees, so that's fine.

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
