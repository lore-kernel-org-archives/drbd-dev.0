Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 2 Jun 2010 14:03:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Philipp Reisner <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
Message-Id: <20100602140322.7e374a2e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__2_Jun_2010_14_03_22_+1000_qmgOgDBi0rK_YRSd"
Cc: Jens Axboe <axboe@kernel.dk>, Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Drbd-dev] linux-next: manual merge of the drbd tree with the block
	tree
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Signature=_Wed__2_Jun_2010_14_03_22_+1000_qmgOgDBi0rK_YRSd
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drbd tree got a conflict in
fs/fs-writeback.c between commit f17625b318d9b151e7bd41e31223e9d89b2aaa77
("Revert "writeback: ensure that WB_SYNC_NONE writeback with sb pinned is
sync"") from the block tree and commits
5c92877730b509fefc445bbba6b3bc441c2c272a ("writeback: fix early free of
work struct") and dff38fd3d1d0914ac0715445bbe21fbce9abed15 ("writeback:
fix non-integrity write-back") from the drbd tree.

I suspect this is caused because the drbd tree id based on a different
version of the block tree to what is in the block tree for-next branch.
I just used the version of this file from the block tree.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__2_Jun_2010_14_03_22_+1000_qmgOgDBi0rK_YRSd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwF2AoACgkQjjKRsyhoI8y7WwCdHpBjAr/Jr/EGUhwowhgFPrz8
qEgAoLfPWJrydOrd+3Mvqdk6I9nVWc7i
=RKTC
-----END PGP SIGNATURE-----

--Signature=_Wed__2_Jun_2010_14_03_22_+1000_qmgOgDBi0rK_YRSd--
