Return-Path: <sfr@canb.auug.org.au>
Date: Sun, 27 Sep 2009 12:59:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, Philipp Reisner <philipp.reisner@linbit.com>
Message-Id: <20090927125943.50971de2.sfr@canb.auug.org.au>
In-Reply-To: <20090927125331.5367db08.sfr@canb.auug.org.au>
References: <20090926152800.a6568e53.sfr@canb.auug.org.au>
	<20090926173143.GA5041@linux.vnet.ibm.com>
	<20090926200839.GA5220@merkur.ravnborg.org>
	<20090927125331.5367db08.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__27_Sep_2009_12_59_43_+1000_FZvg4XsJq/wFUs_t"
Cc: linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linux-next@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] linux-next: 20090926 - drop autoconf.h from
	DRBD driver
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Signature=_Sun__27_Sep_2009_12_59_43_+1000_FZvg4XsJq/wFUs_t
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 27 Sep 2009 12:53:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> So for Greg and Philipp, Sam has added a patch that moves autoconf.h.
> There is no need to include it anywhere anyway, so the above files need
> cleaning up.  I have appended Kamalesh's patch below.  Greg, you may have
> to write your own :-)

I should read the patch :-).  Greg, obviously Kamalesh's patch hits the
staging files as well.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__27_Sep_2009_12_59_43_+1000_FZvg4XsJq/wFUs_t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkq+1R8ACgkQjjKRsyhoI8z3uQCdGAPXCs4h76k/KwjwSSFrymFo
/5cAn3fGlGDtV+xFIIhGli5JAdffcA8F
=N1i5
-----END PGP SIGNATURE-----

--Signature=_Sun__27_Sep_2009_12_59_43_+1000_FZvg4XsJq/wFUs_t--
