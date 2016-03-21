Return-Path: <m@sys4.de>
Received: from mail.sys4.de (mail.sys4.de [194.126.158.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 774671051881
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 00:26:16 +0100 (CET)
Received: from localhost (echo.sys4.de [127.0.0.1])
	by mail.sys4.de (Postfix) with ESMTP id 3qTWwC4YYjz1JGJ
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 00:18:19 +0100 (CET)
Received: from localhost (port-1764.pppoe.wtnet.de [84.46.6.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.sys4.de (Postfix) with ESMTPSA id 3qTWwC2SQVz1HZf
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 00:18:19 +0100 (CET)
Date: Tue, 22 Mar 2016 00:18:17 +0100
From: Marc Schiffbauer <m@sys4.de>
To: drbd-dev@lists.linbit.com
Message-ID: <20160321231817.GI30157@schiffbauer.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cpvLTH7QU4gwfq3S"
Content-Disposition: inline
Subject: [Drbd-dev] integer signedness mixup problem in drbd_main.c
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


--cpvLTH7QU4gwfq3S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi all,

using a kernel hardened with grsecurity/PaX we discovered a problem=20
where PaX detects a size overflow after a quite large uptime:

PAX: size overflow detected in function drbd_send_dblock=20
drivers/block/drbd/drbd_main.c:1625 cicus.964_133 max, count: 1

this was in kernel 3.14.19, but 4.4.5 still seems to have that problem. =20
The line triggering this is:

p->seq_num =3D cpu_to_be32(atomic_inc_return_unchecked(&mdev->packet_seq));

(line 1625 in linux 3.14.19 and 1637 in linux 4.4.5)

please see [1] for more details.

Please can you tell whether this should be fixed in drbd? Or might this=20
be some false positive in PaX?

regards
-Marc

[1] https://forums.grsecurity.net/viewtopic.php?f=3D3&t=3D4425

--=20
[*] sys4 AG

http://sys4.de, +49 (89) 30 90 46 64
Franziskanerstra=DFe 15, 81669 M=FCnchen

Sitz der Gesellschaft: M=FCnchen, Amtsgericht M=FCnchen: HRB 199263
Vorstand: Patrick Ben Koetter, Marc Schiffbauer
Aufsichtsratsvorsitzender: Florian Kirstein

--cpvLTH7QU4gwfq3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW8IE1AAoJEDsr1ZJngzeolvYP/3y+GSurIztZsSHhH51hsSGK
AYZ5VCMdjJhLSbdIhf2BDnfiEyScfygiHsJ7Sc3tw67Ljf3E+02xOq94EiZzzDz0
Sy3oP7RcQBE/7Bp3F9zKVubUHIPeSzlNlpUhXJjKQb8mztfpCpu3fKtGY2afyphe
AnfbTQOul5DXHqRdYltauMKzU18841y5FLk+g2SjymAAQk0Goe73g8kZzzKxIZpu
EUbkR9tLdawxLbczhXSOEaXtb6rP1kA3Ug7relUXzOqhPVDA4YxgsNVjuy5D4Rr7
opilbWBhVsu9WiZuWOrFBvl+cvChd+EN3OGgvEgXeRsiTaIu3O2gptVmkzXsB2+I
SaoaFGn0sLSu8ppScIOAKcQdsyPpYANBV/9Q/N3rmW8U8AIIrtHJ02SVizNFM7kR
62BXch5fakjWK8aGGzC50cZ+jeNMg3d6S3HxzZVtqreIoPYPpkoNE71CgKDQ+qYr
9t4UqEBNdaSBS4cOl2QES3INlsETtcRDhQohEGdVosYqbF4zxJvlZqm4fr7rfOnW
r4AwLXIloxLqzlswTtXEK8wBjaDus78I1vvEWomM2GJDAhG3xjvghZyEXRW/EmmV
2IiXpGo6bo1dpJ2yJiE2yrHKvZxip269dAACOwyit9v9DYCX3tezVHJitTXWSwoS
ZgqLUqoyBlyKcN6urFgX
=PGUi
-----END PGP SIGNATURE-----

--cpvLTH7QU4gwfq3S--
