Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:07:12 +0200
Message-Id: <1314284934-17999-17-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 016/118] drbd: Add read_requests tree
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

We do not do collision detection for read requests, but we still need to
look up the request objects when we receive a package over the network.
Using the same data structure for read and write requests results in
simpler code once the tl_hash and app_reads_hash tables are removed.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h  |    1 +
 drivers/block/drbd/drbd_main.c |    1 +
 drivers/block/drbd/drbd_req.c  |   13 ++++++++++---
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 0583713..fe15319 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1020,6 +1020,7 @@ struct drbd_conf {
 	unsigned int tl_hash_s;
 
 	/* Interval tree of pending local write requests */
+	struct rb_root read_requests;
 	struct rb_root write_requests;
 
 	/* blocks to resync in this run [unit BM_BLOCK_SIZE] */
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 4d85838..c0ea5ba 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3473,6 +3473,7 @@ struct drbd_conf *drbd_new_device(unsigned int minor)
 	/* no need to lock access, we are still initializing this minor device. */
 	if (!tl_init(mdev))
 		goto out_no_tl;
+	mdev->read_requests = RB_ROOT;
 	mdev->write_requests = RB_ROOT;
 
 	mdev->app_reads_hash = kzalloc(APP_R_HSIZE*sizeof(void *), GFP_KERNEL);
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 593576f..d2a78c4 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -260,10 +260,15 @@ void _req_may_be_done(struct drbd_request *req, struct bio_and_error *m)
 
 		/* remove the request from the conflict detection
 		 * respective block_id verification hash */
-		if (!hlist_unhashed(&req->collision)) {
+		if (!drbd_interval_empty(&req->i)) {
+			struct rb_root *root;
+
 			hlist_del(&req->collision);
-			if (!drbd_interval_empty(&req->i))
-				drbd_remove_interval(&mdev->write_requests, &req->i);
+			if (rw == WRITE)
+				root = &mdev->write_requests;
+			else
+				root = &mdev->read_requests;
+			drbd_remove_interval(root, &req->i);
 		} else
 			D_ASSERT((s & (RQ_NET_MASK & ~RQ_NET_DONE)) == 0);
 
@@ -332,6 +337,7 @@ static int _req_conflicts(struct drbd_request *req)
 	struct hlist_head *slot;
 
 	D_ASSERT(hlist_unhashed(&req->collision));
+	D_ASSERT(drbd_interval_empty(&req->i));
 
 	if (!get_net_conf(mdev))
 		return 0;
@@ -493,6 +499,7 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 		/* so we can verify the handle in the answer packet
 		 * corresponding hlist_del is in _req_may_be_done() */
 		hlist_add_head(&req->collision, ar_hash_slot(mdev, req->i.sector));
+		drbd_insert_interval(&mdev->read_requests, &req->i);
 
 		set_bit(UNPLUG_REMOTE, &mdev->flags);
 
-- 
1.7.4.1

