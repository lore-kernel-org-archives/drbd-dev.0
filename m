Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C7E76101AC79
	for <drbd-dev@lists.linbit.com>; Tue,  1 Jul 2014 18:16:51 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Tue,  1 Jul 2014 18:16:46 +0200
Message-Id: <1404231410-29852-17-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1404231410-29852-1-git-send-email-philipp.reisner@linbit.com>
References: <1404231410-29852-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 16/20] drbd: drbd_rs_number_requests: fix unit
	mismatch in comparison
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

We try to limit the number of "in-flight" resync requests.
One condition for that is the amount of requested data should not exceed
half of what can be covered by our "max-buffers" setting.

However we compared number of 4k pages with number of in-flight 512 Byte
sectors, and this extra throttle triggered much earlier than intended.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_worker.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 0b5e429..9f0acb0 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -504,9 +504,9 @@ struct fifo_buffer *fifo_alloc(int fifo_size)
 static int drbd_rs_controller(struct drbd_device *device, unsigned int sect_in)
 {
 	struct disk_conf *dc;
-	unsigned int want;     /* The number of sectors we want in the proxy */
+	unsigned int want;     /* The number of sectors we want in-flight */
 	int req_sect; /* Number of sectors to request in this turn */
-	int correction; /* Number of sectors more we need in the proxy*/
+	int correction; /* Number of sectors more we need in-flight */
 	int cps; /* correction per invocation of drbd_rs_controller() */
 	int steps; /* Number of time steps to plan ahead */
 	int curr_corr;
@@ -577,8 +577,13 @@ static int drbd_rs_number_requests(struct drbd_device *device)
 	 * potentially causing a distributed deadlock on congestion during
 	 * online-verify or (checksum-based) resync, if max-buffers,
 	 * socket buffer sizes and resync rate settings are mis-configured. */
-	if (mxb - device->rs_in_flight < number)
-		number = mxb - device->rs_in_flight;
+
+	/* note that "number" is in units of "BM_BLOCK_SIZE" (which is 4k),
+	 * mxb (as used here, and in drbd_alloc_pages on the peer) is
+	 * "number of pages" (typically also 4k),
+	 * but "rs_in_flight" is in "sectors" (512 Byte). */
+	if (mxb - device->rs_in_flight/8 < number)
+		number = mxb - device->rs_in_flight/8;
 
 	return number;
 }
-- 
1.9.1

