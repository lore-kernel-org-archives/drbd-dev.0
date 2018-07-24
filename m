Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 046D31045C31
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 14:25:15 +0200 (CEST)
Received: by mail-wr1-f68.google.com with SMTP id j5-v6so1519457wrr.8
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 05:25:14 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	u71-v6sm1970344wmd.12.2018.07.26.05.17.19
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 26 Jul 2018 05:17:19 -0700 (PDT)
Resent-Message-ID: <20180726121719.GP25507@soda.linbit>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CD8481011B95
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 18:57:23 +0200 (CEST)
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so3306287pgp.11
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 09:57:23 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 24 Jul 2018 09:49:31 -0700
Message-Id: <20180724164936.37477-14-keescook@chromium.org>
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
Subject: [Drbd-dev] [PATCH v6 13/18] wireless/lib80211: Convert from ahash
	to shash
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

In preparing to remove all stack VLA usage from the kernel[1], this
removes the discouraged use of AHASH_REQUEST_ON_STACK in favor of
the smaller SHASH_DESC_ON_STACK by converting from ahash-wrapped-shash
to direct shash. By removing a layer of indirection this both improves
performance and reduces stack usage. The stack allocation will be made
a fixed size in a later patch to the crypto subsystem.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/wireless/lib80211_crypt_tkip.c | 58 +++++++++++++++---------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/net/wireless/lib80211_crypt_tkip.c b/net/wireless/lib80211_crypt_tkip.c
index ba0a1f398ce5..21040aba3a81 100644
--- a/net/wireless/lib80211_crypt_tkip.c
+++ b/net/wireless/lib80211_crypt_tkip.c
@@ -65,9 +65,9 @@ struct lib80211_tkip_data {
 	int key_idx;
 
 	struct crypto_skcipher *rx_tfm_arc4;
-	struct crypto_ahash *rx_tfm_michael;
+	struct crypto_shash *rx_tfm_michael;
 	struct crypto_skcipher *tx_tfm_arc4;
-	struct crypto_ahash *tx_tfm_michael;
+	struct crypto_shash *tx_tfm_michael;
 
 	/* scratch buffers for virt_to_page() (crypto API) */
 	u8 rx_hdr[16], tx_hdr[16];
@@ -106,8 +106,7 @@ static void *lib80211_tkip_init(int key_idx)
 		goto fail;
 	}
 
-	priv->tx_tfm_michael = crypto_alloc_ahash("michael_mic", 0,
-						  CRYPTO_ALG_ASYNC);
+	priv->tx_tfm_michael = crypto_alloc_shash("michael_mic", 0, 0);
 	if (IS_ERR(priv->tx_tfm_michael)) {
 		priv->tx_tfm_michael = NULL;
 		goto fail;
@@ -120,8 +119,7 @@ static void *lib80211_tkip_init(int key_idx)
 		goto fail;
 	}
 
-	priv->rx_tfm_michael = crypto_alloc_ahash("michael_mic", 0,
-						  CRYPTO_ALG_ASYNC);
+	priv->rx_tfm_michael = crypto_alloc_shash("michael_mic", 0, 0);
 	if (IS_ERR(priv->rx_tfm_michael)) {
 		priv->rx_tfm_michael = NULL;
 		goto fail;
@@ -131,9 +129,9 @@ static void *lib80211_tkip_init(int key_idx)
 
       fail:
 	if (priv) {
-		crypto_free_ahash(priv->tx_tfm_michael);
+		crypto_free_shash(priv->tx_tfm_michael);
 		crypto_free_skcipher(priv->tx_tfm_arc4);
-		crypto_free_ahash(priv->rx_tfm_michael);
+		crypto_free_shash(priv->rx_tfm_michael);
 		crypto_free_skcipher(priv->rx_tfm_arc4);
 		kfree(priv);
 	}
@@ -145,9 +143,9 @@ static void lib80211_tkip_deinit(void *priv)
 {
 	struct lib80211_tkip_data *_priv = priv;
 	if (_priv) {
-		crypto_free_ahash(_priv->tx_tfm_michael);
+		crypto_free_shash(_priv->tx_tfm_michael);
 		crypto_free_skcipher(_priv->tx_tfm_arc4);
-		crypto_free_ahash(_priv->rx_tfm_michael);
+		crypto_free_shash(_priv->rx_tfm_michael);
 		crypto_free_skcipher(_priv->rx_tfm_arc4);
 	}
 	kfree(priv);
@@ -510,29 +508,31 @@ static int lib80211_tkip_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	return keyidx;
 }
 
-static int michael_mic(struct crypto_ahash *tfm_michael, u8 * key, u8 * hdr,
-		       u8 * data, size_t data_len, u8 * mic)
+static int michael_mic(struct crypto_shash *tfm_michael, u8 *key, u8 *hdr,
+		       u8 *data, size_t data_len, u8 *mic)
 {
-	AHASH_REQUEST_ON_STACK(req, tfm_michael);
-	struct scatterlist sg[2];
+	SHASH_DESC_ON_STACK(desc, tfm_michael);
 	int err;
 
-	if (tfm_michael == NULL) {
-		pr_warn("%s(): tfm_michael == NULL\n", __func__);
-		return -1;
-	}
-	sg_init_table(sg, 2);
-	sg_set_buf(&sg[0], hdr, 16);
-	sg_set_buf(&sg[1], data, data_len);
+	desc->tfm = tfm_michael;
+	desc->flags = 0;
 
-	if (crypto_ahash_setkey(tfm_michael, key, 8))
+	if (crypto_shash_setkey(tfm_michael, key, 8))
 		return -1;
 
-	ahash_request_set_tfm(req, tfm_michael);
-	ahash_request_set_callback(req, 0, NULL, NULL);
-	ahash_request_set_crypt(req, sg, mic, data_len + 16);
-	err = crypto_ahash_digest(req);
-	ahash_request_zero(req);
+	err = crypto_shash_init(desc);
+	if (err)
+		goto out;
+	err = crypto_shash_update(desc, hdr, 16);
+	if (err)
+		goto out;
+	err = crypto_shash_update(desc, data, data_len);
+	if (err)
+		goto out;
+	err = crypto_shash_final(desc, mic);
+
+out:
+	shash_desc_zero(desc);
 	return err;
 }
 
@@ -654,9 +654,9 @@ static int lib80211_tkip_set_key(void *key, int len, u8 * seq, void *priv)
 {
 	struct lib80211_tkip_data *tkey = priv;
 	int keyidx;
-	struct crypto_ahash *tfm = tkey->tx_tfm_michael;
+	struct crypto_shash *tfm = tkey->tx_tfm_michael;
 	struct crypto_skcipher *tfm2 = tkey->tx_tfm_arc4;
-	struct crypto_ahash *tfm3 = tkey->rx_tfm_michael;
+	struct crypto_shash *tfm3 = tkey->rx_tfm_michael;
 	struct crypto_skcipher *tfm4 = tkey->rx_tfm_arc4;
 
 	keyidx = tkey->key_idx;
-- 
2.17.1

