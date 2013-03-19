Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 19 Mar 2013 18:16:58 +0100
Message-Id: <1363713419-17803-18-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1363713419-17803-1-git-send-email-philipp.reisner@linbit.com>
References: <1363713419-17803-1-git-send-email-philipp.reisner@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 17/18] drbd: try hard to max out the updates per
	AL transaction
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

There may have been more incoming requests while we where preparing
the current transaction. Try to consolidate more updates into this
transaction until we make no more progres.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_req.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index d72f2fe..9f7ff1c 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1226,6 +1226,37 @@ void do_submit(struct work_struct *ws)
 			break;
 
 		wait_event(mdev->al_wait, prepare_al_transaction_nonblock(mdev, &incoming, &pending));
+		/* Maybe more was queued, while we prepared the transaction?
+		 * Try to stuff them into this transaction as well.
+		 * Be strictly non-blocking here, no wait_event, we already
+		 * have something to commit.
+		 * Stop if we don't make any more progres.
+		 */
+		for (;;) {
+			LIST_HEAD(more_pending);
+			LIST_HEAD(more_incoming);
+			bool made_progress;
+
+			/* It is ok to look outside the lock,
+			 * it's only an optimization anyways */
+			if (list_empty(&mdev->submit.writes))
+				break;
+
+			spin_lock(&mdev->submit.lock);
+			list_splice_tail_init(&mdev->submit.writes, &more_incoming);
+			spin_unlock(&mdev->submit.lock);
+
+			if (list_empty(&more_incoming))
+				break;
+
+			made_progress = prepare_al_transaction_nonblock(mdev, &more_incoming, &more_pending);
+
+			list_splice_tail_init(&more_pending, &pending);
+			list_splice_tail_init(&more_incoming, &incoming);
+
+			if (!made_progress)
+				break;
+		}
 		drbd_al_begin_io_commit(mdev, false);
 
 		list_for_each_entry_safe(req, tmp, &pending, tl_requests) {
-- 
1.7.9.5

