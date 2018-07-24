Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 68EE51045C25
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 14:22:35 +0200 (CEST)
Received: by mail-wr1-f65.google.com with SMTP id h15-v6so1512110wrs.7
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 05:22:35 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	d14-v6sm2024462wrr.12.2018.07.26.05.17.08
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 26 Jul 2018 05:17:08 -0700 (PDT)
Resent-Message-ID: <20180726121707.GH25507@soda.linbit>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
	[209.85.215.194])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4F3BE1011BF2
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 18:56:19 +0200 (CEST)
Received: by mail-pg1-f194.google.com with SMTP id v13-v6so3305787pgr.10
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 09:56:19 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 24 Jul 2018 09:49:35 -0700
Message-Id: <20180724164936.37477-18-keescook@chromium.org>
In-Reply-To: <20180724164936.37477-1-keescook@chromium.org>
References: <20180724164936.37477-1-keescook@chromium.org>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>, x86@kernel.org,
	Mike Snitzer <snitzer@redhat.com>, Eric Biggers <ebiggers@google.com>,
	linux-wireless@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>, dm-devel@redhat.com,
	Jia-Ju Bai <baijiaju1990@gmail.com>,
	Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-afs@lists.infradead.org,
	Alasdair Kergon <agk@redhat.com>,
	Rabin Vincent <rabinv@axis.com>, devel@driverdev.osuosl.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	qat-linux@intel.com, Ingo Molnar <mingo@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	drbd-dev@lists.linbit.com, Kees Cook <keescook@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
	linux-block@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Johannes Berg <johannes@sipsolutions.net>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-crypto@vger.kernel.org, linux-ppp@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Tim Chen <tim.c.chen@linux.intel.com>, netdev@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [Drbd-dev] [PATCH v6 17/18] crypto: ccm: Remove VLA usage
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

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

In the quest to remove all stack VLA usage from the kernel[1], this
drops AHASH_REQUEST_ON_STACK by preallocated the ahash request area
with the skcipher area (which are not used at the same time).

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/ccm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/crypto/ccm.c b/crypto/ccm.c
index 0a083342ec8c..b242fd0d3262 100644
--- a/crypto/ccm.c
+++ b/crypto/ccm.c
@@ -50,7 +50,10 @@ struct crypto_ccm_req_priv_ctx {
 	u32 flags;
 	struct scatterlist src[3];
 	struct scatterlist dst[3];
-	struct skcipher_request skreq;
+	union {
+		struct ahash_request ahreq;
+		struct skcipher_request skreq;
+	};
 };
 
 struct cbcmac_tfm_ctx {
@@ -181,7 +184,7 @@ static int crypto_ccm_auth(struct aead_request *req, struct scatterlist *plain,
 	struct crypto_ccm_req_priv_ctx *pctx = crypto_ccm_reqctx(req);
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
 	struct crypto_ccm_ctx *ctx = crypto_aead_ctx(aead);
-	AHASH_REQUEST_ON_STACK(ahreq, ctx->mac);
+	struct ahash_request *ahreq = &pctx->ahreq;
 	unsigned int assoclen = req->assoclen;
 	struct scatterlist sg[3];
 	u8 *odata = pctx->odata;
@@ -427,7 +430,7 @@ static int crypto_ccm_init_tfm(struct crypto_aead *tfm)
 	crypto_aead_set_reqsize(
 		tfm,
 		align + sizeof(struct crypto_ccm_req_priv_ctx) +
-		crypto_skcipher_reqsize(ctr));
+		max(crypto_ahash_reqsize(mac), crypto_skcipher_reqsize(ctr)));
 
 	return 0;
 
-- 
2.17.1

