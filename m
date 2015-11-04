Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id ED6BB1056192
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 18:09:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E8CB02A24E3
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 18:09:42 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ph0-OdSmzpem for <drbd-dev@lists.linbit.com>;
	Wed,  4 Nov 2015 18:09:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 953E02A2C5F
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 18:09:42 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jO6cr-GjPPum for <drbd-dev@lists.linbit.com>;
	Wed,  4 Nov 2015 18:09:42 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 6B4E22A2BCB
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 18:09:42 +0100 (CET)
Resent-Message-ID: <20151104170942.GR14472@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 680191055F77
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 17:33:38 +0100 (CET)
From: mchristi@redhat.com
To: linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Date: Wed,  4 Nov 2015 10:32:59 -0600
Message-Id: <1446654807-6935-5-git-send-email-mchristi@redhat.com>
In-Reply-To: <1446654807-6935-1-git-send-email-mchristi@redhat.com>
References: <1446654807-6935-1-git-send-email-mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 04/32] block: prepare blkdev_issue_discard for
	bi_rw split
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

From: Mike Christie <mchristi@redhat.com>

The next patches will prepare the submit_bio users
for the split. There were a lot more users than
there were for submit_bio_wait, so if the conversion
was not a one liner, I broke it out into its own
patch.

This patch prepares blkdev_issue_discard.

There is some compat code left which will be dropped
in later patches in the series.
1. REQ_WRITE is still being set. This is because a lot
of code assumes it will be set for discard, flushes and
write sames.
2. submit_bio is still taking a bitmap. This is to make
the series git bisectable.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 block/blk-lib.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 9ebf653..0861c7a 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -42,7 +42,8 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
 	struct request_queue *q = bdev_get_queue(bdev);
-	int type = REQ_WRITE | REQ_DISCARD;
+	int op = REQ_OP_DISCARD;
+	int op_flags = REQ_WRITE;
 	unsigned int granularity;
 	int alignment;
 	struct bio_batch bb;
@@ -63,7 +64,7 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	if (flags & BLKDEV_DISCARD_SECURE) {
 		if (!blk_queue_secdiscard(q))
 			return -EOPNOTSUPP;
-		type |= REQ_SECURE;
+		op_flags |= REQ_SECURE;
 	}
 
 	atomic_set(&bb.done, 1);
@@ -108,7 +109,7 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector = end_sect;
 
 		atomic_inc(&bb.done);
-		submit_bio(type, bio);
+		submit_bio(op | op_flags, bio);
 
 		/*
 		 * We can loop for a long time in here, if someone does
-- 
1.8.3.1

