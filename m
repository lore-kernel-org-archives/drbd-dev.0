Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@suse.de>
Date: Thu, 27 Jan 2005 12:38:48 +0100
References: <200501271047.09852.philipp.reisner@linbit.com>
	<20050127111242.GX5511@marowsky-bree.de>
	<20050127111827.GN2751@suse.de>
In-Reply-To: <20050127111827.GN2751@suse.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ILN+BCncRkVWUtg"
Message-Id: <200501271238.48983.philipp.reisner@linbit.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] Re: bio clone must copy io_vec
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_ILN+BCncRkVWUtg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Here is it....


I will have lunch before comitting it to SVN...

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :

--Boundary-00=_ILN+BCncRkVWUtg
Content-Type: text/x-diff; charset="iso-8859-1";
	name="drbd-remove-__clone_bio.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="drbd-remove-__clone_bio.diff"

diff --exclude .svn -ur /home/phil/src/drbd07/drbd/drbd_compat_wrappers.h /home/phil/src/drbd-0.7.8/drbd/drbd_compat_wrappers.h
--- /home/phil/src/drbd07/drbd/drbd_compat_wrappers.h	2005-01-27 09:50:43.000000000 +0100
+++ /home/phil/src/drbd-0.7.8/drbd/drbd_compat_wrappers.h	2005-01-27 12:19:56.000000000 +0100
@@ -93,6 +93,11 @@
 	return req->private_bio.b_size;
 }
 
+static inline drbd_bio_t* drbd_req_private_bio(struct drbd_request *req)
+{
+	return &req->private_bio;
+}
+
 static inline sector_t drbd_ee_get_sector(struct Tl_epoch_entry *ee)
 {
 	return ee->private_bio.b_blocknr;
@@ -387,7 +392,7 @@
 
 static inline drbd_dev* drbd_req_get_mdev(struct drbd_request *req)
 {
-	return (drbd_dev*) req->private_bio.bi_private;
+	return (drbd_dev*) req->mdev;
 }
 
 static inline sector_t drbd_req_get_sector(struct drbd_request *req)
@@ -397,11 +402,16 @@
 
 static inline unsigned short drbd_req_get_size(struct drbd_request *req)
 {
-	drbd_dev* mdev = req->private_bio.bi_private;
+	drbd_dev* mdev = req->mdev;
 	D_ASSERT(req->master_bio->bi_size);
 	return req->master_bio->bi_size;
 }
 
+static inline drbd_bio_t* drbd_req_private_bio(struct drbd_request *req)
+{
+	return req->private_bio;
+}
+
 static inline sector_t drbd_ee_get_sector(struct Tl_epoch_entry *ee)
 {
 	return ee->ee_sector;
@@ -531,45 +541,33 @@
 static inline void
 drbd_req_prepare_write(drbd_dev *mdev, struct drbd_request *req)
 {
-	struct bio * const bio      = &req->private_bio;
-	struct bio_vec * const bvec = &req->req_bvec;
-	struct bio * const bio_src  =  req->master_bio;
-
-	bio_init(bio); // bio->bi_flags   = 0;
-	bio->bi_io_vec = bvec;
-	bio->bi_max_vecs = 1;
-	
-	/* FIXME: __bio_clone() workaround, fix me properly later! */
-	bio_src->bi_max_vecs = 1;
-	__bio_clone(bio,bio_src);
+	struct bio *bio;
+
+	bio = req->private_bio = bio_clone(req->master_bio, GFP_NOIO );
+	bio_get(bio);
 	bio->bi_bdev    = mdev->backing_bdev;
-	bio->bi_private = mdev;
+	bio->bi_private = req;
 	bio->bi_end_io  = drbd_dio_end;
-	bio->bi_next    = NULL;
+	bio->bi_next    = 0;
 
 	req->rq_status = RQ_DRBD_NOTHING;
+	req->mdev      = mdev;
 }
 
 static inline void
 drbd_req_prepare_read(drbd_dev *mdev, struct drbd_request *req)
 {
-	struct bio * const bio      = &req->private_bio;
-	struct bio_vec * const bvec = &req->req_bvec;
-	struct bio * const bio_src  =  req->master_bio;
-
-	bio_init(bio); // bio->bi_flags   = 0;
-	bio->bi_io_vec = bvec;
-	bio->bi_max_vecs = 1;
-
-	/* FIXME: __bio_clone() workaround, fix me properly later! */
-	bio_src->bi_max_vecs = 1;
-	__bio_clone(bio,bio_src);
+	struct bio *bio;
+
+	bio = req->private_bio = bio_clone(req->master_bio, GFP_NOIO );
+	bio_get(bio);
 	bio->bi_bdev    = mdev->backing_bdev;
-	bio->bi_private = mdev;
+	bio->bi_private = req;
 	bio->bi_end_io  = drbd_read_bi_end_io;	// <- only difference
-	bio->bi_next    = NULL;
+	bio->bi_next    = 0;
 
 	req->rq_status = RQ_DRBD_NOTHING;
+	req->mdev      = mdev;
 }
 
 static inline struct page* drbd_bio_get_page(struct bio *bio)
@@ -635,7 +633,7 @@
 
 static inline int _drbd_send_zc_bio(drbd_dev *mdev, struct bio *bio)
 {
-	struct bio_vec *bvec = bio_iovec(bio);
+	struct bio_vec *bvec = bio_iovec_idx(bio, bio->bi_idx);
 	return _drbd_send_page(mdev,bvec->bv_page,bvec->bv_offset,bvec->bv_len);
 }
 
diff --exclude .svn -ur /home/phil/src/drbd07/drbd/drbd_int.h /home/phil/src/drbd-0.7.8/drbd/drbd_int.h
--- /home/phil/src/drbd07/drbd/drbd_int.h	2005-01-25 10:54:48.000000000 +0100
+++ /home/phil/src/drbd-0.7.8/drbd/drbd_int.h	2005-01-27 12:15:07.000000000 +0100
@@ -629,8 +629,12 @@
 	int rq_status;
 	struct drbd_barrier *barrier; // The next barrier.
 	drbd_bio_t *master_bio;       // master bio pointer
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 	drbd_bio_t private_bio;       // private bio struct
-	ONLY_IN_26(struct bio_vec req_bvec;)
+#else
+	struct bio *private_bio;
+	drbd_dev *mdev;
+#endif
 };
 
 struct drbd_barrier {
@@ -670,7 +674,7 @@
 	long magic;
 	ONLY_IN_26(unsigned int ee_size;)
 	ONLY_IN_26(sector_t ee_sector;)
-	// TODO: we rather want bio_alloc(GFP_*,1) all through the code!
+	// THINK: maybe we rather want bio_alloc(GFP_*,1)
 	ONLY_IN_26(struct bio_vec ee_bvec;)
 };
 
diff --exclude .svn -ur /home/phil/src/drbd07/drbd/drbd_main.c /home/phil/src/drbd-0.7.8/drbd/drbd_main.c
--- /home/phil/src/drbd07/drbd/drbd_main.c	2005-01-25 09:29:06.000000000 +0100
+++ /home/phil/src/drbd-0.7.8/drbd/drbd_main.c	2005-01-27 12:18:52.000000000 +0100
@@ -1064,9 +1064,9 @@
 		ok = sizeof(p) == drbd_send(mdev,mdev->data.socket,&p,sizeof(p),MSG_MORE);
 		if(ok) {
 			if(mdev->conf.wire_protocol == DRBD_PROT_A) {
-				ok = _drbd_send_bio(mdev,&req->private_bio);
+				ok = _drbd_send_bio(mdev,drbd_req_private_bio(req));
 			} else {
-				ok = _drbd_send_zc_bio(mdev,&req->private_bio);
+				ok = _drbd_send_zc_bio(mdev,drbd_req_private_bio(req));
 			}
 		}
 		if(!ok) tl_cancel(mdev,req);
Nur in /home/phil/src/drbd-0.7.8/drbd: drbd-remove-__clone_bio.diff.
diff --exclude .svn -ur /home/phil/src/drbd07/drbd/drbd_req.c /home/phil/src/drbd-0.7.8/drbd/drbd_req.c
--- /home/phil/src/drbd07/drbd/drbd_req.c	2004-11-25 18:03:26.000000000 +0100
+++ /home/phil/src/drbd-0.7.8/drbd/drbd_req.c	2005-01-27 12:19:14.000000000 +0100
@@ -363,7 +363,7 @@
 		else            mdev->read_cnt += size>>9;
 
 		// in 2.4.X, READA are submitted as READ.
-		drbd_generic_make_request(rw,&req->private_bio);
+		drbd_generic_make_request(rw,drbd_req_private_bio(req));
 	}
 
 	// up_read(mdev->device_lock);
diff --exclude .svn -ur /home/phil/src/drbd07/drbd/drbd_worker.c /home/phil/src/drbd-0.7.8/drbd/drbd_worker.c
--- /home/phil/src/drbd07/drbd/drbd_worker.c	2004-12-10 12:01:04.000000000 +0100
+++ /home/phil/src/drbd-0.7.8/drbd/drbd_worker.c	2005-01-27 12:10:14.000000000 +0100
@@ -275,25 +275,21 @@
  */
 int drbd_dio_end(struct bio *bio, unsigned int bytes_done, int error)
 {
-	struct Drbd_Conf* mdev=bio->bi_private;
-	drbd_request_t *req;
+	drbd_request_t *req=bio->bi_private;
+	struct Drbd_Conf* mdev=req->mdev;
 	sector_t rsector;
 
 	// see above
 	ERR_IF (bio->bi_size)
 		return 1;
 
-	PARANOIA_BUG_ON(!IS_VALID_MDEV(mdev));
-
-	req = container_of(bio,struct drbd_request,private_bio);
-	PARANOIA_BUG_ON(!VALID_POINTER(req));
-
 	drbd_chk_io_error(mdev,error);
 	rsector = drbd_req_get_sector(req);
         // the bi_sector of the bio gets modified somewhere in drbd_end_req()!
 	drbd_end_req(req, RQ_DRBD_LOCAL, (error == 0), rsector);
 	drbd_al_complete_io(mdev,rsector);
 	dec_local(mdev);
+	bio_put(bio);
 	return 0;
 }
 
@@ -301,18 +297,13 @@
  */
 int drbd_read_bi_end_io(struct bio *bio, unsigned int bytes_done, int error)
 {
-	struct Drbd_Conf* mdev = bio->bi_private;
-	drbd_request_t *req;
+	drbd_request_t *req=bio->bi_private;
+	struct Drbd_Conf* mdev=req->mdev;
 
 	// see above
 	ERR_IF (bio->bi_size)
 		return 1;
 
-	PARANOIA_BUG_ON(!IS_VALID_MDEV(mdev));
-
-	req = container_of(bio,struct drbd_request,private_bio);
-	PARANOIA_BUG_ON(!VALID_POINTER(req));
-
 	/* READAs may fail.
 	 * upper layers need to be able to handle that themselves */
 	if (bio_rw(bio) == READA) goto pass_on;
@@ -334,6 +325,7 @@
 		mempool_free(req,drbd_request_mempool);
 	}
 
+	bio_put(bio);
 	dec_local(mdev);
 	return 0;
 }
Nur in /home/phil/src/drbd07/drbd: get_last_30_percent.diff.
diff --exclude .svn -ur /home/phil/src/drbd07/drbd/linux/drbd_config.h /home/phil/src/drbd-0.7.8/drbd/linux/drbd_config.h
--- /home/phil/src/drbd07/drbd/linux/drbd_config.h	2005-01-25 11:26:02.000000000 +0100
+++ /home/phil/src/drbd-0.7.8/drbd/linux/drbd_config.h	2005-01-27 12:34:28.000000000 +0100
@@ -22,7 +22,7 @@
 
 extern const char * drbd_buildtag(void);
 
-#define REL_VERSION "0.7.9"
+#define REL_VERSION "0.7.10"
 #define API_VERSION 77
 #define PRO_VERSION 74
 

--Boundary-00=_ILN+BCncRkVWUtg--
