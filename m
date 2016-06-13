Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C83E4105646A
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jun 2016 16:09:21 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 13 Jun 2016 16:08:56 +0200
Message-Id: <1465826958-19398-9-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1465826958-19398-1-git-send-email-philipp.reisner@linbit.com>
References: <1465826958-19398-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 08/30] drbd: fix regression: protocol A sometimes
	synchronous, C sometimes double-latency
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

Regression introduced with 8.4.5
 drbd: application writes may set-in-sync in protocol != C

Overwriting the same block (LBA) while a former version is still
"in-flight" to the peer (to be exact: we did not receive the
P_BARRIER_ACK for its epoch yet) would wait for the full epoch of that
former version to be acknowledged by the peer.

In synchronous and quasi-synchronous protocols C and B,
this may double the latency on overwrites.

With protocol A, which is supposed to be asynchronous and only wait for
local completion, it is even worse: it would make overwrites
quasi-synchronous, they would be hit by the full RTT, which protocol A
was specifically meant to avoid, and possibly the additional time it
takes to drain the buffers first.

Particularly bad for databases, or anything else that
does frequent updates to the same blocks (various file system meta data).

No impact if >= rtt passes between updates to the same block.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_req.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 2255dcf..6dbf1f1 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -977,16 +977,20 @@ static void complete_conflicting_writes(struct drbd_request *req)
 	sector_t sector = req->i.sector;
 	int size = req->i.size;
 
-	i = drbd_find_overlap(&device->write_requests, sector, size);
-	if (!i)
-		return;
-
 	for (;;) {
-		prepare_to_wait(&device->misc_wait, &wait, TASK_UNINTERRUPTIBLE);
-		i = drbd_find_overlap(&device->write_requests, sector, size);
-		if (!i)
+		drbd_for_each_overlap(i, &device->write_requests, sector, size) {
+			/* Ignore, if already completed to upper layers. */
+			if (i->completed)
+				continue;
+			/* Handle the first found overlap.  After the schedule
+			 * we have to restart the tree walk. */
 			break;
+		}
+		if (!i)	/* if any */
+			break;
+
 		/* Indicate to wake up device->misc_wait on progress.  */
+		prepare_to_wait(&device->misc_wait, &wait, TASK_UNINTERRUPTIBLE);
 		i->waiting = true;
 		spin_unlock_irq(&device->resource->req_lock);
 		schedule();
-- 
2.7.4

