Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2FED010562B2
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:36 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:53:58 +0100
Message-Id: <1448448851-10343-26-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 25/38] drbd: use resource name in workqueue
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

Since kernel 3.3, we can use snprintf-style arguments
to create a workqueue.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_main.c     | 4 ++--
 drivers/block/drbd/drbd_receiver.c | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 938bca2..3a9a0f1 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2694,8 +2694,8 @@ static int init_submitter(struct drbd_device *device)
 {
 	/* opencoded create_singlethread_workqueue(),
 	 * to be able to say "drbd%d", ..., minor */
-	device->submit.wq = alloc_workqueue("drbd%u_submit",
-			WQ_UNBOUND | WQ_MEM_RECLAIM, 1, device->minor);
+	device->submit.wq =
+		alloc_ordered_workqueue("drbd%u_submit", WQ_MEM_RECLAIM, device->minor);
 	if (!device->submit.wq)
 		return -ENOMEM;
 
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index ea54341..1957fe8 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1124,7 +1124,10 @@ randomize:
 	}
 
 	drbd_thread_start(&connection->ack_receiver);
-	connection->ack_sender = create_singlethread_workqueue("drbd_ack_sender");
+	/* opencoded create_singlethread_workqueue(),
+	 * to be able to use format string arguments */
+	connection->ack_sender =
+		alloc_ordered_workqueue("drbd_as_%s", WQ_MEM_RECLAIM, connection->resource->name);
 	if (!connection->ack_sender) {
 		drbd_err(connection, "Failed to create workqueue ack_sender\n");
 		return 0;
-- 
1.9.1

