Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2540C103B4DA
	for <drbd-dev@lists.linbit.com>; Tue, 25 Sep 2012 13:41:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 1F31F1B4206
	for <drbd-dev@lists.linbit.com>; Tue, 25 Sep 2012 13:41:09 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J7xq2D9eOPtR for <drbd-dev@lists.linbit.com>;
	Tue, 25 Sep 2012 13:41:09 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id EA2FE1B413D
	for <drbd-dev@lists.linbit.com>; Tue, 25 Sep 2012 13:41:08 +0200 (CEST)
Resent-Message-ID: <20120925114108.GE8143@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id CA0021019A78
	for <drbd-dev@lists.linbit.com>; Tue, 25 Sep 2012 00:35:41 +0200 (CEST)
Received: by pbbrp8 with SMTP id rp8so4123166pbb.27
	for <drbd-dev@lists.linbit.com>; Mon, 24 Sep 2012 15:35:40 -0700 (PDT)
From: Kent Overstreet <koverstreet@google.com>
To: linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com
Date: Mon, 24 Sep 2012 15:34:48 -0700
Message-Id: <1348526106-17074-9-git-send-email-koverstreet@google.com>
In-Reply-To: <1348526106-17074-1-git-send-email-koverstreet@google.com>
References: <1348526106-17074-1-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, "Martin K. Petersen" <martin.petersen@oracle.com>,
	neilb@suse.de, Kent Overstreet <koverstreet@google.com>,
	tj@kernel.org, vgoyal@redhat.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH v3 08/26] block: Change bio_split() to respect
	the current value of bi_idx
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

In the current code bio_split() won't be seeing partially completed bios
so this doesn't change any behaviour, but this makes the code a bit
clearer as to what bio_split() actually requires.

The immediate purpose of the patch is removing unnecessary bi_idx
references, but the end goal is to allow partial completed bios to be
submitted, which along with immutable biovecs enables effecient bio
splitting.

Some of the callers were (double) checking that bios could be split, so
update their checks too.

Signed-off-by: Kent Overstreet <koverstreet@google.com>
CC: Jens Axboe <axboe@kernel.dk>
CC: Lars Ellenberg <drbd-dev@lists.linbit.com>
CC: Neil Brown <neilb@suse.de>
CC: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/block/drbd/drbd_req.c | 6 +++---
 drivers/md/raid0.c            | 3 +--
 drivers/md/raid10.c           | 3 +--
 fs/bio-integrity.c            | 4 ++--
 fs/bio.c                      | 7 +++----
 5 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index d90a1fd..4d09e74 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1155,11 +1155,11 @@ void drbd_make_request(struct request_queue *q, struct bio *bio)
 
 	/* can this bio be split generically?
 	 * Maybe add our own split-arbitrary-bios function. */
-	if (bio->bi_vcnt != 1 || bio->bi_idx != 0 || bio->bi_size > DRBD_MAX_BIO_SIZE) {
+	if (bio_segments(bio) != 1 || bio->bi_size > DRBD_MAX_BIO_SIZE) {
 		/* rather error out here than BUG in bio_split */
 		dev_err(DEV, "bio would need to, but cannot, be split: "
-		    "(vcnt=%u,idx=%u,size=%u,sector=%llu)\n",
-		    bio->bi_vcnt, bio->bi_idx, bio->bi_size,
+		    "(segments=%u,size=%u,sector=%llu)\n",
+		    bio_segments(bio), bio->bi_size,
 		    (unsigned long long)bio->bi_sector);
 		bio_endio(bio, -EINVAL);
 	} else {
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 89016cb..769b3cb 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -510,8 +510,7 @@ static void raid0_make_request(struct mddev *mddev, struct bio *bio)
 		sector_t sector = bio->bi_sector;
 		struct bio_pair *bp;
 		/* Sanity check -- queue functions should prevent this happening */
-		if (bio->bi_vcnt != 1 ||
-		    bio->bi_idx != 0)
+		if (bio_segments(bio) != 1)
 			goto bad_map;
 		/* This is a one page bio that upper layers
 		 * refuse to split for us, so we need to split it.
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 9715aaf..bbd08f5 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1081,8 +1081,7 @@ static void make_request(struct mddev *mddev, struct bio * bio)
 			 || conf->prev.near_copies < conf->prev.raid_disks))) {
 		struct bio_pair *bp;
 		/* Sanity check -- queue functions should prevent this happening */
-		if (bio->bi_vcnt != 1 ||
-		    bio->bi_idx != 0)
+		if (bio_segments(bio) != 1)
 			goto bad_map;
 		/* This is a one page bio that upper layers
 		 * refuse to split for us, so we need to split it.
diff --git a/fs/bio-integrity.c b/fs/bio-integrity.c
index 65b708d..f175814 100644
--- a/fs/bio-integrity.c
+++ b/fs/bio-integrity.c
@@ -659,8 +659,8 @@ void bio_integrity_split(struct bio *bio, struct bio_pair *bp, int sectors)
 	bp->bio1.bi_integrity = &bp->bip1;
 	bp->bio2.bi_integrity = &bp->bip2;
 
-	bp->iv1 = bip->bip_vec[0];
-	bp->iv2 = bip->bip_vec[0];
+	bp->iv1 = bip->bip_vec[bip->bip_idx];
+	bp->iv2 = bip->bip_vec[bip->bip_idx];
 
 	bp->bip1.bip_vec = &bp->iv1;
 	bp->bip2.bip_vec = &bp->iv2;
diff --git a/fs/bio.c b/fs/bio.c
index 9a3935f..062ba8f 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -1616,8 +1616,7 @@ struct bio_pair *bio_split(struct bio *bi, int first_sectors)
 	trace_block_split(bdev_get_queue(bi->bi_bdev), bi,
 				bi->bi_sector + first_sectors);
 
-	BUG_ON(bi->bi_vcnt != 1);
-	BUG_ON(bi->bi_idx != 0);
+	BUG_ON(bio_segments(bi) != 1);
 	atomic_set(&bp->cnt, 3);
 	bp->error = 0;
 	bp->bio1 = *bi;
@@ -1626,8 +1625,8 @@ struct bio_pair *bio_split(struct bio *bi, int first_sectors)
 	bp->bio2.bi_size -= first_sectors << 9;
 	bp->bio1.bi_size = first_sectors << 9;
 
-	bp->bv1 = bi->bi_io_vec[0];
-	bp->bv2 = bi->bi_io_vec[0];
+	bp->bv1 = *bio_iovec(bi);
+	bp->bv2 = *bio_iovec(bi);
 
 	if (bio_is_rw(bi)) {
 		bp->bv2.bv_offset += first_sectors << 9;
-- 
1.7.12

