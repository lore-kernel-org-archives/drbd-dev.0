Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 1 Jun 2010 20:49:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <jaxboe@fusionio.com>
Message-Id: <20100601204942.134965e5.sfr@canb.auug.org.au>
In-Reply-To: <20100601104515.GM3564@kernel.dk>
References: <20100601141324.edf41f7f.sfr@canb.auug.org.au>
	<20100601081823.GA29991@infradead.org>
	<20100601182213.479a777e.sfr@canb.auug.org.au>
	<20100601104515.GM3564@kernel.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__1_Jun_2010_20_49_42_+1000_tei0oTqVGLudjGs+"
Cc: linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	Christoph Hellwig <hch@infradead.org>,
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

--Signature=_Tue__1_Jun_2010_20_49_42_+1000_tei0oTqVGLudjGs+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI Jens,

On Tue, 1 Jun 2010 12:45:15 +0200 Jens Axboe <jaxboe@fusionio.com> wrote:
>
> So the pipe patches were the same, the problem was that a fix for a
> missing pipe_unlock() had gone into mainline and for-linus/for-next
> weren't synced up to that. I'm guessing you pull drbd before for-next
> and that is why it showed up there.

Actually, I merge the drbd tree after the block tree and this fell to the
drbd tree only because your for-next branch had not been updated (and I
don't merge your for-linus branch).

> BTW, I would recommend moving for-next from the block tree up before any
> potential other trees being based off it if that is the case.

That is already true.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__1_Jun_2010_20_49_42_+1000_tei0oTqVGLudjGs+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwE5cYACgkQjjKRsyhoI8wujACffVSwL97RMoEoVSh/+RFVnGnf
n1IAn1AaJi1NtBHimLC5NNYJKpqHsbdj
=FODO
-----END PGP SIGNATURE-----

--Signature=_Tue__1_Jun_2010_20_49_42_+1000_tei0oTqVGLudjGs+--
