Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:18 +0200
Message-Id: <1398703415-17780-8-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 07/24] drbd: fix potential distributed deadlock
	during verify or resync
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

If max-buffers and socket buffer sizes are "too small" for the chosen
resync rate, this could lead potentially lead to a distributed deadlock,
which may or may not resolve itself via the "ko-count" and request
timeout mechanism, or could be resolved by forced disconnect.

One option to deal with this is proper configuration:
use larger max-buffer and socket buffers settings,
or reduce the resync rate.

But even with bad configuration we should not deadlock,
but "gracefully" recover.

The issue is avoided by using only up to max-buffers/2 for resync
requests, and by using max-buffers not as a hard limit for data buffer
allocations, but as a throttle threshold only.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 17 ++++++++++++-----
 drivers/block/drbd/drbd_worker.c   | 27 +++++++++++++++++----------
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 125c9e8..6ffbc22 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -234,9 +234,17 @@ static void drbd_kick_lo_and_reclaim_net(struct drbd_device *device)
  * @retry:	whether to retry, if not enough pages are available right now
  *
  * Tries to allocate number pages, first from our own page pool, then from
- * the kernel, unless this allocation would exceed the max_buffers setting.
+ * the kernel.
  * Possibly retry until DRBD frees sufficient pages somewhere else.
  *
+ * If this allocation would exceed the max_buffers setting, we throttle
+ * allocation (schedule_timeout) to give the system some room to breathe.
+ *
+ * We do not use max-buffers as hard limit, because it could lead to
+ * congestion and further to a distributed deadlock during online-verify or
+ * (checksum based) resync, if the max-buffers, socket buffer sizes and
+ * resync-rate settings are mis-configured.
+ *
  * Returns a page chain linked via page->private.
  */
 struct page *drbd_alloc_pages(struct drbd_peer_device *peer_device, unsigned int number,
@@ -246,10 +254,8 @@ struct page *drbd_alloc_pages(struct drbd_peer_device *peer_device, unsigned int
 	struct page *page = NULL;
 	struct net_conf *nc;
 	DEFINE_WAIT(wait);
-	int mxb;
+	unsigned int mxb;
 
-	/* Yes, we may run up to @number over max_buffers. If we
-	 * follow it strictly, the admin will get it wrong anyways. */
 	rcu_read_lock();
 	nc = rcu_dereference(peer_device->connection->net_conf);
 	mxb = nc ? nc->max_buffers : 1000000;
@@ -277,7 +283,8 @@ struct page *drbd_alloc_pages(struct drbd_peer_device *peer_device, unsigned int
 			break;
 		}
 
-		schedule();
+		if (schedule_timeout(HZ/10) == 0)
+			mxb = UINT_MAX;
 	}
 	finish_wait(&drbd_pp_wait, &wait);
 
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index dcd95a6..7e633ca 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -492,10 +492,9 @@ struct fifo_buffer *fifo_alloc(int fifo_size)
 	return fb;
 }
 
-static int drbd_rs_controller(struct drbd_device *device)
+static int drbd_rs_controller(struct drbd_device *device, unsigned int sect_in)
 {
 	struct disk_conf *dc;
-	unsigned int sect_in;  /* Number of sectors that came in since the last turn */
 	unsigned int want;     /* The number of sectors we want in the proxy */
 	int req_sect; /* Number of sectors to request in this turn */
 	int correction; /* Number of sectors more we need in the proxy*/
@@ -505,9 +504,6 @@ static int drbd_rs_controller(struct drbd_device *device)
 	int max_sect;
 	struct fifo_buffer *plan;
 
-	sect_in = atomic_xchg(&device->rs_sect_in, 0); /* Number of sectors that came in */
-	device->rs_in_flight -= sect_in;
-
 	dc = rcu_dereference(device->ldev->disk_conf);
 	plan = rcu_dereference(device->rs_plan_s);
 
@@ -550,11 +546,16 @@ static int drbd_rs_controller(struct drbd_device *device)
 
 static int drbd_rs_number_requests(struct drbd_device *device)
 {
-	int number;
+	unsigned int sect_in;  /* Number of sectors that came in since the last turn */
+	int number, mxb;
+
+	sect_in = atomic_xchg(&device->rs_sect_in, 0);
+	device->rs_in_flight -= sect_in;
 
 	rcu_read_lock();
+	mxb = drbd_get_max_buffers(device) / 2;
 	if (rcu_dereference(device->rs_plan_s)->size) {
-		number = drbd_rs_controller(device) >> (BM_BLOCK_SHIFT - 9);
+		number = drbd_rs_controller(device, sect_in) >> (BM_BLOCK_SHIFT - 9);
 		device->c_sync_rate = number * HZ * (BM_BLOCK_SIZE / 1024) / SLEEP_TIME;
 	} else {
 		device->c_sync_rate = rcu_dereference(device->ldev->disk_conf)->resync_rate;
@@ -562,8 +563,14 @@ static int drbd_rs_number_requests(struct drbd_device *device)
 	}
 	rcu_read_unlock();
 
-	/* ignore the amount of pending requests, the resync controller should
-	 * throttle down to incoming reply rate soon enough anyways. */
+	/* Don't have more than "max-buffers"/2 in-flight.
+	 * Otherwise we may cause the remote site to stall on drbd_alloc_pages(),
+	 * potentially causing a distributed deadlock on congestion during
+	 * online-verify or (checksum-based) resync, if max-buffers,
+	 * socket buffer sizes and resync rate settings are mis-configured. */
+	if (mxb - device->rs_in_flight < number)
+		number = mxb - device->rs_in_flight;
+
 	return number;
 }
 
@@ -597,7 +604,7 @@ static int make_resync_request(struct drbd_device *device, int cancel)
 
 	max_bio_size = queue_max_hw_sectors(device->rq_queue) << 9;
 	number = drbd_rs_number_requests(device);
-	if (number == 0)
+	if (number <= 0)
 		goto requeue;
 
 	for (i = 0; i < number; i++) {
-- 
1.9.1

