Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 1 Jun 2010 18:22:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@infradead.org>
Message-Id: <20100601182213.479a777e.sfr@canb.auug.org.au>
In-Reply-To: <20100601081823.GA29991@infradead.org>
References: <20100601141324.edf41f7f.sfr@canb.auug.org.au>
	<20100601081823.GA29991@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__1_Jun_2010_18_22_13_+1000_4Uiwu0yNAo6fFDnA"
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-next@vger.kernel.org, Julia Lawall <julia@diku.dk>,
	Al Viro <viro@zeniv.linux.org.uk>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] linux-next: manual merge of the drbd tree with
	Linus' tree
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Signature=_Tue__1_Jun_2010_18_22_13_+1000_4Uiwu0yNAo6fFDnA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Replacing Jens' Oracle address ...]

Hi Christoph,

On Tue, 1 Jun 2010 04:18:23 -0400 Christoph Hellwig <hch@infradead.org> wro=
te:
>
> On Tue, Jun 01, 2010 at 02:13:24PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Today's linux-next merge of the drbd tree got a conflict in fs/pipe.c
> > between commit cc967be54710d97c05229b2e5ba2d00df84ddd64 ("fs: Add missi=
ng
> > mutex_unlock") from Linus' tree and commits
> > 0191f8697bbdfefcd36e7b8dc3eeddfe82893e4b ("pipe: F_SETPIPE_SZ should
> > return -EPERM for non-root") and b9598db3401282bb27b4aef77e3eee12015f7f=
29
> > ("pipe: make F_{GET,SET}PIPE_SZ deal with byte sizes") from the drbd tr=
ee.
> >=20
> > I fixed it up (see below) and can carry the fix for a while.
>=20
> Why is the drbd tree touching fs/pipe.c anyway?

It is based on the block tree.  I assume that it is currently based on a
version of the block tree that Jens has not yet pushed into
linux-next.  :-(

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__1_Jun_2010_18_22_13_+1000_4Uiwu0yNAo6fFDnA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwEwzUACgkQjjKRsyhoI8yR4QCgl/psxaQUgkFBNBPudbrU70K+
uB4AoILTi95f7AZPWIgKskt2yEknj1DT
=q5dZ
-----END PGP SIGNATURE-----

--Signature=_Tue__1_Jun_2010_18_22_13_+1000_4Uiwu0yNAo6fFDnA--
