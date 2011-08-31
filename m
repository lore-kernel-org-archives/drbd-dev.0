Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 31 Aug 2011 17:11:00 +0200
Message-Id: <1314803468-1201-9-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314803468-1201-1-git-send-email-philipp.reisner@linbit.com>
References: <1314803468-1201-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 08/16] drbd: Remove left-over function prototypes
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
 drivers/block/drbd/drbd_int.h      |    2 --
 drivers/block/drbd/drbd_receiver.c |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index c7b9fc9..e065985 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1534,7 +1534,6 @@ extern void drbd_csum_bio(struct drbd_conf *, struct crypto_hash *, struct bio *
 extern void drbd_csum_ee(struct drbd_conf *, struct crypto_hash *,
 			 struct drbd_peer_request *, void *);
 /* worker callbacks */
-extern int w_req_cancel_conflict(struct drbd_work *, int);
 extern int w_read_retry_remote(struct drbd_work *, int);
 extern int w_e_end_data_req(struct drbd_work *, int);
 extern int w_e_end_rsdata_req(struct drbd_work *, int);
@@ -1543,7 +1542,6 @@ extern int w_e_end_ov_reply(struct drbd_work *, int);
 extern int w_e_end_ov_req(struct drbd_work *, int);
 extern int w_ov_finished(struct drbd_work *, int);
 extern int w_resync_timer(struct drbd_work *, int);
-extern int w_resume_next_sg(struct drbd_work *, int);
 extern int w_send_write_hint(struct drbd_work *, int);
 extern int w_send_dblock(struct drbd_work *, int);
 extern int w_send_barrier(struct drbd_work *, int);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index d78ab6e..88552e1 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4012,7 +4012,6 @@ static int drbd_disconnected(int vnr, void *p, void *data)
 
 	del_timer(&mdev->request_timer);
 
-	/* make sure syncer is stopped and w_resume_next_sg queued */
 	del_timer_sync(&mdev->resync_timer);
 	resync_timer_fn((unsigned long)mdev);
 
-- 
1.7.4.1

