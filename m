Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 18A7910561A3
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2015 11:54:31 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Wed, 25 Nov 2015 11:53:45 +0100
Message-Id: <1448448851-10343-13-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
References: <1448448851-10343-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 12/38] drbd: Fix spurious disk-timeout
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

(You should not use disk-timeout anyways,
 see the man page for why...)

We add incoming requests to the tail of some ring list.
On local completion, requests are removed from that list.
The timer looks only at the head of that ring list,
so is supposed to only see the oldest request.
All protected by a spinlock.

The request object is created with timestamps zeroed out.
The timestamp was only filled in just before the actual submit.
But to actually submit the request, we need to give up the spinlock.

If you are unlucky, there is no older still pending request, the timer
looks at a new request with timestamp still zero (before it even was
submitted), and 0 + timeout is most likely older than "now".

Better assign the timestamp right when we put the
request object on said ring list.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_req.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 55fca68..7660f6e 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1167,7 +1167,6 @@ drbd_submit_req_private_bio(struct drbd_request *req)
 	 * stable storage, and this is a WRITE, we may not even submit
 	 * this bio. */
 	if (get_ldev(device)) {
-		req->pre_submit_jif = jiffies;
 		if (drbd_insert_fault(device,
 				      rw == WRITE ? DRBD_FAULT_DT_WR
 				    : rw == READ  ? DRBD_FAULT_DT_RD
@@ -1311,6 +1310,7 @@ static void drbd_send_and_submit(struct drbd_device *device, struct drbd_request
 			&device->pending_master_completion[rw == WRITE]);
 	if (req->private_bio) {
 		/* needs to be marked within the same spinlock */
+		req->pre_submit_jif = jiffies;
 		list_add_tail(&req->req_pending_local,
 			&device->pending_completion[rw == WRITE]);
 		_req_mod(req, TO_BE_SUBMITTED);
-- 
1.9.1

