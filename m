Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2BFAA10622BA
	for <drbd-dev@lists.linbit.com>; Wed, 23 Sep 2009 13:57:10 +0200 (CEST)
Date: Wed, 23 Sep 2009 21:56:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
Message-Id: <20090923215659.2869830d.sfr@canb.auug.org.au>
In-Reply-To: <20090923111225.GC8000@barkeeper1-xen.linbit>
References: <20090923145100.1917fdd8.sfr@canb.auug.org.au>
	<20090923071152.GA8000@barkeeper1-xen.linbit>
	<20090923111225.GC8000@barkeeper1-xen.linbit>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__23_Sep_2009_21_56_59_+1000_w7R_=bQd.7aXcUls"
Cc: linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-next@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] linux-next: block tree build failure
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Signature=_Wed__23_Sep_2009_21_56_59_+1000_w7R_=bQd.7aXcUls
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On Wed, 23 Sep 2009 13:12:25 +0200 Lars Ellenberg <lars.ellenberg@linbit.co=
m> wrote:
>
> Sorry that it took me so long to have that look.
> We can simply drop that include, we don't even use it.

OK, great.  I guess Jens needs to remerge your tree.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__23_Sep_2009_21_56_59_+1000_w7R_=bQd.7aXcUls
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkq6DQsACgkQjjKRsyhoI8zzbQCgpilFr7Gbdiv59BTo3arCrv+0
ynIAn3aNSg5+vQiMsV5lt7dr88Bz2cnW
=e9Gn
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Sep_2009_21_56_59_+1000_w7R_=bQd.7aXcUls--
