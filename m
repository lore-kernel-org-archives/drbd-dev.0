Return-Path: <lmb@suse.de>
Date: Tue, 25 Jan 2005 00:23:18 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [fix] drbd uses wrong API for struct bio
Message-ID: <20050124232318.GV5638@marowsky-bree.de>
References: <20050123161633.GH24350@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="10jrOL3x2xqLmOsH"
Content-Disposition: inline
In-Reply-To: <20050123161633.GH24350@marowsky-bree.de>
Cc: drbd-user@linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


--10jrOL3x2xqLmOsH
Content-Type: multipart/mixed; boundary="mJm6k4Vb/yFcL9ZU"
Content-Disposition: inline


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2005-01-23T17:16:33, Lars Marowsky-Bree <lmb@suse.de> wrote:

The attached patch fixes drbds useage of bios up some. The proper fix
would be to indeed change it over to use bio_alloc(), bio_get/put(),
bio_add_page(), bio_clone (instead of __bio_clone) et cetera, but that
fix is too complex for the timeframe I have right now.

This should keep drbd-0.7.8 from oopsing not only on the SLES9 SP1
kernel but also the recent 2.6.10-ac series.

(I could possibly _code_ it, but it'd be too invasive and I'm weary of
the side-effects it might have and the QA would take too long. There's a
number of potential cleanups like further consolidation between
drbd_prepare_req_write/_read and others, but I'd propose to do that for
the drbd-0.8 branch instead when we can do away with 2.4.)

Please comment on the patch, I'd be grateful.

I have tested the patch in a standalone configuration, primary/secondary
(and switching around during resyncing etc), and it seems to be doing
quite well so far.


Sincerely,
    Lars Marowsky-Br=E9e <lmb@suse.de>

--=20
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=drbd-50103
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
Index: drbd/drbd_compat_wrappers.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drbd/drbd_compat_wrappers.h	(revision 1730)
+++ drbd/drbd_compat_wrappers.h	(working copy)
@@ -429,11 +429,9 @@
  */
 static inline char *drbd_bio_kmap(struct bio *bio)
 {
-	struct bio_vec *bvec;
+	struct bio_vec *bvec =3D bio_iovec(bio);
 	unsigned long addr;
=20
-	bvec =3D bio_iovec_idx(bio, bio->bi_idx);
-
 	addr =3D (unsigned long) kmap(bvec->bv_page);
=20
 	if (addr & ~PAGE_MASK)
@@ -444,16 +442,15 @@
=20
 static inline void drbd_bio_kunmap(struct bio *bio)
 {
-	struct bio_vec *bvec;
+	struct bio_vec *bvec =3D bio_iovec(bio);
=20
-	bvec =3D bio_iovec_idx(bio, bio->bi_idx);
 	kunmap(bvec->bv_page);
 }
=20
 #else
 static inline char *drbd_bio_kmap(struct bio *bio)
 {
-	struct bio_vec *bvec =3D bio_iovec_idx(bio, bio->bi_idx);
+	struct bio_vec *bvec =3D bio_iovec(bio);
 	return page_address(bvec->bv_page) + bvec->bv_offset;
 }
 static inline void drbd_bio_kunmap(struct bio *bio)
@@ -466,16 +463,17 @@
 {
 	struct bio * const bio =3D &e->private_bio;
 	struct bio_vec * const vec =3D &e->ee_bvec;
+
 	memset(e, 0, sizeof(*e));
+	bio_init(bio);
=20
-	// bio_init(&bio); memset did it for us.
 	bio->bi_io_vec =3D vec;
-	vec->bv_page   =3D page;
-	vec->bv_len    =3D
-	bio->bi_size   =3D PAGE_SIZE;
-	bio->bi_max_vecs =3D 1;
 	bio->bi_destructor =3D NULL;
-	atomic_set(&bio->bi_cnt, 1);
+	vec->bv_page =3D page;
+	bio->bi_size =3D vec->bv_len =3D PAGE_SIZE;
+	bio->bi_max_vecs =3D bio->bi_vcnt =3D=20
+	bio->bi_phys_segments =3D bio->bi_hw_segments =3D 1;
+	vec->bv_offset =3D 0;
=20
 	e->block_id =3D ID_VACANT;
 }
@@ -495,20 +493,25 @@
 		    sector_t sector, int size)
 {
 	struct bio * const bio =3D &e->private_bio;
-
+	struct bio_vec * const vec =3D &e->ee_bvec;
+	struct page * const page =3D vec->bv_page;
 	D_ASSERT(mdev->backing_bdev);
=20
-	bio->bi_flags  =3D 1 << BIO_UPTODATE;
-	bio->bi_io_vec->bv_len =3D
-	bio->bi_size    =3D size;
-	bio->bi_bdev    =3D mdev->backing_bdev;
-	bio->bi_sector  =3D sector;
+	/* Clear plate. */
+	bio_init(bio);
+
+	bio->bi_io_vec =3D vec;
+	bio->bi_destructor =3D NULL;
+	vec->bv_page =3D page;
+	vec->bv_offset =3D 0;
+	bio->bi_max_vecs =3D bio->bi_vcnt =3D=20
+	bio->bi_phys_segments =3D bio->bi_hw_segments =3D 1;
+
+	bio->bi_bdev =3D mdev->backing_bdev;
 	bio->bi_private =3D mdev;
-	bio->bi_next    =3D 0;
-	bio->bi_idx     =3D 0; // for blk_recount_segments
-	bio->bi_vcnt    =3D 1; // for blk_recount_segments
-	e->ee_sector =3D sector;
-	e->ee_size =3D size;
+
+	e->ee_sector =3D bio->bi_sector =3D sector;
+	e->ee_size =3D bio->bi_size =3D bio->bi_io_vec->bv_len =3D size;
 }
=20
 static inline void
@@ -530,15 +533,19 @@
 static inline void
 drbd_req_prepare_write(drbd_dev *mdev, struct drbd_request *req)
 {
-	struct bio * const bio     =3D &req->private_bio;
-	struct bio * const bio_src =3D  req->master_bio;
+	struct bio * const bio      =3D &req->private_bio;
+	struct bio_vec * const bvec =3D &req->req_bvec;
+	struct bio * const bio_src  =3D  req->master_bio;
=20
 	bio_init(bio); // bio->bi_flags   =3D 0;
+	bio->bi_io_vec =3D bvec;
+	bio->bi_max_vecs =3D 1;
+
 	__bio_clone(bio,bio_src);
 	bio->bi_bdev    =3D mdev->backing_bdev;
 	bio->bi_private =3D mdev;
 	bio->bi_end_io  =3D drbd_dio_end;
-	bio->bi_next    =3D 0;
+	bio->bi_next    =3D NULL;
=20
 	req->rq_status =3D RQ_DRBD_NOTHING;
 }
@@ -546,22 +553,26 @@
 static inline void
 drbd_req_prepare_read(drbd_dev *mdev, struct drbd_request *req)
 {
-	struct bio * const bio     =3D &req->private_bio;
-	struct bio * const bio_src =3D  req->master_bio;
+	struct bio * const bio      =3D &req->private_bio;
+	struct bio_vec * const bvec =3D &req->req_bvec;
+	struct bio * const bio_src  =3D  req->master_bio;
=20
 	bio_init(bio); // bio->bi_flags   =3D 0;
+	bio->bi_io_vec =3D bvec;
+	bio->bi_max_vecs =3D 1;
+
 	__bio_clone(bio,bio_src);
 	bio->bi_bdev    =3D mdev->backing_bdev;
 	bio->bi_private =3D mdev;
 	bio->bi_end_io  =3D drbd_read_bi_end_io;	// <- only difference
-	bio->bi_next    =3D 0;
+	bio->bi_next    =3D NULL;
=20
 	req->rq_status =3D RQ_DRBD_NOTHING;
 }
=20
 static inline struct page* drbd_bio_get_page(struct bio *bio)
 {
-	struct bio_vec *bvec =3D bio_iovec_idx(bio, bio->bi_idx);
+	struct bio_vec *bvec =3D bio_iovec(bio);
 	return bvec->bv_page;
 }
=20
@@ -622,13 +633,13 @@
=20
 static inline int _drbd_send_zc_bio(drbd_dev *mdev, struct bio *bio)
 {
-	struct bio_vec *bvec =3D bio_iovec_idx(bio, bio->bi_idx);
+	struct bio_vec *bvec =3D bio_iovec(bio);
 	return _drbd_send_page(mdev,bvec->bv_page,bvec->bv_offset,bvec->bv_len);
 }
=20
 static inline int _drbd_send_bio(drbd_dev *mdev, struct bio *bio)
 {
-	struct bio_vec *bvec =3D bio_iovec_idx(bio, bio->bi_idx);
+	struct bio_vec *bvec =3D bio_iovec(bio);
 	struct page *page =3D bvec->bv_page;
 	size_t size =3D bvec->bv_len;
 	int offset =3D bvec->bv_offset;
Index: drbd/drbd_int.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drbd/drbd_int.h	(revision 1730)
+++ drbd/drbd_int.h	(working copy)
@@ -630,6 +630,7 @@
 	struct drbd_barrier *barrier; // The next barrier.
 	drbd_bio_t *master_bio;       // master bio pointer
 	drbd_bio_t private_bio;       // private bio struct
+	ONLY_IN_26(struct bio_vec req_bvec;)
 };
=20
 struct drbd_barrier {
@@ -669,7 +670,7 @@
 	long magic;
 	ONLY_IN_26(unsigned int ee_size;)
 	ONLY_IN_26(sector_t ee_sector;)
-	// THINK: maybe we rather want bio_alloc(GFP_*,1)
+	// TODO: we rather want bio_alloc(GFP_*,1) all through the code!
 	ONLY_IN_26(struct bio_vec ee_bvec;)
 };
=20

--mJm6k4Vb/yFcL9ZU--

--10jrOL3x2xqLmOsH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB9YNmudf3XQV4S2cRAtXoAJkBKBC0XhTfPYc362cR4e4diQwCUACeP3GQ
pDVrdLLkF/UKpvXxTMaGl9Q=
=Ukw2
-----END PGP SIGNATURE-----

--10jrOL3x2xqLmOsH--
