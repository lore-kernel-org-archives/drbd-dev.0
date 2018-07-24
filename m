Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 35C7B1045C33
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 14:24:20 +0200 (CEST)
Received: by mail-wr1-f67.google.com with SMTP id g6-v6so1528921wrp.0
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 05:24:20 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	i1-v6sm1295060wrq.69.2018.07.26.05.17.06
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 26 Jul 2018 05:17:06 -0700 (PDT)
Resent-Message-ID: <20180726121706.GG25507@soda.linbit>
Received: from mail-pl0-f65.google.com (mail-pl0-f65.google.com
	[209.85.160.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 33D6A101AC7B
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 18:56:18 +0200 (CEST)
Received: by mail-pl0-f65.google.com with SMTP id s17-v6so2028010plp.7
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 09:56:17 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 24 Jul 2018 09:49:36 -0700
Message-Id: <20180724164936.37477-19-keescook@chromium.org>
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
Subject: [Drbd-dev] [PATCH v6 18/18] crypto: Remove AHASH_REQUEST_ON_STACK
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

All users of AHASH_REQUEST_ON_STACK have been removed from the kernel, so
drop it entirely so no VLAs get reintroduced by future users.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/crypto/hash.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 21587011ab0f..fca3e28c77a4 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -64,11 +64,6 @@ struct ahash_request {
 	void *__ctx[] CRYPTO_MINALIGN_ATTR;
 };
 
-#define AHASH_REQUEST_ON_STACK(name, ahash) \
-	char __##name##_desc[sizeof(struct ahash_request) + \
-		crypto_ahash_reqsize(ahash)] CRYPTO_MINALIGN_ATTR; \
-	struct ahash_request *name = (void *)__##name##_desc
-
 /**
  * struct ahash_alg - asynchronous message digest definition
  * @init: **[mandatory]** Initialize the transformation context. Intended only to initialize the
-- 
2.17.1

