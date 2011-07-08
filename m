Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C3AE01056470
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jul 2011 16:51:57 +0200 (CEST)
Resent-Message-ID: <20110708145157.GH15170@barkeeper1-xen.linbit>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DAA891056470
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jul 2011 16:45:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 991801B4262
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jul 2011 16:45:43 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vi54k24rvnO8 for <drbd-dev@lists.linbit.com>;
	Fri,  8 Jul 2011 16:45:41 +0200 (CEST)
Received: from [10.0.1.67] (85-127-83-88.dynamic.xdsl-line.inode.at
	[85.127.83.88])
	by zimbra.linbit.com (Postfix) with ESMTPSA id 764261B4218
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jul 2011 16:45:41 +0200 (CEST)
Message-ID: <4E171814.1050707@linbit.com>
Date: Fri, 08 Jul 2011 16:45:40 +0200
From: Florian Haas <florian.haas@linbit.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
References: <1310053461-15060-1-git-send-email-mrten+drbd@ii.nl>
	<4E170DC3.4000401@linbit.com>
In-Reply-To: <4E170DC3.4000401@linbit.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3800E8520D1105C707190D1C"
Subject: Re: [Drbd-dev] [PATCH 1/2] add extra paragraph about manpages/
	directory
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3800E8520D1105C707190D1C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/08/2011 04:01 PM, Florian Haas wrote:
> Erm, NACK. :) That way to build the man pages is now obsolete. Thanks a=

> lot for the patch nonetheless, it highlighted an important omission.
> I've fixed the README for the right way to do this now.
>=20
> And as an aside, when a make variable is defined with "?=3D" as opposed=
 to
> ":=3D", then it's meant to be overridden from the environment.

Lars just corrected me on this one (you learn something every day): even
a :=3D variable can be overridden from the command line. Anyhow, that's
what you could have done, rather than edit the Makefile. :)

Cheers,
Florian


--------------enig3800E8520D1105C707190D1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4XGBQACgkQc0m4l7x1nPHoZgCfUKN3/3xRg3DVMLL9N8AQmWTd
AdMAnAoiWKN6aaCCvK2LaOXcjQVKj16y
=1JPN
-----END PGP SIGNATURE-----

--------------enig3800E8520D1105C707190D1C--
