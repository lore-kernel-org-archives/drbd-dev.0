Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 08E0D105B0D2
	for <drbd-dev@lists.linbit.com>; Mon, 23 Dec 2013 22:50:59 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 23 Dec 2013 22:50:52 +0100
Message-Id: <1387835456-29695-24-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1387835456-29695-1-git-send-email-philipp.reisner@linbit.com>
References: <1387835456-29695-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 23/27] drbd: In the worker thread,
	process drbd_work instead of drbd_device_work items
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

From: Andreas Gruenbacher <agruen@kernel.org>

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 drivers/block/drbd/drbd_worker.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 7961af9..b826648 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1888,7 +1888,7 @@ void wait_for_work(struct drbd_connection *connection, struct list_head *work_li
 int drbd_worker(struct drbd_thread *thi)
 {
 	struct drbd_connection *connection = thi->connection;
-	struct drbd_device_work *dw = NULL;
+	struct drbd_work *w = NULL;
 	struct drbd_peer_device *peer_device;
 	LIST_HEAD(work_list);
 	int vnr;
@@ -1914,9 +1914,9 @@ int drbd_worker(struct drbd_thread *thi)
 			break;
 
 		while (!list_empty(&work_list)) {
-			dw = list_first_entry(&work_list, struct drbd_device_work, w.list);
-			list_del_init(&dw->w.list);
-			if (dw->w.cb(&dw->w, connection->cstate < C_WF_REPORT_PARAMS) == 0)
+			w = list_first_entry(&work_list, struct drbd_work, list);
+			list_del_init(&w->list);
+			if (w->cb(w, connection->cstate < C_WF_REPORT_PARAMS) == 0)
 				continue;
 			if (connection->cstate >= C_WF_REPORT_PARAMS)
 				conn_request_state(connection, NS(conn, C_NETWORK_FAILURE), CS_HARD);
@@ -1925,9 +1925,9 @@ int drbd_worker(struct drbd_thread *thi)
 
 	do {
 		while (!list_empty(&work_list)) {
-			dw = list_first_entry(&work_list, struct drbd_device_work, w.list);
-			list_del_init(&dw->w.list);
-			dw->w.cb(&dw->w, 1);
+			w = list_first_entry(&work_list, struct drbd_work, list);
+			list_del_init(&w->list);
+			w->cb(w, 1);
 		}
 		dequeue_work_batch(&connection->sender_work, &work_list);
 	} while (!list_empty(&work_list));
-- 
1.7.9.5

