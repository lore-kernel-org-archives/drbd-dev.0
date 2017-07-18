Return-Path: <bwiedemann@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 843FA1057FD4
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 10:08:22 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 229D1AD78
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 08:08:22 +0000 (UTC)
To: drbd-dev@lists.linbit.com
References: <20170717194958.22787-1-bwiedemann@suse.de>
	<20170718072542.GB1453@rck.sh>
From: "Bernhard M. Wiedemann" <bwiedemann@suse.de>
Message-ID: <e66b3632-f591-4874-dc47-2a79b986b684@suse.de>
Date: Tue, 18 Jul 2017 10:08:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170718072542.GB1453@rck.sh>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="VBU61OPlOFf3aeiE7ni3j90N4Gulve2hA"
Subject: Re: [Drbd-dev] [PATCH] [RFC] drbd: do not record build details
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VBU61OPlOFf3aeiE7ni3j90N4Gulve2hA
Content-Type: multipart/mixed; boundary="sUM3jFDKoe6uNBad8EvHj1WNxF3UekuVv";
 protected-headers="v1"
From: "Bernhard M. Wiedemann" <bwiedemann@suse.de>
To: drbd-dev@lists.linbit.com
Message-ID: <e66b3632-f591-4874-dc47-2a79b986b684@suse.de>
Subject: Re: [Drbd-dev] [PATCH] [RFC] drbd: do not record build details
References: <20170717194958.22787-1-bwiedemann@suse.de>
 <20170718072542.GB1453@rck.sh>
In-Reply-To: <20170718072542.GB1453@rck.sh>

--sUM3jFDKoe6uNBad8EvHj1WNxF3UekuVv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2017-07-18 09:25, Roland Kammerer wrote:
>=20
> I'm a big fan of reproducible builds, but only as long as it does not
> break very useful information for us when we actually look at customer
> installations. In that case it IMO does break that.

it was only meant as an example (see comment in patch).
We can make something nicer.

https://lists.samba.org/archive/samba-technical/2017-July/121677.html
actually preferred to completely drop such build-time data collection
over my initial patch of making it optional.

> Again, I totally understand what the reproducible build project tries t=
o
> achieve, and it is important, but why isn't that just a vendor-patch fo=
r
> the distribution you care about like the Debian guys do it?

because it is also us (open)SUSE guys, the Fedora guys, the FreeBSD guys
and there are probably a dozen other distributions out there, which is
why I try to upstream such patches as much as possible to only have to
fix it once for everyone.

Ciao
Bernhard M.


--sUM3jFDKoe6uNBad8EvHj1WNxF3UekuVv--

--VBU61OPlOFf3aeiE7ni3j90N4Gulve2hA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlltwfUACgkQSTYLOx37oWRm0wCg2SEBuqL2hjFbTljZrdDxC8Ne
c2UAoPwQ8H/93I625QCBT1HNe90a8H78
=xzqi
-----END PGP SIGNATURE-----

--VBU61OPlOFf3aeiE7ni3j90N4Gulve2hA--
