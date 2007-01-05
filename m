Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: ocfs2-devel@oss.oracle.com
Date: Fri, 5 Jan 2007 15:06:52 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8tlnFjYNm1W0NvV"
Message-Id: <200701051506.52840.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] Fixing cluster/heartbeat.c's use of bio_add_page()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_8tlnFjYNm1W0NvV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi There,

As was already pointed out Mathieu Avila on Thu, 07 Sep 2006 03:15:25 -0700
that OCFS2 is expecting bio_add_page() to add pages to BIOs in an easily
predictable manner.

That is not true, especially for devices with own merge_bvec_fn().

Therefore OCFS2's heartbeat code is very likely to fail on such devices.

The attached patch corrects this, and reduces the file cluster/heartbeat.c
by 90 lines.

  The whole patch builds around the change that the bio_put() call is
  moved to the bio's bi_end_io() function.
  This makes the whole idea of trying to predict the behaviour of 
  bio_add_page() unnecessary, therefore we can remove compute_max_sectors()
  and o2hb_compute_request_limits().

-Phil

PS1: With that applied I can happily run OCFS2 on a DRBD-8.0 device which
     sits on top of software raid (both have interesting merge_bvec_fn()
     functions.

PS2: I created the ocfs2-fix-bio_add_page.diff on 2.6.17 .
     And later refitted the patch to 2.6.20-rc2.
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :

--Boundary-00=_8tlnFjYNm1W0NvV
Content-Type: text/x-diff; charset="us-ascii";
	name="ocfs2-fix-bio_add_page.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ocfs2-fix-bio_add_page.diff"

diff -rup linux-2.6.17-kdb_orig/fs/ocfs2/cluster/heartbeat.c linux-2.6.17-kdb/fs/ocfs2/cluster/heartbeat.c
--- linux-2.6.17-kdb_orig/fs/ocfs2/cluster/heartbeat.c	2007-01-05 11:29:06.696018258 +0100
+++ linux-2.6.17-kdb/fs/ocfs2/cluster/heartbeat.c	2007-01-05 14:08:00.133625148 +0100
@@ -3,6 +3,8 @@
  *
  * Copyright (C) 2004, 2005 Oracle.  All rights reserved.
  *
+ * 5. Jan 2007 Philipp Reisner, fixed the use of bio_add_page().
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public
  * License as published by the Free Software Foundation; either
@@ -182,10 +184,9 @@ static void o2hb_disarm_write_timeout(st
 	flush_scheduled_work();
 }
 
-static inline void o2hb_bio_wait_init(struct o2hb_bio_wait_ctxt *wc,
-				      unsigned int num_ios)
+static inline void o2hb_bio_wait_init(struct o2hb_bio_wait_ctxt *wc)
 {
-	atomic_set(&wc->wc_num_reqs, num_ios);
+	atomic_set(&wc->wc_num_reqs, 0);
 	init_completion(&wc->wc_io_complete);
 	wc->wc_error = 0;
 }
@@ -229,6 +230,7 @@ static int o2hb_bio_end_io(struct bio *b
 		return 1;
 
 	o2hb_bio_wait_dec(wc, 1);
+	bio_put(bio);
 	return 0;
 }
 
@@ -236,23 +238,22 @@ static int o2hb_bio_end_io(struct bio *b
  * start_slot. */
 static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 				      struct o2hb_bio_wait_ctxt *wc,
-				      unsigned int start_slot,
-				      unsigned int num_slots)
+				      unsigned int *current_slot,
+				      unsigned int max_slots)
 {
-	int i, nr_vecs, len, first_page, last_page;
+	int len, current_page;
 	unsigned int vec_len, vec_start;
 	unsigned int bits = reg->hr_block_bits;
 	unsigned int spp = reg->hr_slots_per_page;
+	unsigned int cs = *current_slot;
 	struct bio *bio;
 	struct page *page;
 
-	nr_vecs = (num_slots + spp - 1) / spp;
-
 	/* Testing has shown this allocation to take long enough under
 	 * GFP_KERNEL that the local node can get fenced. It would be
 	 * nicest if we could pre-allocate these bios and avoid this
 	 * all together. */
-	bio = bio_alloc(GFP_ATOMIC, nr_vecs);
+	bio = bio_alloc(GFP_ATOMIC, 16);
 	if (!bio) {
 		mlog(ML_ERROR, "Could not alloc slots BIO!\n");
 		bio = ERR_PTR(-ENOMEM);
@@ -260,133 +261,53 @@ static struct bio *o2hb_setup_one_bio(st
 	}
 
 	/* Must put everything in 512 byte sectors for the bio... */
-	bio->bi_sector = (reg->hr_start_block + start_slot) << (bits - 9);
+	bio->bi_sector = (reg->hr_start_block + cs) << (bits - 9);
 	bio->bi_bdev = reg->hr_bdev;
 	bio->bi_private = wc;
 	bio->bi_end_io = o2hb_bio_end_io;
 
-	first_page = start_slot / spp;
-	last_page = first_page + nr_vecs;
-	vec_start = (start_slot << bits) % PAGE_CACHE_SIZE;
-	for(i = first_page; i < last_page; i++) {
-		page = reg->hr_slot_data[i];
-
-		vec_len = PAGE_CACHE_SIZE;
-		/* last page might be short */
-		if (((i + 1) * spp) > (start_slot + num_slots))
-			vec_len = ((num_slots + start_slot) % spp) << bits;
-		vec_len -=  vec_start;
+	vec_start = (cs << bits) % PAGE_CACHE_SIZE;
+	while(cs < max_slots) {
+		current_page = cs / spp;
+		page = reg->hr_slot_data[current_page];
+
+		vec_len = min( PAGE_CACHE_SIZE, 
+			       (max_slots-cs) * (PAGE_CACHE_SIZE/spp) ); 
 
 		mlog(ML_HB_BIO, "page %d, vec_len = %u, vec_start = %u\n",
-		     i, vec_len, vec_start);
+		     current_page, vec_len, vec_start);
 
 		len = bio_add_page(bio, page, vec_len, vec_start);
-		if (len != vec_len) {
-			bio_put(bio);
-			bio = ERR_PTR(-EIO);
-
-			mlog(ML_ERROR, "Error adding page to bio i = %d, "
-			     "vec_len = %u, len = %d\n, start = %u\n",
-			     i, vec_len, len, vec_start);
-			goto bail;
-		}
+		if (len != vec_len) break;
 
+		cs += vec_len / (PAGE_CACHE_SIZE/spp);
 		vec_start = 0;
 	}
 
 bail:
+	*current_slot = cs;
 	return bio;
 }
 
-/*
- * Compute the maximum number of sectors the bdev can handle in one bio,
- * as a power of two.
- *
- * Stolen from oracleasm, thanks Joel!
- */
-static int compute_max_sectors(struct block_device *bdev)
-{
-	int max_pages, max_sectors, pow_two_sectors;
-
-	struct request_queue *q;
-
-	q = bdev_get_queue(bdev);
-	max_pages = q->max_sectors >> (PAGE_SHIFT - 9);
-	if (max_pages > BIO_MAX_PAGES)
-		max_pages = BIO_MAX_PAGES;
-	if (max_pages > q->max_phys_segments)
-		max_pages = q->max_phys_segments;
-	if (max_pages > q->max_hw_segments)
-		max_pages = q->max_hw_segments;
-	max_pages--; /* Handle I/Os that straddle a page */
-
-	max_sectors = max_pages << (PAGE_SHIFT - 9);
-
-	/* Why is fls() 1-based???? */
-	pow_two_sectors = 1 << (fls(max_sectors) - 1);
-
-	return pow_two_sectors;
-}
-
-static inline void o2hb_compute_request_limits(struct o2hb_region *reg,
-					       unsigned int num_slots,
-					       unsigned int *num_bios,
-					       unsigned int *slots_per_bio)
-{
-	unsigned int max_sectors, io_sectors;
-
-	max_sectors = compute_max_sectors(reg->hr_bdev);
-
-	io_sectors = num_slots << (reg->hr_block_bits - 9);
-
-	*num_bios = (io_sectors + max_sectors - 1) / max_sectors;
-	*slots_per_bio = max_sectors >> (reg->hr_block_bits - 9);
-
-	mlog(ML_HB_BIO, "My io size is %u sectors for %u slots. This "
-	     "device can handle %u sectors of I/O\n", io_sectors, num_slots,
-	     max_sectors);
-	mlog(ML_HB_BIO, "Will need %u bios holding %u slots each\n",
-	     *num_bios, *slots_per_bio);
-}
-
 static int o2hb_read_slots(struct o2hb_region *reg,
 			   unsigned int max_slots)
 {
-	unsigned int num_bios, slots_per_bio, start_slot, num_slots;
-	int i, status;
+	unsigned int current_slot=0;
+	int status;
 	struct o2hb_bio_wait_ctxt wc;
-	struct bio **bios;
 	struct bio *bio;
 
-	o2hb_compute_request_limits(reg, max_slots, &num_bios, &slots_per_bio);
-
-	bios = kcalloc(num_bios, sizeof(struct bio *), GFP_KERNEL);
-	if (!bios) {
-		status = -ENOMEM;
-		mlog_errno(status);
-		return status;
-	}
-
-	o2hb_bio_wait_init(&wc, num_bios);
-
-	num_slots = slots_per_bio;
-	for(i = 0; i < num_bios; i++) {
-		start_slot = i * slots_per_bio;
+	o2hb_bio_wait_init(&wc);
 
-		/* adjust num_slots at last bio */
-		if (max_slots < (start_slot + num_slots))
-			num_slots = max_slots - start_slot;
-
-		bio = o2hb_setup_one_bio(reg, &wc, start_slot, num_slots);
+	while(current_slot < max_slots) {
+		bio = o2hb_setup_one_bio(reg, &wc, &current_slot, max_slots);
 		if (IS_ERR(bio)) {
-			o2hb_bio_wait_dec(&wc, num_bios - i);
-
 			status = PTR_ERR(bio);
 			mlog_errno(status);
 			goto bail_and_wait;
 		}
-		bios[i] = bio;
 
+		atomic_inc(&wc.wc_num_reqs);
 		submit_bio(READ, bio);
 	}
 
@@ -397,38 +318,30 @@ bail_and_wait:
 	if (wc.wc_error && !status)
 		status = wc.wc_error;
 
-	if (bios) {
-		for(i = 0; i < num_bios; i++)
-			if (bios[i])
-				bio_put(bios[i]);
-		kfree(bios);
-	}
-
 	return status;
 }
 
 static int o2hb_issue_node_write(struct o2hb_region *reg,
-				 struct bio **write_bio,
 				 struct o2hb_bio_wait_ctxt *write_wc)
 {
 	int status;
 	unsigned int slot;
 	struct bio *bio;
 
-	o2hb_bio_wait_init(write_wc, 1);
+	o2hb_bio_wait_init(write_wc);
 
 	slot = o2nm_this_node();
 
-	bio = o2hb_setup_one_bio(reg, write_wc, slot, 1);
+	bio = o2hb_setup_one_bio(reg, write_wc, &slot, slot+1);
 	if (IS_ERR(bio)) {
 		status = PTR_ERR(bio);
 		mlog_errno(status);
 		goto bail;
 	}
 
+	atomic_inc(&write_wc->wc_num_reqs);
 	submit_bio(WRITE, bio);
 
-	*write_bio = bio;
 	status = 0;
 bail:
 	return status;
@@ -800,7 +713,6 @@ static int o2hb_do_disk_heartbeat(struct
 {
 	int i, ret, highest_node, change = 0;
 	unsigned long configured_nodes[BITS_TO_LONGS(O2NM_MAX_NODES)];
-	struct bio *write_bio;
 	struct o2hb_bio_wait_ctxt write_wc;
 
 	ret = o2nm_configured_node_map(configured_nodes,
@@ -838,7 +750,7 @@ static int o2hb_do_disk_heartbeat(struct
 
 	/* And fire off the write. Note that we don't wait on this I/O
 	 * until later. */
-	ret = o2hb_issue_node_write(reg, &write_bio, &write_wc);
+	ret = o2hb_issue_node_write(reg, &write_wc);
 	if (ret < 0) {
 		mlog_errno(ret);
 		return ret;
@@ -856,7 +768,6 @@ static int o2hb_do_disk_heartbeat(struct
 	 * people we find in our steady state have seen us.
 	 */
 	o2hb_wait_on_io(reg, &write_wc);
-	bio_put(write_bio);
 	if (write_wc.wc_error) {
 		/* Do not re-arm the write timeout on I/O error - we
 		 * can't be sure that the new block ever made it to
@@ -917,7 +828,6 @@ static int o2hb_thread(void *data)
 {
 	int i, ret;
 	struct o2hb_region *reg = data;
-	struct bio *write_bio;
 	struct o2hb_bio_wait_ctxt write_wc;
 	struct timeval before_hb, after_hb;
 	unsigned int elapsed_msec;
@@ -967,10 +877,9 @@ static int o2hb_thread(void *data)
 	 *
 	 * XXX: Should we skip this on unclean_stop? */
 	o2hb_prepare_block(reg, 0);
-	ret = o2hb_issue_node_write(reg, &write_bio, &write_wc);
+	ret = o2hb_issue_node_write(reg, &write_wc);
 	if (ret == 0) {
 		o2hb_wait_on_io(reg, &write_wc);
-		bio_put(write_bio);
 	} else {
 		mlog_errno(ret);
 	}
Binary files linux-2.6.17-kdb_orig/fs/ocfs2/cluster/heartbeat.o and linux-2.6.17-kdb/fs/ocfs2/cluster/heartbeat.o differ
Binary files linux-2.6.17-kdb_orig/fs/ocfs2/cluster/ocfs2_nodemanager.ko and linux-2.6.17-kdb/fs/ocfs2/cluster/ocfs2_nodemanager.ko differ
Binary files linux-2.6.17-kdb_orig/fs/ocfs2/cluster/ocfs2_nodemanager.mod.o and linux-2.6.17-kdb/fs/ocfs2/cluster/ocfs2_nodemanager.mod.o differ
Binary files linux-2.6.17-kdb_orig/fs/ocfs2/cluster/ocfs2_nodemanager.o and linux-2.6.17-kdb/fs/ocfs2/cluster/ocfs2_nodemanager.o differ

--Boundary-00=_8tlnFjYNm1W0NvV
Content-Type: text/x-diff; charset="us-ascii";
	name="ocfs2-fix-bio_add_page-for-2.6.20-rc2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ocfs2-fix-bio_add_page-for-2.6.20-rc2.diff"

--- heartbeat-2.6.20-rc2.c	2007-01-05 14:56:13.000000000 +0100
+++ heartbeat.c	2007-01-05 15:02:08.000000000 +0100
@@ -3,6 +3,8 @@
  *
  * Copyright (C) 2004, 2005 Oracle.  All rights reserved.
  *
+ * 5. Jan 2007 Philipp Reisner, fixed the use of bio_add_page().
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public
  * License as published by the Free Software Foundation; either
@@ -184,10 +186,9 @@ static void o2hb_disarm_write_timeout(st
 	flush_scheduled_work();
 }
 
-static inline void o2hb_bio_wait_init(struct o2hb_bio_wait_ctxt *wc,
-				      unsigned int num_ios)
+static inline void o2hb_bio_wait_init(struct o2hb_bio_wait_ctxt *wc)
 {
-	atomic_set(&wc->wc_num_reqs, num_ios);
+	atomic_set(&wc->wc_num_reqs, 0);
 	init_completion(&wc->wc_io_complete);
 	wc->wc_error = 0;
 }
@@ -231,6 +232,7 @@ static int o2hb_bio_end_io(struct bio *b
 		return 1;
 
 	o2hb_bio_wait_dec(wc, 1);
+	bio_put(bio);
 	return 0;
 }
 
@@ -238,23 +240,22 @@ static int o2hb_bio_end_io(struct bio *b
  * start_slot. */
 static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 				      struct o2hb_bio_wait_ctxt *wc,
-				      unsigned int start_slot,
-				      unsigned int num_slots)
+				      unsigned int *current_slot,
+				      unsigned int max_slots)
 {
-	int i, nr_vecs, len, first_page, last_page;
+	int len, current_page;
 	unsigned int vec_len, vec_start;
 	unsigned int bits = reg->hr_block_bits;
 	unsigned int spp = reg->hr_slots_per_page;
+	unsigned int cs = *current_slot;
 	struct bio *bio;
 	struct page *page;
 
-	nr_vecs = (num_slots + spp - 1) / spp;
-
 	/* Testing has shown this allocation to take long enough under
 	 * GFP_KERNEL that the local node can get fenced. It would be
 	 * nicest if we could pre-allocate these bios and avoid this
 	 * all together. */
-	bio = bio_alloc(GFP_ATOMIC, nr_vecs);
+	bio = bio_alloc(GFP_ATOMIC, 16);
 	if (!bio) {
 		mlog(ML_ERROR, "Could not alloc slots BIO!\n");
 		bio = ERR_PTR(-ENOMEM);
@@ -262,137 +263,53 @@ static struct bio *o2hb_setup_one_bio(st
 	}
 
 	/* Must put everything in 512 byte sectors for the bio... */
-	bio->bi_sector = (reg->hr_start_block + start_slot) << (bits - 9);
+	bio->bi_sector = (reg->hr_start_block + cs) << (bits - 9);
 	bio->bi_bdev = reg->hr_bdev;
 	bio->bi_private = wc;
 	bio->bi_end_io = o2hb_bio_end_io;
 
-	first_page = start_slot / spp;
-	last_page = first_page + nr_vecs;
-	vec_start = (start_slot << bits) % PAGE_CACHE_SIZE;
-	for(i = first_page; i < last_page; i++) {
-		page = reg->hr_slot_data[i];
-
-		vec_len = PAGE_CACHE_SIZE;
-		/* last page might be short */
-		if (((i + 1) * spp) > (start_slot + num_slots))
-			vec_len = ((num_slots + start_slot) % spp) << bits;
-		vec_len -=  vec_start;
+	vec_start = (cs << bits) % PAGE_CACHE_SIZE;
+	while(cs < max_slots) {
+		current_page = cs / spp;
+		page = reg->hr_slot_data[current_page];
+
+		vec_len = min( PAGE_CACHE_SIZE, 
+			       (max_slots-cs) * (PAGE_CACHE_SIZE/spp) ); 
 
 		mlog(ML_HB_BIO, "page %d, vec_len = %u, vec_start = %u\n",
-		     i, vec_len, vec_start);
+		     current_page, vec_len, vec_start);
 
 		len = bio_add_page(bio, page, vec_len, vec_start);
-		if (len != vec_len) {
-			bio_put(bio);
-			bio = ERR_PTR(-EIO);
-
-			mlog(ML_ERROR, "Error adding page to bio i = %d, "
-			     "vec_len = %u, len = %d\n, start = %u\n",
-			     i, vec_len, len, vec_start);
-			goto bail;
-		}
+		if (len != vec_len) break;
 
+		cs += vec_len / (PAGE_CACHE_SIZE/spp);
 		vec_start = 0;
 	}
 
 bail:
+	*current_slot = cs;
 	return bio;
 }
 
-/*
- * Compute the maximum number of sectors the bdev can handle in one bio,
- * as a power of two.
- *
- * Stolen from oracleasm, thanks Joel!
- */
-static int compute_max_sectors(struct block_device *bdev)
-{
-	int max_pages, max_sectors, pow_two_sectors;
-
-	struct request_queue *q;
-
-	q = bdev_get_queue(bdev);
-	max_pages = q->max_sectors >> (PAGE_SHIFT - 9);
-	if (max_pages > BIO_MAX_PAGES)
-		max_pages = BIO_MAX_PAGES;
-	if (max_pages > q->max_phys_segments)
-		max_pages = q->max_phys_segments;
-	if (max_pages > q->max_hw_segments)
-		max_pages = q->max_hw_segments;
-	max_pages--; /* Handle I/Os that straddle a page */
-
-	if (max_pages) {
-		max_sectors = max_pages << (PAGE_SHIFT - 9);
-	} else {
-		/* If BIO contains 1 or less than 1 page. */
-		max_sectors = q->max_sectors;
-	}
-	/* Why is fls() 1-based???? */
-	pow_two_sectors = 1 << (fls(max_sectors) - 1);
-
-	return pow_two_sectors;
-}
-
-static inline void o2hb_compute_request_limits(struct o2hb_region *reg,
-					       unsigned int num_slots,
-					       unsigned int *num_bios,
-					       unsigned int *slots_per_bio)
-{
-	unsigned int max_sectors, io_sectors;
-
-	max_sectors = compute_max_sectors(reg->hr_bdev);
-
-	io_sectors = num_slots << (reg->hr_block_bits - 9);
-
-	*num_bios = (io_sectors + max_sectors - 1) / max_sectors;
-	*slots_per_bio = max_sectors >> (reg->hr_block_bits - 9);
-
-	mlog(ML_HB_BIO, "My io size is %u sectors for %u slots. This "
-	     "device can handle %u sectors of I/O\n", io_sectors, num_slots,
-	     max_sectors);
-	mlog(ML_HB_BIO, "Will need %u bios holding %u slots each\n",
-	     *num_bios, *slots_per_bio);
-}
-
 static int o2hb_read_slots(struct o2hb_region *reg,
 			   unsigned int max_slots)
 {
-	unsigned int num_bios, slots_per_bio, start_slot, num_slots;
-	int i, status;
+	unsigned int current_slot=0;
+	int status;
 	struct o2hb_bio_wait_ctxt wc;
-	struct bio **bios;
 	struct bio *bio;
 
-	o2hb_compute_request_limits(reg, max_slots, &num_bios, &slots_per_bio);
+	o2hb_bio_wait_init(&wc);
 
-	bios = kcalloc(num_bios, sizeof(struct bio *), GFP_KERNEL);
-	if (!bios) {
-		status = -ENOMEM;
-		mlog_errno(status);
-		return status;
-	}
-
-	o2hb_bio_wait_init(&wc, num_bios);
-
-	num_slots = slots_per_bio;
-	for(i = 0; i < num_bios; i++) {
-		start_slot = i * slots_per_bio;
-
-		/* adjust num_slots at last bio */
-		if (max_slots < (start_slot + num_slots))
-			num_slots = max_slots - start_slot;
-
-		bio = o2hb_setup_one_bio(reg, &wc, start_slot, num_slots);
+	while(current_slot < max_slots) {
+		bio = o2hb_setup_one_bio(reg, &wc, &current_slot, max_slots);
 		if (IS_ERR(bio)) {
-			o2hb_bio_wait_dec(&wc, num_bios - i);
-
 			status = PTR_ERR(bio);
 			mlog_errno(status);
 			goto bail_and_wait;
 		}
-		bios[i] = bio;
 
+		atomic_inc(&wc.wc_num_reqs);
 		submit_bio(READ, bio);
 	}
 
@@ -403,38 +320,30 @@ bail_and_wait:
 	if (wc.wc_error && !status)
 		status = wc.wc_error;
 
-	if (bios) {
-		for(i = 0; i < num_bios; i++)
-			if (bios[i])
-				bio_put(bios[i]);
-		kfree(bios);
-	}
-
 	return status;
 }
 
 static int o2hb_issue_node_write(struct o2hb_region *reg,
-				 struct bio **write_bio,
 				 struct o2hb_bio_wait_ctxt *write_wc)
 {
 	int status;
 	unsigned int slot;
 	struct bio *bio;
 
-	o2hb_bio_wait_init(write_wc, 1);
+	o2hb_bio_wait_init(write_wc);
 
 	slot = o2nm_this_node();
 
-	bio = o2hb_setup_one_bio(reg, write_wc, slot, 1);
+	bio = o2hb_setup_one_bio(reg, write_wc, &slot, slot+1);
 	if (IS_ERR(bio)) {
 		status = PTR_ERR(bio);
 		mlog_errno(status);
 		goto bail;
 	}
 
+	atomic_inc(&write_wc->wc_num_reqs);
 	submit_bio(WRITE, bio);
 
-	*write_bio = bio;
 	status = 0;
 bail:
 	return status;
@@ -826,7 +735,6 @@ static int o2hb_do_disk_heartbeat(struct
 {
 	int i, ret, highest_node, change = 0;
 	unsigned long configured_nodes[BITS_TO_LONGS(O2NM_MAX_NODES)];
-	struct bio *write_bio;
 	struct o2hb_bio_wait_ctxt write_wc;
 
 	ret = o2nm_configured_node_map(configured_nodes,
@@ -864,7 +772,7 @@ static int o2hb_do_disk_heartbeat(struct
 
 	/* And fire off the write. Note that we don't wait on this I/O
 	 * until later. */
-	ret = o2hb_issue_node_write(reg, &write_bio, &write_wc);
+	ret = o2hb_issue_node_write(reg, &write_wc);
 	if (ret < 0) {
 		mlog_errno(ret);
 		return ret;
@@ -882,7 +790,6 @@ static int o2hb_do_disk_heartbeat(struct
 	 * people we find in our steady state have seen us.
 	 */
 	o2hb_wait_on_io(reg, &write_wc);
-	bio_put(write_bio);
 	if (write_wc.wc_error) {
 		/* Do not re-arm the write timeout on I/O error - we
 		 * can't be sure that the new block ever made it to
@@ -943,7 +850,6 @@ static int o2hb_thread(void *data)
 {
 	int i, ret;
 	struct o2hb_region *reg = data;
-	struct bio *write_bio;
 	struct o2hb_bio_wait_ctxt write_wc;
 	struct timeval before_hb, after_hb;
 	unsigned int elapsed_msec;
@@ -993,10 +899,9 @@ static int o2hb_thread(void *data)
 	 *
 	 * XXX: Should we skip this on unclean_stop? */
 	o2hb_prepare_block(reg, 0);
-	ret = o2hb_issue_node_write(reg, &write_bio, &write_wc);
+	ret = o2hb_issue_node_write(reg, &write_wc);
 	if (ret == 0) {
 		o2hb_wait_on_io(reg, &write_wc);
-		bio_put(write_bio);
 	} else {
 		mlog_errno(ret);
 	}

--Boundary-00=_8tlnFjYNm1W0NvV--
