Return-Path: <lmb@suse.de>
Date: Sun, 23 Jan 2005 17:16:33 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Message-ID: <20050123161633.GH24350@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
Cc: axboe@suse.de
Subject: [Drbd-dev] drbd uses wrong API for struct bio
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


--Fba/0zbH8Xs+Fj9o
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

drbd is a quite bad offender for using bio's on stack or embedded in
other internal structs instead of the pointer interface.

The attached patch shows the 'right' way as an example, which was pretty ea=
sy
because I could use Jens' patch for md with minimal modifications ;-) Howev=
er,
the other offending code lines are within the transfer log and other places,
and I'm not sure Philipp wants me to mess around with that.

Jens, on chip.suse.de:/local/lmb/drbd-07/drbd/ you can find the most recent
drbd kernel code. Could you look over drbd_compat_wrappers.h line 326ff in
particular and give me a rough rundown of what's broken? We need to fix thi=
s by
Tuesday latest :-(


Sincerely,
    Lars Marowsky-Br=E9e <lmb@suse.de>

--=20
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=drbd-bio-on-stack
Content-Transfer-Encoding: quoted-printable

Index: drbd/drbd_actlog.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drbd/drbd_actlog.c	(revision 1730)
+++ drbd/drbd_actlog.c	(working copy)
@@ -64,35 +64,29 @@
 STATIC int _drbd_md_sync_page_io(drbd_dev *mdev, struct page *page,=20
 				 sector_t sector, int rw, int size)
 {
-	struct bio bio;
-	struct bio_vec vec;
+	struct bio *bio =3D bio_alloc(GFP_KERNEL, 1);
 	struct completion event;
 	int ok;
=20
-	bio_init(&bio);
-	bio.bi_io_vec =3D &vec;
-	vec.bv_page =3D page;
-	vec.bv_offset =3D 0;
-	vec.bv_len =3D
-	bio.bi_size =3D size;
-	bio.bi_vcnt =3D 1;
-	bio.bi_idx =3D 0;
-	bio.bi_bdev =3D mdev->md_bdev;
-	bio.bi_sector =3D sector;
+	bio_get(bio);
+
+	bio->bi_bdev =3D mdev->md_bdev;
+	bio->bi_sector =3D sector;
+	bio_add_page(bio, page, size, 0);
 	init_completion(&event);
-	bio.bi_private =3D &event;
-	bio.bi_end_io =3D drbd_md_io_complete;
+	bio->bi_private =3D &event;
+	bio->bi_end_io =3D drbd_md_io_complete;
=20
 #ifdef BIO_RW_SYNC
-	submit_bio(rw | (1 << BIO_RW_SYNC), &bio);
+	submit_bio(rw | (1 << BIO_RW_SYNC), bio);
 #else
-	submit_bio(rw, &bio);
+	submit_bio(rw, bio);
 	drbd_blk_run_queue(bdev_get_queue(mdev->md_bdev));
 #endif
 	wait_for_completion(&event);
=20
-	ok =3D test_bit(BIO_UPTODATE, &bio.bi_flags);
-
+	ok =3D test_bit(BIO_UPTODATE, &bio->bi_flags);
+	bio_put(bio);
 	return ok;
 }
 #endif

--wac7ysb48OaltWcw--

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB883hudf3XQV4S2cRApN2AJ9SdT7zl5tuWahh2cZIiYSnFF+8MQCfaLAh
Bw2IcfnQ64ENwNpUM0PeVx8=
=tBP+
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
