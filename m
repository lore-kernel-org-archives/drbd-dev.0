Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D8B421011BFF
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jun 2019 17:05:58 +0200 (CEST)
Received: by mail-wr1-f67.google.com with SMTP id x4so14287640wrt.6
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jun 2019 08:05:58 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	q25sm16425309wrc.68.2019.06.24.08.05.57
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 24 Jun 2019 08:05:57 -0700 (PDT)
Resent-Message-ID: <20190624150556.GO30528@soda.linbit>
Received: from deadmen.hmeau.com (helcar.hmeau.com [216.24.177.18])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B5C6C1028A66
	for <drbd-dev@lists.linbit.com>; Mon, 17 Jun 2019 17:25:51 +0200 (CEST)
Date: Mon, 17 Jun 2019 22:43:35 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190617144335.q243r7l7ox7galhl@gondor.apana.org.au>
References: <20190617132440.2721536-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617132440.2721536-1-arnd@arndb.de>
Cc: Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@chromium.org>,
	Eric Biggers <ebiggers@google.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com,
	Roland Kammerer <roland.kammerer@linbit.com>
Subject: Re: [Drbd-dev] [PATCH] drbd: dynamically allocate shash descriptor
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

On Mon, Jun 17, 2019 at 03:24:13PM +0200, Arnd Bergmann wrote:
> Building with clang and KASAN, we get a warning about an overly large
> stack frame on 32-bit architectures:
> 
> drivers/block/drbd/drbd_receiver.c:921:31: error: stack frame size of 1280 bytes in function 'conn_connect'
>       [-Werror,-Wframe-larger-than=]
> 
> We already allocate other data dynamically in this function, so
> just do the same for the shash descriptor, which makes up most of
> this memory.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/drbd/drbd_receiver.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Does this patch fix the warning as well?

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 90ebfcae0ce6..ead13a6b3887 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -5401,6 +5401,35 @@ static int drbd_do_auth(struct drbd_connection *connection)
 #else
 #define CHALLENGE_LEN 64
 
+static char *drbd_get_response(struct drbd_connection *connection,
+			       const char *challenge, unsigned int len)
+{
+	unsigned dlen = crypto_shash_digestsize(connection->cram_hmac_tfm);
+	SHASH_DESC_ON_STACK(desc, connection->cram_hmac_tfm);
+	char *response;
+	int err;
+
+	desc->tfm = connection->cram_hmac_tfm;
+
+	response = kmalloc(dlen, GFP_NOIO);
+	if (!response) {
+		drbd_err(connection, "kmalloc of response failed\n");
+		goto out;
+	}
+
+	err = crypto_shash_digest(desc, challenge, len, response);
+	if (err) {
+		drbd_err(connection, "crypto_shash_digest() failed with %d\n",
+			 err);
+		kfree(response);
+		response = NULL;
+	}
+
+out:
+	shash_desc_zero(desc);
+	return response;
+}
+
 /* Return value:
 	1 - auth succeeded,
 	0 - failed, try again (network error),
@@ -5417,7 +5446,6 @@ static int drbd_do_auth(struct drbd_connection *connection)
 	unsigned int key_len;
 	char secret[SHARED_SECRET_MAX]; /* 64 byte */
 	unsigned int resp_size;
-	SHASH_DESC_ON_STACK(desc, connection->cram_hmac_tfm);
 	struct packet_info pi;
 	struct net_conf *nc;
 	int err, rv;
@@ -5430,8 +5458,6 @@ static int drbd_do_auth(struct drbd_connection *connection)
 	memcpy(secret, nc->shared_secret, key_len);
 	rcu_read_unlock();
 
-	desc->tfm = connection->cram_hmac_tfm;
-
 	rv = crypto_shash_setkey(connection->cram_hmac_tfm, (u8 *)secret, key_len);
 	if (rv) {
 		drbd_err(connection, "crypto_shash_setkey() failed with %d\n", rv);
@@ -5496,16 +5522,8 @@ static int drbd_do_auth(struct drbd_connection *connection)
 	}
 
 	resp_size = crypto_shash_digestsize(connection->cram_hmac_tfm);
-	response = kmalloc(resp_size, GFP_NOIO);
+	response = drbd_get_response(connection, peers_ch, pi.size);
 	if (response == NULL) {
-		drbd_err(connection, "kmalloc of response failed\n");
-		rv = -1;
-		goto fail;
-	}
-
-	rv = crypto_shash_digest(desc, peers_ch, pi.size, response);
-	if (rv) {
-		drbd_err(connection, "crypto_hash_digest() failed with %d\n", rv);
 		rv = -1;
 		goto fail;
 	}
@@ -5544,17 +5562,9 @@ static int drbd_do_auth(struct drbd_connection *connection)
 		goto fail;
 	}
 
-	right_response = kmalloc(resp_size, GFP_NOIO);
+	right_response = drbd_get_response(connection, my_challenge,
+					   CHALLENGE_LEN);
 	if (right_response == NULL) {
-		drbd_err(connection, "kmalloc of right_response failed\n");
-		rv = -1;
-		goto fail;
-	}
-
-	rv = crypto_shash_digest(desc, my_challenge, CHALLENGE_LEN,
-				 right_response);
-	if (rv) {
-		drbd_err(connection, "crypto_hash_digest() failed with %d\n", rv);
 		rv = -1;
 		goto fail;
 	}
@@ -5571,7 +5581,6 @@ static int drbd_do_auth(struct drbd_connection *connection)
 	kfree(peers_ch);
 	kfree(response);
 	kfree(right_response);
-	shash_desc_zero(desc);
 
 	return rv;
 }
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
