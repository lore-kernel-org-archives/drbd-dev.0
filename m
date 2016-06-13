Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 70E581056455
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 00:26:42 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Tue, 14 Jun 2016 00:26:16 +0200
Message-Id: <1465856799-2151-8-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <575ECD32.2080700@fb.com>
References: <575ECD32.2080700@fb.com>
In-Reply-To: <575ECD32.2080700@fb.com>
References: <575ECD32.2080700@fb.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 07/30] drbd: adjust assert in w_bitmap_io to
	account for BM_LOCKED_CHANGE_ALLOWED
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

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index b0891c3..64e9525 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3523,7 +3523,12 @@ static int w_bitmap_io(struct drbd_work *w, int unused)
 	struct bm_io_work *work = &device->bm_io_work;
 	int rv = -EIO;
 
-	D_ASSERT(device, atomic_read(&device->ap_bio_cnt) == 0);
+	if (work->flags != BM_LOCKED_CHANGE_ALLOWED) {
+		int cnt = atomic_read(&device->ap_bio_cnt);
+		if (cnt)
+			drbd_err(device, "FIXME: ap_bio_cnt %d, expected 0; queued for '%s'\n",
+					cnt, work->why);
+	}
 
 	if (get_ldev(device)) {
 		drbd_bm_lock(device, work->why, work->flags);
-- 
2.7.4

