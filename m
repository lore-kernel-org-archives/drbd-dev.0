Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5AF9D105B0BB
	for <drbd-dev@lists.linbit.com>; Mon, 23 Dec 2013 22:50:58 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 23 Dec 2013 22:50:45 +0100
Message-Id: <1387835456-29695-17-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1387835456-29695-1-git-send-email-philipp.reisner@linbit.com>
References: <1387835456-29695-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 16/27] drbd: Rename w_prev_work_done -> w_complete
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

From: Andreas Gruenbacher <agruen@linbit.com>

Also move it to drbd_receiver.c and make it static.

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 drivers/block/drbd/drbd_int.h      |    1 -
 drivers/block/drbd/drbd_receiver.c |   10 +++++++++-
 drivers/block/drbd/drbd_worker.c   |    8 --------
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 2b0fdfd..5cf496d 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1321,7 +1321,6 @@ extern int w_send_write_hint(struct drbd_work *, int);
 extern int w_make_resync_request(struct drbd_work *, int);
 extern int w_send_dblock(struct drbd_work *, int);
 extern int w_send_read_req(struct drbd_work *, int);
-extern int w_prev_work_done(struct drbd_work *, int);
 extern int w_e_reissue(struct drbd_work *, int);
 extern int w_restart_disk_io(struct drbd_work *, int);
 extern int w_send_out_of_sync(struct drbd_work *, int);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 9ccb856..250c8d4 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4481,11 +4481,19 @@ static void drbdd(struct drbd_connection *connection)
 	conn_request_state(connection, NS(conn, C_PROTOCOL_ERROR), CS_HARD);
 }
 
+static int w_complete(struct drbd_work *w, int cancel)
+{
+	struct drbd_wq_barrier *b = container_of(w, struct drbd_wq_barrier, w);
+
+	complete(&b->done);
+	return 0;
+}
+
 void conn_flush_workqueue(struct drbd_connection *connection)
 {
 	struct drbd_wq_barrier barr;
 
-	barr.w.cb = w_prev_work_done;
+	barr.w.cb = w_complete;
 	barr.w.connection = connection;
 	init_completion(&barr.done);
 	drbd_queue_work(&connection->sender_work, &barr.w);
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 8aaec6c..7d68227 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1262,14 +1262,6 @@ int w_e_end_ov_reply(struct drbd_work *w, int cancel)
 	return err;
 }
 
-int w_prev_work_done(struct drbd_work *w, int cancel)
-{
-	struct drbd_wq_barrier *b = container_of(w, struct drbd_wq_barrier, w);
-
-	complete(&b->done);
-	return 0;
-}
-
 /* FIXME
  * We need to track the number of pending barrier acks,
  * and to be able to wait for them.
-- 
1.7.9.5

