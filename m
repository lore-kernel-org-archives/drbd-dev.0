Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BC41B1045C23
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 14:17:18 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so1767898wmb.4
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 05:17:18 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	x7-v6sm2516191wrr.95.2018.07.26.05.17.17
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 26 Jul 2018 05:17:17 -0700 (PDT)
Resent-Message-ID: <20180726121717.GN25507@soda.linbit>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
	[209.85.215.194])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B03641011B9A
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 18:57:02 +0200 (CEST)
Received: by mail-pg1-f194.google.com with SMTP id p23-v6so3298978pgv.13
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 09:57:02 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 24 Jul 2018 09:49:27 -0700
Message-Id: <20180724164936.37477-10-keescook@chromium.org>
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
Subject: [Drbd-dev] [PATCH v6 09/18] ppp: mppe: Remove VLA usage
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
removes the discouraged use of AHASH_REQUEST_ON_STACK (and associated
VLA) by switching to shash directly and keeping the associated descriptor
allocated with the regular state on the heap.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ppp/ppp_mppe.c | 56 ++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ppp/ppp_mppe.c b/drivers/net/ppp/ppp_mppe.c
index 6c7fd98cb00a..a205750b431b 100644
--- a/drivers/net/ppp/ppp_mppe.c
+++ b/drivers/net/ppp/ppp_mppe.c
@@ -96,7 +96,7 @@ static inline void sha_pad_init(struct sha_pad *shapad)
  */
 struct ppp_mppe_state {
 	struct crypto_skcipher *arc4;
-	struct crypto_ahash *sha1;
+	struct shash_desc *sha1;
 	unsigned char *sha1_digest;
 	unsigned char master_key[MPPE_MAX_KEY_LEN];
 	unsigned char session_key[MPPE_MAX_KEY_LEN];
@@ -136,25 +136,16 @@ struct ppp_mppe_state {
  */
 static void get_new_key_from_sha(struct ppp_mppe_state * state)
 {
-	AHASH_REQUEST_ON_STACK(req, state->sha1);
-	struct scatterlist sg[4];
-	unsigned int nbytes;
-
-	sg_init_table(sg, 4);
-
-	nbytes = setup_sg(&sg[0], state->master_key, state->keylen);
-	nbytes += setup_sg(&sg[1], sha_pad->sha_pad1,
-			   sizeof(sha_pad->sha_pad1));
-	nbytes += setup_sg(&sg[2], state->session_key, state->keylen);
-	nbytes += setup_sg(&sg[3], sha_pad->sha_pad2,
-			   sizeof(sha_pad->sha_pad2));
-
-	ahash_request_set_tfm(req, state->sha1);
-	ahash_request_set_callback(req, 0, NULL, NULL);
-	ahash_request_set_crypt(req, sg, state->sha1_digest, nbytes);
-
-	crypto_ahash_digest(req);
-	ahash_request_zero(req);
+	crypto_shash_init(state->sha1);
+	crypto_shash_update(state->sha1, state->master_key,
+			    state->keylen);
+	crypto_shash_update(state->sha1, sha_pad->sha_pad1,
+			    sizeof(sha_pad->sha_pad1));
+	crypto_shash_update(state->sha1, state->session_key,
+			    state->keylen);
+	crypto_shash_update(state->sha1, sha_pad->sha_pad2,
+			    sizeof(sha_pad->sha_pad2));
+	crypto_shash_final(state->sha1, state->sha1_digest);
 }
 
 /*
@@ -200,6 +191,7 @@ static void mppe_rekey(struct ppp_mppe_state * state, int initial_key)
 static void *mppe_alloc(unsigned char *options, int optlen)
 {
 	struct ppp_mppe_state *state;
+	struct crypto_shash *shash;
 	unsigned int digestsize;
 
 	if (optlen != CILEN_MPPE + sizeof(state->master_key) ||
@@ -217,13 +209,21 @@ static void *mppe_alloc(unsigned char *options, int optlen)
 		goto out_free;
 	}
 
-	state->sha1 = crypto_alloc_ahash("sha1", 0, CRYPTO_ALG_ASYNC);
-	if (IS_ERR(state->sha1)) {
-		state->sha1 = NULL;
+	shash = crypto_alloc_shash("sha1", 0, 0);
+	if (IS_ERR(shash))
+		goto out_free;
+
+	state->sha1 = kmalloc(sizeof(*state->sha1) +
+				     crypto_shash_descsize(shash),
+			      GFP_KERNEL);
+	if (!state->sha1) {
+		crypto_free_shash(shash);
 		goto out_free;
 	}
+	state->sha1->tfm = shash;
+	state->sha1->flags = 0;
 
-	digestsize = crypto_ahash_digestsize(state->sha1);
+	digestsize = crypto_shash_digestsize(shash);
 	if (digestsize < MPPE_MAX_KEY_LEN)
 		goto out_free;
 
@@ -246,7 +246,10 @@ static void *mppe_alloc(unsigned char *options, int optlen)
 
 out_free:
 	kfree(state->sha1_digest);
-	crypto_free_ahash(state->sha1);
+	if (state->sha1) {
+		crypto_free_shash(state->sha1->tfm);
+		kzfree(state->sha1);
+	}
 	crypto_free_skcipher(state->arc4);
 	kfree(state);
 out:
@@ -261,7 +264,8 @@ static void mppe_free(void *arg)
 	struct ppp_mppe_state *state = (struct ppp_mppe_state *) arg;
 	if (state) {
 		kfree(state->sha1_digest);
-		crypto_free_ahash(state->sha1);
+		crypto_free_shash(state->sha1->tfm);
+		kzfree(state->sha1);
 		crypto_free_skcipher(state->arc4);
 		kfree(state);
 	}
-- 
2.17.1

