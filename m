Return-Path: <shixinhe6@gmail.com>
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
	[209.85.218.65])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 579B7160968
	for <drbd-dev@lists.linbit.com>; Sun, 29 Dec 2024 06:58:46 +0100 (CET)
Received: by mail-ej1-f65.google.com with SMTP id
	a640c23a62f3a-aa6a92f863cso1334881266b.1
	for <drbd-dev@lists.linbit.com>; Sat, 28 Dec 2024 21:58:46 -0800 (PST)
MIME-Version: 1.0
References: <20241229042758.163842-1-shixinhe6@gmail.com>
	<qfagx4fjlluq4fox7fw5ltx63wxpifnr7lp3nkt63jm4wbtzp2@mna6znzgfqv2>
In-Reply-To: <qfagx4fjlluq4fox7fw5ltx63wxpifnr7lp3nkt63jm4wbtzp2@mna6znzgfqv2>
From: newBox shi <shixinhe6@gmail.com>
Message-ID: <CABEB809afGY_ha6aXwDm28U7j_b8mHLycxp=PNfUdi017KtAaw@mail.gmail.com>
Subject: Re: [PATCH] Documentation zram: fix description about huge page
	writeback example
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Date: Sun, 29 Dec 2024 05:58:47 -0000

I just changed 'incompressible' to 'huge'. I thought huge page is
incompressible but incompressible page does not just include huge
page. Given the example is `echo huge`, it may be better to use `huge
page writeback'.


Sergey Senozhatsky <senozhatsky@chromium.org> =E4=BA=8E2024=E5=B9=B412=E6=
=9C=8829=E6=97=A5=E5=91=A8=E6=97=A5 12:36=E5=86=99=E9=81=93=EF=BC=9A
>
> On (24/12/29 04:27), Shi Xinhe wrote:
> >
> > Corrected the description to accurately reflect that huge page writebac=
k example.
>
> But what is the correction?  In zram huge page is incompressible page.
