Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:08:09 +0200
Message-Id: <1314284934-17999-74-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 073/118] drbd: Moved SEND_PING to the per
	connection (tconn) flags
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
 drivers/block/drbd/drbd_int.h      |    4 ++--
 drivers/block/drbd/drbd_receiver.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index a88bf7c..9024bc6 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -757,7 +757,6 @@ enum {
 enum {
 	CREATE_BARRIER,		/* next P_DATA is preceded by a P_BARRIER */
 	SIGNAL_ASENDER,		/* whether asender wants to be interrupted */
-	SEND_PING,		/* whether asender should send a ping asap */
 
 	UNPLUG_QUEUED,		/* only relevant with kernel 2.4 */
 	UNPLUG_REMOTE,		/* sending a "UnplugRemote" could help */
@@ -910,6 +909,7 @@ struct fifo_buffer {
 enum {
 	NET_CONGESTED,		/* The data socket is congested */
 	DISCARD_CONCURRENT,	/* Set on one node, cleared on the peer! */
+	SEND_PING,		/* whether asender should send a ping asap */
 };
 
 struct drbd_tconn {			/* is a resource from the config file */
@@ -1866,7 +1866,7 @@ static inline void wake_asender(struct drbd_conf *mdev)
 
 static inline void request_ping(struct drbd_conf *mdev)
 {
-	set_bit(SEND_PING, &mdev->flags);
+	set_bit(SEND_PING, &mdev->tconn->flags);
 	wake_asender(mdev);
 }
 
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index cb45a3c..4b1d19d 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4568,7 +4568,7 @@ int drbd_asender(struct drbd_thread *thi)
 
 	while (get_t_state(thi) == RUNNING) {
 		drbd_thread_current_set_cpu(mdev, thi);
-		if (test_and_clear_bit(SEND_PING, &mdev->flags)) {
+		if (test_and_clear_bit(SEND_PING, &mdev->tconn->flags)) {
 			if (!drbd_send_ping(mdev)) {
 				dev_err(DEV, "drbd_send_ping has failed\n");
 				goto reconnect;
@@ -4639,7 +4639,7 @@ int drbd_asender(struct drbd_thread *thi)
 				dev_err(DEV, "PingAck did not arrive in time.\n");
 				goto reconnect;
 			}
-			set_bit(SEND_PING, &mdev->flags);
+			set_bit(SEND_PING, &mdev->tconn->flags);
 			continue;
 		} else if (rv == -EINTR) {
 			continue;
-- 
1.7.4.1

