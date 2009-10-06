Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 6 Oct 2009 14:01:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <jens.axboe@oracle.com>
Message-Id: <20091006140154.8d94d95c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__6_Oct_2009_14_01_54_+1100_Ai_VUbGcy5ILQKYg"
Cc: linux-next@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>
Subject: [Drbd-dev] linux-next: block/drbd tree build warning
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Signature=_Tue__6_Oct_2009_14_01_54_+1100_Ai_VUbGcy5ILQKYg
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jens, Philipp,

Today's linux-next build (x86_64 allmodconfig) produced this warning:

drivers/block/drbd/drbd_nl.c: In function 'drbd_nl_init':
drivers/block/drbd/drbd_nl.c:2309: warning: passing argument 3 of 'cn_add_c=
allback' from incompatible pointer type
include/linux/connector.h:167: note: expected 'void (*)(struct cn_msg *, st=
ruct netlink_skb_parms *)' but argument is of type 'void (*)(struct cn_msg =
*)'

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__6_Oct_2009_14_01_54_+1100_Ai_VUbGcy5ILQKYg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkrKsyIACgkQjjKRsyhoI8y6UACfUuJLy6uEuHLILte0KEaJz3y/
pvMAn30N9UidNRzWm5uwOBJnI+4tOuK+
=0HZ9
-----END PGP SIGNATURE-----

--Signature=_Tue__6_Oct_2009_14_01_54_+1100_Ai_VUbGcy5ILQKYg--
