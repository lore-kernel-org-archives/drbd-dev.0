Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
	[209.85.218.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BCDBC4202B6
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 17:26:20 +0200 (CEST)
Received: by mail-ej1-f66.google.com with SMTP id qp15so23752815ejb.3
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 08:26:20 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	k21sm10680740edv.31.2020.10.12.08.26.19
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 12 Oct 2020 08:26:19 -0700 (PDT)
Resent-Message-ID: <20201012152617.GC2116@soda.linbit>
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net
	[176.9.242.54])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 9F09F42022A
	for <drbd-dev@lists.linbit.com>; Sun, 11 Oct 2020 20:48:40 +0200 (CEST)
Date: Sun, 11 Oct 2020 20:39:30 +0200
From: Elimar Riesebieter <riesebie@lxtec.de>
To: Lukas Wunner <lukas@wunner.de>
Message-ID: <20201011183930.veucf6z335njrkwe@toy.home.lxtec.de>
References: <1c700caab1ce71fa144116541471b3f7bb4629fa.1602432204.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1c700caab1ce71fa144116541471b3f7bb4629fa.1602432204.git.lukas@wunner.de>
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

* Lukas Wunner <lukas@wunner.de> [2020-10-11 18:07 +0200]:

> Commit torvalds/linux@88dca4ca5a93 removed the pgprot argument from
> __vmalloc().  There's a single invocation in drbd_bitmap.c.  Drop the
> argument to stay as close as possible to upstream and apply a cocci
> patch for older kernels which reinstates the additional argument.
>=20
> Reported-by: Michael Hierweck <michael.hierweck@hostsharing.net>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drbd/drbd-kernel-compat/cocci/__vmalloc__no_has_2_params.cocci | 3 +++
>  drbd/drbd-kernel-compat/gen_patch_names.c                      | 3 +++
>  drbd/drbd-kernel-compat/tests/__vmalloc_has_2_params.c         | 8 +++++=
+++
>  drbd/drbd_bitmap.c                                             | 3 +--

Applied that patch to tag 9.0.25-1. Building the module via dkms
gives:

/var/lib/dkms/drbd/9.0.25-1hsh2/build/src/drbd/drbd_bitmap.c: In function =
=E2=80=98bm_realloc_pages=E2=80=99:
/var/lib/dkms/drbd/9.0.25-1hsh2/build/src/drbd/drbd_bitmap.c:368:15: error:=
 too few arguments to function =E2=80=98__vmalloc=E2=80=99
   new_pages =3D __vmalloc(bytes,
               ^~~~~~~~~
In file included from /var/lib/dkms/drbd/9.0.25-1hsh2/build/src/drbd/drbd_b=
itmap.c:16:
/usr/src/linux-headers-4.19.0-9-common/include/linux/vmalloc.h:80:14: note:=
 declared here
 extern void *__vmalloc(unsigned long size, gfp_t gfp_mask, pgprot_t prot);
              ^~~~~~~~~

Elimar
--=20
  Numeric stability is probably not all that
  important when you're guessing;-)

