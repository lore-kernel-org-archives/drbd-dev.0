Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C982B1017A24
	for <drbd-dev@lists.linbit.com>; Sun,  3 Mar 2013 20:48:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id C29F01B44E6
	for <drbd-dev@lists.linbit.com>; Sun,  3 Mar 2013 20:48:22 +0100 (CET)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dR-8ij2VSa3l for <drbd-dev@lists.linbit.com>;
	Sun,  3 Mar 2013 20:48:22 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 81C141B44DE
	for <drbd-dev@lists.linbit.com>; Sun,  3 Mar 2013 20:48:22 +0100 (CET)
Resent-Message-ID: <20130303194822.GT2696@soda.linbit>
Received: from mail-pb0-f52.google.com (mail-pb0-f52.google.com
	[209.85.160.52]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4EF461018D68
	for <drbd-dev@lists.linbit.com>; Wed, 20 Feb 2013 01:30:49 +0100 (CET)
Received: by mail-pb0-f52.google.com with SMTP id ma3so2520903pbc.11
	for <drbd-dev@lists.linbit.com>; Tue, 19 Feb 2013 16:30:48 -0800 (PST)
From: Kent Overstreet <koverstreet@google.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 19 Feb 2013 16:22:24 -0800
Message-Id: <1361319761-23873-11-git-send-email-koverstreet@google.com>
In-Reply-To: <1361319761-23873-1-git-send-email-koverstreet@google.com>
References: <1361319761-23873-1-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, Neil Brown <neilb@suse.de>,
	Kent Overstreet <koverstreet@google.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 10/27] block: Change bio_split() to respect the
	current value of bi_idx
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
 drivers/md/raid0.c  | 3 +--
 drivers/md/raid10.c | 3 +--
 fs/bio-integrity.c  | 4 ++--
 fs/bio.c            | 7 +++----
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 1ff39e6..0a07239 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -520,8 +520,7 @@ static void raid0_make_request(struct mddev *mddev, struct bio *bio)
 		sector_t sector = bio->bi_sector;
 		struct bio_pair *bp;
 		/* Sanity check -- queue functions should prevent this happening */
-		if ((bio->bi_vcnt != 1 && bio->bi_vcnt != 0) ||
-		    bio->bi_idx != 0)
+		if (bio_segments(bio) > 1)
 			goto bad_map;
 		/* This is a one page bio that upper layers
 		 * refuse to split for us, so we need to split it.
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 4c6705f..84cd9d7 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1127,8 +1127,7 @@ static void make_request(struct mddev *mddev, struct bio * bio)
 			 || conf->prev.near_copies < conf->prev.raid_disks))) {
 		struct bio_pair *bp;
 		/* Sanity check -- queue functions should prevent this happening */
-		if ((bio->bi_vcnt != 1 && bio->bi_vcnt != 0) ||
-		    bio->bi_idx != 0)
+		if (bio_segments(bio) > 1)
 			goto bad_map;
 		/* This is a one page bio that upper layers
 		 * refuse to split for us, so we need to split it.
diff --git a/fs/bio-integrity.c b/fs/bio-integrity.c
index 8c4c604..ca7b02d 100644
--- a/fs/bio-integrity.c
+++ b/fs/bio-integrity.c
@@ -661,8 +661,8 @@ void bio_integrity_split(struct bio *bio, struct bio_pair *bp, int sectors)
 	bp->bio1.bi_integrity = &bp->bip1;
 	bp->bio2.bi_integrity = &bp->bip2;
 
-	bp->iv1 = bip->bip_vec[0];
-	bp->iv2 = bip->bip_vec[0];
+	bp->iv1 = bip->bip_vec[bip->bip_idx];
+	bp->iv2 = bip->bip_vec[bip->bip_idx];
 
 	bp->bip1.bip_vec = &bp->iv1;
 	bp->bip2.bip_vec = &bp->iv2;
diff --git a/fs/bio.c b/fs/bio.c
index 7edc08d..f1b4c16 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -1620,8 +1620,7 @@ struct bio_pair *bio_split(struct bio *bi, int first_sectors)
 	trace_block_split(bdev_get_queue(bi->bi_bdev), bi,
 				bi->bi_sector + first_sectors);
 
-	BUG_ON(bi->bi_vcnt != 1 && bi->bi_vcnt != 0);
-	BUG_ON(bi->bi_idx != 0);
+	BUG_ON(bio_segments(bi) > 1);
 	atomic_set(&bp->cnt, 3);
 	bp->error = 0;
 	bp->bio1 = *bi;
@@ -1631,8 +1630,8 @@ struct bio_pair *bio_split(struct bio *bi, int first_sectors)
 	bp->bio1.bi_size = first_sectors << 9;
 
 	if (bi->bi_vcnt != 0) {
-		bp->bv1 = bi->bi_io_vec[0];
-		bp->bv2 = bi->bi_io_vec[0];
+		bp->bv1 = *bio_iovec(bi);
+		bp->bv2 = *bio_iovec(bi);
 
 		if (bio_is_rw(bi)) {
 			bp->bv2.bv_offset += first_sectors << 9;
-- 
1.7.12

