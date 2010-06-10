Return-Path: <sfr@canb.auug.org.au>
Date: Thu, 10 Jun 2010 13:52:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Philipp Reisner <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
Message-Id: <20100610135203.4649453a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__10_Jun_2010_13_52_03_+1000_you=wQaCdG6.Z_Oj"
Cc: Jens Axboe <axboe@kernel.dk>, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [Drbd-dev] linux-next: manual merge of the drbd tree with the block
	trees
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Signature=_Thu__10_Jun_2010_13_52_03_+1000_you=wQaCdG6.Z_Oj
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drbd tree got a conflicts in
fs/fs-writeback.c against the block tree.

It looks like the block tree has moved under the drbd tree again.  I used
the version of this file from the block tree for today.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__10_Jun_2010_13_52_03_+1000_you=wQaCdG6.Z_Oj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwQYWMACgkQjjKRsyhoI8yEAwCeL6kicpb/0nbdh0HOzwoKfUZb
v6kAoIghvlDHLarzhUg2MYytPS4KT/As
=sfiT
-----END PGP SIGNATURE-----

--Signature=_Thu__10_Jun_2010_13_52_03_+1000_you=wQaCdG6.Z_Oj--
