Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6C93A42042E
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:58:57 +0200 (CEST)
Received: by mail-wm1-f68.google.com with SMTP id l26so10039626wme.3
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:58:57 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	o10sm14086644wrq.40.2020.06.13.02.58.56
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:58:56 -0700 (PDT)
Resent-Message-ID: <20200613095854.GC4222@soda.linbit>
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
	[209.85.166.65])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 548D242030B
	for <drbd-dev@lists.linbit.com>; Thu,  4 Jun 2020 04:53:47 +0200 (CEST)
Received: by mail-io1-f65.google.com with SMTP id h4so4658385iob.10
	for <drbd-dev@lists.linbit.com>; Wed, 03 Jun 2020 19:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200603233203.1695403-1-keescook@chromium.org>
	<20200603233203.1695403-9-keescook@chromium.org>
	<ff9087b0571e1fc499bd8a4c9fd99bfc0357f245.camel@perches.com>
	<202006031838.55722640DC@keescook>
	<6f921002478544217903ee4bfbe3c400e169687f.camel@perches.com>
	<202006031944.9551FAA68E@keescook>
In-Reply-To: <202006031944.9551FAA68E@keescook>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Thu, 4 Jun 2020 04:53:34 +0200
Message-ID: <CA+icZUVg24VrpPgMdfsgPa+Wckci9XkzKUdtwhVB3ZW96uZOWw@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Andy Whitcroft <apw@canonical.com>,
	Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	x86@kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	linux-mm@kvack.org, Alexander Potapenko <glider@google.com>,
	b43-dev@lists.infradead.org, Joe Perches <joe@perches.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-clk@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 08/10] checkpatch: Remove awareness of
	uninitialized_var() macro
Reply-To: sedat.dilek@gmail.com
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

Hi Kees,

can you push that change also to kees/linux.git#kspp/uninit/v5.7/macro ?

Thanks in advance.

Regards,
- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/uninit/v5.7/macro

On Thu, Jun 4, 2020 at 4:44 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Jun 03, 2020 at 06:47:13PM -0700, Joe Perches wrote:
> > On Wed, 2020-06-03 at 18:40 -0700, Kees Cook wrote:
> > > On Wed, Jun 03, 2020 at 05:02:29PM -0700, Joe Perches wrote:
> > > > On Wed, 2020-06-03 at 16:32 -0700, Kees Cook wrote:
> > > > > Using uninitialized_var() is dangerous as it papers over real bugs[1]
> > > > > (or can in the future), and suppresses unrelated compiler warnings
> > > > > (e.g. "unused variable"). If the compiler thinks it is uninitialized,
> > > > > either simply initialize the variable or make compiler changes.
> > > > >
> > > > > In preparation for removing[2] the[3] macro[4], effectively revert
> > > > > commit 16b7f3c89907 ("checkpatch: avoid warning about uninitialized_var()")
> > > > > and remove all remaining mentions of uninitialized_var().
> > > > >
> > > > > [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> > > > > [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> > > > > [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> > > > > [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
> > > >
> > > > nack.  see below.
> > > >
> > > > I'd prefer a simple revert, but it shouldn't
> > > > be done here.
> > >
> > > What do you mean? (I can't understand this and "fine by me" below?)
> >
> > I did write "other than that"...
> >
> > I mean that the original commit fixed 2 issues,
> > one with the uninitialized_var addition, and
> > another with the missing void function declaration.
> >
> > I think I found the missing void function bit because
> > the uninitialized_var use looked like a function so I
> > fixed both things at the same time.
> >
> > If you change it, please just remove the bit that
> > checks for uninitialized_var.
>
> Ah! Gotcha. Thanks; I will update it.
>
> -Kees
>
> >
> > Thanks, Joe
> >
> > > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > []
> > > > > @@ -4075,7 +4074,7 @@ sub process {
> > > > >                 }
> > > > >
> > > > >  # check for function declarations without arguments like "int foo()"
> > > > > -               if ($line =~ /(\b$Type\s*$Ident)\s*\(\s*\)/) {
> > > > > +               if ($line =~ /(\b$Type\s+$Ident)\s*\(\s*\)/) {
> > > >
> > > > This isn't right because $Type includes a possible trailing *
> > > > where there isn't a space between $Type and $Ident
> > >
> > > Ah, hm, that was changed in the mentioned commit:
> > >
> > > -               if ($line =~ /(\b$Type\s+$Ident)\s*\(\s*\)/) {
> > > +               if ($line =~ /(\b$Type\s*$Ident)\s*\(\s*\)/) {
> > >
> > > > e.g.:     int *bar(void);
> > > >
> > > > Other than that, fine by me...
> > >
> > > Thanks for looking it over! I'll adjust it however you'd like. :)
> > >
> >
>
> --
> Kees Cook
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/202006031944.9551FAA68E%40keescook.
