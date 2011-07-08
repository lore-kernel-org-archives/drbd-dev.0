Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4BBD01056471
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jul 2011 16:13:41 +0200 (CEST)
Resent-Message-ID: <20110708141340.GE15170@barkeeper1-xen.linbit>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2A2F81056469
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jul 2011 16:01:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 08AF91B4262
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jul 2011 16:01:47 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KvnJE+08nE6k for <drbd-dev@lists.linbit.com>;
	Fri,  8 Jul 2011 16:01:43 +0200 (CEST)
Received: from [10.0.1.67] (85-127-83-88.dynamic.xdsl-line.inode.at
	[85.127.83.88])
	by zimbra.linbit.com (Postfix) with ESMTPSA id 3900E1B4218
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jul 2011 16:01:43 +0200 (CEST)
Message-ID: <4E170DC3.4000401@linbit.com>
Date: Fri, 08 Jul 2011 16:01:39 +0200
From: Florian Haas <florian.haas@linbit.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
References: <1310053461-15060-1-git-send-email-mrten+drbd@ii.nl>
In-Reply-To: <1310053461-15060-1-git-send-email-mrten+drbd@ii.nl>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig30CA8074B2B8A92BA488B179"
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
--------------enig30CA8074B2B8A92BA488B179
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Erm, NACK. :) That way to build the man pages is now obsolete. Thanks a
lot for the patch nonetheless, it highlighted an important omission.
I've fixed the README for the right way to do this now.

And as an aside, when a make variable is defined with "?=3D" as opposed t=
o
":=3D", then it's meant to be overridden from the environment. Thus, even=

when building the old way, you could have just done

make <target> DRBD=3D/path/to/drbd/checkout

=2E.. rather than hacking the Makefile.

Cheers,
Florian

On 07/07/2011 05:44 PM, Mrten wrote:
> ---
>  README.txt |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)


--------------enig30CA8074B2B8A92BA488B179
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4XDcMACgkQc0m4l7x1nPHYcQCgkdQ+jGfseZm2wmO0EEa87L0L
rLgAn2oBWy+O4b8G2nPq4YAHkv9Vw2Sq
=9LNM
-----END PGP SIGNATURE-----

--------------enig30CA8074B2B8A92BA488B179--
