Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 27DBC101AC43
	for <drbd-dev@lists.linbit.com>; Tue, 23 Jul 2019 09:53:22 +0200 (CEST)
Received: by mail-wr1-f66.google.com with SMTP id p17so42009319wrf.11
	for <drbd-dev@lists.linbit.com>; Tue, 23 Jul 2019 00:53:22 -0700 (PDT)
Date: Tue, 23 Jul 2019 09:47:01 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190723074701.fp2qjjm5dwj4i2x7@rck.sh>
References: <20190722122647.351002-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722122647.351002-1-arnd@arndb.de>
Cc: Jens Axboe <axboe@kernel.dk>, Herbert Xu <herbert@gondor.apana.org.au>,
	Kees Cook <keescook@chromium.org>, Eric Biggers <ebiggers@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	clang-built-linux@googlegroups.com,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com,
	Roland Kammerer <roland.kammerer@linbit.com>
Subject: Re: [Drbd-dev] [PATCH] [v2] drbd: dynamically allocate shash
	descriptor
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

On Mon, Jul 22, 2019 at 02:26:34PM +0200, Arnd Bergmann wrote:
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
> Link: https://lore.kernel.org/lkml/20190617132440.2721536-1-arnd@arndb.de/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Roland Kammerer <roland.kammerer@linbit.com>

> ---
> v2:
> - don't try to zero a NULL descriptor pointer,
>   based on review from Roland Kammerer.
> ---
>  drivers/block/drbd/drbd_receiver.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index 90ebfcae0ce6..2b3103c30857 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -5417,7 +5417,7 @@ static int drbd_do_auth(struct drbd_connection *connection)
>  	unsigned int key_len;
>  	char secret[SHARED_SECRET_MAX]; /* 64 byte */
>  	unsigned int resp_size;
> -	SHASH_DESC_ON_STACK(desc, connection->cram_hmac_tfm);
> +	struct shash_desc *desc;
>  	struct packet_info pi;
>  	struct net_conf *nc;
>  	int err, rv;
> @@ -5430,6 +5430,13 @@ static int drbd_do_auth(struct drbd_connection *connection)
>  	memcpy(secret, nc->shared_secret, key_len);
>  	rcu_read_unlock();
>  
> +	desc = kmalloc(sizeof(struct shash_desc) +
> +		       crypto_shash_descsize(connection->cram_hmac_tfm),
> +		       GFP_KERNEL);
> +	if (!desc) {
> +		rv = -1;
> +		goto fail;
> +	}
>  	desc->tfm = connection->cram_hmac_tfm;
>  
>  	rv = crypto_shash_setkey(connection->cram_hmac_tfm, (u8 *)secret, key_len);
> @@ -5571,7 +5578,10 @@ static int drbd_do_auth(struct drbd_connection *connection)
>  	kfree(peers_ch);
>  	kfree(response);
>  	kfree(right_response);
> -	shash_desc_zero(desc);
> +	if (desc) {
> +		shash_desc_zero(desc);
> +		kfree(desc);
> +	}
>  
>  	return rv;
>  }
> -- 
> 2.20.0
> 
