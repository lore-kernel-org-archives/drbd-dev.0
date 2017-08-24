Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wr0-f171.google.com (mail-wr0-f171.google.com
	[209.85.128.171])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E41661058015
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 23:30:11 +0200 (CEST)
Received: by mail-wr0-f171.google.com with SMTP id z91so2131849wrc.1
	for <drbd-dev@lists.linbit.com>; Thu, 24 Aug 2017 14:30:11 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 24 Aug 2017 23:22:59 +0200
Message-Id: <1503609794-13233-3-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
References: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 02/17] drbd: change list_for_each_safe to
	while(list_first_entry_or_null)
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

Two instances of list_for_each_safe can drop their tmp element, they
really just peel off each element in turn from the start of the list.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 5955ab8..85e05ee 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1485,12 +1485,12 @@ static bool prepare_al_transaction_nonblock(struct drbd_device *device,
 					    struct list_head *pending,
 					    struct list_head *later)
 {
-	struct drbd_request *req, *tmp;
+	struct drbd_request *req;
 	int wake = 0;
 	int err;
 
 	spin_lock_irq(&device->al_lock);
-	list_for_each_entry_safe(req, tmp, incoming, tl_requests) {
+	while ((req = list_first_entry_or_null(incoming, struct drbd_request, tl_requests))) {
 		err = drbd_al_begin_io_nonblock(device, &req->i);
 		if (err == -ENOBUFS)
 			break;
@@ -1509,9 +1509,9 @@ static bool prepare_al_transaction_nonblock(struct drbd_device *device,
 
 void send_and_submit_pending(struct drbd_device *device, struct list_head *pending)
 {
-	struct drbd_request *req, *tmp;
+	struct drbd_request *req;
 
-	list_for_each_entry_safe(req, tmp, pending, tl_requests) {
+	while ((req = list_first_entry_or_null(pending, struct drbd_request, tl_requests))) {
 		req->rq_state |= RQ_IN_ACT_LOG;
 		req->in_actlog_jif = jiffies;
 		atomic_dec(&device->ap_actlog_cnt);
-- 
2.7.4

