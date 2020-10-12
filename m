Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AC4424203C4
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 17:39:40 +0200 (CEST)
Received: by mail-wr1-f68.google.com with SMTP id n18so19712369wrs.5
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 08:39:40 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	h25sm9044860wrc.55.2020.10.12.08.39.39
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 12 Oct 2020 08:39:39 -0700 (PDT)
Resent-Message-ID: <20201012153937.GR2116@soda.linbit>
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5E1C04203DE
	for <drbd-dev@lists.linbit.com>; Wed,  1 Jul 2020 14:39:50 +0200 (CEST)
Received: by mail-ed1-f68.google.com with SMTP id dg28so19531367edb.3
	for <drbd-dev@lists.linbit.com>; Wed, 01 Jul 2020 05:39:50 -0700 (PDT)
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	axboe@kernel.dk
Message-Id: <20200701123832.3868-1-guoqing.jiang@cloud.ionos.com>
Cc: linux-block@vger.kernel.org, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: remove unused argument from
	drbd_request_prepare and __drbd_make_request
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>
Date: Mon, 12 Oct 2020 15:39:59 -0000

We can remove start_jif since it is not used by drbd_request_prepare,
then remove it from __drbd_make_request further.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/block/drbd/drbd_int.h  |  2 +-
 drivers/block/drbd/drbd_main.c |  3 +--
 drivers/block/drbd/drbd_req.c  | 11 ++++-------
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 33d0831c99b6..512888514c9e 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1450,7 +1450,7 @@ extern void conn_free_crypto(struct drbd_connection *connection);
 
 /* drbd_req */
 extern void do_submit(struct work_struct *ws);
-extern void __drbd_make_request(struct drbd_device *, struct bio *, unsigned long);
+extern void __drbd_make_request(struct drbd_device *, struct bio *);
 extern blk_qc_t drbd_make_request(struct request_queue *q, struct bio *bio);
 extern int drbd_read_remote(struct drbd_device *device, struct drbd_request *req);
 extern int is_valid_ar_handle(struct drbd_request *, sector_t);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 45fbd526c453..2aff9a3f06e3 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2292,7 +2292,6 @@ static void do_retry(struct work_struct *ws)
 	list_for_each_entry_safe(req, tmp, &writes, tl_requests) {
 		struct drbd_device *device = req->device;
 		struct bio *bio = req->master_bio;
-		unsigned long start_jif = req->start_jif;
 		bool expected;
 
 		expected =
@@ -2327,7 +2326,7 @@ static void do_retry(struct work_struct *ws)
 		/* We are not just doing generic_make_request(),
 		 * as we want to keep the start_time information. */
 		inc_ap_bio(device);
-		__drbd_make_request(device, bio, start_jif);
+		__drbd_make_request(device, bio);
 	}
 }
 
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index c80a2f1c3c2a..991d9ba1a5e7 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1188,7 +1188,7 @@ static void drbd_queue_write(struct drbd_device *device, struct drbd_request *re
  * Returns ERR_PTR(-ENOMEM) if we cannot allocate a drbd_request.
  */
 static struct drbd_request *
-drbd_request_prepare(struct drbd_device *device, struct bio *bio, unsigned long start_jif)
+drbd_request_prepare(struct drbd_device *device, struct bio *bio)
 {
 	const int rw = bio_data_dir(bio);
 	struct drbd_request *req;
@@ -1416,9 +1416,9 @@ static void drbd_send_and_submit(struct drbd_device *device, struct drbd_request
 		complete_master_bio(device, &m);
 }
 
-void __drbd_make_request(struct drbd_device *device, struct bio *bio, unsigned long start_jif)
+void __drbd_make_request(struct drbd_device *device, struct bio *bio)
 {
-	struct drbd_request *req = drbd_request_prepare(device, bio, start_jif);
+	struct drbd_request *req = drbd_request_prepare(device, bio);
 	if (IS_ERR_OR_NULL(req))
 		return;
 	drbd_send_and_submit(device, req);
@@ -1596,19 +1596,16 @@ void do_submit(struct work_struct *ws)
 blk_qc_t drbd_make_request(struct request_queue *q, struct bio *bio)
 {
 	struct drbd_device *device = (struct drbd_device *) q->queuedata;
-	unsigned long start_jif;
 
 	blk_queue_split(q, &bio);
 
-	start_jif = jiffies;
-
 	/*
 	 * what we "blindly" assume:
 	 */
 	D_ASSERT(device, IS_ALIGNED(bio->bi_iter.bi_size, 512));
 
 	inc_ap_bio(device);
-	__drbd_make_request(device, bio, start_jif);
+	__drbd_make_request(device, bio);
 	return BLK_QC_T_NONE;
 }
 
-- 
2.17.1

