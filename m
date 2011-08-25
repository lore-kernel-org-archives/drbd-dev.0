Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:07:44 +0200
Message-Id: <1314284934-17999-49-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 048/118] drbd: struct drbd_request: Introduce a
	new collision flag
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

This flag is set when a processes puts itself to sleep to wait for a
conflicting request to complete.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |    7 ++++-
 drivers/block/drbd/drbd_req.c      |   42 ++---------------------------------
 drivers/block/drbd/drbd_req.h      |    7 ++++++
 3 files changed, 15 insertions(+), 41 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 0d9d777..ed24dc3 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1819,6 +1819,7 @@ static int receive_Data(struct drbd_conf *mdev, enum drbd_packet cmd,
 		first = 1;
 		for (;;) {
 			struct drbd_interval *i;
+			struct drbd_request *req2;
 			int have_unacked = 0;
 			int have_conflict = 0;
 			prepare_to_wait(&mdev->misc_wait, &wait,
@@ -1826,8 +1827,7 @@ static int receive_Data(struct drbd_conf *mdev, enum drbd_packet cmd,
 
 			i = drbd_find_overlap(&mdev->write_requests, sector, size);
 			if (i) {
-				struct drbd_request *req2 =
-					container_of(i, struct drbd_request, i);
+				req2 = container_of(i, struct drbd_request, i);
 
 				/* only ALERT on first iteration,
 				 * we may be woken up early... */
@@ -1873,6 +1873,9 @@ static int receive_Data(struct drbd_conf *mdev, enum drbd_packet cmd,
 				goto out_interrupted;
 			}
 
+			/* Indicate to wake up mdev->misc_wait upon completion.  */
+			req2->rq_state |= RQ_COLLISION;
+
 			spin_unlock_irq(&mdev->tconn->req_lock);
 			if (first) {
 				first = 0;
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 25fa87c..8b4ba94 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -176,45 +176,9 @@ static void _about_to_complete_local_write(struct drbd_conf *mdev,
 	    req->epoch == mdev->tconn->newest_tle->br_number)
 		queue_barrier(mdev);
 
-	/* we need to do the conflict detection stuff,
-	 * if the epoch_entries tree is non-empty and
-	 * this request has completed on the network */
-	if ((s & RQ_NET_DONE) && !RB_EMPTY_ROOT(&mdev->epoch_entries)) {
-		const sector_t sector = req->i.sector;
-		const int size = req->i.size;
-		struct drbd_interval *i;
-
-		/* ASSERT:
-		 * there must be no conflicting requests, since
-		 * they must have been failed on the spot */
-
-		i = drbd_find_overlap(&mdev->write_requests, sector, size);
-		if (i) {
-			struct drbd_request *req2 =
-				container_of(i, struct drbd_request, i);
-
-			dev_alert(DEV, "LOGIC BUG: completed: %p %llus +%u; "
-			      "other: %p %llus +%u\n",
-			      req, (unsigned long long)sector, size,
-			      i, (unsigned long long)req2->i.sector, req2->i.size);
-		}
-
-		/* maybe "wake" those conflicting epoch entries
-		 * that wait for this request to finish.
-		 *
-		 * currently, there can be only _one_ such ee
-		 * (well, or some more, which would be pending
-		 * P_DISCARD_ACK not yet sent by the asender...),
-		 * since we block the receiver thread upon the
-		 * first conflict detection, which will wait on
-		 * misc_wait.  maybe we want to assert that?
-		 *
-		 * anyways, if we found one,
-		 * we just have to do a wake_up.  */
-		i = drbd_find_overlap(&mdev->epoch_entries, sector, size);
-		if (i)
-			wake_up(&mdev->misc_wait);
-	}
+	/* Wake up any processes waiting for this request to complete.  */
+	if ((s & RQ_NET_DONE) && (s & RQ_COLLISION))
+		wake_up(&mdev->misc_wait);
 }
 
 void complete_master_bio(struct drbd_conf *mdev,
diff --git a/drivers/block/drbd/drbd_req.h b/drivers/block/drbd/drbd_req.h
index 431e3f9..7a7464a 100644
--- a/drivers/block/drbd/drbd_req.h
+++ b/drivers/block/drbd/drbd_req.h
@@ -194,6 +194,12 @@ enum drbd_req_state_bits {
 
 	/* Should call drbd_al_complete_io() for this request... */
 	__RQ_IN_ACT_LOG,
+
+	/*
+	 * Set when a processes puts itself to sleep to wait for this request
+	 * to complete.
+	 */
+	__RQ_COLLISION,
 };
 
 #define RQ_LOCAL_PENDING   (1UL << __RQ_LOCAL_PENDING)
@@ -214,6 +220,7 @@ enum drbd_req_state_bits {
 
 #define RQ_WRITE           (1UL << __RQ_WRITE)
 #define RQ_IN_ACT_LOG      (1UL << __RQ_IN_ACT_LOG)
+#define RQ_COLLISION	   (1UL << __RQ_COLLISION)
 
 /* For waking up the frozen transfer log mod_req() has to return if the request
    should be counted in the epoch object*/
-- 
1.7.4.1

