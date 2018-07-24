Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DED7F1045C34
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 14:25:40 +0200 (CEST)
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so1522546wre.6
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 05:25:40 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	w9-v6sm1539622wrk.28.2018.07.26.05.17.29
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 26 Jul 2018 05:17:29 -0700 (PDT)
Resent-Message-ID: <20180726121729.GY25507@soda.linbit>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.161.195])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 370F6101AC7B
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 20:00:03 +0200 (CEST)
Received: by mail-yw0-f195.google.com with SMTP id v197-v6so1864721ywg.3
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 11:00:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1bdc706ae86039c4ffcff39698251424d54af116.camel@perches.com>
References: <20180724164936.37477-1-keescook@chromium.org>
	<20180724164936.37477-19-keescook@chromium.org>
	<1bdc706ae86039c4ffcff39698251424d54af116.camel@perches.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 24 Jul 2018 10:53:26 -0700
Message-ID: <CAGXu5j+gTpZFkXE8XSNgYPEpBT4+hCb1kzv8s8KrSTerHyKp6w@mail.gmail.com>
To: Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Mike Snitzer <snitzer@redhat.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>,
	device-mapper development <dm-devel@redhat.com>,
	Jia-Ju Bai <baijiaju1990@gmail.com>,
	Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-afs@lists.infradead.org,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com,
	"open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	X86 ML <x86@kernel.org>, qat-linux@intel.com,
	Ingo Molnar <mingo@redhat.com>, Eric Biggers <ebiggers@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rabin Vincent <rabinv@axis.com>, Arnd Bergmann <arnd@arndb.de>,
	Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
	linux-block <linux-block@vger.kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-crypto <linux-crypto@vger.kernel.org>, linux-ppp@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Network Development <netdev@vger.kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [Drbd-dev] [PATCH v6 18/18] crypto: Remove
	AHASH_REQUEST_ON_STACK
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

On Tue, Jul 24, 2018 at 10:31 AM, Joe Perches <joe@perches.com> wrote:
> On Tue, 2018-07-24 at 09:49 -0700, Kees Cook wrote:
>> All users of AHASH_REQUEST_ON_STACK have been removed from the kernel, so
>> drop it entirely so no VLAs get reintroduced by future users.
>
> checkpatch has a test for that.
> It could now be removed as well.
> ---
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 34e4683de7a3..a3517334d661 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -796,7 +796,7 @@ our $declaration_macros = qr{(?x:
>         (?:$Storage\s+)?(?:[A-Z_][A-Z0-9]*_){0,2}(?:DEFINE|DECLARE)(?:_[A-Z0-9]+){1,6}\s*\(|
>         (?:$Storage\s+)?[HLP]?LIST_HEAD\s*\(|
>         (?:$Storage\s+)?${Type}\s+uninitialized_var\s*\(|
> -       (?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(
> +       (?:SKCIPHER_REQUEST|SHASH_DESC)_ON_STACK\s*\(
>  )};

Ah! Cool. I've added this now.

-Kees

-- 
Kees Cook
Pixel Security
