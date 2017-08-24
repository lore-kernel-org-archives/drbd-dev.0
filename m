Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8E46E1058013
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 23:30:11 +0200 (CEST)
Received: by mail-wm0-f44.google.com with SMTP id b189so4589460wmd.0
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 14:30:11 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 24 Aug 2017 23:23:02 +0200
Message-Id: <1503609794-13233-6-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
References: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/17] drbd: mark symbols static where possible
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

From: Baoyou Xie <baoyou.xie@linaro.org>

We get a few warnings when building kernel with W=1:
drbd/drbd_receiver.c:1224:6: warning: no previous prototype for 'one_flush_endio' [-Wmissing-prototypes]
drbd/drbd_req.c:1450:6: warning: no previous prototype for 'send_and_submit_pending' [-Wmissing-prototypes]
drbd/drbd_main.c:924:6: warning: no previous prototype for 'assign_p_sizes_qlim' [-Wmissing-prototypes]
....

In fact, these functions are only used in the file in which they are
declared and don't need a declaration, but can be made static.
So this patch marks these functions with 'static'.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index a3b2ee7..11f3852 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -923,7 +923,9 @@ void drbd_gen_and_send_sync_uuid(struct drbd_peer_device *peer_device)
 }
 
 /* communicated if (agreed_features & DRBD_FF_WSAME) */
-void assign_p_sizes_qlim(struct drbd_device *device, struct p_sizes *p, struct request_queue *q)
+static void
+assign_p_sizes_qlim(struct drbd_device *device, struct p_sizes *p,
+					struct request_queue *q)
 {
 	if (q) {
 		p->qlim->physical_block_size = cpu_to_be32(queue_physical_block_size(q));
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 1b3f439..2489667 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1261,7 +1261,7 @@ struct one_flush_context {
 	struct issue_flush_context *ctx;
 };
 
-void one_flush_endio(struct bio *bio)
+static void one_flush_endio(struct bio *bio)
 {
 	struct one_flush_context *octx = bio->bi_private;
 	struct drbd_device *device = octx->device;
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 72cb0bd..e48012d 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -203,7 +203,8 @@ void drbd_peer_request_endio(struct bio *bio)
 	}
 }
 
-void drbd_panic_after_delayed_completion_of_aborted_request(struct drbd_device *device)
+static void
+drbd_panic_after_delayed_completion_of_aborted_request(struct drbd_device *device)
 {
 	panic("drbd%u %s/%u potential random memory corruption caused by delayed completion of aborted local request\n",
 		device->minor, device->resource->name, device->vnr);
-- 
2.7.4

