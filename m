Return-Path: <lmb@suse.de>
Date: Mon, 24 Jan 2005 13:24:46 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [Drbd-dev] Re: drbd uses wrong API for struct bio
Message-ID: <20050124122446.GF5638@marowsky-bree.de>
References: <20050123161633.GH24350@marowsky-bree.de>
	<20050124091006.GA2716@suse.de>
	<20050124095854.GB5638@marowsky-bree.de>
	<20050124102310.GB2716@suse.de>
	<20050124102852.GC5638@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050124102852.GC5638@marowsky-bree.de>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 2005-01-24T11:28:52, Lars Marowsky-Bree <lmb@suse.de> wrote:

> > Make drbd_ee_init() just init the bastard, and add the page in
> > prepare().
> In theory you're right, but drbd seems to use this as a cache and
> allocate the page just once, but fills it with different data of
> different sizes over time, or at least that's what it looks like.
> 
> I'm not sure that's easily fixed.

I couldn't easily and cleanly initialize the io vec in the bio w/o
calling bio_alloc(), as bvec_alloc() can't cleanly be called outside of
fs/bio.c.

So I converted that to use bio_alloc() and bio_put() etc correctly, but
this wonderful beautiful code in drbd_worker.c assumes that every bio it
gets is embedded in a epoch_entry struct and uses the container_of()
macro to convert from the bio to the enclosing struct.

Which of course no longer works if the private_bio is indeed a pointer.
Wonderful.

I've attached the partial patch (which because of that doesn't compile
yet, but shows the general direction of the changes. I've _tried_ not to
mess up the 2.4 compatibility code, but I'm not sure whether I've
succeeded.

I guess another (smaller) option would be to add a bio_init_on_stack()
accompanied by a fitting destructor to fs/bio.c, which would initialize
the bio_io_vec correctly and deallocate it later, but this would change
core kernel code and I wanted to fix this completely in drbd if
possible.

Any comments?


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=drbd-bio

Index: drbd_receiver.c
===================================================================
--- drbd_receiver.c	(revision 1730)
+++ drbd_receiver.c	(working copy)
@@ -163,7 +163,7 @@
 	e = kmem_cache_alloc(drbd_ee_cache, mask);
 	if( e == NULL ) return FALSE;
 
-	drbd_ee_init(e,page);
+	drbd_ee_init(e,page,mask);
 	spin_lock_irq(&mdev->ee_lock);
 	list_add(&e->w.list,&mdev->free_ee);
 	mdev->ee_vacant++;
@@ -202,13 +202,16 @@
 	list_del(le);
 
 	page = drbd_bio_get_page(&e->private_bio);
+	
 ONLY_IN_26(
-	D_ASSERT(page == e->ee_bvec.bv_page);
-	page = e->ee_bvec.bv_page;
+	D_ASSERT(page == e->page);
+	page = e->page;
 )
 	kmem_cache_free(drbd_ee_cache, e);
 	mdev->ee_vacant--;
 
+	bio_put(e->private_bio);
+
 	return page;
 }
 
@@ -334,7 +337,7 @@
 	e=list_entry(le, struct Tl_epoch_entry, w.list);
 ONLY_IN_26(
 	D_ASSERT(e->private_bio.bi_idx == 0);
-	drbd_ee_init(e,e->ee_bvec.bv_page); // reinitialize
+	drbd_ee_init(e,e->page, GFP_KERNEL); // reinitialize
 )
 	e->block_id = !ID_VACANT;
 	SET_MAGIC(e);
@@ -824,7 +827,7 @@
 read_in_block(drbd_dev *mdev, int data_size)
 {
 	struct Tl_epoch_entry *e;
-	drbd_bio_t *bio;
+	struct bio *bio;
 	int rr;
 
 	spin_lock_irq(&mdev->ee_lock);
@@ -869,7 +872,7 @@
 STATIC int recv_dless_read(drbd_dev *mdev, drbd_request_t *req,
 			   sector_t sector, int data_size)
 {
-	drbd_bio_t *bio;
+	struct bio *bio;
 	int ok,rr;
 
 	bio = req->master_bio;
@@ -1603,7 +1606,7 @@
 STATIC void drbd_fail_pending_reads(drbd_dev *mdev)
 {
 	struct list_head *le;
-	drbd_bio_t *bio;
+	struct bio *bio;
 	LIST_HEAD(workset);
 
 	/*
Index: drbd_actlog.c
===================================================================
--- drbd_actlog.c	(revision 1730)
+++ drbd_actlog.c	(working copy)
@@ -64,35 +64,29 @@
 STATIC int _drbd_md_sync_page_io(drbd_dev *mdev, struct page *page, 
 				 sector_t sector, int rw, int size)
 {
-	struct bio bio;
-	struct bio_vec vec;
+	struct bio *bio = bio_alloc(GFP_KERNEL, 1);
 	struct completion event;
 	int ok;
 
-	bio_init(&bio);
-	bio.bi_io_vec = &vec;
-	vec.bv_page = page;
-	vec.bv_offset = 0;
-	vec.bv_len =
-	bio.bi_size = size;
-	bio.bi_vcnt = 1;
-	bio.bi_idx = 0;
-	bio.bi_bdev = mdev->md_bdev;
-	bio.bi_sector = sector;
+	bio_get(bio);
+
+	bio->bi_bdev = mdev->md_bdev;
+	bio->bi_sector = sector;
+	bio_add_page(bio, page, size, 0);
 	init_completion(&event);
-	bio.bi_private = &event;
-	bio.bi_end_io = drbd_md_io_complete;
+	bio->bi_private = &event;
+	bio->bi_end_io = drbd_md_io_complete;
 
 #ifdef BIO_RW_SYNC
-	submit_bio(rw | (1 << BIO_RW_SYNC), &bio);
+	submit_bio(rw | (1 << BIO_RW_SYNC), bio);
 #else
-	submit_bio(rw, &bio);
+	submit_bio(rw, bio);
 	drbd_blk_run_queue(bdev_get_queue(mdev->md_bdev));
 #endif
 	wait_for_completion(&event);
 
-	ok = test_bit(BIO_UPTODATE, &bio.bi_flags);
-
+	ok = test_bit(BIO_UPTODATE, &bio->bi_flags);
+	bio_put(bio);
 	return ok;
 }
 #endif
Index: drbd_compat_wrappers.h
===================================================================
--- drbd_compat_wrappers.h	(revision 1730)
+++ drbd_compat_wrappers.h	(working copy)
@@ -113,7 +113,7 @@
 	bh_kunmap(bh);
 }
 
-static inline void drbd_ee_init(struct Tl_epoch_entry *e,struct page *page)
+static inline void drbd_ee_init(struct Tl_epoch_entry *e,struct page *page,int mask)
 {
 	struct buffer_head * const bh = &e->private_bio;
 	memset(e, 0, sizeof(*e));
@@ -387,7 +387,7 @@
 
 static inline drbd_dev* drbd_req_get_mdev(struct drbd_request *req)
 {
-	return (drbd_dev*) req->private_bio.bi_private;
+	return (drbd_dev*) req->private_bio->bi_private;
 }
 
 static inline sector_t drbd_req_get_sector(struct drbd_request *req)
@@ -397,7 +397,7 @@
 
 static inline unsigned short drbd_req_get_size(struct drbd_request *req)
 {
-	drbd_dev* mdev = req->private_bio.bi_private;
+	drbd_dev* mdev = req->private_bio->bi_private;
 	D_ASSERT(req->master_bio->bi_size);
 	return req->master_bio->bi_size;
 }
@@ -429,11 +429,9 @@
  */
 static inline char *drbd_bio_kmap(struct bio *bio)
 {
-	struct bio_vec *bvec;
+	struct bio_vec *bvec = bio_iovec(bio);
 	unsigned long addr;
 
-	bvec = bio_iovec_idx(bio, bio->bi_idx);
-
 	addr = (unsigned long) kmap(bvec->bv_page);
 
 	if (addr & ~PAGE_MASK)
@@ -444,16 +442,15 @@
 
 static inline void drbd_bio_kunmap(struct bio *bio)
 {
-	struct bio_vec *bvec;
+	struct bio_vec *bvec = bio_iovec(bio);
 
-	bvec = bio_iovec_idx(bio, bio->bi_idx);
 	kunmap(bvec->bv_page);
 }
 
 #else
 static inline char *drbd_bio_kmap(struct bio *bio)
 {
-	struct bio_vec *bvec = bio_iovec_idx(bio, bio->bi_idx);
+	struct bio_vec *bvec = bio_iovec(bio);
 	return page_address(bvec->bv_page) + bvec->bv_offset;
 }
 static inline void drbd_bio_kunmap(struct bio *bio)
@@ -462,21 +459,10 @@
 }
 #endif
 
-static inline void drbd_ee_init(struct Tl_epoch_entry *e,struct page *page)
+static inline void drbd_ee_init(struct Tl_epoch_entry *e,struct page *page,int mask)
 {
-	struct bio * const bio = &e->private_bio;
-	struct bio_vec * const vec = &e->ee_bvec;
-	memset(e, 0, sizeof(*e));
-
-	// bio_init(&bio); memset did it for us.
-	bio->bi_io_vec = vec;
-	vec->bv_page   = page;
-	vec->bv_len    =
-	bio->bi_size   = PAGE_SIZE;
-	bio->bi_max_vecs = 1;
-	bio->bi_destructor = NULL;
-	atomic_set(&bio->bi_cnt, 1);
-
+	e->private_bio = bio_alloc(mask, 1);
+	e->page = page;
 	e->block_id = ID_VACANT;
 }
 
@@ -494,19 +480,15 @@
 drbd_ee_bio_prepare(drbd_dev *mdev, struct Tl_epoch_entry* e,
 		    sector_t sector, int size)
 {
-	struct bio * const bio = &e->private_bio;
+	struct bio *bio = e->private_bio;
 
 	D_ASSERT(mdev->backing_bdev);
 
-	bio->bi_flags  = 1 << BIO_UPTODATE;
-	bio->bi_io_vec->bv_len =
-	bio->bi_size    = size;
 	bio->bi_bdev    = mdev->backing_bdev;
 	bio->bi_sector  = sector;
 	bio->bi_private = mdev;
-	bio->bi_next    = 0;
-	bio->bi_idx     = 0; // for blk_recount_segments
-	bio->bi_vcnt    = 1; // for blk_recount_segments
+	bio_add_page(bio, e->page, size, 0);
+
 	e->ee_sector = sector;
 	e->ee_size = size;
 }
@@ -516,7 +498,7 @@
 		      sector_t sector, int size)
 {
 	drbd_ee_bio_prepare(mdev,e,sector,size);
-	e->private_bio.bi_end_io = drbd_dio_end_sec;
+	e->private_bio->bi_end_io = drbd_dio_end_sec;
 }
 
 static inline void
@@ -524,21 +506,21 @@
 		     sector_t sector, int size)
 {
 	drbd_ee_bio_prepare(mdev,e,sector,size);
-	e->private_bio.bi_end_io = enslaved_read_bi_end_io;
+	e->private_bio->bi_end_io = enslaved_read_bi_end_io;
 }
 
 static inline void
 drbd_req_prepare_write(drbd_dev *mdev, struct drbd_request *req)
 {
-	struct bio * const bio     = &req->private_bio;
+	struct bio * const bio     = req->private_bio;
 	struct bio * const bio_src =  req->master_bio;
 
-	bio_init(bio); // bio->bi_flags   = 0;
+	/* bio_init(bio); // bio->bi_flags   = 0; */
 	__bio_clone(bio,bio_src);
 	bio->bi_bdev    = mdev->backing_bdev;
 	bio->bi_private = mdev;
 	bio->bi_end_io  = drbd_dio_end;
-	bio->bi_next    = 0;
+	bio->bi_next    = NULL;
 
 	req->rq_status = RQ_DRBD_NOTHING;
 }
@@ -546,22 +528,22 @@
 static inline void
 drbd_req_prepare_read(drbd_dev *mdev, struct drbd_request *req)
 {
-	struct bio * const bio     = &req->private_bio;
+	struct bio * const bio     =  req->private_bio;
 	struct bio * const bio_src =  req->master_bio;
 
-	bio_init(bio); // bio->bi_flags   = 0;
+	/* bio_init(bio); // bio->bi_flags   = 0; */
 	__bio_clone(bio,bio_src);
 	bio->bi_bdev    = mdev->backing_bdev;
 	bio->bi_private = mdev;
 	bio->bi_end_io  = drbd_read_bi_end_io;	// <- only difference
-	bio->bi_next    = 0;
+	bio->bi_next    = NULL;
 
 	req->rq_status = RQ_DRBD_NOTHING;
 }
 
 static inline struct page* drbd_bio_get_page(struct bio *bio)
 {
-	struct bio_vec *bvec = bio_iovec_idx(bio, bio->bi_idx);
+	struct bio_vec *bvec = bio_iovec(bio);
 	return bvec->bv_page;
 }
 
@@ -622,13 +604,13 @@
 
 static inline int _drbd_send_zc_bio(drbd_dev *mdev, struct bio *bio)
 {
-	struct bio_vec *bvec = bio_iovec_idx(bio, bio->bi_idx);
+	struct bio_vec *bvec = bio_iovec(bio);
 	return _drbd_send_page(mdev,bvec->bv_page,bvec->bv_offset,bvec->bv_len);
 }
 
 static inline int _drbd_send_bio(drbd_dev *mdev, struct bio *bio)
 {
-	struct bio_vec *bvec = bio_iovec_idx(bio, bio->bi_idx);
+	struct bio_vec *bvec = bio_iovec(bio);
 	struct page *page = bvec->bv_page;
 	size_t size = bvec->bv_len;
 	int offset = bvec->bv_offset;
Index: drbd_int.h
===================================================================
--- drbd_int.h	(revision 1730)
+++ drbd_int.h	(working copy)
@@ -629,7 +629,8 @@
 	int rq_status;
 	struct drbd_barrier *barrier; // The next barrier.
 	drbd_bio_t *master_bio;       // master bio pointer
-	drbd_bio_t private_bio;       // private bio struct
+	NOT_IN_26(drbd_bio_t private_bio;)
+	ONLY_IN_26(struct bio *private_bio;)
 };
 
 struct drbd_barrier {
@@ -664,13 +665,13 @@
  */
 struct Tl_epoch_entry {
 	struct drbd_work    w;
-	drbd_bio_t private_bio; // private bio struct, NOT a pointer
+	NOT_IN_26(drbd_bio_t private_bio;)
+	ONLY_IN_26(struct bio *private_bio;)
+	struct page *page;
 	u64    block_id;
 	long magic;
 	ONLY_IN_26(unsigned int ee_size;)
 	ONLY_IN_26(sector_t ee_sector;)
-	// THINK: maybe we rather want bio_alloc(GFP_*,1)
-	ONLY_IN_26(struct bio_vec ee_bvec;)
 };
 
 /* flag bits */

--ZGiS0Q5IWpPtfppv--
