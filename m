Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9EA0F1011BAE
	for <drbd-dev@lists.linbit.com>; Fri, 16 Oct 2009 15:32:59 +0200 (CEST)
Resent-Message-ID: <20091016133259.GE8041@barkeeper1-xen.linbit>
Received: from [10.102.193.59] (unknown [194.24.158.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPSA id 73D2A10620B3
	for <drbd-dev@lists.linbit.com>; Fri, 16 Oct 2009 14:01:46 +0200 (CEST)
Message-ID: <4AD860A7.80301@linbit.com>
Date: Fri, 16 Oct 2009 14:01:43 +0200
From: Florian Haas <florian.haas@linbit.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
References: <20091016103845.GA15975@suse.de>	<20091016112001.GB8041@barkeeper1-xen.linbit>
	<20091016114302.GC26808@suse.de>
In-Reply-To: <20091016114302.GC26808@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7025A630A7169A0D91BBDB78"
Subject: Re: [Drbd-dev] SCTP support for drbd
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7025A630A7169A0D91BBDB78
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/16/2009 01:43 PM, Lars Marowsky-Bree wrote:
> On 2009-10-16T13:20:01, Lars Ellenberg <lars.ellenberg@linbit.com> wrot=
e:
>=20
>>> The other service is drbd, which also uses TCP-only right now. It'd b=
e
>>> nice if it also supported SCTP; it can't be that hard, since the
>>> in-kernel dlm also supports TCP and SCTP.
>> Is somewhere on our todo list,
>> but may have to wait for DRBD 9.
>> Feature sponsoring accepted ;)
>=20
> How much sponsoring do you need? Florian said it looked trivial enough.=

> ;-)

Talk about a quote yanked out of context. I dug up one code snippet and
said "looks good". No word about trivial, as far as I remember.

Florian


--------------enig7025A630A7169A0D91BBDB78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkrYYKcACgkQc0m4l7x1nPFWowCfaRFvpQApACtQow+qX9DFBhVz
iAMAn3LfEYkdFGwPkSK8rBt12R3GLjvQ
=PzA1
-----END PGP SIGNATURE-----

--------------enig7025A630A7169A0D91BBDB78--
