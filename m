Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4AB64101AC7B
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 15:40:36 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id o78-v6so9431877wmg.0
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 06:40:36 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	w1-v6sm10591075edk.7.2018.05.23.06.40.34
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 23 May 2018 06:40:35 -0700 (PDT)
Resent-Message-ID: <20180523134033.GR499@soda.linbit>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 57C49101AC56
	for <drbd-dev@lists.linbit.com>; Mon, 21 May 2018 01:23:42 +0200 (CEST)
From: NeilBrown <neilb@suse.com>
To: Kent Overstreet <kent.overstreet@gmail.com>, Shaohua Li <shli@kernel.org>
Date: Mon, 21 May 2018 09:08:10 +1000
In-Reply-To: <20180520222558.7053-1-kent.overstreet@gmail.com>
References: <20180520222558.7053-1-kent.overstreet@gmail.com>
Message-ID: <87603i0vtx.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Cc: axboe@kernel.dk, hch@infradead.org, linux-raid@vger.kernel.org,
	snitzer@redhat.com, darrick.wong@oracle.com,
	linux-kernel@vger.kernel.org, colyli@suse.de,
	linux-block@vger.kernel.org, clm@fb.com,
	Kent Overstreet <kent.overstreet@gmail.com>, bacik@fb.com,
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/13] convert block layer to
	bioset_init()/mempool_init()
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

--=-=-=
Content-Type: text/plain

On Sun, May 20 2018, Kent Overstreet wrote:

> Jens - this series does the rest of the conversions that Christoph wanted, and
> drops bioset_create().
>
> Only lightly tested, but the changes are pretty mechanical. Based on your
> for-next tree.
>
> It's also in the for-jens branch at https://evilpiepirate.org/git/bcachefs.git
>
> Kent Overstreet (12):
>   block: convert bounce, q->bio_split to bioset_init()/mempool_init()
>   drbd: convert to bioset_init()/mempool_init()
>   pktcdvd: convert to bioset_init()/mempool_init()
>   lightnvm: convert to bioset_init()/mempool_init()
>   bcache: convert to bioset_init()/mempool_init()
>   md: convert to bioset_init()/mempool_init()

Hi Kent,
 this conversion looks really good, thanks for Ccing me on it.
 However as Shaohua Li is now the maintainer of md, it probably should
 have gone to him as well.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsB/9sACgkQOeye3VZi
gbmQjhAAkneDkZDXwI4jufoLm+ksYkuZ2yPsJX7lxD0w3gtDRQNk3uTIQEjMYQe8
8c3IjqNrxPnmcPx5wA2UmVokicHc/hcbsPyy8xkDSiWruqTEUgFqxnMlIN3xWGu7
ioQOpIxtvPT6wpnHG7lQfX+H+ghXWL0r4kACmxNFvQ4M0dSNJDubudWCmfNhVgm1
LM1rRYF287B73sBgsxAF1ilbiDWagpFksHNleKn/svSD0GaS4jLZ1QfYcG+8TLeW
RrXmPswflBrF3v70hJWXkPD5Z7yXgJUkOISoRS3oi+f5mXEyN92zPqKVUkPp+pzR
sVE+I4FNP8uwnZiVIlw89LvC7XMj8FyKyzup+YlWH+PwHsyFDEWVnj2b1053AbHJ
lacklAZzdWrfpLR4adCfbzynD+zs3yvL1abqazfgKakZsMtyxf0hmBKA/lJ1i9Zg
za62CbJhCPCGn1SR5oZ85rYxI3rsLTIIckYB5q5idt/99EECGBcvl2aNFZBxvgKm
qHWW1dP2glR3Mhn7S1hEiDlpR02ruF8fdvUNK03ezFHJMMEPypN8IgPBFYVxegBK
O/CjRA5XOHJpKNTrU4EFqs4lCyoJMExyfE+dNxAKTZGne92v2c3tRpneQyeoyc5k
41Dy/JEMrFfR+nQZ7OKNd1opOO4hu69gE3cJHEHUBi0xAH4GKk4=
=6JdX
-----END PGP SIGNATURE-----
--=-=-=--
