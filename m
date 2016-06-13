Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2E05D105646B
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 00:26:44 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Tue, 14 Jun 2016 00:26:22 +0200
Message-Id: <1465856799-2151-14-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <575ECD32.2080700@fb.com>
References: <575ECD32.2080700@fb.com>
In-Reply-To: <575ECD32.2080700@fb.com>
References: <575ECD32.2080700@fb.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 13/30] drbd: zero-out partial unaligned discards
	on local backend
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

For consistency, also zero-out partial unaligned chunks of discard
requests on the local backend.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h |  2 ++
 drivers/block/drbd/drbd_req.c | 29 +++++++++++++++++++++++------
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index f49ff86..0b5a658 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1553,6 +1553,8 @@ extern void start_resync_timer_fn(unsigned long data);
 extern void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req);
 
 /* drbd_receiver.c */
+extern int drbd_issue_discard_or_zero_out(struct drbd_device *device,
+		sector_t start, unsigned int nr_sectors, bool discard);
 extern int drbd_receiver(struct drbd_thread *thi);
 extern int drbd_ack_receiver(struct drbd_thread *thi);
 extern void drbd_send_ping_wf(struct work_struct *ws);
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 74903ab..355cf10 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1156,6 +1156,16 @@ static int drbd_process_write_request(struct drbd_request *req)
 	return remote;
 }
 
+static void drbd_process_discard_req(struct drbd_request *req)
+{
+	int err = drbd_issue_discard_or_zero_out(req->device,
+				req->i.sector, req->i.size >> 9, true);
+
+	if (err)
+		req->private_bio->bi_error = -EIO;
+	bio_endio(req->private_bio);
+}
+
 static void
 drbd_submit_req_private_bio(struct drbd_request *req)
 {
@@ -1176,6 +1186,8 @@ drbd_submit_req_private_bio(struct drbd_request *req)
 				    : rw == READ  ? DRBD_FAULT_DT_RD
 				    :               DRBD_FAULT_DT_RA))
 			bio_io_error(bio);
+		else if (bio_op(bio) == REQ_OP_DISCARD)
+			drbd_process_discard_req(req);
 		else
 			generic_make_request(bio);
 		put_ldev(device);
@@ -1227,18 +1239,23 @@ drbd_request_prepare(struct drbd_device *device, struct bio *bio, unsigned long
 	/* Update disk stats */
 	_drbd_start_io_acct(device, req);
 
+	/* process discards always from our submitter thread */
+	if (bio_op(bio) & REQ_OP_DISCARD)
+		goto queue_for_submitter_thread;
+
 	if (rw == WRITE && req->private_bio && req->i.size
 	&& !test_bit(AL_SUSPENDED, &device->flags)) {
-		if (!drbd_al_begin_io_fastpath(device, &req->i)) {
-			atomic_inc(&device->ap_actlog_cnt);
-			drbd_queue_write(device, req);
-			return NULL;
-		}
+		if (!drbd_al_begin_io_fastpath(device, &req->i))
+			goto queue_for_submitter_thread;
 		req->rq_state |= RQ_IN_ACT_LOG;
 		req->in_actlog_jif = jiffies;
 	}
-
 	return req;
+
+ queue_for_submitter_thread:
+	atomic_inc(&device->ap_actlog_cnt);
+	drbd_queue_write(device, req);
+	return NULL;
 }
 
 static void drbd_send_and_submit(struct drbd_device *device, struct drbd_request *req)
-- 
2.7.4

