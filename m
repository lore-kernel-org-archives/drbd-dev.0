Return-Path: <f.g.haas@gmx.net>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by mail09.linbit.com (LINBIT Mail Daemon) with SMTP id 03D4510556A6
	for <drbd-dev@lists.linbit.com>; Fri,  2 Sep 2011 09:37:23 +0200 (CEST)
Message-ID: <4E6087B1.5080901@gmx.net>
Date: Fri, 02 Sep 2011 09:37:21 +0200
From: Florian Haas <f.g.haas@gmx.net>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEEF191F0AB1EB11A7D609AD7"
Subject: [Drbd-dev] [GIT PULL] Tiny addition to User's Guide LVM chapter
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEEF191F0AB1EB11A7D609AD7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Phil/Lars,

Please consider pulling this little UG patch reminding users to update
their initrd after they make DRBD-related changes to lvm.conf. This is
an issue that has popped up on IRC a few times recently.

Thanks,
Florian

The following changes since commit 1e37327f145e42f6e9c8f93f2934a28f1d0596=
4c:

  User's Guide: rename preface to "Please Read This First" (2011-07-15
12:08:55 +0200)

are available in the git repository at:
  git://github.com/fghaas/drbd-documentation master

Florian Haas (1):
      User's Guide: add note about updating initrd in LVM chapter

 users-guide/lvm.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)


--------------enigEEF191F0AB1EB11A7D609AD7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5gh7EACgkQ3LcKy7E7Hp2vPwCeMagkHMSN8GER3JPa2REFUuVy
gHcAnRr6WRuQIkGZHUeWQez0vNmU1eHT
=FOCV
-----END PGP SIGNATURE-----

--------------enigEEF191F0AB1EB11A7D609AD7--
