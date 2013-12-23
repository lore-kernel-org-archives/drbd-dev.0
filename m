Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 67B38105B0CF
	for <drbd-dev@lists.linbit.com>; Mon, 23 Dec 2013 22:50:57 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 23 Dec 2013 22:50:37 +0100
Message-Id: <1387835456-29695-9-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1387835456-29695-1-git-send-email-philipp.reisner@linbit.com>
References: <1387835456-29695-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 08/27] drbd: Rename drbdd_init() ->
	drbd_receiver()
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

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 drivers/block/drbd/drbd_main.c     |    4 ++--
 drivers/block/drbd/drbd_nl.c       |    2 +-
 drivers/block/drbd/drbd_receiver.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 718c3bd..a2003cd 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -58,7 +58,7 @@
 #include "drbd_vli.h"
 
 static DEFINE_MUTEX(drbd_main_mutex);
-int drbdd_init(struct drbd_thread *);
+int drbd_receiver(struct drbd_thread *);
 int drbd_worker(struct drbd_thread *);
 int drbd_asender(struct drbd_thread *);
 
@@ -2616,7 +2616,7 @@ struct drbd_connection *conn_create(const char *name, struct res_opts *res_opts)
 	mutex_init(&connection->data.mutex);
 	mutex_init(&connection->meta.mutex);
 
-	drbd_thread_init(connection, &connection->receiver, drbdd_init, "receiver");
+	drbd_thread_init(connection, &connection->receiver, drbd_receiver, "receiver");
 	drbd_thread_init(connection, &connection->worker, drbd_worker, "worker");
 	drbd_thread_init(connection, &connection->asender, drbd_asender, "asender");
 
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index a84f1e2..f7d62ff 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -2332,7 +2332,7 @@ static enum drbd_state_rv conn_try_disconnect(struct drbd_connection *connection
 		/* Race breaker.  This additional state change request may be
 		 * necessary, if this was a forced disconnect during a receiver
 		 * restart.  We may have "killed" the receiver thread just
-		 * after drbdd_init() returned.  Typically, we should be
+		 * after drbd_receiver() returned.  Typically, we should be
 		 * C_STANDALONE already, now, and this becomes a no-op.
 		 */
 		rv2 = conn_request_state(connection, NS(conn, C_STANDALONE),
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 217ed11..9349113 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4843,7 +4843,7 @@ static int drbd_do_auth(struct drbd_connection *connection)
 }
 #endif
 
-int drbdd_init(struct drbd_thread *thi)
+int drbd_receiver(struct drbd_thread *thi)
 {
 	struct drbd_connection *connection = thi->connection;
 	int h;
-- 
1.7.9.5

