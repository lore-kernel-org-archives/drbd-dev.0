Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f173.google.com (mail-wr0-f173.google.com
	[209.85.128.173])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5AFE61057FF4
	for <drbd-dev@lists.linbit.com>; Mon,  4 Sep 2017 16:32:29 +0200 (CEST)
Received: by mail-wr0-f173.google.com with SMTP id p14so156020wrg.3
	for <drbd-dev@lists.linbit.com>; Mon, 04 Sep 2017 07:32:29 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	n35sm7287097wrn.57.2017.09.04.07.32.27
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 04 Sep 2017 07:32:27 -0700 (PDT)
Resent-Message-ID: <20170904143222.GD18589@soda.linbit>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3BADA1057FF4
	for <drbd-dev@lists.linbit.com>; Wed, 30 Aug 2017 00:33:40 +0200 (CEST)
From: NeilBrown <neilb@suse.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Wed, 30 Aug 2017 08:16:15 +1000
Message-ID: <87bmmygguo.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: remove BIOSET_NEED_RESCUER flag from
 drbd_{md_, }io_bio_set
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Careful analysis shows that this flag is not needed.

The RESCUER flag is only needed when a make_request_fn might:
 - allocate a bio from the bioset
 - submit it with generic_make_request() or similar
 - allocate another bio from the bioset

The second allocation can block until the first bio is processed, so
a rescuer is needed to ensure the first bio does get processed.  With
a rescuer it will only get processed when the make_request_fn completes.

In drbd, allocations from drbd_io_bio_set happen from drbd_new_req()
or w_restart_disk_io() which is only called to handle
RESTART_FROZEN_DISK_IO.

In former is called precisely once from the make_request_fn.
The later is never called by within the make_request_fn.

So there cannot be two allocations in the same call to the
make_request_fn, so a rescuer is not needed.

Allocations from drbd_md_io_bio_set are used for IO to the bitmap and
the activity log.  There are only accessed from worker threads and
workqueues, never directly from make_request_fn.
Again, the rescuer isn't needed.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 drivers/block/drbd/drbd_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index e2ed28d45ce1..4fe7c058a573 100644
=2D-- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2167,13 +2167,12 @@ static int drbd_create_mempools(void)
 		goto Enomem;
=20
 	/* mempools */
=2D	drbd_io_bio_set =3D bioset_create(BIO_POOL_SIZE, 0, BIOSET_NEED_RESCUER=
);
+	drbd_io_bio_set =3D bioset_create(BIO_POOL_SIZE, 0, 0);
 	if (drbd_io_bio_set =3D=3D NULL)
 		goto Enomem;
=20
 	drbd_md_io_bio_set =3D bioset_create(DRBD_MIN_POOL_PAGES, 0,
=2D					   BIOSET_NEED_BVECS |
=2D					   BIOSET_NEED_RESCUER);
+					   BIOSET_NEED_BVECS);
 	if (drbd_md_io_bio_set =3D=3D NULL)
 		goto Enomem;
=20
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlml57EACgkQOeye3VZi
gbnSig/9F8bo9ud5Aoo5fhkjP/xbHGSiKG7rl3v9cm3JeOEFpBbfeRsyNPxpawI3
4bJnO3fSp/lr3pUajD4n/AzAqTqWwTGU0p2EBa+COKRWORCw8K3Z6jbxHCthVlFr
qKgBL5q7vzAxgkdx5euF7lXDcbu9VH4X4+6Cf0kp7ydvoPVp7X5aqHwlZxfIg/6d
3l4UrVduKqRR7pavg0zrMzc4NglGL5dF/xAvjyeyul5m3c9+6oMpvgOkhKXy5J4a
nIvnJoCmS735xzzXj6spB3P35MEQ3wJDocYg6Z4VjiN4tHbm5yiJ3viMADR1z2hT
z/mrs1Ggvn69qX/FJcolji3wGMzB3j2EVfouQHGTQJqQdm+sAPAoJoAQv99Xfa8d
Zc/+fW7ecBrCA8g7NANIeH9bmr2UFt7W+Ff2UzcTzADWXNUORQKTMC+mQWpCHSVa
Ns2iXJX4Z54JkASYuR6tndSvQ/zFx+2WJb54XGNllnaMZrI2An38SWaRd2oLbRRs
WRqhzy645A6KzUjrAx3ia1mGH3CS878T0MSyrStN5SFOmsuN4T8DoFfUi6ySK5H7
uvuBSguYFlA9W0ZV6Iai0yc2lKw+/nYqXNOgIUKemAPDbYTwuhcict0JR0fQja+q
yXKJGmJ/124w5GuESCa/39VtPup5d0+H0l2HNaqJx8yO8AvEdIk=
=e+9f
-----END PGP SIGNATURE-----
--=-=-=--
