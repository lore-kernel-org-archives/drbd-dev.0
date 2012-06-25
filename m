Return-Path: <lars.ellenberg@linbit.com>
Date: Mon, 25 Jun 2012 12:56:40 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-user@lists.linbit.com, drbd-dev@lists.linbit.com
Message-ID: <20120625105640.GD25597@soda.linbit>
References: <4FE0A0F5.9070001@macprofessionals.com>
	<4FE4A54D.2080006@macprofessionals.com>
	<s9u62ajrzti.fsf@qrclab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s9u62ajrzti.fsf@qrclab.com>
Subject: Re: [Drbd-dev] [DRBD-user] DRBD fsync() seems to return before
	writing to disk
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Jun 22, 2012 at 02:01:13PM -0400, Matteo Frigo wrote:
> Phil Frost writes:


Sorry, we have been busy last week, and not been able to react properly
on the more interesting threads.

> 
> > Unfortunately, I don't feel very qualified in this area, so can anyone
> > tell me if I'm totally off base here? Any suggestions on how I might
> > test this?
> 
> I don't know much about the kernel myself, but your post suggested a
> fix.  I applied the patch below to linux-3.4.1 and this patch appears to
> fix the problem.  Specifically, fsync() is too fast before the patch,
> and it runs at non-drbd speed after the patch.
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 211fc44..96e400b 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -3413,6 +3413,7 @@ struct drbd_conf *drbd_new_device(unsigned int minor)
>  	set_disk_ro(disk, true);
>  
>  	disk->queue = q;
> +	blk_queue_flush(disk->queue, REQ_FLUSH | REQ_FUA);
>  	disk->major = DRBD_MAJOR;
>  	disk->first_minor = minor;
>  	disk->fops = &drbd_ops;

Basically you are correct, yes,
this is part of what is needed to expose FLUSH/FUA
to upper layers/file systems.

But. This alone...

... it will crash the kernel ...



DRBD as of now, does not expose FLUSH/FUA to upper layers, so whatever
upper layers do, generic_maker_request() will strip away these flags,
and the full stack from DRBD and below down to the hardware will no
longer even see these flags.

I'm preparing a patch that will enable the use and pass through of
FLUSH/FUA on DRBD, should hit public git this week.


Now, a short history of fsync, barrier, flush, fua and DRBD.


Some time ago, fsync would only make sure that all relevant
"dirty" data in the linux page cache and buffer cache
would have been submitted to the hardware. Maybe even wait for the
completion of these requests.

But not care for potentially volatile device caches.

Then, devices had "native" respective "tagged" command
queueing (NCQ/TCQ), and drivers started to support these operations.

This was supported as "barrier" request in the linux block and file
system layer.

Still some drivers did not support this, some file systems did not
use them, or not by default, anyways.
There have been implementation flaws, like fsync "sometimes" causing
a barrier, but sometimes not.
Some stacked drivers did not support them either.

Then with increased awareness of the "fsync problem",
file system implementations have been audited and improved,
defaults have been revised.

With mainline 2.6.29, non-fragmented single segment dm-linear
learned to support (pass through) barrier requests.
2.6.30 most dm targets (LVM) had support for barriers, with
2.6.33 even dm-raid1, which was the last one to receive barrier support.
I don't recall which mainline version of MD started to support barriers,
but I think it dates back to 2005.


"Back then", DRBD did neither use barriers, nor expose, pass-through, or
support them in other ways. As most other drivers did not either,
and file systems (ok, ext3) did not enable them by default, and we'd
have to implement a lot of "try, then fall back and disable, but
re-issue the request anyways" code, we did not.


Also, because people who cared used battery backed write cache in their
controllers anyways, and would explicitly disable barriers.


Then DRBD started to care for barriers for DRBD internal meta data
writes: for each meta data transaction, and before all "DRBD barrier
acks", which separate reorder domains or "epochs" in the DRBD
replication stream, we issue a barrier or flush request.

We still did not expose the use of barriers to upper layers.

 * either you disable your volatile write caches,
 * or you make them non-volatile, by adding a BBU

But even with volatile caches, for the "simple" node failure + failover,
DRBD would be ok, because of the frequent flush requests for the "DRBD
barrier ack", while they have been replicating still.

If you drive DRBD without a peer, though, you'd only get barriers
down to the hardware, if you happened to leave the current hot working
set, causing DRBD to write an activity log transaction, and only
if the drbd meta-data is located on the same physical drive, or the same
lower level linux block device queue, or both.

So if you crash a primary drbd without a peer on volatile cache, 
you may experience data loss, where, with proper use of barriers
in your file system and lower level devices may have been avoided
without DRBD in the mix. Lame excuse: "Multiple failures" and such ...



Then there was the re-wiring of the linux block layer respective
barriers and flushes.  BIO_RW_BARRIER and REQ_HARDBARRIER vanished, and
all semantics are expressed as a combination of REQ_FLUSH | REQ_FUA.
Users of the interface are no longer required to implement
try-and-fallback, it is supposed to be transparent now.


That has been almost two years ago already (2.6.36 following).
But still DRBD does not expose or pass through these request types.
Me culpa.


As these are now supposed to be transparent (no try-then-fallback
implementation needed on our part anymore), I have implemented
support for this finally.

Will do some more testing, and add "#ifdef's" as necessary for older
kernel versions.  Then you should have it in git, and with all
further releases (that will be 8.3.14, 8.4.2, and newer).

Still my recommendation for best performance is to have battery backed
write cache on your controllers, disable any volatile caches, and
disable/forget about barriers/flushes/fua.


For those interested, below is my current, not yet final, patch.
As is, it should work with kernels >= 2.6.36,
and those that have backported FLUSH/FUA and blk_queue_flush(),
which include RHEL 6.1 and later (note: NOT 6.0).



diff --git a/drbd/drbd_actlog.c b/drbd/drbd_actlog.c
index 0f03a4c..b856c95 100644
--- a/drbd/drbd_actlog.c
+++ b/drbd/drbd_actlog.c
@@ -926,7 +926,11 @@ int __drbd_set_out_of_sync(struct drbd_conf *mdev, sector_t sector, int size,
 	unsigned int enr, count = 0;
 	struct lc_element *e;
 
-	if (size <= 0 || (size & 0x1ff) != 0 || size > DRBD_MAX_BIO_SIZE) {
+	/* this should be an empty REQ_FLUSH */
+	if (size == 0)
+		return 0;
+
+	if (size < 0 || (size & 0x1ff) != 0 || size > DRBD_MAX_BIO_SIZE) {
 		dev_err(DEV, "sector: %llus, size: %d\n",
 			(unsigned long long)sector, size);
 		return 0;
diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
index c3cad43..f2e9c39 100644
--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -3916,6 +3916,7 @@ struct drbd_conf *drbd_new_device(unsigned int minor)
 	q->backing_dev_info.congested_data = mdev;
 
 	blk_queue_make_request(q, drbd_make_request);
+	blk_queue_flush(q, REQ_FLUSH | REQ_FUA);
 	/* Setting the max_hw_sectors to an odd value of 8kibyte here
 	   This triggers a max_bio_size message upon first attach or connect */
 	blk_queue_max_hw_sectors(q, DRBD_MAX_BIO_SIZE_SAFE >> 8);
diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 6f8de0c..993a09c 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -316,6 +316,9 @@ STATIC void drbd_pp_free(struct drbd_conf *mdev, struct page *page, int is_net)
 	atomic_t *a = is_net ? &mdev->pp_in_use_by_net : &mdev->pp_in_use;
 	int i;
 
+	if (page == NULL)
+		return;
+
 	if (drbd_pp_vacant > (DRBD_MAX_BIO_SIZE/PAGE_SIZE)*minor_count)
 		i = page_chain_free(page);
 	else {
@@ -355,7 +358,7 @@ struct drbd_epoch_entry *drbd_alloc_ee(struct drbd_conf *mdev,
 				     gfp_t gfp_mask) __must_hold(local)
 {
 	struct drbd_epoch_entry *e;
-	struct page *page;
+	struct page *page = NULL;
 	unsigned nr_pages = (data_size + PAGE_SIZE -1) >> PAGE_SHIFT;
 
 	if (drbd_insert_fault(mdev, DRBD_FAULT_AL_EE))
@@ -368,9 +371,11 @@ struct drbd_epoch_entry *drbd_alloc_ee(struct drbd_conf *mdev,
 		return NULL;
 	}
 
-	page = drbd_pp_alloc(mdev, nr_pages, (gfp_mask & __GFP_WAIT));
-	if (!page)
-		goto fail;
+	if (data_size) {
+		page = drbd_pp_alloc(mdev, nr_pages, (gfp_mask & __GFP_WAIT));
+		if (!page)
+			goto fail;
+	}
 
 	INIT_HLIST_NODE(&e->collision);
 	e->epoch = NULL;
@@ -1476,7 +1481,6 @@ read_in_block(struct drbd_conf *mdev, u64 id, sector_t sector, int data_size) __
 
 	data_size -= dgs;
 
-	ERR_IF(data_size == 0) return NULL;
 	ERR_IF(data_size &  0x1ff) return NULL;
 	ERR_IF(data_size >  DRBD_MAX_BIO_SIZE) return NULL;
 
@@ -1497,6 +1501,9 @@ read_in_block(struct drbd_conf *mdev, u64 id, sector_t sector, int data_size) __
 	if (!e)
 		return NULL;
 
+	if (!data_size)
+		return e;
+
 	ds = data_size;
 	page = e->pages;
 	page_chain_for_each(page) {
@@ -1933,6 +1940,10 @@ STATIC int receive_Data(struct drbd_conf *mdev, enum drbd_packets cmd, unsigned
 
 	dp_flags = be32_to_cpu(p->dp_flags);
 	rw |= wire_flags_to_bio(mdev, dp_flags);
+	if (e->pages == NULL) {
+		D_ASSERT(e->size == 0);
+		D_ASSERT(dp_flags & DP_FLUSH);
+	}
 
 	if (dp_flags & DP_MAY_SET_IN_SYNC)
 		e->flags |= EE_MAY_SET_IN_SYNC;
diff --git a/drbd/drbd_req.c b/drbd/drbd_req.c
index 5593fc8..a104daf 100644
--- a/drbd/drbd_req.c
+++ b/drbd/drbd_req.c
@@ -1168,13 +1168,12 @@ MAKE_REQUEST_TYPE drbd_make_request(struct request_queue *q, struct bio *bio)
 	/*
 	 * what we "blindly" assume:
 	 */
-	D_ASSERT(bio->bi_size > 0);
 	D_ASSERT((bio->bi_size & 0x1ff) == 0);
 
 	/* to make some things easier, force alignment of requests within the
 	 * granularity of our hash tables */
 	s_enr = bio->bi_sector >> HT_SHIFT;
-	e_enr = (bio->bi_sector+(bio->bi_size>>9)-1) >> HT_SHIFT;
+	e_enr = bio->bi_size ? (bio->bi_sector+(bio->bi_size>>9)-1) >> HT_SHIFT : s_enr;
 
 	if (likely(s_enr == e_enr)) {
 		do {




-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com
