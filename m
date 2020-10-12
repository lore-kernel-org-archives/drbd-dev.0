Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
	[209.85.218.67])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 822D2420329
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 17:26:35 +0200 (CEST)
Received: by mail-ej1-f67.google.com with SMTP id ce10so23756765ejc.5
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 08:26:35 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	d12sm10915180ejt.105.2020.10.12.08.26.34
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 12 Oct 2020 08:26:34 -0700 (PDT)
Resent-Message-ID: <20201012152632.GI2116@soda.linbit>
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net
	[83.223.78.233])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id F03804202E2
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 12:57:38 +0200 (CEST)
Date: Mon, 12 Oct 2020 12:57:37 +0200
From: Elimar Riesebieter <riesebie@lxtec.de>
To: Lukas Wunner <lukas@wunner.de>
Message-ID: <20201012105737.wnlrajearpdpqohu@toy.home.lxtec.de>
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
[...]
> --- a/drbd/drbd_bitmap.c
> +++ b/drbd/drbd_bitmap.c
> @@ -366,9 +366,7 @@ static struct page **bm_realloc_pages(struct drbd_bit=
map *b, unsigned long want)
          ^ should be 8 otherwise this patch doesn't apply.
>  	new_pages =3D kzalloc(bytes, GFP_NOIO | __GFP_NOWARN);
>  	if (!new_pages) {
>  		new_pages =3D __vmalloc(bytes,
> -				GFP_NOIO | __GFP_HIGHMEM | __GFP_ZERO,
> -				PAGE_KERNEL);
> +				      GFP_NOIO | __GFP_HIGHMEM | __GFP_ZERO);
>  		if (!new_pages)
>  			return NULL;
>  	}
> --=20
> 2.27.0
>=20

--=20
  Alles, was viel bedacht wird, wird bedenklich!;-)
         Friedrich Nietzsche

