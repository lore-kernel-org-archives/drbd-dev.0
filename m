Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 18 May 2010 15:20:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Philipp Reisner <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
Message-Id: <20100518152031.9a244971.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__18_May_2010_15_20_31_+1000_NelEjYw54Z3ygQJ7"
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>
Subject: [Drbd-dev] linux-next: manual merge of the drbd tree with the block
	tree
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Signature=_Tue__18_May_2010_15_20_31_+1000_NelEjYw54Z3ygQJ7
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drbd tree got a conflict in
mm/page-writeback.c between commit
42bd225c0ba7c95af39293d39a950c48e7e5cb23 (""laptop-mode: Make flushes
per-device" fix") from the block tree and commit
e913fc825dc685a444cb4c1d0f9d32f372f59861 ("writeback: fix WB_SYNC_NONE
writeback from umount") from the drbd tree (via its merge of the block
tree).

I used the next-20100517 version of the block tree today (because the
above conflict was not resolved correctly in the block tree and caused a
build failure), so I will also use the next-20100517 version of the drbd
tree for today.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__18_May_2010_15_20_31_+1000_NelEjYw54Z3ygQJ7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvyI58ACgkQjjKRsyhoI8wzaQCcC7BjrS41+6/VunWH2k22rV9I
5q8AnAzKvtDlvBqH2ypu67DzeLvaU2KU
=GaEt
-----END PGP SIGNATURE-----

--Signature=_Tue__18_May_2010_15_20_31_+1000_NelEjYw54Z3ygQJ7--
