Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 354EA101AC7C
	for <drbd-dev@lists.linbit.com>; Mon, 30 Jun 2014 17:53:08 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 30 Jun 2014 17:52:57 +0200
Message-Id: <1404143587-24344-9-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1404143587-24344-1-git-send-email-philipp.reisner@linbit.com>
References: <1404143587-24344-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 08/18] drbd: fix a race stopping the worker thread
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

We may implicitly call drbd_send() from inside wait_for_work(),
via maybe_send_barrier().

If the "stop" signal was send just before that, drbd_send() would call
flush_signals(), and we would run an unbounded schedule() afterwards.

Fix: check for thread_state == RUNNING before we schedule()

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_worker.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 5915885..47bc840 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1930,6 +1930,9 @@ static void wait_for_work(struct drbd_connection *connection, struct list_head *
 		if (send_barrier)
 			maybe_send_barrier(connection,
 					connection->send.current_epoch_nr + 1);
+		/* drbd_send() may have called flush_signals() */
+		if (get_t_state(&connection->worker) != RUNNING)
+			break;
 		schedule();
 		/* may be woken up for other things but new work, too,
 		 * e.g. if the current epoch got closed.
-- 
1.9.1

