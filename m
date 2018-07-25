Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 889CE1045C33
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 14:17:44 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so1766371wma.1
	for <drbd-dev@lists.linbit.com>; Thu, 26 Jul 2018 05:17:44 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	w8-v6sm2022133wrp.72.2018.07.26.05.17.43
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 26 Jul 2018 05:17:43 -0700 (PDT)
Resent-Message-ID: <20180726121743.GB25507@soda.linbit>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
	[209.85.218.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2CEE3101E043
	for <drbd-dev@lists.linbit.com>; Wed, 25 Jul 2018 13:39:56 +0200 (CEST)
Received: by mail-oi0-f66.google.com with SMTP id l10-v6so13290309oii.0
	for <drbd-dev@lists.linbit.com>; Wed, 25 Jul 2018 04:39:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180724164936.37477-11-keescook@chromium.org>
References: <20180724164936.37477-1-keescook@chromium.org>
	<20180724164936.37477-11-keescook@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Jul 2018 13:32:23 +0200
Message-ID: <CAJZ5v0gVDotjufLKUW0YuQu2vA4fmU_gqia=ZA4DocW4XHxx0w@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Mike Snitzer <snitzer@redhat.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"open list:NETWORKING DRIVERS \(WIRELESS\)"
	<linux-wireless@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>, dm-devel@redhat.com,
	Jia-Ju Bai <baijiaju1990@gmail.com>,
	Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-afs@lists.infradead.org,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com,
	devel@driverdev.osuosl.org, Herbert Xu <herbert@gondor.apana.org.au>,
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
	Linux PM <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-crypto@vger.kernel.org, linux-ppp@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Tim Chen <tim.c.chen@linux.intel.com>, netdev <netdev@vger.kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [Drbd-dev] [PATCH v6 10/18] x86/power/64: Remove VLA usage
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

On Tue, Jul 24, 2018 at 6:49 PM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> removes the discouraged use of AHASH_REQUEST_ON_STACK by switching to
> shash directly and allocating the descriptor in heap memory (which should
> be fine: the tfm has already been allocated there too).
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>

I think I can queue this up if there are no objections from others.

Do you want me to do that?

> ---
>  arch/x86/power/hibernate_64.c | 36 ++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
> index 67ccf64c8bd8..f8e3b668d20b 100644
> --- a/arch/x86/power/hibernate_64.c
> +++ b/arch/x86/power/hibernate_64.c
> @@ -233,29 +233,35 @@ struct restore_data_record {
>   */
>  static int get_e820_md5(struct e820_table *table, void *buf)
>  {
> -       struct scatterlist sg;
> -       struct crypto_ahash *tfm;
> +       struct crypto_shash *tfm;
> +       struct shash_desc *desc;
>         int size;
>         int ret = 0;
>
> -       tfm = crypto_alloc_ahash("md5", 0, CRYPTO_ALG_ASYNC);
> +       tfm = crypto_alloc_shash("md5", 0, 0);
>         if (IS_ERR(tfm))
>                 return -ENOMEM;
>
> -       {
> -               AHASH_REQUEST_ON_STACK(req, tfm);
> -               size = offsetof(struct e820_table, entries) + sizeof(struct e820_entry) * table->nr_entries;
> -               ahash_request_set_tfm(req, tfm);
> -               sg_init_one(&sg, (u8 *)table, size);
> -               ahash_request_set_callback(req, 0, NULL, NULL);
> -               ahash_request_set_crypt(req, &sg, buf, size);
> -
> -               if (crypto_ahash_digest(req))
> -                       ret = -EINVAL;
> -               ahash_request_zero(req);
> +       desc = kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(tfm),
> +                      GFP_KERNEL);
> +       if (!desc) {
> +               ret = -ENOMEM;
> +               goto free_tfm;
>         }
> -       crypto_free_ahash(tfm);
>
> +       desc->tfm = tfm;
> +       desc->flags = 0;
> +
> +       size = offsetof(struct e820_table, entries) +
> +               sizeof(struct e820_entry) * table->nr_entries;
> +
> +       if (crypto_shash_digest(desc, (u8 *)table, size, buf))
> +               ret = -EINVAL;
> +
> +       kzfree(desc);
> +
> +free_tfm:
> +       crypto_free_shash(tfm);
>         return ret;
>  }
>
> --
> 2.17.1
>
