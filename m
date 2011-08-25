Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Aug 2011 17:08:10 +0200
Message-Id: <1314284934-17999-75-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 074/118] drbd: Moved SIGNAL_ASENDER to the per
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
 drivers/block/drbd/drbd_int.h      |    5 ++---
 drivers/block/drbd/drbd_receiver.c |    8 ++++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 9024bc6..1c43975 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -756,8 +756,6 @@ enum {
 /* flag bits per mdev */
 enum {
 	CREATE_BARRIER,		/* next P_DATA is preceded by a P_BARRIER */
-	SIGNAL_ASENDER,		/* whether asender wants to be interrupted */
-
 	UNPLUG_QUEUED,		/* only relevant with kernel 2.4 */
 	UNPLUG_REMOTE,		/* sending a "UnplugRemote" could help */
 	MD_DIRTY,		/* current uuids and flags not yet on disk */
@@ -910,6 +908,7 @@ enum {
 	NET_CONGESTED,		/* The data socket is congested */
 	DISCARD_CONCURRENT,	/* Set on one node, cleared on the peer! */
 	SEND_PING,		/* whether asender should send a ping asap */
+	SIGNAL_ASENDER,		/* whether asender wants to be interrupted */
 };
 
 struct drbd_tconn {			/* is a resource from the config file */
@@ -1860,7 +1859,7 @@ drbd_queue_work(struct drbd_work_queue *q, struct drbd_work *w)
 
 static inline void wake_asender(struct drbd_conf *mdev)
 {
-	if (test_bit(SIGNAL_ASENDER, &mdev->flags))
+	if (test_bit(SIGNAL_ASENDER, &mdev->tconn->flags))
 		force_sig(DRBD_SIG, mdev->tconn->asender.task);
 }
 
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 4b1d19d..5f44b43 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4584,12 +4584,12 @@ int drbd_asender(struct drbd_thread *thi)
 			3 < atomic_read(&mdev->unacked_cnt))
 			drbd_tcp_cork(mdev->tconn->meta.socket);
 		while (1) {
-			clear_bit(SIGNAL_ASENDER, &mdev->flags);
+			clear_bit(SIGNAL_ASENDER, &mdev->tconn->flags);
 			flush_signals(current);
 			if (!drbd_process_done_ee(mdev))
 				goto reconnect;
 			/* to avoid race with newly queued ACKs */
-			set_bit(SIGNAL_ASENDER, &mdev->flags);
+			set_bit(SIGNAL_ASENDER, &mdev->tconn->flags);
 			spin_lock_irq(&mdev->tconn->req_lock);
 			empty = list_empty(&mdev->done_ee);
 			spin_unlock_irq(&mdev->tconn->req_lock);
@@ -4609,7 +4609,7 @@ int drbd_asender(struct drbd_thread *thi)
 
 		rv = drbd_recv_short(mdev, mdev->tconn->meta.socket,
 				     buf, expect-received, 0);
-		clear_bit(SIGNAL_ASENDER, &mdev->flags);
+		clear_bit(SIGNAL_ASENDER, &mdev->tconn->flags);
 
 		flush_signals(current);
 
@@ -4692,7 +4692,7 @@ disconnect:
 		drbd_force_state(mdev, NS(conn, C_DISCONNECTING));
 		drbd_md_sync(mdev);
 	}
-	clear_bit(SIGNAL_ASENDER, &mdev->flags);
+	clear_bit(SIGNAL_ASENDER, &mdev->tconn->flags);
 
 	D_ASSERT(mdev->state.conn < C_CONNECTED);
 	dev_info(DEV, "asender terminated\n");
-- 
1.7.4.1

