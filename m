Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 31 Aug 2011 17:10:57 +0200
Message-Id: <1314803468-1201-6-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314803468-1201-1-git-send-email-philipp.reisner@linbit.com>
References: <1314803468-1201-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 05/16] drbd: Remove redundant check
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Opening a device only succeeds on a primary node, or when explicitly
setting the allow_oos module parameter to allow opening the device
read-only on a secondary node.  There is no other way that a request can
get into drbd_make_request(), so this code cannot trigger.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_req.c |   27 ---------------------------
 1 files changed, 0 insertions(+), 27 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index aab1acd..cfa5fba 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -997,39 +997,12 @@ fail_and_free_req:
 	return ret;
 }
 
-/* helper function for drbd_make_request
- * if we can determine just by the mdev (state) that this request will fail,
- * return 1
- * otherwise return 0
- */
-static int drbd_fail_request_early(struct drbd_conf *mdev, int is_write)
-{
-	if (mdev->state.role != R_PRIMARY &&
-		(!allow_oos || is_write)) {
-		if (__ratelimit(&drbd_ratelimit_state)) {
-			dev_err(DEV, "Process %s[%u] tried to %s; "
-			    "since we are not in Primary state, "
-			    "we cannot allow this\n",
-			    current->comm, current->pid,
-			    is_write ? "WRITE" : "READ");
-		}
-		return 1;
-	}
-
-	return 0;
-}
-
 int drbd_make_request(struct request_queue *q, struct bio *bio)
 {
 	unsigned int s_enr, e_enr;
 	struct drbd_conf *mdev = (struct drbd_conf *) q->queuedata;
 	unsigned long start_time;
 
-	if (drbd_fail_request_early(mdev, bio_data_dir(bio) & WRITE)) {
-		bio_endio(bio, -EPERM);
-		return 0;
-	}
-
 	start_time = jiffies;
 
 	/*
-- 
1.7.4.1

