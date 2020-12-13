Return-Path: <michael.d.labriola@gmail.com>
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com
	[209.85.166.196])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 414B842062A
	for <drbd-dev@lists.linbit.com>; Sun, 13 Dec 2020 06:59:10 +0100 (CET)
Received: by mail-il1-f196.google.com with SMTP id c18so12764196iln.10
	for <drbd-dev@lists.linbit.com>; Sat, 12 Dec 2020 21:59:10 -0800 (PST)
From: Michael D Labriola <michael.d.labriola@gmail.com>
To: drbd-dev@lists.linbit.com
Date: Sun, 13 Dec 2020 00:58:55 -0500
Message-Id: <20201213055859.3305-5-michael.d.labriola@gmail.com>
In-Reply-To: <20201213055859.3305-1-michael.d.labriola@gmail.com>
References: <20201213055859.3305-1-michael.d.labriola@gmail.com>
Subject: [Drbd-dev] [PATCH 4/8] drbd: fix drbd_submit_bio argument handling
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

Looks like we changed arguments from q to bio, but left the line that gets
device from q untouched.  Oopsie.

Signed-off-by: Michael D Labriola <michael.d.labriola@gmail.com>
---
 drbd/drbd_req.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drbd/drbd_req.c b/drbd/drbd_req.c
index 8db2a0e0..92b3b863 100644
--- a/drbd/drbd_req.c
+++ b/drbd/drbd_req.c
@@ -2196,7 +2196,7 @@ static bool drbd_fail_request_early(struct drbd_device *device, struct bio *bio)
 
 blk_qc_t drbd_submit_bio(struct bio *bio)
 {
-	struct drbd_device *device = (struct drbd_device *) q->queuedata;
+	struct drbd_device *device = bio->bi_disk->private_data;
 #ifdef CONFIG_DRBD_TIMING_STATS
 	ktime_t start_kt;
 #endif
-- 
2.17.1

