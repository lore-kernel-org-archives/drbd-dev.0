Return-Path: <shixinhe6@gmail.com>
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
	[209.85.208.65])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B23E8160963
	for <drbd-dev@lists.linbit.com>; Sun, 29 Dec 2024 06:19:06 +0100 (CET)
Received: by mail-ed1-f65.google.com with SMTP id
	4fb4d7f45d1cf-5d7e527becaso13305829a12.3
	for <drbd-dev@lists.linbit.com>; Sat, 28 Dec 2024 21:19:06 -0800 (PST)
MIME-Version: 1.0
References: <20241229042758.163842-1-shixinhe6@gmail.com>
	<qfagx4fjlluq4fox7fw5ltx63wxpifnr7lp3nkt63jm4wbtzp2@mna6znzgfqv2>
In-Reply-To: <qfagx4fjlluq4fox7fw5ltx63wxpifnr7lp3nkt63jm4wbtzp2@mna6znzgfqv2>
From: newBox shi <shixinhe6@gmail.com>
Message-ID: <CABEB8098qotPWb-QkJ3_R9b6RwpKin_h8TrZ9v96S6KgMtxzDA@mail.gmail.com>
Subject: Re: [PATCH] Documentation zram: fix description about huge page
	writeback example
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: multipart/alternative; boundary="000000000000afbfad062a61d596"
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, philipp.reisner@linbit.com,
	linux-kernel@vger.kernel.org, minchan@kernel.org,
	lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com
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
Date: Sun, 29 Dec 2024 05:19:26 -0000

--000000000000afbfad062a61d596
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I just changed 'incompressible' to 'huge'. I thought huge page is
incompressible but incompressible page does not just include huge page.
Given the example is `echo huge`, it may be better to use `huge page
writeback'.

Sergey Senozhatsky <senozhatsky@chromium.org> =E4=BA=8E2024=E5=B9=B412=E6=
=9C=8829=E6=97=A5=E5=91=A8=E6=97=A5 12:36=E5=86=99=E9=81=93=EF=BC=9A

> On (24/12/29 04:27), Shi Xinhe wrote:
> >
> > Corrected the description to accurately reflect that huge page writebac=
k
> example.
>
> But what is the correction?  In zram huge page is incompressible page.
>

--000000000000afbfad062a61d596
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I just changed &#39;incompressible&#39; to &#39;huge&#39;.=
 I thought huge page is incompressible but incompressible page does not jus=
t include huge page. Given the example is `echo huge`, it may be better to =
use `huge page writeback&#39;.</div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">Sergey Senozhatsky &lt;=
<a href=3D"mailto:senozhatsky@chromium.org">senozhatsky@chromium.org</a>&gt=
; =E4=BA=8E2024=E5=B9=B412=E6=9C=8829=E6=97=A5=E5=91=A8=E6=97=A5 12:36=E5=
=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On (24/12/29 04:27), Shi Xinhe wrote:<br>
&gt; <br>
&gt; Corrected the description to accurately reflect that huge page writeba=
ck example.<br>
<br>
But what is the correction?=C2=A0 In zram huge page is incompressible page.=
<br>
</blockquote></div>

--000000000000afbfad062a61d596--
