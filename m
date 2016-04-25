Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D9AA81056453
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 14:08:25 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 25 Apr 2016 14:07:37 +0200
Message-Id: <1461586077-11581-11-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
References: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 10/30] drbd: allow parallel flushes for
	multi-volume resources
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

To maintain write-order fidelity accros all volumes in a DRBD resource,
the receiver of a P_BARRIER needs to issue flushes to all volumes.
We used to do this by calling blkdev_issue_flush(), synchronously,
one volume at a time.

We now submit all flushes to all volumes in parallel, then wait for all
completions, to reduce worst-case latencies on multi-volume resources.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 113 +++++++++++++++++++++++++++++--------
 1 file changed, 88 insertions(+), 25 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 4cfc721..a2e7ba9 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1204,13 +1204,83 @@ static int drbd_recv_header(struct drbd_connection *connection, struct packet_in
 	return err;
 }
 
-static void drbd_flush(struct drbd_connection *connection)
+/* This is blkdev_issue_flush, but asynchronous.
+ * We want to submit to all component volumes in parallel,
+ * then wait for all completions.
+ */
+struct issue_flush_context {
+	atomic_t pending;
+	int error;
+	struct completion done;
+};
+struct one_flush_context {
+	struct drbd_device *device;
+	struct issue_flush_context *ctx;
+};
+
+void one_flush_endio(struct bio *bio)
 {
-	int rv;
-	struct drbd_peer_device *peer_device;
-	int vnr;
+	struct one_flush_context *octx = bio->bi_private;
+	struct drbd_device *device = octx->device;
+	struct issue_flush_context *ctx = octx->ctx;
+
+	if (bio->bi_error) {
+		ctx->error = bio->bi_error;
+		drbd_info(device, "local disk FLUSH FAILED with status %d\n", bio->bi_error);
+	}
+	kfree(octx);
+	bio_put(bio);
+
+	clear_bit(FLUSH_PENDING, &device->flags);
+	put_ldev(device);
+	kref_put(&device->kref, drbd_destroy_device);
+
+	if (atomic_dec_and_test(&ctx->pending))
+		complete(&ctx->done);
+}
+
+static void submit_one_flush(struct drbd_device *device, struct issue_flush_context *ctx)
+{
+	struct bio *bio = bio_alloc(GFP_NOIO, 0);
+	struct one_flush_context *octx = kmalloc(sizeof(*octx), GFP_NOIO);
+	if (!bio || !octx) {
+		drbd_warn(device, "Could not allocate a bio, CANNOT ISSUE FLUSH\n");
+		/* FIXME: what else can I do now?  disconnecting or detaching
+		 * really does not help to improve the state of the world, either.
+		 */
+		kfree(octx);
+		if (bio)
+			bio_put(bio);
 
+		ctx->error = -ENOMEM;
+		put_ldev(device);
+		kref_put(&device->kref, drbd_destroy_device);
+		return;
+	}
+
+	octx->device = device;
+	octx->ctx = ctx;
+	bio->bi_bdev = device->ldev->backing_bdev;
+	bio->bi_private = octx;
+	bio->bi_end_io = one_flush_endio;
+
+	device->flush_jif = jiffies;
+	set_bit(FLUSH_PENDING, &device->flags);
+	atomic_inc(&ctx->pending);
+	submit_bio(WRITE_FLUSH, bio);
+}
+
+static void drbd_flush(struct drbd_connection *connection)
+{
 	if (connection->resource->write_ordering >= WO_BDEV_FLUSH) {
+		struct drbd_peer_device *peer_device;
+		struct issue_flush_context ctx;
+		int vnr;
+
+		atomic_set(&ctx.pending, 1);
+		ctx.error = 0;
+		init_completion(&ctx.done);
+
 		rcu_read_lock();
 		idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
 			struct drbd_device *device = peer_device->device;
@@ -1220,31 +1290,24 @@ static void drbd_flush(struct drbd_connection *connection)
 			kref_get(&device->kref);
 			rcu_read_unlock();
 
-			/* Right now, we have only this one synchronous code path
-			 * for flushes between request epochs.
-			 * We may want to make those asynchronous,
-			 * or at least parallelize the flushes to the volume devices.
-			 */
-			device->flush_jif = jiffies;
-			set_bit(FLUSH_PENDING, &device->flags);
-			rv = blkdev_issue_flush(device->ldev->backing_bdev,
-					GFP_NOIO, NULL);
-			clear_bit(FLUSH_PENDING, &device->flags);
-			if (rv) {
-				drbd_info(device, "local disk flush failed with status %d\n", rv);
-				/* would rather check on EOPNOTSUPP, but that is not reliable.
-				 * don't try again for ANY return value != 0
-				 * if (rv == -EOPNOTSUPP) */
-				drbd_bump_write_ordering(connection->resource, NULL, WO_DRAIN_IO);
-			}
-			put_ldev(device);
-			kref_put(&device->kref, drbd_destroy_device);
+			submit_one_flush(device, &ctx);
 
 			rcu_read_lock();
-			if (rv)
-				break;
 		}
 		rcu_read_unlock();
+
+		/* Do we want to add a timeout,
+		 * if disk-timeout is set? */
+		if (!atomic_dec_and_test(&ctx.pending))
+			wait_for_completion(&ctx.done);
+
+		if (ctx.error) {
+			/* would rather check on EOPNOTSUPP, but that is not reliable.
+			 * don't try again for ANY return value != 0
+			 * if (rv == -EOPNOTSUPP) */
+			/* Any error is already reported by bio_endio callback. */
+			drbd_bump_write_ordering(connection->resource, NULL, WO_DRAIN_IO);
+		}
 	}
 }
 
-- 
1.9.1

