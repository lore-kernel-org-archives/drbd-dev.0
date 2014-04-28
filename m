Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Apr 2014 18:43:19 +0200
Message-Id: <1398703415-17780-9-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
References: <1398703415-17780-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 08/24] drbd: don't let application IO pre-empt
	resync too often
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

Before, application IO could pre-empt resync activity
for up to hardcoded 20 seconds per resync request.
A very busy server could throttle the effective resync bandwidth
down to one request per 20 seconds.

Now, we only let application IO pre-empt resync traffic
while the current resync rate estimate is above c-min-rate.

If you disable the c-min-rate throttle feature (set c-min-rate = 0),
application IO will no longer pre-empt resync traffic at all.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c   | 13 +++++------
 drivers/block/drbd/drbd_int.h      |  3 ++-
 drivers/block/drbd/drbd_receiver.c | 47 +++++++++++++++++++++-----------------
 3 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 7e7b0e1..8dd09a7 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -1022,8 +1022,7 @@ int drbd_rs_begin_io(struct drbd_device *device, sector_t sector)
 	unsigned int enr = BM_SECT_TO_EXT(sector);
 	struct bm_extent *bm_ext;
 	int i, sig;
-	int sa = 200; /* Step aside 200 times, then grab the extent and let app-IO wait.
-			 200 times -> 20 seconds. */
+	bool sa;
 
 retry:
 	sig = wait_event_interruptible(device->al_wait,
@@ -1034,12 +1033,15 @@ retry:
 	if (test_bit(BME_LOCKED, &bm_ext->flags))
 		return 0;
 
+	/* step aside only while we are above c-min-rate; unless disabled. */
+	sa = drbd_rs_c_min_rate_throttle(device);
+
 	for (i = 0; i < AL_EXT_PER_BM_SECT; i++) {
 		sig = wait_event_interruptible(device->al_wait,
 					       !_is_in_al(device, enr * AL_EXT_PER_BM_SECT + i) ||
-					       test_bit(BME_PRIORITY, &bm_ext->flags));
+					       (sa && test_bit(BME_PRIORITY, &bm_ext->flags)));
 
-		if (sig || (test_bit(BME_PRIORITY, &bm_ext->flags) && sa)) {
+		if (sig || (sa && test_bit(BME_PRIORITY, &bm_ext->flags))) {
 			spin_lock_irq(&device->al_lock);
 			if (lc_put(device->resync, &bm_ext->lce) == 0) {
 				bm_ext->flags = 0; /* clears BME_NO_WRITES and eventually BME_PRIORITY */
@@ -1051,9 +1053,6 @@ retry:
 				return -EINTR;
 			if (schedule_timeout_interruptible(HZ/10))
 				return -EINTR;
-			if (sa && --sa == 0)
-				drbd_warn(device, "drbd_rs_begin_io() stepped aside for 20sec."
-					 "Resync stalled?\n");
 			goto retry;
 		}
 	}
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 361a2e9..f0cabea 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1339,7 +1339,8 @@ extern void start_resync_timer_fn(unsigned long data);
 /* drbd_receiver.c */
 extern int drbd_receiver(struct drbd_thread *thi);
 extern int drbd_asender(struct drbd_thread *thi);
-extern int drbd_rs_should_slow_down(struct drbd_device *device, sector_t sector);
+extern bool drbd_rs_c_min_rate_throttle(struct drbd_device *device);
+extern bool drbd_rs_should_slow_down(struct drbd_device *device, sector_t sector);
 extern int drbd_submit_peer_request(struct drbd_device *,
 				    struct drbd_peer_request *, const unsigned,
 				    const int);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 6ffbc22..10d2dcb 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2323,39 +2323,45 @@ out_interrupted:
  * The current sync rate used here uses only the most recent two step marks,
  * to have a short time average so we can react faster.
  */
-int drbd_rs_should_slow_down(struct drbd_device *device, sector_t sector)
+bool drbd_rs_should_slow_down(struct drbd_device *device, sector_t sector)
 {
-	struct gendisk *disk = device->ldev->backing_bdev->bd_contains->bd_disk;
-	unsigned long db, dt, dbdt;
 	struct lc_element *tmp;
-	int curr_events;
-	int throttle = 0;
-	unsigned int c_min_rate;
+	bool throttle = true;
 
-	rcu_read_lock();
-	c_min_rate = rcu_dereference(device->ldev->disk_conf)->c_min_rate;
-	rcu_read_unlock();
-
-	/* feature disabled? */
-	if (c_min_rate == 0)
-		return 0;
+	if (!drbd_rs_c_min_rate_throttle(device))
+		return false;
 
 	spin_lock_irq(&device->al_lock);
 	tmp = lc_find(device->resync, BM_SECT_TO_EXT(sector));
 	if (tmp) {
 		struct bm_extent *bm_ext = lc_entry(tmp, struct bm_extent, lce);
-		if (test_bit(BME_PRIORITY, &bm_ext->flags)) {
-			spin_unlock_irq(&device->al_lock);
-			return 0;
-		}
+		if (test_bit(BME_PRIORITY, &bm_ext->flags))
+			throttle = false;
 		/* Do not slow down if app IO is already waiting for this extent */
 	}
 	spin_unlock_irq(&device->al_lock);
 
+	return throttle;
+}
+
+bool drbd_rs_c_min_rate_throttle(struct drbd_device *device)
+{
+	struct gendisk *disk = device->ldev->backing_bdev->bd_contains->bd_disk;
+	unsigned long db, dt, dbdt;
+	unsigned int c_min_rate;
+	int curr_events;
+
+	rcu_read_lock();
+	c_min_rate = rcu_dereference(device->ldev->disk_conf)->c_min_rate;
+	rcu_read_unlock();
+
+	/* feature disabled? */
+	if (c_min_rate == 0)
+		return false;
+
 	curr_events = (int)part_stat_read(&disk->part0, sectors[0]) +
 		      (int)part_stat_read(&disk->part0, sectors[1]) -
 			atomic_read(&device->rs_sect_ev);
-
 	if (!device->rs_last_events || curr_events - device->rs_last_events > 64) {
 		unsigned long rs_left;
 		int i;
@@ -2378,12 +2384,11 @@ int drbd_rs_should_slow_down(struct drbd_device *device, sector_t sector)
 		dbdt = Bit2KB(db/dt);
 
 		if (dbdt > c_min_rate)
-			throttle = 1;
+			return true;
 	}
-	return throttle;
+	return false;
 }
 
-
 static int receive_DataRequest(struct drbd_connection *connection, struct packet_info *pi)
 {
 	struct drbd_peer_device *peer_device;
-- 
1.9.1

