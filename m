Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
	[209.85.128.196])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E85E11057321
	for <drbd-dev@lists.linbit.com>; Wed,  2 May 2018 17:35:57 +0200 (CEST)
Received: by mail-wr0-f196.google.com with SMTP id 94-v6so13183476wrf.5
	for <drbd-dev@lists.linbit.com>; Wed, 02 May 2018 08:35:57 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	194sm6014426wml.20.2018.05.02.08.35.56
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 02 May 2018 08:35:57 -0700 (PDT)
Resent-Message-ID: <20180502153556.GP10032@soda.linbit>
Received: from mail.xen.prgmr.com (mail.prgmr.com [71.19.149.6])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E1BCB1057321
	for <drbd-dev@lists.linbit.com>; Mon, 30 Apr 2018 03:20:47 +0200 (CEST)
From: Sarah Newman <srn@prgmr.com>
To: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Sun, 29 Apr 2018 18:19:18 -0700
Message-Id: <1525051158-18696-1-git-send-email-srn@prgmr.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: avoid use-after-free in drbd_request_endio
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

It appears that bio_put(req->private_bio) may put the bio being
passed in, after which point accessing bio will no longer be
valid. Make a local copy of bio->bi_error before then.

Without this patch, with CONFIG_DEBUG_PAGEALLOC the debug message

"role( Secondary -> Primary )"

is followed by

"BUG: unable to handle kernel paging request"

This applies to versions before 4e4cbee93d561, first released
in v4.13. v4.13+ appears to have a similar bug.

Signed-off-by: Sarah Newman <srn@prgmr.com>
---
 drivers/block/drbd/drbd_worker.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index c6755c9..e9992b8 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -209,6 +209,7 @@ void drbd_request_endio(struct bio *bio)
 	struct drbd_device *device = req->device;
 	struct bio_and_error m;
 	enum drbd_req_event what;
+	int bi_error = bio->bi_error;
 
 	/* If this request was aborted locally before,
 	 * but now was completed "successfully",
@@ -242,15 +243,15 @@ void drbd_request_endio(struct bio *bio)
 		if (__ratelimit(&drbd_ratelimit_state))
 			drbd_emerg(device, "delayed completion of aborted local request; disk-timeout may be too aggressive\n");
 
-		if (!bio->bi_error)
+		if (!bi_error)
 			drbd_panic_after_delayed_completion_of_aborted_request(device);
 	}
 
 	/* to avoid recursion in __req_mod */
-	if (unlikely(bio->bi_error)) {
+	if (unlikely(bi_error)) {
 		switch (bio_op(bio)) {
 		case REQ_OP_DISCARD:
-			if (bio->bi_error == -EOPNOTSUPP)
+			if (bi_error == -EOPNOTSUPP)
 				what = DISCARD_COMPLETED_NOTSUPP;
 			else
 				what = DISCARD_COMPLETED_WITH_ERROR;
@@ -270,7 +271,7 @@ void drbd_request_endio(struct bio *bio)
 	}
 
 	bio_put(req->private_bio);
-	req->private_bio = ERR_PTR(bio->bi_error);
+	req->private_bio = ERR_PTR(bi_error);
 
 	/* not req_mod(), we need irqsave here! */
 	spin_lock_irqsave(&device->resource->req_lock, flags);
-- 
1.9.1

