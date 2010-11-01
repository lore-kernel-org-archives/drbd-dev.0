Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8028B10595B5
	for <drbd-dev@lists.linbit.com>; Tue,  2 Nov 2010 11:38:57 +0100 (CET)
Resent-Message-ID: <20101102103857.GH4340@barkeeper1-xen.linbit>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B897410593B6
	for <drbd-dev@lists.linbit.com>; Mon,  1 Nov 2010 17:16:31 +0100 (CET)
From: Tejun Heo <tj@kernel.org>
To: axboe@kernel.dk, hch@infradead.org, linux-kernel@vger.kernel.org,
	petero2@telia.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
	jack@suse.cz, akpm@linux-foundation.org, adilger.kernel@dilger.ca,
	tytso@mit.edu, mfasheh@suse.com, joel.becker@oracle.com,
	aelder@sgi.com, dm-devel@redhat.com, drbd-dev@lists.linbit.com,
	neilb@suse.de, leochen@broadcom.com, sbranden@broadcom.com,
	chris.mason@oracle.com, swhiteho@redhat.com, shaggy@linux.vnet.ibm.com,
	joern@logfs.org, konishi.ryusuke@lab.ntt.co.jp,
	reiserfs-devel@vger.kernel.org, viro@zeniv.linux.org.uk
Date: Mon,  1 Nov 2010 17:15:29 +0100
Message-Id: <1288628129-12811-6-git-send-email-tj@kernel.org>
In-Reply-To: <1288628129-12811-1-git-send-email-tj@kernel.org>
References: <1288628129-12811-1-git-send-email-tj@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Subject: [Drbd-dev] [PATCH 5/5] block: reorganize claim/release
	implementation
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

With claim/release rolled into blkdev_get/put(), there's no reason to
keep bd_abort/finish_claim(), __bd_claim() and bd_release() as
separate functions.  It only makes the code difficult to follow.
Collapse them into blkdev_get/put().  This will ease future changes
around claim/release.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 fs/block_dev.c |  127 +++++++++++++++++++++-----------------------------------
 1 files changed, 48 insertions(+), 79 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index fc48912..269bfbb 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -772,79 +772,6 @@ static struct block_device *bd_start_claiming(struct block_device *bdev,
 	}
 }
 
-/* releases bdev_lock */
-static void __bd_abort_claiming(struct block_device *whole, void *holder)
-{
-	BUG_ON(whole->bd_claiming != holder);
-	whole->bd_claiming = NULL;
-	wake_up_bit(&whole->bd_claiming, 0);
-
-	spin_unlock(&bdev_lock);
-	bdput(whole);
-}
-
-/**
- * bd_abort_claiming - abort claiming a block device
- * @whole: whole block device returned by bd_start_claiming()
- * @holder: holder trying to claim @bdev
- *
- * Abort a claiming block started by bd_start_claiming().  Note that
- * @whole is not the block device to be claimed but the whole device
- * returned by bd_start_claiming().
- *
- * CONTEXT:
- * Grabs and releases bdev_lock.
- */
-static void bd_abort_claiming(struct block_device *whole, void *holder)
-{
-	spin_lock(&bdev_lock);
-	__bd_abort_claiming(whole, holder);		/* releases bdev_lock */
-}
-
-/* increment holders when we have a legitimate claim. requires bdev_lock */
-static void __bd_claim(struct block_device *bdev, struct block_device *whole,
-					void *holder)
-{
-	/* note that for a whole device bd_holders
-	 * will be incremented twice, and bd_holder will
-	 * be set to bd_may_claim before being set to holder
-	 */
-	whole->bd_holders++;
-	whole->bd_holder = bd_may_claim;
-	bdev->bd_holders++;
-	bdev->bd_holder = holder;
-}
-
-/**
- * bd_finish_claiming - finish claiming a block device
- * @bdev: block device of interest (passed to bd_start_claiming())
- * @whole: whole block device returned by bd_start_claiming()
- * @holder: holder trying to claim @bdev
- *
- * Finish a claiming block started by bd_start_claiming().
- *
- * CONTEXT:
- * Grabs and releases bdev_lock.
- */
-static void bd_finish_claiming(struct block_device *bdev,
-				struct block_device *whole, void *holder)
-{
-	spin_lock(&bdev_lock);
-	BUG_ON(!bd_may_claim(bdev, whole, holder));
-	__bd_claim(bdev, whole, holder);
-	__bd_abort_claiming(whole, holder); /* not actually an abort */
-}
-
-static void bd_release(struct block_device *bdev)
-{
-	spin_lock(&bdev_lock);
-	if (!--bdev->bd_contains->bd_holders)
-		bdev->bd_contains->bd_holder = NULL;
-	if (!--bdev->bd_holders)
-		bdev->bd_holder = NULL;
-	spin_unlock(&bdev_lock);
-}
-
 #ifdef CONFIG_SYSFS
 static int add_symlink(struct kobject *from, struct kobject *to)
 {
@@ -1223,10 +1150,30 @@ int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 	res = __blkdev_get(bdev, mode, 0);
 
 	if (whole) {
-		if (res == 0)
-			bd_finish_claiming(bdev, whole, holder);
-		else
-			bd_abort_claiming(whole, holder);
+		/* finish claiming */
+		spin_lock(&bdev_lock);
+
+		if (res == 0) {
+			BUG_ON(!bd_may_claim(bdev, whole, holder));
+			/*
+			 * Note that for a whole device bd_holders
+			 * will be incremented twice, and bd_holder
+			 * will be set to bd_may_claim before being
+			 * set to holder
+			 */
+			whole->bd_holders++;
+			whole->bd_holder = bd_may_claim;
+			bdev->bd_holders++;
+			bdev->bd_holder = holder;
+		}
+
+		/* tell others that we're done */
+		BUG_ON(whole->bd_claiming != holder);
+		whole->bd_claiming = NULL;
+		wake_up_bit(&whole->bd_claiming, 0);
+
+		spin_unlock(&bdev_lock);
+		bdput(whole);
 	}
 
 	return res;
@@ -1272,6 +1219,7 @@ static int __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
 		bdev->bd_part_count--;
 
 	if (!--bdev->bd_openers) {
+		WARN_ON_ONCE(bdev->bd_holders);
 		sync_blockdev(bdev);
 		kill_bdev(bdev);
 	}
@@ -1303,10 +1251,31 @@ static int __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
 int blkdev_put(struct block_device *bdev, fmode_t mode)
 {
 	if (mode & FMODE_EXCL) {
+		bool bdev_free;
+
+		/*
+		 * Release a claim on the device.  The holder fields
+		 * are protected with bdev_lock.  bd_mutex is to
+		 * synchronize disk_holder unlinking.
+		 */
 		mutex_lock(&bdev->bd_mutex);
-		bd_release(bdev);
-		if (!bdev->bd_holders)
+		spin_lock(&bdev_lock);
+
+		WARN_ON_ONCE(--bdev->bd_holders < 0);
+		WARN_ON_ONCE(--bdev->bd_contains->bd_holders < 0);
+
+		/* bd_contains might point to self, check in a separate step */
+		if ((bdev_free = !bdev->bd_holders))
+			bdev->bd_holder = NULL;
+		if (!bdev->bd_contains->bd_holders)
+			bdev->bd_contains->bd_holder = NULL;
+
+		spin_unlock(&bdev_lock);
+
+		/* if this was the last claim, holder link should go too */
+		if (bdev_free)
 			bd_unlink_disk_holder(bdev);
+
 		mutex_unlock(&bdev->bd_mutex);
 	}
 	return __blkdev_put(bdev, mode, 0);
-- 
1.7.1

