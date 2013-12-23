Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 81F73105B0BB
	for <drbd-dev@lists.linbit.com>; Mon, 23 Dec 2013 22:50:57 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 23 Dec 2013 22:50:38 +0100
Message-Id: <1387835456-29695-10-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1387835456-29695-1-git-send-email-philipp.reisner@linbit.com>
References: <1387835456-29695-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/27] drbd: Function prototype cleanups
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

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 drivers/block/drbd/drbd_int.h  |    2 ++
 drivers/block/drbd/drbd_main.c |    5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index d7eade8..c9eea4d 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1340,6 +1340,8 @@ extern void resync_timer_fn(unsigned long data);
 extern void start_resync_timer_fn(unsigned long data);
 
 /* drbd_receiver.c */
+extern int drbd_receiver(struct drbd_thread *thi);
+extern int drbd_asender(struct drbd_thread *thi);
 extern int drbd_rs_should_slow_down(struct drbd_device *device, sector_t sector);
 extern int drbd_submit_peer_request(struct drbd_device *,
 				    struct drbd_peer_request *, const unsigned,
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index a2003cd..a7f992f 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -58,11 +58,6 @@
 #include "drbd_vli.h"
 
 static DEFINE_MUTEX(drbd_main_mutex);
-int drbd_receiver(struct drbd_thread *);
-int drbd_worker(struct drbd_thread *);
-int drbd_asender(struct drbd_thread *);
-
-int drbd_init(void);
 static int drbd_open(struct block_device *bdev, fmode_t mode);
 static void drbd_release(struct gendisk *gd, fmode_t mode);
 static int w_md_sync(struct drbd_work *w, int unused);
-- 
1.7.9.5

