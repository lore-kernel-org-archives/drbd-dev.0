Return-Path: <sfr@canb.auug.org.au>
Resent-Message-ID: <200907290956.45616.sfr@canb.auug.org.au>
Date: Wed, 29 Jul 2009 16:17:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Message-Id: <20090729161750.148374e2.sfr@canb.auug.org.au>
In-Reply-To: <yq1prbk59bv.fsf@sermon.lab.mkp.net>
References: <20090729152938.791a81c3.sfr@canb.auug.org.au>
	<yq1prbk59bv.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__29_Jul_2009_16_17_50_+1000_xvCd_y+sks3xo53H"
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-next@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org
Subject: Re: [Drbd-dev] linux-next: drbd tree build failure
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Signature=_Wed__29_Jul_2009_16_17_50_+1000_xvCd_y+sks3xo53H
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Wed, 29 Jul 2009 01:47:48 -0400 "Martin K. Petersen" <martin.petersen@or=
acle.com> wrote:
>
> >>>>> "Stephen" =3D=3D Stephen Rothwell <sfr@canb.auug.org.au> writes:
>=20
> Stephen> drivers/block/drbd/drbd_nl.c: In function
> Stephen> 'drbd_setup_queue_param': drivers/block/drbd/drbd_nl.c:707:
> Stephen> error: implicit declaration of function
> Stephen> 'blk_queue_stack_limits'
>=20
> We've decided to keep blk_queue_stack_limits as a wrapper to ease the
> transition.  I sent Jens a patch earlier today that does this.

OK, thanks.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__29_Jul_2009_16_17_50_+1000_xvCd_y+sks3xo53H
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpv6Y4ACgkQjjKRsyhoI8yVwwCbBkCYQj7fuUGy5KSTNOP1+ui7
AnkAn3aV4bzsP9fTuA/KZ+xmF8DqhlLr
=mDdM
-----END PGP SIGNATURE-----

--Signature=_Wed__29_Jul_2009_16_17_50_+1000_xvCd_y+sks3xo53H--

