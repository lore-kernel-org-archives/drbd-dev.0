Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 98266105B0D0
	for <drbd-dev@lists.linbit.com>; Mon, 23 Dec 2013 22:50:58 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 23 Dec 2013 22:50:48 +0100
Message-Id: <1387835456-29695-20-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1387835456-29695-1-git-send-email-philipp.reisner@linbit.com>
References: <1387835456-29695-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 19/27] drbd: struct after_conn_state_chg_work:
	Use drbd_work instead of drbd_device_work
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
 drivers/block/drbd/drbd_state.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index c9a0dba..720b803 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1533,7 +1533,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 }
 
 struct after_conn_state_chg_work {
-	struct drbd_device_work dw;
+	struct drbd_work w;
 	enum drbd_conns oc;
 	union drbd_state ns_min;
 	union drbd_state ns_max; /* new, max state, over all devices */
@@ -1544,7 +1544,7 @@ struct after_conn_state_chg_work {
 static int w_after_conn_state_ch(struct drbd_work *w, int unused)
 {
 	struct after_conn_state_chg_work *acscw =
-		container_of(w, struct after_conn_state_chg_work, dw.w);
+		container_of(w, struct after_conn_state_chg_work, w);
 	struct drbd_connection *connection = acscw->connection;
 	enum drbd_conns oc = acscw->oc;
 	union drbd_state ns_max = acscw->ns_max;
@@ -1846,10 +1846,10 @@ _conn_request_state(struct drbd_connection *connection, union drbd_state mask, u
 		acscw->ns_min = ns_min;
 		acscw->ns_max = ns_max;
 		acscw->flags = flags;
-		acscw->dw.w.cb = w_after_conn_state_ch;
+		acscw->w.cb = w_after_conn_state_ch;
 		kref_get(&connection->kref);
 		acscw->connection = connection;
-		drbd_queue_work(&connection->sender_work, &acscw->dw.w);
+		drbd_queue_work(&connection->sender_work, &acscw->w);
 	} else {
 		drbd_err(connection, "Could not kmalloc an acscw\n");
 	}
-- 
1.7.9.5

