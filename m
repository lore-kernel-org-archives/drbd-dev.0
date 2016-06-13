Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C9DF21056445
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 00:26:40 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Tue, 14 Jun 2016 00:26:10 +0200
Message-Id: <1465856799-2151-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <575ECD32.2080700@fb.com>
References: <575ECD32.2080700@fb.com>
In-Reply-To: <575ECD32.2080700@fb.com>
References: <575ECD32.2080700@fb.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/30] drbd: bitmap bulk IO: do not always
	suspend IO
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

The intention was to only suspend IO if some normal bitmap operation is
supposed to be locked out, not always. If the bulk operation is flaged
as BM_LOCKED_CHANGE_ALLOWED, we do not need to suspend IO.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 2b37744..2891631 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3587,18 +3587,20 @@ void drbd_queue_bitmap_io(struct drbd_device *device,
 int drbd_bitmap_io(struct drbd_device *device, int (*io_fn)(struct drbd_device *),
 		char *why, enum bm_flag flags)
 {
+	/* Only suspend io, if some operation is supposed to be locked out */
+	const bool do_suspend_io = flags & (BM_DONT_CLEAR|BM_DONT_SET|BM_DONT_TEST);
 	int rv;
 
 	D_ASSERT(device, current != first_peer_device(device)->connection->worker.task);
 
-	if ((flags & BM_LOCKED_SET_ALLOWED) == 0)
+	if (do_suspend_io)
 		drbd_suspend_io(device);
 
 	drbd_bm_lock(device, why, flags);
 	rv = io_fn(device);
 	drbd_bm_unlock(device);
 
-	if ((flags & BM_LOCKED_SET_ALLOWED) == 0)
+	if (do_suspend_io)
 		drbd_resume_io(device);
 
 	return rv;
-- 
2.7.4

