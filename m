Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 7 Oct 2009 13:55:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <jens.axboe@oracle.com>
Message-Id: <20091007135505.df1f058c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__7_Oct_2009_13_55_05_+1100_WGOGbk=59+JqOSwA"
Cc: linux-next@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org, Alasdair G Kergon <agk@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
Subject: [Drbd-dev] linux-next: block tree build failure
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Signature=_Wed__7_Oct_2009_13_55_05_+1100_WGOGbk=59+JqOSwA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jens,

Today's linux-next build (x86_64 allmodconfig) failed like this:

drivers/block/drbd/drbd_req.c: In function '_drbd_start_io_acct':
drivers/block/drbd/drbd_req.c:43: error: lvalue required as increment opera=
nd
drivers/block/drbd/drbd_req.c: In function '_drbd_end_io_acct':
drivers/block/drbd/drbd_req.c:56: error: lvalue required as decrement opera=
nd

This is back again :-(

I have used the block tree from next-20091006 for today.  I also had to
use the device-mapper tree from next-20091006 since that is based on the
block tree.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__7_Oct_2009_13_55_05_+1100_WGOGbk=59+JqOSwA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkrMAwkACgkQjjKRsyhoI8wlDgCaAjX+tc7SlH8G0SOMYezFnOWt
6scAoJxOBXgNFWSBuHwMoQCoJPvN6h19
=WjqK
-----END PGP SIGNATURE-----

--Signature=_Wed__7_Oct_2009_13_55_05_+1100_WGOGbk=59+JqOSwA--
