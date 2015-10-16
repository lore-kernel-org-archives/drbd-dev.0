Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7BB7F10003FC
	for <drbd-dev@lists.linbit.com>; Fri, 16 Oct 2015 10:13:40 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Fri, 16 Oct 2015 16:13:15 +0800
Message-Id: <1444983195-12439-1-git-send-email-nwang@suse.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, linux-kernel@vger.kernel.org
Subject: [Drbd-dev] [PATCH] fix failure with new bi_error field of bio
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

drbd fail to build with new bio structure and interface
after 4.3.0, see 4246a0b63bd8f56a1469b12eafeb875b1041a451
A new bi_error field to store an errno value directly in
struct bio and remove the existing mechanisms to clean
all this up.

With 8ae126660fddbeebb9251a174e6fa45b6ad8f932,
generic_make_request() is now able to handle arbitrarily
sized bios,it's no longer need to define its merge_bvec_fn.

This patch delete merge_bvec_fn and support new bio struct. 

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org
---
 drbd/drbd_actlog.c   |   4 ++
 drbd/drbd_bitmap.c   |  46 +++++++++++++++++++++
 drbd/drbd_int.h      |   2 +
 drbd/drbd_main.c     |   2 +
 drbd/drbd_req.c      |   4 +-
 drbd/drbd_worker.c   | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++
 drbd/drbd_wrappers.h |  31 +++++++++++++-
 7 files changed, 201 insertions(+), 2 deletions(-)

diff --git a/drbd/drbd_actlog.c b/drbd/drbd_actlog.c
index 1a274c5..c73bb32 100644
--- a/drbd/drbd_actlog.c
+++ b/drbd/drbd_actlog.c
@@ -184,7 +184,11 @@ static int _drbd_md_sync_page_io(struct drbd_device *device,
 	else
 		submit_bio(rw, bio);
 	wait_until_done_or_force_detached(device, bdev, &device->md_io.done);
+#ifdef NO_ERROR_BIO_END_IO
+	if (bio->bi_error)
+#else
 	if (bio_flagged(bio, BIO_UPTODATE))
+#endif
 		err = device->md_io.error;
 
 #ifndef REQ_FLUSH
diff --git a/drbd/drbd_bitmap.c b/drbd/drbd_bitmap.c
index abf1bc1..2e16bc8 100644
--- a/drbd/drbd_bitmap.c
+++ b/drbd/drbd_bitmap.c
@@ -960,6 +960,51 @@ static void drbd_bm_aio_ctx_destroy(struct kref *kref)
 }
 
 /* bv_page may be a copy, or may be the original */
+#ifdef NO_ERROR_BIO_END_IO
+static BIO_ENDIO_TYPE drbd_bm_endio BIO_ENDIO_ARGS(struct bio *bio)
+{
+	struct drbd_bm_aio_ctx *ctx = bio->bi_private;
+	struct drbd_device *device = ctx->device;
+	struct drbd_bitmap *b = device->bitmap;
+	unsigned int idx = bm_page_to_idx(bio->bi_io_vec[0].bv_page);
+
+	BIO_ENDIO_FN_START;
+
+	if ((ctx->flags & BM_AIO_COPY_PAGES) == 0 &&
+	    !bm_test_page_unchanged(b->bm_pages[idx]))
+		drbd_warn(device, "bitmap page idx %u changed during IO!\n", idx);
+
+	if (bio->bi_error) {
+		/* ctx error will hold the completed-last non-zero error code,
+		 * in case error codes differ. */
+		ctx->error = bio->bi_error;
+		bm_set_page_io_err(b->bm_pages[idx]);
+		/* Not identical to on disk version of it.
+		 * Is BM_PAGE_IO_ERROR enough? */
+		if (DRBD_ratelimit(5*HZ, 5))
+			drbd_err(device, "IO ERROR %d on bitmap page idx %u\n",
+					bio->bi_error, idx);
+	} else {
+		bm_clear_page_io_err(b->bm_pages[idx]);
+		dynamic_drbd_dbg(device, "bitmap page idx %u completed\n", idx);
+	}
+
+	bm_page_unlock_io(device, idx);
+
+	if (ctx->flags & BM_AIO_COPY_PAGES)
+		mempool_free(bio->bi_io_vec[0].bv_page, drbd_md_io_page_pool);
+
+	bio_put(bio);
+
+	if (atomic_dec_and_test(&ctx->in_flight)) {
+		ctx->done = 1;
+		wake_up(&device->misc_wait);
+		kref_put(&ctx->kref, &drbd_bm_aio_ctx_destroy);
+	}
+
+	BIO_ENDIO_FN_RETURN;
+}
+#else
 static BIO_ENDIO_TYPE drbd_bm_endio BIO_ENDIO_ARGS(struct bio *bio, int error)
 {
 	struct drbd_bm_aio_ctx *ctx = bio->bi_private;
@@ -1011,6 +1056,7 @@ static BIO_ENDIO_TYPE drbd_bm_endio BIO_ENDIO_ARGS(struct bio *bio, int error)
 
 	BIO_ENDIO_FN_RETURN;
 }
+#endif
 
 static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_hold(local)
 {
diff --git a/drbd/drbd_int.h b/drbd/drbd_int.h
index d1e2bc0..bed73cc 100644
--- a/drbd/drbd_int.h
+++ b/drbd/drbd_int.h
@@ -1563,6 +1563,7 @@ extern void do_submit(struct work_struct *ws);
 extern void __drbd_make_request(struct drbd_device *, struct bio *, unsigned long);
 extern MAKE_REQUEST_TYPE drbd_make_request(struct request_queue *q, struct bio *bio);
 extern int drbd_read_remote(struct drbd_device *device, struct drbd_request *req);
+#ifndef NO_ERROR_BIO_END_IO
 extern int drbd_merge_bvec(struct request_queue *q,
 #ifdef HAVE_bvec_merge_data
 		struct bvec_merge_data *bvm,
@@ -1570,6 +1571,7 @@ extern int drbd_merge_bvec(struct request_queue *q,
 		struct bio *bvm,
 #endif
 		struct bio_vec *bvec);
+#endif
 extern int is_valid_ar_handle(struct drbd_request *, sector_t);
 
 
diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index 31bf43f..6171714 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -2855,7 +2855,9 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	   This triggers a max_bio_size message upon first attach or connect */
 	blk_queue_max_hw_sectors(q, DRBD_MAX_BIO_SIZE_SAFE >> 8);
 	blk_queue_bounce_limit(q, BLK_BOUNCE_ANY);
+#ifndef NO_ERROR_BIO_END_IO
 	blk_queue_merge_bvec(q, drbd_merge_bvec);
+#endif
 	q->queue_lock = &resource->req_lock;
 #ifdef blk_queue_plugged
 		/* plugging on a queue, that actually has no requests! */
diff --git a/drbd/drbd_req.c b/drbd/drbd_req.c
index 305fe71..e7b1b14 100644
--- a/drbd/drbd_req.c
+++ b/drbd/drbd_req.c
@@ -1573,6 +1573,7 @@ MAKE_REQUEST_TYPE drbd_make_request(struct request_queue *q, struct bio *bio)
  * As long as the BIO is empty we have to allow at least one bvec,
  * regardless of size and offset, so no need to ask lower levels.
  */
+#ifndef NO_ERROR_BIO_END_IO
 #ifdef HAVE_bvec_merge_data
 int drbd_merge_bvec(struct request_queue *q,
 		struct bvec_merge_data *bvm,
@@ -1604,7 +1605,7 @@ int drbd_merge_bvec(struct request_queue *q,
 		struct bio_vec *bvec)
 {
 	struct drbd_device *device = (struct drbd_device *) q->queuedata;
-	unsigned int bio_size = bvm->bi_size;
+	unsigned int bio_size = bvm->bi_iter.bi_size;
 	int limit = DRBD_MAX_BIO_SIZE;
 	int backing_limit;
 
@@ -1626,6 +1627,7 @@ int drbd_merge_bvec(struct request_queue *q,
 	return limit;
 }
 #endif
+#endif /* END NO_ERROR_BIO_END_IO*/
 
 static bool net_timeout_reached(struct drbd_request *net_req,
 		struct drbd_connection *connection,
diff --git a/drbd/drbd_worker.c b/drbd/drbd_worker.c
index 2a15aeb..391237e 100644
--- a/drbd/drbd_worker.c
+++ b/drbd/drbd_worker.c
@@ -58,14 +58,22 @@ static int make_resync_request(struct drbd_device *, int);
 /* used for synchronous meta data and bitmap IO
  * submitted by drbd_md_sync_page_io()
  */
+#ifdef NO_ERROR_BIO_END_IO
+BIO_ENDIO_TYPE drbd_md_endio BIO_ENDIO_ARGS(struct bio *bio)
+#else
 BIO_ENDIO_TYPE drbd_md_endio BIO_ENDIO_ARGS(struct bio *bio, int error)
+#endif
 {
 	struct drbd_device *device;
 
 	BIO_ENDIO_FN_START;
 
 	device = bio->bi_private;
+#ifdef NO_ERROR_BIO_END_IO
+	device->md_io.error = bio->bi_error;
+#else
 	device->md_io.error = error;
+#endif
 
 	/* We grabbed an extra reference in _drbd_md_sync_page_io() to be able
 	 * to timeout on the lower level device, and eventually detach from it.
@@ -194,6 +202,34 @@ void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req) __releases(l
 /* writes on behalf of the partner, or resync writes,
  * "submitted" by the receiver.
  */
+#ifdef NO_ERROR_BIO_END_IO
+BIO_ENDIO_TYPE drbd_peer_request_endio BIO_ENDIO_ARGS(struct bio *bio)
+{
+	struct drbd_peer_request *peer_req = bio->bi_private;
+	struct drbd_device *device = peer_req->peer_device->device;
+	int is_write = bio_data_dir(bio) == WRITE;
+	int is_discard = !!(bio->bi_rw & DRBD_REQ_DISCARD);
+
+	BIO_ENDIO_FN_START;
+	if (bio->bi_error && DRBD_ratelimit(5*HZ, 5))
+		drbd_warn(device, "%s: error=%d s=%llus\n",
+				is_write ? (is_discard ? "discard" : "write")
+					: "read", bio->bi_error,
+				(unsigned long long)peer_req->i.sector);
+
+	if (bio->bi_error)
+		set_bit(__EE_WAS_ERROR, &peer_req->flags);
+
+	bio_put(bio); /* no need for the bio anymore */
+	if (atomic_dec_and_test(&peer_req->pending_bios)) {
+		if (is_write)
+			drbd_endio_write_sec_final(peer_req);
+		else
+			drbd_endio_read_sec_final(peer_req);
+	}
+	BIO_ENDIO_FN_RETURN;
+}
+#else
 BIO_ENDIO_TYPE drbd_peer_request_endio BIO_ENDIO_ARGS(struct bio *bio, int error)
 {
 	struct drbd_peer_request *peer_req = bio->bi_private;
@@ -231,6 +267,7 @@ BIO_ENDIO_TYPE drbd_peer_request_endio BIO_ENDIO_ARGS(struct bio *bio, int error
 	}
 	BIO_ENDIO_FN_RETURN;
 }
+#endif
 
 void drbd_panic_after_delayed_completion_of_aborted_request(struct drbd_device *device)
 {
@@ -240,6 +277,82 @@ void drbd_panic_after_delayed_completion_of_aborted_request(struct drbd_device *
 
 /* read, readA or write requests on R_PRIMARY coming from drbd_make_request
  */
+#ifdef NO_ERROR_BIO_END_IO
+BIO_ENDIO_TYPE drbd_request_endio BIO_ENDIO_ARGS(struct bio *bio)
+{
+	unsigned long flags;
+	struct drbd_request *req = bio->bi_private;
+	struct drbd_device *device = req->device;
+	struct bio_and_error m;
+	enum drbd_req_event what;
+
+	BIO_ENDIO_FN_START;
+
+	/* If this request was aborted locally before,
+	 * but now was completed "successfully",
+	 * chances are that this caused arbitrary data corruption.
+	 *
+	 * "aborting" requests, or force-detaching the disk, is intended for
+	 * completely blocked/hung local backing devices which do no longer
+	 * complete requests at all, not even do error completions.  In this
+	 * situation, usually a hard-reset and failover is the only way out.
+	 *
+	 * By "aborting", basically faking a local error-completion,
+	 * we allow for a more graceful swichover by cleanly migrating services.
+	 * Still the affected node has to be rebooted "soon".
+	 *
+	 * By completing these requests, we allow the upper layers to re-use
+	 * the associated data pages.
+	 *
+	 * If later the local backing device "recovers", and now DMAs some data
+	 * from disk into the original request pages, in the best case it will
+	 * just put random data into unused pages; but typically it will corrupt
+	 * meanwhile completely unrelated data, causing all sorts of damage.
+	 *
+	 * Which means delayed successful completion,
+	 * especially for READ requests,
+	 * is a reason to panic().
+	 *
+	 * We assume that a delayed *error* completion is OK,
+	 * though we still will complain noisily about it.
+	 */
+	if (unlikely(req->rq_state & RQ_LOCAL_ABORTED)) {
+		if (DRBD_ratelimit(5*HZ, 5))
+			drbd_emerg(device, "delayed completion of aborted local request; disk-timeout may be too aggressive\n");
+
+		if (!bio->bi_error)
+			drbd_panic_after_delayed_completion_of_aborted_request(device);
+	}
+
+	/* to avoid recursion in __req_mod */
+	if (unlikely(bio->bi_error)) {
+		if (bio->bi_rw & DRBD_REQ_DISCARD)
+			what = (bio->bi_error == -EOPNOTSUPP)
+				? DISCARD_COMPLETED_NOTSUPP
+				: DISCARD_COMPLETED_WITH_ERROR;
+		else
+			what = (bio_data_dir(bio) == WRITE)
+			? WRITE_COMPLETED_WITH_ERROR
+			: (bio_rw(bio) == READ)
+			  ? READ_COMPLETED_WITH_ERROR
+			  : READ_AHEAD_COMPLETED_WITH_ERROR;
+	} else
+		what = COMPLETED_OK;
+
+	bio_put(req->private_bio);
+	req->private_bio = ERR_PTR(bio->bi_error);
+
+	/* not req_mod(), we need irqsave here! */
+	spin_lock_irqsave(&device->resource->req_lock, flags);
+	__req_mod(req, what, &m);
+	spin_unlock_irqrestore(&device->resource->req_lock, flags);
+	put_ldev(device);
+
+	if (m.bio)
+		complete_master_bio(device, &m);
+	BIO_ENDIO_FN_RETURN;
+}
+#else
 BIO_ENDIO_TYPE drbd_request_endio BIO_ENDIO_ARGS(struct bio *bio, int error)
 {
 	unsigned long flags;
@@ -324,6 +437,7 @@ BIO_ENDIO_TYPE drbd_request_endio BIO_ENDIO_ARGS(struct bio *bio, int error)
 		complete_master_bio(device, &m);
 	BIO_ENDIO_FN_RETURN;
 }
+#endif
 
 void drbd_csum_ee(struct crypto_hash *tfm, struct drbd_peer_request *peer_req, void *digest)
 {
diff --git a/drbd/drbd_wrappers.h b/drbd/drbd_wrappers.h
index d7a4138..c9ccb93 100644
--- a/drbd/drbd_wrappers.h
+++ b/drbd/drbd_wrappers.h
@@ -195,16 +195,38 @@ static inline int drbd_blkdev_put(struct block_device *bdev, fmode_t mode)
 #define BIO_ENDIO_FN_START if (bio->bi_size) return 1
 #define BIO_ENDIO_FN_RETURN return 0
 #else
+ #if LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)
+ /* After Linux-4.3 a new bi_error field to store an errno value in struct bio.
+    See 4246a0b63bd8f56a1469b12eafeb875b1041a451 */
+	#define bio_endio(B,E)				\
+    do {                                \
+		(B)->bi_error = (E);			\
+		bio_endio(B);					\
+    } while (0)
+	#define BIO_ENDIO_ARGS(b) (b)
+ #else
+	#define BIO_ENDIO_ARGS(b,e) (b,e)
+ #endif
 #define BIO_ENDIO_TYPE void
-#define BIO_ENDIO_ARGS(b,e) (b,e)
 #define BIO_ENDIO_FN_START do {} while (0)
 #define BIO_ENDIO_FN_RETURN return
 #endif
 
 /* bi_end_io handlers */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)
+#undef NO_ERROR_BIO_END_IO
+#define NO_ERROR_BIO_END_IO 1
+#endif
+
+#ifdef NO_ERROR_BIO_END_IO
+extern BIO_ENDIO_TYPE drbd_md_endio BIO_ENDIO_ARGS(struct bio *bio);
+extern BIO_ENDIO_TYPE drbd_peer_request_endio BIO_ENDIO_ARGS(struct bio *bio);
+extern BIO_ENDIO_TYPE drbd_request_endio BIO_ENDIO_ARGS(struct bio *bio);
+#else
 extern BIO_ENDIO_TYPE drbd_md_endio BIO_ENDIO_ARGS(struct bio *bio, int error);
 extern BIO_ENDIO_TYPE drbd_peer_request_endio BIO_ENDIO_ARGS(struct bio *bio, int error);
 extern BIO_ENDIO_TYPE drbd_request_endio BIO_ENDIO_ARGS(struct bio *bio, int error);
+#endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
 #define part_inc_in_flight(A, B) part_inc_in_flight(A)
@@ -222,6 +244,13 @@ extern BIO_ENDIO_TYPE drbd_request_endio BIO_ENDIO_ARGS(struct bio *bio, int err
 # define HAVE_bvec_merge_data 1
 #endif
 
+/* After 4.3.0 (with 8ae126660fddbeebb9251a174e6fa45b6ad8f932)
+   bvec_merge_data was killed. */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)
+# undef HAVE_bvec_merge_data
+#endif
+
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,24)
 static inline void sg_set_page(struct scatterlist *sg, struct page *page,
 			       unsigned int len, unsigned int offset)
-- 
2.1.4

