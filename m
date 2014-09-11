Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DDECF101E072
	for <drbd-dev@lists.linbit.com>; Thu, 11 Sep 2014 14:29:15 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Date: Thu, 11 Sep 2014 14:29:10 +0200
Message-Id: <1410438553-30440-7-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1410438553-30440-1-git-send-email-philipp.reisner@linbit.com>
References: <1410438553-30440-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 6/9] drbd: Get rid of the WORK_PENDING macro
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

From: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>

This macro doesn't add any value; just use test_bit() instead.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_worker.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index b20cd21..3b74f08 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1931,19 +1931,18 @@ void __update_timing_details(
 	++(*cb_nr);
 }
 
-#define WORK_PENDING(work_bit, todo)	(todo & (1UL << work_bit))
 static void do_device_work(struct drbd_device *device, const unsigned long todo)
 {
-	if (WORK_PENDING(MD_SYNC, todo))
+	if (test_bit(MD_SYNC, &todo))
 		do_md_sync(device);
-	if (WORK_PENDING(RS_DONE, todo) ||
-	    WORK_PENDING(RS_PROGRESS, todo))
-		update_on_disk_bitmap(device, WORK_PENDING(RS_DONE, todo));
-	if (WORK_PENDING(GO_DISKLESS, todo))
+	if (test_bit(RS_DONE, &todo) ||
+	    test_bit(RS_PROGRESS, &todo))
+		update_on_disk_bitmap(device, test_bit(RS_DONE, &todo));
+	if (test_bit(GO_DISKLESS, &todo))
 		go_diskless(device);
-	if (WORK_PENDING(DESTROY_DISK, todo))
+	if (test_bit(DESTROY_DISK, &todo))
 		drbd_ldev_destroy(device);
-	if (WORK_PENDING(RS_START, todo))
+	if (test_bit(RS_START, &todo))
 		do_start_resync(device);
 }
 
-- 
1.9.1

