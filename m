Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2A32D1045C32
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 14:17:28 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so1779568wmc.2
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 05:17:28 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	l11-v6sm1504532wru.25.2018.07.26.05.17.27
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 26 Jul 2018 05:17:27 -0700 (PDT)
Resent-Message-ID: <20180726121726.GW25507@soda.linbit>
Received: from smtprelay.hostedemail.com (smtprelay0235.hostedemail.com
	[216.40.44.235])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4058C101AC7B
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 19:41:17 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
	[10.5.19.251])
	by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 0A84B1800FEAC
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 17:31:23 +0000 (UTC)
Message-ID: <1bdc706ae86039c4ffcff39698251424d54af116.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Kees Cook <keescook@chromium.org>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 24 Jul 2018 10:31:13 -0700
In-Reply-To: <20180724164936.37477-19-keescook@chromium.org>
References: <20180724164936.37477-1-keescook@chromium.org>
	<20180724164936.37477-19-keescook@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Lars, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Ingo,
	Mike Snitzer <snitzer@redhat.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-wireless@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>, x86@kernel.org,
	qat-linux@intel.com, David Howells <dhowells@redhat.com>,
	dm-devel@redhat.com, Jia-Ju Bai <baijiaju1990@gmail.com>,
	Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-afs@lists.infradead.org,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com,
	devel@driverdev.osuosl.org, Eric Biggers <ebiggers@google.com>,
	Andrew, Molnar <mingo@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rabin Vincent <rabinv@axis.com>, Arnd Bergmann <arnd@arndb.de>,
	Tudor-Dan Ambarus <tudor.ambarus@microchip.com>, David,
	linux-block@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Berg <johannes@sipsolutions.net>, Jens Axboe <axboe@kernel.dk>,
	Johannes, Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-ppp@vger.kernel.org, Ellenberg <lars.ellenberg@linbit.com>,
	Tim Chen <tim.c.chen@linux.intel.com>, netdev@vger.kernel.org,
	Woodhouse <dwmw@amazon.co.uk>
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

On Tue, 2018-07-24 at 09:49 -0700, Kees Cook wrote:
> All users of AHASH_REQUEST_ON_STACK have been removed from the kernel, so
> drop it entirely so no VLAs get reintroduced by future users.

checkpatch has a test for that.
It could now be removed as well.
---
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 34e4683de7a3..a3517334d661 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -796,7 +796,7 @@ our $declaration_macros = qr{(?x:
 	(?:$Storage\s+)?(?:[A-Z_][A-Z0-9]*_){0,2}(?:DEFINE|DECLARE)(?:_[A-Z0-9]+){1,6}\s*\(|
 	(?:$Storage\s+)?[HLP]?LIST_HEAD\s*\(|
 	(?:$Storage\s+)?${Type}\s+uninitialized_var\s*\(|
-	(?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(
+	(?:SKCIPHER_REQUEST|SHASH_DESC)_ON_STACK\s*\(
 )};


