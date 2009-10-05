Return-Path: <sfr@canb.auug.org.au>
Date: Mon, 5 Oct 2009 14:35:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <jens.axboe@oracle.com>
Message-Id: <20091005143552.977a2d4d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__5_Oct_2009_14_35_52_+1100_2ZCHj9cMIv.fPR.Z"
Cc: linux-next@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>
Subject: [Drbd-dev] linux-next: block/drbd tree build failure
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Signature=_Mon__5_Oct_2009_14_35_52_+1100_2ZCHj9cMIv.fPR.Z
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jens,

Today's linux-next build (x86_64 allmodconfig) failed like this:

drivers/block/drbd/drbd_req.c: In function '_drbd_start_io_acct':
drivers/block/drbd/drbd_req.c:43: error: subscripted value is neither array=
 nor pointer
drivers/block/drbd/drbd_req.c: In function '_drbd_end_io_acct':
drivers/block/drbd/drbd_req.c:56: error: subscripted value is neither array=
 nor pointer

I reported a similar error against the dbd tree, which was fixed, but now
the commit that caused that error has been reverted and thus we get
this :-(

I have reverted the drbd commits from the block tree for today.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__5_Oct_2009_14_35_52_+1100_2ZCHj9cMIv.fPR.Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkrJaZgACgkQjjKRsyhoI8wJVACgqTXbwMTIz4i4e7dAsoonH1Rk
gLUAn12cxosRRzbpeEeDygaWaFQVcSiq
=xTzB
-----END PGP SIGNATURE-----

--Signature=_Mon__5_Oct_2009_14_35_52_+1100_2ZCHj9cMIv.fPR.Z--
