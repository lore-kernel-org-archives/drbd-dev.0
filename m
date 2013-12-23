Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D9C33105B0D0
	for <drbd-dev@lists.linbit.com>; Mon, 23 Dec 2013 22:50:58 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 23 Dec 2013 22:50:51 +0100
Message-Id: <1387835456-29695-23-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1387835456-29695-1-git-send-email-philipp.reisner@linbit.com>
References: <1387835456-29695-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 22/27] drbd: Turn w_make_ov_request and
	make_resync_request into "normal" functions
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

From: Andreas Gruenbacher <agruen@linbit.com>

These functions are not used as drbd_work callbacks.

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 drivers/block/drbd/drbd_worker.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index b0f6ae0..7961af9 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -39,8 +39,8 @@
 #include "drbd_protocol.h"
 #include "drbd_req.h"
 
-static int w_make_ov_request(struct drbd_work *, int);
-static int w_make_resync_request(struct drbd_work *, int);
+static int make_ov_request(struct drbd_device *, int);
+static int make_resync_request(struct drbd_device *, int);
 
 /* endio handlers:
  *   drbd_md_io_complete (defined here)
@@ -427,10 +427,10 @@ int w_resync_timer(struct drbd_work *w, int cancel)
 
 	switch (device->state.conn) {
 	case C_VERIFY_S:
-		w_make_ov_request(w, cancel);
+		make_ov_request(device, cancel);
 		break;
 	case C_SYNC_TARGET:
-		w_make_resync_request(w, cancel);
+		make_resync_request(device, cancel);
 		break;
 	}
 
@@ -565,10 +565,8 @@ static int drbd_rs_number_requests(struct drbd_device *device)
 	return number;
 }
 
-static int w_make_resync_request(struct drbd_work *w, int cancel)
+static int make_resync_request(struct drbd_device *device, int cancel)
 {
-	struct drbd_device_work *dw = device_work(w);
-	struct drbd_device *device = dw->device;
 	unsigned long bit;
 	sector_t sector;
 	const sector_t capacity = drbd_get_capacity(device->this_bdev);
@@ -730,9 +728,8 @@ next_sector:
 	return 0;
 }
 
-static int w_make_ov_request(struct drbd_work *w, int cancel)
+static int make_ov_request(struct drbd_device *device, int cancel)
 {
-	struct drbd_device *device = device_work(w)->device;
 	int number, i, size;
 	sector_t sector;
 	const sector_t capacity = drbd_get_capacity(device->this_bdev);
-- 
1.7.9.5

