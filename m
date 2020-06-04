Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 73B4E420437
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:59:34 +0200 (CEST)
Received: by mail-wr1-f68.google.com with SMTP id q11so12301251wrp.3
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:59:34 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	a126sm13103878wme.28.2020.06.13.02.59.33
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:59:33 -0700 (PDT)
Resent-Message-ID: <20200613095931.GO4222@soda.linbit>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6FA94420302
	for <drbd-dev@lists.linbit.com>; Thu,  4 Jun 2020 21:29:30 +0200 (CEST)
Received: by mail-pl1-f196.google.com with SMTP id m7so2624586plt.5
	for <drbd-dev@lists.linbit.com>; Thu, 04 Jun 2020 12:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200603233203.1695403-1-keescook@chromium.org>
	<20200603233203.1695403-6-keescook@chromium.org>
In-Reply-To: <20200603233203.1695403-6-keescook@chromium.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 4 Jun 2020 12:29:17 -0700
Message-ID: <CAKwvOdm5zDide5RuppY_jG=r46=UMdVJBrkBqD5x=dOMTG9cZg@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Andy Whitcroft <apw@canonical.com>,
	clang-built-linux <clang-built-linux@googlegroups.com>,
	linux-ide@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-spi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Alexander Potapenko <glider@google.com>,
	b43-dev@lists.infradead.org, Joe Perches <joe@perches.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-clk@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 05/10] ide: Remove uninitialized_var() usage
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Jun 3, 2020 at 4:32 PM Kees Cook <keescook@chromium.org> wrote:
>
> Using uninitialized_var() is dangerous as it papers over real bugs[1]
> (or can in the future), and suppresses unrelated compiler warnings (e.g.
> "unused variable"). If the compiler thinks it is uninitialized, either
> simply initialize the variable or make compiler changes. As a precursor
> to removing[2] this[3] macro[4], just remove this variable since it was
> actually unused:
>
> drivers/ide/ide-taskfile.c:232:34: warning: unused variable 'flags' [-Wunused-variable]
>         unsigned long uninitialized_var(flags);
>                                         ^
>
> [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Fixes ce1e518190ea ("ide: don't disable interrupts during kmap_atomic()")

> ---
>  drivers/ide/ide-taskfile.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
> index aab6a10435b6..a26f85ab58a9 100644
> --- a/drivers/ide/ide-taskfile.c
> +++ b/drivers/ide/ide-taskfile.c
> @@ -229,7 +229,6 @@ void ide_pio_bytes(ide_drive_t *drive, struct ide_cmd *cmd,
>         ide_hwif_t *hwif = drive->hwif;
>         struct scatterlist *sg = hwif->sg_table;
>         struct scatterlist *cursg = cmd->cursg;
> -       unsigned long uninitialized_var(flags);
>         struct page *page;
>         unsigned int offset;
>         u8 *buf;
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200603233203.1695403-6-keescook%40chromium.org.



-- 
Thanks,
~Nick Desaulniers
