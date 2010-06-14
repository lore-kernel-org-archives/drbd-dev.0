Return-Path: <sfr@canb.auug.org.au>
Date: Mon, 14 Jun 2010 11:26:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>
Message-Id: <20100614112639.ef45a777.sfr@canb.auug.org.au>
In-Reply-To: <4C107FBF.9050209@kernel.dk>
References: <20100610135203.4649453a.sfr@canb.auug.org.au>
	<4C107FBF.9050209@kernel.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__14_Jun_2010_11_26_39_+1000_oL/Hwo6W0EN0Jg5q"
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] linux-next: manual merge of the drbd tree with the
	block trees
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Signature=_Mon__14_Jun_2010_11_26_39_+1000_oL/Hwo6W0EN0Jg5q
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jens, Philipp,

On Thu, 10 Jun 2010 08:01:35 +0200 Jens Axboe <axboe@kernel.dk> wrote:
>
> I'm starting to think that it would be a little easier if you did not
> pull the drbd tree, I really should be pulling that into my -next branch
> instead.

Given that the drbd tree has not been updated to match the increasingly
different block tree, I have dropped it for today.

There a a few possibilities here:
	- I just drop the drbd tree completely and it only gets merged
into the block tree.
	- if the drbd tree doesn't actually depend on any of the features
in the block tree then it could be rebased onto Linus tree (and I would
cope with any merge fixups - as I do with many other trees).
	- if it does depend on things in the block tree, those particular
features in the block tree could be put in a separate branch that is
never rebased and then that branch could be merged into both the block
and drbd trees (this has been done before e.g. stuff in the vfs tree.
	- the drbd tree could be rebased on tom of the current block tree
(but then it must be kept up to date if the block tree is rebased).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__14_Jun_2010_11_26_39_+1000_oL/Hwo6W0EN0Jg5q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwVhU8ACgkQjjKRsyhoI8w7mACcC5IH+E4sX4sag6CLghdiHQuq
bXoAn3C91BgaFpPPAZYnyFR/7zvMXsAD
=OBWy
-----END PGP SIGNATURE-----

--Signature=_Mon__14_Jun_2010_11_26_39_+1000_oL/Hwo6W0EN0Jg5q--
