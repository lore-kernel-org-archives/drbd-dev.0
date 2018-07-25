Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8BA32101AC7B
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 14:24:35 +0200 (CEST)
Received: by mail-wr1-f65.google.com with SMTP id v14-v6so1524697wro.5
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 05:24:35 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	u4-v6sm2397015wrt.31.2018.07.26.05.17.41
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 26 Jul 2018 05:17:41 -0700 (PDT)
Resent-Message-ID: <20180726121740.GZ25507@soda.linbit>
Received: from sipsolutions.net (s3.sipsolutions.net [144.76.63.242])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1E51C1011B9A
	for <drbd-dev@lists.linbit.com>; Wed, 25 Jul 2018 10:02:29 +0200 (CEST)
Message-ID: <1532503493.3223.0.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Kees Cook <keescook@chromium.org>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 25 Jul 2018 09:24:53 +0200
In-Reply-To: <20180724164936.37477-14-keescook@chromium.org>
	(sfid-20180724_184958_869692_1891A71D)
References: <20180724164936.37477-1-keescook@chromium.org>
	<20180724164936.37477-14-keescook@chromium.org>
	(sfid-20180724_184958_869692_1891A71D)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Lars, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Ingo,
	Mike Snitzer <snitzer@redhat.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-wireless@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>, dm-devel@redhat.com,
	Jia-Ju Bai <baijiaju1990@gmail.com>,
	Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-afs@lists.infradead.org,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com,
	devel@driverdev.osuosl.org, Eric Biggers <ebiggers@google.com>,
	qat-linux@intel.com, Molnar <mingo@redhat.com>,
	Uytterhoeven <geert@linux-m68k.org>, Geert,
	Rabin Vincent <rabinv@axis.com>, Arnd Bergmann <arnd@arndb.de>,
	Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
	linux-block@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-crypto@vger.kernel.org, linux-ppp@vger.kernel.org,
	Ellenberg <lars.ellenberg@linbit.com>,
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

On Tue, 2018-07-24 at 09:49 -0700, Kees Cook wrote:
> In preparing to remove all stack VLA usage from the kernel[1], this
> removes the discouraged use of AHASH_REQUEST_ON_STACK in favor of
> the smaller SHASH_DESC_ON_STACK by converting from ahash-wrapped-shash
> to direct shash. By removing a layer of indirection this both improves
> performance and reduces stack usage. The stack allocation will be made
> a fixed size in a later patch to the crypto subsystem.
> 
I think you sent this before - it should be in net-next now.

johannes
