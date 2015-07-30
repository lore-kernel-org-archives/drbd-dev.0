Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 184B1105573E
	for <drbd-dev@lists.linbit.com>; Thu, 30 Jul 2015 13:22:09 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Thu, 30 Jul 2015 13:21:51 +0200
Message-Id: <1438255314-14877-17-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
References: <1438255314-14877-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 16/19] drbd:
	drbd_panic_after_delayed_completion_of_aborted_request()
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

The only way to make DRBD intentionally call panic is to
set a disk timeout, have that trigger, "abort" some request and complete
to upper layers, then have the backend IO subsystem later complete these
requests successfully regardless.

As the attached IO pages have been recycled for other purposes
meanwhile, this will cause unexpected random memory changes.
To prevent corruption, we rather panic in that case.

Make it obvious from stack traces that this was the case by introducing
drbd_panic_after_delayed_completion_of_aborted_request().

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_worker.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index ef70e1f..93777b1 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -199,6 +199,12 @@ void drbd_peer_request_endio(struct bio *bio, int error)
 	}
 }
 
+void drbd_panic_after_delayed_completion_of_aborted_request(struct drbd_device *device)
+{
+	panic("drbd%u %s/%u potential random memory corruption caused by delayed completion of aborted local request\n",
+		device->minor, device->resource->name, device->vnr);
+}
+
 /* read, readA or write requests on R_PRIMARY coming from drbd_make_request
  */
 void drbd_request_endio(struct bio *bio, int error)
@@ -253,7 +259,7 @@ void drbd_request_endio(struct bio *bio, int error)
 			drbd_emerg(device, "delayed completion of aborted local request; disk-timeout may be too aggressive\n");
 
 		if (!error)
-			panic("possible random memory corruption caused by delayed completion of aborted local request\n");
+			drbd_panic_after_delayed_completion_of_aborted_request(device);
 	}
 
 	/* to avoid recursion in __req_mod */
-- 
1.9.1

