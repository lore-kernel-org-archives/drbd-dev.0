Return-Path: <lmb@suse.de>
Date: Mon, 24 Jan 2005 15:41:57 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd uses wrong API for struct bio
Message-ID: <20050124144157.GM5638@marowsky-bree.de>
References: <20050123161633.GH24350@marowsky-bree.de>
	<200501241538.33555.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200501241538.33555.philipp.reisner@linbit.com>
Cc: axboe@suse.de
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 2005-01-24T15:38:33, Philipp Reisner <philipp.reisner@linbit.com> wrote:

> I just see some hectic discussion going on here, it runs as it is on 
> Linux-2.6.10 as from kernel.org . Could someone tell me what the 
> actual problem is ?

The problem is that the fix (attached) for a memory corruption in md
exposes some bugs (aka, not using struct bio as it's supposed to) in
drbd (as well as md).

This fix is merged in SLES9 SP1, and in the 2.6.10-ac series, and will
likely become part of 2.6.11 one day.

The proper way for fixing it would be to have drbd use bio_alloc() and
friends instead of messing with the bio directly, but that changes quite
a bit of the code...


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=bio-clone-duplicate-vec

From: Jens Axboe <axboe@suse.de>
Subject: bio clone must copy io_vec
Patch-mainline: 
References: 47777

The way md uses bio_clones, it's possible for the original bio to be freed
before the clone is freed. This means the clone ->bi_io_vec points to freed
memory potentially. Fix it by duplicating the io_vec as well.

Acked-by: 
Signed-off-by: Jens Axboe <axboe@suse.de>

--- linux-2.6.5/fs/bio.c~	2004-11-24 12:42:10.532343678 +0100
+++ linux-2.6.5/fs/bio.c	2004-11-24 12:46:49.308021403 +0100
@@ -98,12 +98,7 @@
 
 	BIO_BUG_ON(pool_idx >= BIOVEC_NR_POOLS);
 
-	/*
-	 * cloned bio doesn't own the veclist
-	 */
-	if (!bio_flagged(bio, BIO_CLONED))
-		mempool_free(bio->bi_io_vec, bp->pool);
-
+	mempool_free(bio->bi_io_vec, bp->pool);
 	mempool_free(bio, bio_pool);
 }
 
@@ -212,7 +207,9 @@
  */
 inline void __bio_clone(struct bio *bio, struct bio *bio_src)
 {
-	bio->bi_io_vec = bio_src->bi_io_vec;
+	request_queue_t *q = bdev_get_queue(bio_src->bi_bdev);
+
+	memcpy(bio->bi_io_vec, bio_src->bi_io_vec, bio_src->bi_max_vecs * sizeof(struct bio_vec));
 
 	bio->bi_sector = bio_src->bi_sector;
 	bio->bi_bdev = bio_src->bi_bdev;
@@ -224,21 +221,9 @@
 	 * for the clone
 	 */
 	bio->bi_vcnt = bio_src->bi_vcnt;
-	bio->bi_idx = bio_src->bi_idx;
-	if (bio_flagged(bio, BIO_SEG_VALID)) {
-		bio->bi_phys_segments = bio_src->bi_phys_segments;
-		bio->bi_hw_segments = bio_src->bi_hw_segments;
-		bio->bi_flags |= (1 << BIO_SEG_VALID);
-	}
 	bio->bi_size = bio_src->bi_size;
-
-	/*
-	 * cloned bio does not own the bio_vec, so users cannot fiddle with
-	 * it. clear bi_max_vecs and clear the BIO_POOL_BITS to make this
-	 * apparent
-	 */
-	bio->bi_max_vecs = 0;
-	bio->bi_flags &= (BIO_POOL_MASK - 1);
+	bio_phys_segments(q, bio);
+	bio_hw_segments(q, bio);
 }
 
 /**
@@ -250,7 +235,7 @@
  */
 struct bio *bio_clone(struct bio *bio, int gfp_mask)
 {
-	struct bio *b = bio_alloc(gfp_mask, 0);
+	struct bio *b = bio_alloc(gfp_mask, bio->bi_max_vecs);
 
 	if (b)
 		__bio_clone(b, bio);

--PmA2V3Z32TCmWXqI--
