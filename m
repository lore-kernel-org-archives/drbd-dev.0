Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BC3C91045C20
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 14:24:24 +0200 (CEST)
Received: by mail-wr1-f67.google.com with SMTP id h10-v6so1518560wre.6
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 05:24:24 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	i2-v6sm1352359wri.53.2018.07.26.05.17.26
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 26 Jul 2018 05:17:26 -0700 (PDT)
Resent-Message-ID: <20180726121725.GV25507@soda.linbit>
Received: from mail-io0-f193.google.com (mail-io0-f193.google.com
	[209.85.223.193])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EDBD6101AC7B
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 19:05:30 +0200 (CEST)
Received: by mail-io0-f193.google.com with SMTP id w11-v6so4033016iob.2
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 10:05:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180724164936.37477-18-keescook@chromium.org>
References: <20180724164936.37477-1-keescook@chromium.org>
	<20180724164936.37477-18-keescook@chromium.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 24 Jul 2018 18:57:44 +0200
Message-ID: <CAKv+Gu-D9FrOrFU0EmkPA52vrywCGZkFP9vUsyEovdby9dLj0g@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Mike Snitzer <snitzer@redhat.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>,
	device-mapper development <dm-devel@redhat.com>,
	Jia-Ju Bai <baijiaju1990@gmail.com>,
	Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-afs@lists.infradead.org,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com,
	"open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	the arch/x86 maintainers <x86@kernel.org>, qat-linux@intel.com,
	Ingo Molnar <mingo@redhat.com>, Eric Biggers <ebiggers@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rabin Vincent <rabinv@axis.com>, Arnd Bergmann <arnd@arndb.de>,
	Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
	linux-block@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	"open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
	<linux-crypto@vger.kernel.org>, linux-ppp@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [Drbd-dev] [PATCH v6 17/18] crypto: ccm: Remove VLA usage
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

On 24 July 2018 at 18:49, Kees Cook <keescook@chromium.org> wrote:
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> In the quest to remove all stack VLA usage from the kernel[1], this
> drops AHASH_REQUEST_ON_STACK by preallocated the ahash request area
> with the skcipher area (which are not used at the same time).
>

-EGRAMMAR

> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  crypto/ccm.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/crypto/ccm.c b/crypto/ccm.c
> index 0a083342ec8c..b242fd0d3262 100644
> --- a/crypto/ccm.c
> +++ b/crypto/ccm.c
> @@ -50,7 +50,10 @@ struct crypto_ccm_req_priv_ctx {
>         u32 flags;
>         struct scatterlist src[3];
>         struct scatterlist dst[3];
> -       struct skcipher_request skreq;
> +       union {
> +               struct ahash_request ahreq;
> +               struct skcipher_request skreq;
> +       };
>  };
>
>  struct cbcmac_tfm_ctx {
> @@ -181,7 +184,7 @@ static int crypto_ccm_auth(struct aead_request *req, struct scatterlist *plain,
>         struct crypto_ccm_req_priv_ctx *pctx = crypto_ccm_reqctx(req);
>         struct crypto_aead *aead = crypto_aead_reqtfm(req);
>         struct crypto_ccm_ctx *ctx = crypto_aead_ctx(aead);
> -       AHASH_REQUEST_ON_STACK(ahreq, ctx->mac);
> +       struct ahash_request *ahreq = &pctx->ahreq;
>         unsigned int assoclen = req->assoclen;
>         struct scatterlist sg[3];
>         u8 *odata = pctx->odata;
> @@ -427,7 +430,7 @@ static int crypto_ccm_init_tfm(struct crypto_aead *tfm)
>         crypto_aead_set_reqsize(
>                 tfm,
>                 align + sizeof(struct crypto_ccm_req_priv_ctx) +
> -               crypto_skcipher_reqsize(ctr));
> +               max(crypto_ahash_reqsize(mac), crypto_skcipher_reqsize(ctr)));
>
>         return 0;
>
> --
> 2.17.1
>
