Return-Path: <lars.ellenberg@linbit.com>
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Date: Thu, 11 May 2017 10:21:46 +0200
Message-Id: <1494490906-19582-1-git-send-email-lars.ellenberg@linbit.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Ingo Molnar <mingo@kernel.org>, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: fix request leak introduced by
	locking/atomic, kref: Kill kref_sub()
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

Regression fix for 4.11, which totally broke DRBD

When killing kref_sub(), the unconditional additional kref_get()
was not properly paired with the necessary kref_put(), causing
a leak of struct drbd_requests (~ 224 Bytes) per submitted bio,
and breaking DRBD in general, as the destructor of those "drbd_requests"
does more than just the mempoll_free().

Fixes: bdfafc4ffdd2 ("locking/atomic, kref: Kill kref_sub()")
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_req.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 652114a..1fc8a67 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -314,24 +314,32 @@ void drbd_req_complete(struct drbd_request *req, struct bio_and_error *m)
 }
 
 /* still holds resource->req_lock */
-static int drbd_req_put_completion_ref(struct drbd_request *req, struct bio_and_error *m, int put)
+static void drbd_req_put_completion_ref(struct drbd_request *req, struct bio_and_error *m, int put)
 {
 	struct drbd_device *device = req->device;
 	D_ASSERT(device, m || (req->rq_state & RQ_POSTPONED));
 
+	if (!put)
+		return;
+
 	if (!atomic_sub_and_test(put, &req->completion_ref))
-		return 0;
+		return;
 
 	drbd_req_complete(req, m);
 
+	/* local completion may still come in later,
+	 * we need to keep the req object around. */
+	if (req->rq_state & RQ_LOCAL_ABORTED)
+		return;
+
 	if (req->rq_state & RQ_POSTPONED) {
 		/* don't destroy the req object just yet,
 		 * but queue it for retry */
 		drbd_restart_request(req);
-		return 0;
+		return;
 	}
 
-	return 1;
+	kref_put(&req->kref, drbd_req_destroy);
 }
 
 static void set_if_null_req_next(struct drbd_peer_device *peer_device, struct drbd_request *req)
@@ -518,12 +526,8 @@ static void mod_rq_state(struct drbd_request *req, struct bio_and_error *m,
 	if (req->i.waiting)
 		wake_up(&device->misc_wait);
 
-	if (c_put) {
-		if (drbd_req_put_completion_ref(req, m, c_put))
-			kref_put(&req->kref, drbd_req_destroy);
-	} else {
-		kref_put(&req->kref, drbd_req_destroy);
-	}
+	drbd_req_put_completion_ref(req, m, c_put);
+	kref_put(&req->kref, drbd_req_destroy);
 }
 
 static void drbd_report_io_error(struct drbd_device *device, struct drbd_request *req)
@@ -1363,8 +1367,7 @@ static void drbd_send_and_submit(struct drbd_device *device, struct drbd_request
 	}
 
 out:
-	if (drbd_req_put_completion_ref(req, &m, 1))
-		kref_put(&req->kref, drbd_req_destroy);
+	drbd_req_put_completion_ref(req, &m, 1);
 	spin_unlock_irq(&resource->req_lock);
 
 	/* Even though above is a kref_put(), this is safe.
-- 
2.7.4

