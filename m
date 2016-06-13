Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 228F7105647F
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jun 2016 16:09:28 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 13 Jun 2016 16:09:16 +0200
Message-Id: <1465826958-19398-29-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1465826958-19398-1-git-send-email-philipp.reisner@linbit.com>
References: <1465826958-19398-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 28/30] drbd: finally report ms, not jiffies,
	in log message
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

Also skip the message unless bitmap IO took longer than 5 ms.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_bitmap.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 17e5e60..801b8f3 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1121,10 +1121,14 @@ static int bm_rw(struct drbd_device *device, const unsigned int flags, unsigned
 		kref_put(&ctx->kref, &drbd_bm_aio_ctx_destroy);
 
 	/* summary for global bitmap IO */
-	if (flags == 0)
-		drbd_info(device, "bitmap %s of %u pages took %lu jiffies\n",
-			 (flags & BM_AIO_READ) ? "READ" : "WRITE",
-			 count, jiffies - now);
+	if (flags == 0) {
+		unsigned int ms = jiffies_to_msecs(jiffies - now);
+		if (ms > 5) {
+			drbd_info(device, "bitmap %s of %u pages took %u ms\n",
+				 (flags & BM_AIO_READ) ? "READ" : "WRITE",
+				 count, ms);
+		}
+	}
 
 	if (ctx->error) {
 		drbd_alert(device, "we had at least one MD IO ERROR during bitmap IO\n");
-- 
2.7.4

