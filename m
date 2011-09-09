Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri,  9 Sep 2011 13:17:36 +0200
Message-Id: <1315567056-32314-12-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1315567056-32314-1-git-send-email-philipp.reisner@linbit.com>
References: <1315567056-32314-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/11] drbd: Use tconn in request_timer_fn()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c |    1 +
 drivers/block/drbd/drbd_req.c      |   15 ++++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index d6afb3a..6e6b829 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -794,6 +794,7 @@ int drbd_connected(int vnr, void *p, void *data)
 		err = drbd_send_state(mdev);
 	clear_bit(USE_DEGR_WFC_T, &mdev->flags);
 	clear_bit(RESIZE_PENDING, &mdev->flags);
+	mod_timer(&mdev->request_timer, jiffies + HZ); /* just start it here. */
 	return err;
 }
 
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index e296d7e..fd0b452 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1047,21 +1047,22 @@ int drbd_merge_bvec(struct request_queue *q, struct bvec_merge_data *bvm, struct
 void request_timer_fn(unsigned long data)
 {
 	struct drbd_conf *mdev = (struct drbd_conf *) data;
+	struct drbd_tconn *tconn = mdev->tconn;
 	struct drbd_request *req; /* oldest request */
 	struct list_head *le;
 	unsigned long et = 0; /* effective timeout = ko_count * timeout */
 
-	if (get_net_conf(mdev->tconn)) {
-		et = mdev->tconn->net_conf->timeout*HZ/10 * mdev->tconn->net_conf->ko_count;
-		put_net_conf(mdev->tconn);
+	if (get_net_conf(tconn)) {
+		et = tconn->net_conf->timeout*HZ/10 * tconn->net_conf->ko_count;
+		put_net_conf(tconn);
 	}
 	if (!et || mdev->state.conn < C_WF_REPORT_PARAMS)
 		return; /* Recurring timer stopped */
 
-	spin_lock_irq(&mdev->tconn->req_lock);
-	le = &mdev->tconn->oldest_tle->requests;
+	spin_lock_irq(&tconn->req_lock);
+	le = &tconn->oldest_tle->requests;
 	if (list_empty(le)) {
-		spin_unlock_irq(&mdev->tconn->req_lock);
+		spin_unlock_irq(&tconn->req_lock);
 		mod_timer(&mdev->request_timer, jiffies + et);
 		return;
 	}
@@ -1080,5 +1081,5 @@ void request_timer_fn(unsigned long data)
 		mod_timer(&mdev->request_timer, req->start_time + et);
 	}
 
-	spin_unlock_irq(&mdev->tconn->req_lock);
+	spin_unlock_irq(&tconn->req_lock);
 }
-- 
1.7.4.1

