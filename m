Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 81B3B1045C25
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 14:17:21 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so1774108wmc.0
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 05:17:21 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	p184-v6sm1493064wmp.31.2018.07.26.05.17.20
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 26 Jul 2018 05:17:20 -0700 (PDT)
Resent-Message-ID: <20180726121720.GQ25507@soda.linbit>
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
	[209.85.215.196])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 35E611011BA6
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 18:57:30 +0200 (CEST)
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so3306434pgp.11
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 09:57:30 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 24 Jul 2018 09:49:23 -0700
Message-Id: <20180724164936.37477-6-keescook@chromium.org>
In-Reply-To: <20180724164936.37477-1-keescook@chromium.org>
References: <20180724164936.37477-1-keescook@chromium.org>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Mike Snitzer <snitzer@redhat.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-wireless@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>, dm-devel@redhat.com,
	Jia-Ju Bai <baijiaju1990@gmail.com>,
	Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-afs@lists.infradead.org,
	Alasdair Kergon <agk@redhat.com>,
	Kees Cook <keescook@chromium.org>, devel@driverdev.osuosl.org,
	x86@kernel.org, qat-linux@intel.com, Ingo Molnar <mingo@redhat.com>,
	Eric Biggers <ebiggers@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	drbd-dev@lists.linbit.com, Rabin Vincent <rabinv@axis.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
	linux-block@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-crypto@vger.kernel.org, linux-ppp@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Tim Chen <tim.c.chen@linux.intel.com>, netdev@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [Drbd-dev] [PATCH v6 05/18] crypto alg: Introduce generic max
	blocksize and alignmask
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

In the quest to remove all stack VLA usage from the kernel[1], this
exposes a new general upper bound on crypto blocksize and alignmask
(higher than for the existing cipher limits) for VLA removal,
and introduces new checks.

At present, the highest cra_alignmask in the kernel is 63. The highest
cra_blocksize is 144 (SHA3_224_BLOCK_SIZE, 18 8-byte words). For the
new blocksize limit, I went with 160 (20 8-byte words).

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/algapi.c         | 7 ++++++-
 include/crypto/algapi.h | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index c0755cf4f53f..496fc51bf215 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -57,9 +57,14 @@ static int crypto_check_alg(struct crypto_alg *alg)
 	if (alg->cra_alignmask & (alg->cra_alignmask + 1))
 		return -EINVAL;
 
-	if (alg->cra_blocksize > PAGE_SIZE / 8)
+	/* General maximums for all algs. */
+	if (alg->cra_alignmask > MAX_ALGAPI_ALIGNMASK)
 		return -EINVAL;
 
+	if (alg->cra_blocksize > MAX_ALGAPI_BLOCKSIZE)
+		return -EINVAL;
+
+	/* Lower maximums for specific alg types. */
 	if (!alg->cra_type && (alg->cra_flags & CRYPTO_ALG_TYPE_MASK) ==
 			       CRYPTO_ALG_TYPE_CIPHER) {
 		if (alg->cra_alignmask > MAX_CIPHER_ALIGNMASK)
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index bd5e8ccf1687..21371ac8f355 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -20,8 +20,10 @@
 /*
  * Maximum values for blocksize and alignmask, used to allocate
  * static buffers that are big enough for any combination of
- * ciphers and architectures.
+ * algs and architectures. Ciphers have a lower maximum size.
  */
+#define MAX_ALGAPI_BLOCKSIZE		160
+#define MAX_ALGAPI_ALIGNMASK		63
 #define MAX_CIPHER_BLOCKSIZE		16
 #define MAX_CIPHER_ALIGNMASK		15
 
-- 
2.17.1

