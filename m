Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 310DF1045C23
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 14:23:00 +0200 (CEST)
Received: by mail-wr1-f65.google.com with SMTP id e7-v6so1510828wrs.9
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 05:23:00 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	b22-v6sm2567084wme.48.2018.07.26.05.17.28
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 26 Jul 2018 05:17:28 -0700 (PDT)
Resent-Message-ID: <20180726121727.GX25507@soda.linbit>
Received: from mail-yw0-f196.google.com (mail-yw0-f196.google.com
	[209.85.161.196])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0F006101AC7B
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 19:56:46 +0200 (CEST)
Received: by mail-yw0-f196.google.com with SMTP id z143-v6so1857183ywa.7
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 10:56:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-D9FrOrFU0EmkPA52vrywCGZkFP9vUsyEovdby9dLj0g@mail.gmail.com>
References: <20180724164936.37477-1-keescook@chromium.org>
	<20180724164936.37477-18-keescook@chromium.org>
	<CAKv+Gu-D9FrOrFU0EmkPA52vrywCGZkFP9vUsyEovdby9dLj0g@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 24 Jul 2018 10:51:27 -0700
Message-ID: <CAGXu5j+-AwHdGZ7Be854WyEQoK2p57JPuTgSXcFq7GOzUtJGEA@mail.gmail.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Mike Snitzer <snitzer@redhat.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
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
	linux-pm <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	"open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
	<linux-crypto@vger.kernel.org>, linux-ppp@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [Drbd-dev] [PATCH v6 17/18] crypto: ccm: Remove VLA usage
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

On Tue, Jul 24, 2018 at 9:57 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 24 July 2018 at 18:49, Kees Cook <keescook@chromium.org> wrote:
>> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> drops AHASH_REQUEST_ON_STACK by preallocated the ahash request area
>> with the skcipher area (which are not used at the same time).
>>
>
> -EGRAMMAR

Whoops. Will fix my poor sentence merging. :)

-Kees

-- 
Kees Cook
Pixel Security
