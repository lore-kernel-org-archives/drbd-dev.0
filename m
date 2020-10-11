Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
	[209.85.208.65])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B6337420347
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 17:27:14 +0200 (CEST)
Received: by mail-ed1-f65.google.com with SMTP id v19so17383122edx.9
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 08:27:14 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214])
	by smtp.gmail.com with ESMTPSA id m2sm10867204ejo.4.2020.10.12.08.26.13
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 12 Oct 2020 08:26:13 -0700 (PDT)
Resent-Message-ID: <20201012152611.GB2116@soda.linbit>
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net
	[176.9.242.54])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8720D42022A
	for <drbd-dev@lists.linbit.com>; Sun, 11 Oct 2020 20:47:43 +0200 (CEST)
Date: Sun, 11 Oct 2020 20:47:41 +0200
From: Elimar Riesebieter <riesebie@lxtec.de>
To: Lukas Wunner <lukas@wunner.de>
Message-ID: <20201011184741.c766frixh5v7xgyb@toy.home.lxtec.de>
References: <1c700caab1ce71fa144116541471b3f7bb4629fa.1602432204.git.lukas@wunner.de>
	<20201011183930.veucf6z335njrkwe@toy.home.lxtec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201011183930.veucf6z335njrkwe@toy.home.lxtec.de>
Cc: Michael Hierweck <michael.hierweck@hostsharing.net>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH drbd-9.0] compat: __vmalloc() pgprot argument
 was removed in v5.8
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

* Elimar Riesebieter <riesebie@lxtec.de> [2020-10-11 20:39 +0200]:

> Applied that patch to tag 9.0.25-1. Building the module via dkms
> gives:
>=20
> /var/lib/dkms/drbd/9.0.25-1hsh2/build/src/drbd/drbd_bitmap.c: In function=
 =E2=80=98bm_realloc_pages=E2=80=99:
> /var/lib/dkms/drbd/9.0.25-1hsh2/build/src/drbd/drbd_bitmap.c:368:15: erro=
r: too few arguments to function =E2=80=98__vmalloc=E2=80=99
>    new_pages =3D __vmalloc(bytes,
>                ^~~~~~~~~
> In file included from /var/lib/dkms/drbd/9.0.25-1hsh2/build/src/drbd/drbd=
_bitmap.c:16:
> /usr/src/linux-headers-4.19.0-9-common/include/linux/vmalloc.h:80:14: not=
e: declared here
>  extern void *__vmalloc(unsigned long size, gfp_t gfp_mask, pgprot_t prot=
);
>               ^~~~~~~~~

This was on 4.19. I think the changes must depend on KVERS as the
modules should build from 4.19 upwards. Will try your patch against
5.8 tomorrow.

Elimar
--=20
  From The Collaborative International Dictionary of English v.0.48 [gcide]:
  .
  arsehole \arse"hole`\ ([aum]rs"h[=3Do]l`), n.
         1. execretory opening at the end of the alimentary canal.

