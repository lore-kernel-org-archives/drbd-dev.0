Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 29 Sep 2011 10:15:28 +0200
Message-Id: <1317284131-17464-10-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1317284131-17464-1-git-send-email-philipp.reisner@linbit.com>
References: <1317284131-17464-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/12] drbd: Make drbd_wait_ee_list_empty() and
	_drbd_wait_ee_list_empty() static
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h      |    4 ----
 drivers/block/drbd/drbd_receiver.c |    6 ++++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index d64aaf3..8fc21a7 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1463,10 +1463,6 @@ extern void __drbd_free_peer_req(struct drbd_conf *, struct drbd_peer_request *,
 				 int);
 #define drbd_free_peer_req(m,e) __drbd_free_peer_req(m, e, 0)
 #define drbd_free_net_peer_req(m,e) __drbd_free_peer_req(m, e, 1)
-extern void drbd_wait_ee_list_empty(struct drbd_conf *mdev,
-		struct list_head *head);
-extern void _drbd_wait_ee_list_empty(struct drbd_conf *mdev,
-		struct list_head *head);
 extern void drbd_set_recv_tcq(struct drbd_conf *mdev, int tcq_enabled);
 extern void _drbd_clear_done_ee(struct drbd_conf *mdev, struct list_head *to_be_freed);
 extern void conn_flush_workqueue(struct drbd_tconn *tconn);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 8b73589..3003d9e 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -428,7 +428,8 @@ static int drbd_finish_peer_reqs(struct drbd_conf *mdev)
 	return err;
 }
 
-void _drbd_wait_ee_list_empty(struct drbd_conf *mdev, struct list_head *head)
+static void _drbd_wait_ee_list_empty(struct drbd_conf *mdev,
+				     struct list_head *head)
 {
 	DEFINE_WAIT(wait);
 
@@ -443,7 +444,8 @@ void _drbd_wait_ee_list_empty(struct drbd_conf *mdev, struct list_head *head)
 	}
 }
 
-void drbd_wait_ee_list_empty(struct drbd_conf *mdev, struct list_head *head)
+static void drbd_wait_ee_list_empty(struct drbd_conf *mdev,
+				    struct list_head *head)
 {
 	spin_lock_irq(&mdev->tconn->req_lock);
 	_drbd_wait_ee_list_empty(mdev, head);
-- 
1.7.4.1

