Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 253D010003E2
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:30:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 197561B4315
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:30:20 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1fGnlSyGdjOE for <drbd-dev@lists.linbit.com>;
	Fri, 25 May 2012 22:30:20 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id DF9C61B40F5
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:30:19 +0200 (CEST)
Resent-Message-ID: <20120525203019.GT1903@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8D0AF106DCC0
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:26:34 +0200 (CEST)
Received: by mail-pb0-f54.google.com with SMTP id ro2so2900206pbb.27
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 13:26:34 -0700 (PDT)
From: Kent Overstreet <koverstreet@google.com>
To: linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	dm-devel@redhat.com, linux-fsdevel@vger.kernel.org
Date: Fri, 25 May 2012 13:25:39 -0700
Message-Id: <1337977539-16977-17-git-send-email-koverstreet@google.com>
In-Reply-To: <1337977539-16977-1-git-send-email-koverstreet@google.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, neilb@suse.de,
	Kent Overstreet <koverstreet@google.com>, mpatocka@redhat.com,
	vgoyal@redhat.com, bharrosh@panasas.com, tj@kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v3 16/16] dm: Kill merge_bvec_fn()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


Signed-off-by: Kent Overstreet <koverstreet@google.com>
---
 drivers/md/dm.c |   58 -------------------------------------------------------
 1 file changed, 58 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 193fb19..a4c5256 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1309,63 +1309,6 @@ static void __split_and_process_bio(struct mapped_device *md, struct bio *bio)
  * CRUD END
  *---------------------------------------------------------------*/
 
-static int dm_merge_bvec(struct request_queue *q,
-			 struct bvec_merge_data *bvm,
-			 struct bio_vec *biovec)
-{
-	struct mapped_device *md = q->queuedata;
-	struct dm_table *map = dm_get_live_table(md);
-	struct dm_target *ti;
-	sector_t max_sectors;
-	int max_size = 0;
-
-	if (unlikely(!map))
-		goto out;
-
-	ti = dm_table_find_target(map, bvm->bi_sector);
-	if (!dm_target_is_valid(ti))
-		goto out_table;
-
-	/*
-	 * Find maximum amount of I/O that won't need splitting
-	 */
-	max_sectors = min(max_io_len(bvm->bi_sector, ti),
-			  (sector_t) BIO_MAX_SECTORS);
-	max_size = (max_sectors << SECTOR_SHIFT) - bvm->bi_size;
-	if (max_size < 0)
-		max_size = 0;
-
-	/*
-	 * merge_bvec_fn() returns number of bytes
-	 * it can accept at this offset
-	 * max is precomputed maximal io size
-	 */
-	if (max_size && ti->type->merge)
-		max_size = ti->type->merge(ti, bvm, biovec, max_size);
-	/*
-	 * If the target doesn't support merge method and some of the devices
-	 * provided their merge_bvec method (we know this by looking at
-	 * queue_max_hw_sectors), then we can't allow bios with multiple vector
-	 * entries.  So always set max_size to 0, and the code below allows
-	 * just one page.
-	 */
-	else if (queue_max_hw_sectors(q) <= PAGE_SIZE >> 9)
-
-		max_size = 0;
-
-out_table:
-	dm_table_put(map);
-
-out:
-	/*
-	 * Always allow an entire first page
-	 */
-	if (max_size <= biovec->bv_len && !(bvm->bi_size >> SECTOR_SHIFT))
-		max_size = biovec->bv_len;
-
-	return max_size;
-}
-
 /*
  * The request function that just remaps the bio built up by
  * dm_merge_bvec.
@@ -1766,7 +1709,6 @@ static void dm_init_md_queue(struct mapped_device *md)
 	md->queue->backing_dev_info.congested_data = md;
 	blk_queue_make_request(md->queue, dm_request);
 	blk_queue_bounce_limit(md->queue, BLK_BOUNCE_ANY);
-	blk_queue_merge_bvec(md->queue, dm_merge_bvec);
 }
 
 /*
-- 
1.7.9.3.327.g2980b

