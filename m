Return-Path: <Thomas.Schoebel-Theuer@1und1.de>
Received: from msxmx04.webde.de (msxmx04.webde.de [217.72.192.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id A8ACA2E08BA0
	for <drbd-dev@lists.linbit.com>; Wed,  1 Oct 2008 11:17:21 +0200 (CEST)
Received: from WEBEXCHANGE.webde.local (webexc03.webde.local [10.2.3.29])
	by msxmx04.webde.de (Postfix) with ESMTP id A01331838E
	for <drbd-dev@lists.linbit.com>; Wed,  1 Oct 2008 11:17:21 +0200 (CEST)
From: "Thomas Schoebel-Theuer" <thomas.schoebel-theuer@1und1.de>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Behaviour of verify: false positives -> true positives
Date: Wed, 1 Oct 2008 11:16:41 +0200
References: <200809091602.31104.thomas.schoebel-theuer@1und1.de>
	<20080911092512.GC9756@soda.linbit> <20080930201016.GB30030@racke>
In-Reply-To: <20080930201016.GB30030@racke>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5/z4IXP6qENs5er"
Message-Id: <200810011116.41804.thomas.schoebel-theuer@1und1.de>
Cc: Michael Ziegel <Michael.Ziegel@1und1.de>,
	Peter Scheitterer <Peter.Scheitterer@1und1.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_5/z4IXP6qENs5er
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Lars,

I have two different patches, both based on your git version from 2008-09-11.

The first one implements the checksumming method while the second one 
implements the copy method proposed by you.

I found that your suggestion was much more easier to implement than the 
checksumming method. However, the copy method works completely silently (you 
get no response whether a race on the data is actually taking place or not), 
while the checksumming method writes reports to the kernel log (so you can 
observe the behavior).

I have also run some performance tests with iozone, but could not find any 
significant difference between any of the patched and unpatched versions 
(and, of course, no difference between the two alternatives). iozone's 
measurements seem to produce "noise" in the range of about 5%. Theoretical 
considerations tell me that both patches should slowdown overall system 
performance by about 1% at most, so I could not figure out anything with my 
single tests (I had no time for running them repeatedly 100 or 1000 times).

Enclosed you will find both patches. They are intended only for _testing_ 
(e.g. performance benchmarks), not for production use. I would be glad if 
someone could report any experience with it, e.g. performance tests (probably 
with better testing tools).

Currently both methods are enabled by a preprocessor constant (just for 
testing). For production use, we should do it right. Since both methods are 
in fact some sort of "paranoia options" (similar to the CRCs already 
present), I would ask whether we should enable/disable them by drbdadm via 
the kernel interface, leading to a new interface revision [oh, as a side 
note, I found that git revision 2008-09-11 crashed with userspace tools 8.2.5 
although the interface revision claimed to be compatible, or did I miss 
something there?].

Should I do the work on the interfaces also, or do you want to integrate it 
yourself to your systematics?

Another issue with the checksumming method: I had problems interfacing with 
the crypto api (probably a wrongly braced kmap/kunmap bug), and it seems that 
different kernel versions do it differently, so I wrote my own small XOR 
checksum algorithm (almost trivial). I'm not sure whether this quick hack is 
really good. And there is some dead code about the crypto API, which I should 
either remove or clean it up (e.g. by moving global_tfm to struct drbd_conf). 
Currently this is all a little hackish, not for production use. Do you have 
any suggestions how to cleanup this in order to meet your style?

Thanks,

Thomas


Am Dienstag, 30. September 2008 22:10:16 schrieb Lars Ellenberg:
> On Thu, Sep 11, 2008 at 11:25:12AM +0200, Lars Ellenberg wrote:
> > On Tue, Sep 09, 2008 at 04:02:30PM +0200, schoebel wrote:
>
> ...
>
> > > Now I am reasoning on different solutions. Please comment.
> > >
> > > Here are just some brainstorming ideas, without judging on their
> > > quality (this will come later):
>
> ...
>
> > how about holding a ring buffer of pinned pages,
> > say "drbd max-buffer" pages plus some,
> > and in drbd_make_request,
> > memcpy(ring buffer, submitted data)
> > then checksum that,
> > and submit it to localdisk as well as to tcp stack.
> > as these are now "private" data buffers,
> > the "application" cannot possibly modify them in-flight.
>
> have you made any progress on that matter?
>
> shall we further discuss whether or not it should be "fixed" (in drbd),
> and if so, how?
>
> or have you decided to just move a long?



--Boundary-00=_5/z4IXP6qENs5er
Content-Type: text/x-diff; charset="iso 8859-15";
	name="drbd-8.2-checksum.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="drbd-8.2-checksum.patch"

diff --git a/drbd/drbd_int.h b/drbd/drbd_int.h
index 0281a46..77dc26b 100644
--- a/drbd/drbd_int.h
+++ b/drbd/drbd_int.h
@@ -99,6 +99,17 @@ extern char usermode_helper[];
 #define FALSE 0
 #endif
 
+#define VERIFY_HACK
+
+#ifdef VERIFY_HACK
+#define CRC_SIZE 16
+int drbd_checksum_bio(struct bio *bio, u8 * res);
+int drbd_checksum_loadalg(char * algname);
+void drbd_checksum_unloadalg(void);
+struct drbd_conf;
+void _restart_requests(struct drbd_conf * mdev);
+#endif
+
 /* I don't remember why XCPU ...
  * This is used to wake the asender,
  * and to interrupt sending the sending task
@@ -678,6 +689,9 @@ struct drbd_request {
 	unsigned long rq_state; /* see comments above _req_mod() */
 	int seq_num;
 	unsigned long start_time;
+#ifdef VERIFY_HACK
+	u8 checksum[CRC_SIZE];
+#endif
 };
 
 struct drbd_barrier {
@@ -1000,6 +1014,11 @@ struct drbd_conf {
 	struct bm_io_work bm_io_work;
 	u64 ed_uuid; /* UUID of the exposed data */
 	struct mutex state_mutex;
+#ifdef VERIFY_HACK
+#define RESTART_MAX 8
+	int restart_head, restart_tail, restart_count;
+	struct bio * restart[RESTART_MAX];
+#endif
 };
 
 static inline struct drbd_conf *minor_to_mdev(unsigned int minor)
diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index dde171e..b7bde61 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -2838,6 +2838,10 @@ STATIC void drbd_cleanup(void)
 
 	drbd_unregister_blkdev(DRBD_MAJOR, "drbd");
 
+#ifdef VERIFY_HACK
+	drbd_checksum_unloadalg();
+#endif
+
 	printk(KERN_INFO "drbd: module cleanup done.\n");
 }
 
@@ -2997,6 +3001,12 @@ int __init drbd_init(void)
 		DRBD_MAJOR);
 	printk(KERN_INFO "drbd: minor_table @ 0x%p\n", minor_table);
 
+#ifdef VERIFY_HACK
+	if(drbd_checksum_loadalg("md5")) {
+	    printk(KERN_INFO "drbd: loading checksum algorithm module failed\n");
+	}
+#endif
+
 	return 0; /* Success! */
 
 Enomem:
diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 8ca228c..831dec9 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -3685,6 +3685,9 @@ STATIC int got_BlockAck(struct drbd_conf *mdev, struct Drbd_Header *h)
 			D_ASSERT(0);
 		}
 		spin_unlock_irq(&mdev->req_lock);
+#ifdef VERIFY_HACK
+		_restart_requests(mdev);
+#endif
 	}
 	/* dec_ap_pending is handled within _req_mod */
 
diff --git a/drbd/drbd_req.c b/drbd/drbd_req.c
index e198a03..53ab136 100644
--- a/drbd/drbd_req.c
+++ b/drbd/drbd_req.c
@@ -93,6 +93,142 @@ STATIC void _print_req_mod(struct drbd_request *req, enum drbd_req_event what)
 	INFO("_req_mod(%p %c ,%s)\n", req, rw, rq_event_names[what]);
 }
 
+#ifdef VERIFY_HACK
+
+#include <linux/crypto.h>
+
+STATIC int drbd_make_request_common(struct drbd_conf *mdev, struct bio *bio);
+
+static struct crypto_hash * global_tfm = NULL;
+
+/* Separation between allocation and usage of crypto descriptors.
+ * This is necessary because crypto_alloc_*() can call schedule().
+ */
+int drbd_checksum_loadalg(char * algname)
+{
+	int digestsize;
+	global_tfm = crypto_alloc_hash(algname, 0, CRYPTO_ALG_ASYNC);
+	if(IS_ERR(global_tfm)) {
+		printk("Aha algorithm=%s error\n", algname);
+		return -1;
+	}
+	digestsize = crypto_hash_digestsize(global_tfm);
+	if(digestsize > CRC_SIZE || CRC_SIZE != 2*(sizeof(long long))) {
+		printk("Aha digestsize=%d reslen=%d\n", digestsize, CRC_SIZE);
+		return -1;
+	}
+	printk(KERN_INFO "drbd_checksum_loadalg OK\n");
+	return 0;
+}
+
+void drbd_checksum_unloadalg(void)
+{
+	crypto_free_hash(global_tfm);
+	global_tfm = NULL;
+}
+
+/* A backwards iterator is missing in <linux/bio.h>.
+ * We need it for correct nesting of bvec_bmap_irq / unmap pairs.
+ */
+#define __bio_for_each_segment_back(bvl, bio, i, start_idx)		\
+	for (bvl = bio_iovec_idx((bio), (start_idx)+(bio)->bi_vcnt-1), i = (start_idx+(bio)->bi_vcnt-1);	\
+	     i >= (start_idx);						\
+	     bvl--, i--)
+
+#define bio_for_each_segment_back(bvl, bio, i)				\
+	__bio_for_each_segment_back(bvl, bio, i, (bio)->bi_idx)
+
+static void dummy_checksum(void * data, int len, long long res[])
+{
+	register long long val0 = res[0];
+	register long long val1 = res[1];
+	long long * _data = data;
+	while(len > 0) {
+		val0 ^= *_data++;
+		val1 ^= *_data++;
+		len -= 2*sizeof(val0);
+	}
+	res[0] = val0;
+	res[1] = val1;
+}
+
+int drbd_checksum_bio(struct bio *bio, u8 * res)
+{
+	int err = -1;
+	struct hash_desc desc;
+	int count;
+	
+	if(!global_tfm)
+		return -1;
+
+	desc.flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+	desc.tfm = global_tfm;
+
+	memset(res, 0, CRC_SIZE);
+
+	count = bio->bi_vcnt;
+	{
+		void *data[count];
+		unsigned long flags[count];
+		struct scatterlist sg[count];
+		struct bio_vec * bv;
+		int nbytes = 0;
+		int i;
+		int j;
+		sg_init_table(sg, count);
+		
+		j = 0;
+		bio_for_each_segment(bv, bio, i) {
+			data[j] = bvec_kmap_irq(bv, &flags[j]);
+			nbytes += bv->bv_len;
+			dummy_checksum(data[j], bv->bv_len, (long long*)res);
+			sg_set_buf(&sg[j], data[j], bv->bv_len);
+			bvec_kunmap_irq(data[j], &flags[j]);
+			j++;
+		}
+#if 0		
+		if(crypto_hash_init(&desc))
+			goto out;
+		if(crypto_hash_update(&desc, sg, nbytes))
+			goto out;
+		if(crypto_hash_final(&desc, res))
+			goto out;
+		bio_for_each_segment_back(bv, bio, i) {
+			j--;
+		}
+#endif		
+	}
+	err = 0;
+#if 0	
+out:
+#endif
+	return err;
+}
+
+void _restart_requests(struct drbd_conf * mdev)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&mdev->req_lock, flags);
+	while(mdev->restart_count > 0) {
+		struct bio * master_bio;
+		int restart_count = mdev->restart_count;
+		master_bio = mdev->restart[mdev->restart_head];
+		mdev->restart_head = (mdev->restart_head+1) % RESTART_MAX;
+		mdev->restart_count--;
+		if(master_bio) {
+			spin_unlock_irqrestore(&mdev->req_lock, flags);
+			INFO("restarting block=%ld (count=%d)\n", master_bio->bi_sector, restart_count);
+			drbd_make_request_common(mdev, master_bio);
+			spin_lock_irqsave(&mdev->req_lock, flags);
+		}
+	}
+	spin_unlock_irqrestore(&mdev->req_lock, flags);
+}
+
+
+#endif
+
+
 # ifdef ENABLE_DYNAMIC_TRACE
 #  define print_rq_state(R, T) \
 	MTRACE(TraceTypeRq, TraceLvlMetrics, _print_rq_state(R, T);)
@@ -381,6 +517,35 @@ void _req_may_be_done(struct drbd_request *req, int error)
 		/* Update disk stats */
 		_drbd_end_io_acct(mdev, req);
 
+#ifdef VERIFY_HACK
+		int restart = 0;
+		if(ok && rw == WRITE) {
+			u8 checksum[CRC_SIZE];
+			int err;
+			//INFO("checksumming %ld\n", req->master_bio->bi_sector);
+			err = drbd_checksum_bio(req->master_bio, checksum);
+			if(!err) {
+				err = memcmp(req->checksum, checksum, sizeof(checksum));
+			}
+			if(err) {
+				INFO("bio checksum mismatch block=%ld\n", req->master_bio->bi_sector);
+				restart = 1;
+			}
+		}
+		if(restart) {
+			if(mdev->restart_count <= RESTART_MAX) {
+				INFO("queuing block=%ld for restart (count=%d)\n", req->master_bio->bi_sector, mdev->restart_count);
+				mdev->restart[mdev->restart_tail] = req->master_bio;
+				mdev->restart_tail = (mdev->restart_tail+1) % RESTART_MAX;
+				mdev->restart_count++;
+				req->master_bio = NULL;
+			} else {
+				INFO("Aieee, queue buffer is full (block=%ld)\n", req->master_bio->bi_sector);
+				restart = 0;
+			}
+		}
+		if(!restart)
+#endif
 		_complete_master_bio(mdev,req,
 				     ok ? 0 : ( error ? error : -EIO ) );
 	} else {
@@ -887,6 +1052,11 @@ STATIC int drbd_make_request_common(struct drbd_conf *mdev, struct bio *bio)
 	}
 	if (rw == WRITE) {
 		remote = 1;
+#ifdef VERIFY_HACK
+		if(drbd_checksum_bio(bio, req->checksum)) {
+			ERR("error in checksumming algorithm\n");
+		}
+#endif
 	} else {
 		/* READ || READA */
 		if (local) {
diff --git a/drbd/drbd_worker.c b/drbd/drbd_worker.c
index aff97cc..fe69dd2 100644
--- a/drbd/drbd_worker.c
+++ b/drbd/drbd_worker.c
@@ -247,6 +247,9 @@ BIO_ENDIO_TYPE drbd_endio_pri BIO_ENDIO_ARGS(struct bio *bio, int error)
 	spin_lock_irqsave(&mdev->req_lock, flags);
 	_req_mod(req, what, error);
 	spin_unlock_irqrestore(&mdev->req_lock, flags);
+#ifdef VERIFY_HACK
+	_restart_requests(mdev);
+#endif
 
 	BIO_ENDIO_FN_RETURN;
 }

--Boundary-00=_5/z4IXP6qENs5er
Content-Type: text/x-diff; charset="iso 8859-15"; name="drbd-8.2-copy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="drbd-8.2-copy.patch"

diff --git a/drbd/drbd_int.h b/drbd/drbd_int.h
index 0281a46..c61856e 100644
--- a/drbd/drbd_int.h
+++ b/drbd/drbd_int.h
@@ -40,6 +40,17 @@
 #include <net/tcp.h>
 #include "lru_cache.h"
 
+#define COPY_HACK
+
+#ifdef COPY_HACK
+struct drbd_conf;
+struct page *drbd_pp_alloc(struct drbd_conf *mdev, gfp_t gfp_mask);
+void drbd_pp_free(struct drbd_conf *mdev, struct page *page);
+struct drbd_request;
+void drbd_page_copy(struct drbd_conf *mdev, struct drbd_request *req, struct bio *bio);
+void drbd_page_free(struct drbd_conf *mdev, struct drbd_request *req);
+#endif
+
 #ifdef __CHECKER__
 # define __protected_by(x)       __attribute__((require_context(x,1,999,"rdwr")))
 # define __protected_read_by(x)  __attribute__((require_context(x,1,999,"read")))
@@ -678,6 +689,9 @@ struct drbd_request {
 	unsigned long rq_state; /* see comments above _req_mod() */
 	int seq_num;
 	unsigned long start_time;
+#ifdef COPY_HACK
+        struct page * copy_page;
+#endif
 };
 
 struct drbd_barrier {
diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index dde171e..bd8e2dc 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -2665,7 +2665,6 @@ STATIC void drbd_destroy_mempools(void)
 	drbd_request_mempool = NULL;
 	drbd_ee_cache        = NULL;
 	drbd_request_cache   = NULL;
-
 	return;
 }
 
diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 8ca228c..88d1103 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -92,7 +92,7 @@ void drbd_assert_breakpoint(struct drbd_conf *mdev, char *exp,
 /**
  * drbd_bp_alloc: Returns a page. Fails only if a signal comes in.
  */
-STATIC struct page *drbd_pp_alloc(struct drbd_conf *mdev, gfp_t gfp_mask)
+struct page *drbd_pp_alloc(struct drbd_conf *mdev, gfp_t gfp_mask)
 {
 	unsigned long flags = 0;
 	struct page *page;
@@ -167,7 +167,7 @@ STATIC struct page *drbd_pp_alloc(struct drbd_conf *mdev, gfp_t gfp_mask)
 	return page;
 }
 
-STATIC void drbd_pp_free(struct drbd_conf *mdev, struct page *page)
+void drbd_pp_free(struct drbd_conf *mdev, struct page *page)
 {
 	unsigned long flags = 0;
 	int free_it;
diff --git a/drbd/drbd_req.c b/drbd/drbd_req.c
index e198a03..2d25450 100644
--- a/drbd/drbd_req.c
+++ b/drbd/drbd_req.c
@@ -839,6 +839,39 @@ STATIC int drbd_may_do_local_read(struct drbd_conf *mdev, sector_t sector, int s
 	return (0 == drbd_bm_count_bits(mdev, sbnr, ebnr));
 }
 
+#ifdef COPY_HACK
+void drbd_page_copy(struct drbd_conf *mdev, struct drbd_request *req, struct bio *bio)
+{
+	struct bio_vec *bvec;
+        int i;
+	bio_for_each_segment(bvec, bio, i) {
+                struct page *dst_page = drbd_pp_alloc(mdev, GFP_KERNEL);
+                struct page *src_page = bvec->bv_page;
+                void *dst = kmap(dst_page);
+                void *src = kmap(src_page);
+                set_page_private(dst_page, (unsigned long)req->copy_page);
+                req->copy_page = dst_page;
+                memcpy(dst, src, PAGE_SIZE);
+#if 1
+                bvec->bv_page = dst_page;
+#endif
+                kunmap(src_page);
+                kunmap(dst_page);
+        }        
+}
+
+void drbd_page_free(struct drbd_conf *mdev, struct drbd_request *req)
+{
+        struct page * free;
+        while((free = req->copy_page)) {
+                req->copy_page = (struct page *)page_private(free);
+                set_page_private(free, (unsigned long)NULL);
+                drbd_pp_free(mdev, free);
+        }
+}
+
+#endif
+
 /*
  * general note:
  * looking at the state (conn, disk, susp, pdsk) outside of the spinlock that
@@ -887,6 +920,11 @@ STATIC int drbd_make_request_common(struct drbd_conf *mdev, struct bio *bio)
 	}
 	if (rw == WRITE) {
 		remote = 1;
+#ifdef COPY_HACK
+                if(req->private_bio) {
+                        drbd_page_copy(mdev, req, req->private_bio);
+                }
+#endif
 	} else {
 		/* READ || READA */
 		if (local) {
diff --git a/drbd/drbd_req.h b/drbd/drbd_req.h
index 2c67f09..04c8556 100644
--- a/drbd/drbd_req.h
+++ b/drbd/drbd_req.h
@@ -294,6 +294,9 @@ static inline struct drbd_request *drbd_req_new(struct drbd_conf *mdev,
 		req->sector      = bio->bi_sector;
 		req->size        = bio->bi_size;
 		req->start_time  = jiffies;
+#ifdef COPY_HACK
+                req->copy_page = NULL;
+#endif
 		INIT_HLIST_NODE(&req->colision);
 		INIT_LIST_HEAD(&req->tl_requests);
 
@@ -306,6 +309,10 @@ static inline struct drbd_request *drbd_req_new(struct drbd_conf *mdev,
 
 static inline void drbd_req_free(struct drbd_request *req)
 {
+#ifdef COPY_HACK
+        if(req->mdev)
+                drbd_page_free(req->mdev, req);
+#endif
 	mempool_free(req, drbd_request_mempool);
 }
 

--Boundary-00=_5/z4IXP6qENs5er--
