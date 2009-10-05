Return-Path: <sfr@canb.auug.org.au>
Date: Mon, 5 Oct 2009 18:21:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <jens.axboe@oracle.com>
Message-Id: <20091005182103.0a391d15.sfr@canb.auug.org.au>
In-Reply-To: <20091005063138.GO26573@kernel.dk>
References: <20091005143552.977a2d4d.sfr@canb.auug.org.au>
	<20091005063138.GO26573@kernel.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__5_Oct_2009_18_21_03_+1100_MHtEgfBX0PVloY.h"
Cc: linux-next@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] linux-next: block/drbd tree build failure
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Signature=_Mon__5_Oct_2009_18_21_03_+1100_MHtEgfBX0PVloY.h
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Mon, 5 Oct 2009 08:31:38 +0200 Jens Axboe <jens.axboe@oracle.com> wrote:
>
> On Mon, Oct 05 2009, Stephen Rothwell wrote:
> >=20
> > Today's linux-next build (x86_64 allmodconfig) failed like this:
> >=20
> > drivers/block/drbd/drbd_req.c: In function '_drbd_start_io_acct':
> > drivers/block/drbd/drbd_req.c:43: error: subscripted value is neither a=
rray nor pointer
> > drivers/block/drbd/drbd_req.c: In function '_drbd_end_io_acct':
> > drivers/block/drbd/drbd_req.c:56: error: subscripted value is neither a=
rray nor pointer
> >=20
> > I reported a similar error against the dbd tree, which was fixed, but n=
ow
> > the commit that caused that error has been reverted and thus we get
> > this :-(
> >=20
> > I have reverted the drbd commits from the block tree for today.
>=20
> That's probably my fault, not drbd. I moved it to a new branch since it
> isn't going into 2.6.32, and perhaps dropped that fix along the way.
> I'll look into it.

The original problem was caused by commit
a9327cac440be4d8333bba975cbbf76045096275 ("Seperate read and write
statistics of in_flight requests") which went into Linus' tree on Sept
15.  The drbd tee was fixed to cope with that change.  Then that commit
was reverted in Linus' tree on Oct 5, so the fix to the drbd tree needs
to be reverted as well.  Unfortunately, the drbd tree has been rebased
into (basically) one commit, so that commit needs fixing.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__5_Oct_2009_18_21_03_+1100_MHtEgfBX0PVloY.h
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkrJnl8ACgkQjjKRsyhoI8zvMACglTRM6hitGZWiknE5kvzC2mRx
KQAAn17A0+HMaeOR1VbeDw7onsRK0qQq
=yDU5
-----END PGP SIGNATURE-----

--Signature=_Mon__5_Oct_2009_18_21_03_+1100_MHtEgfBX0PVloY.h--
