Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 31F331028A5B
	for <drbd-dev@lists.linbit.com>; Mon, 10 Nov 2014 17:21:17 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 10 Nov 2014 17:21:13 +0100
Message-Id: <1415636475-7883-6-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1415636475-7883-1-git-send-email-philipp.reisner@linbit.com>
References: <1415636475-7883-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 5/7] drbd: merge_bvec_fn: properly remap
	bvm->bi_bdev
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

This was not noticed for many years. Affects operation if
md raid is used a backing device for DRBD.

CC: stable@kernel.org # v3.2+
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_req.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 5a01c53..90319b1 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1545,6 +1545,7 @@ int drbd_merge_bvec(struct request_queue *q, struct bvec_merge_data *bvm, struct
 		struct request_queue * const b =
 			device->ldev->backing_bdev->bd_disk->queue;
 		if (b->merge_bvec_fn) {
+			bvm->bi_bdev = device->ldev->backing_bdev;
 			backing_limit = b->merge_bvec_fn(b, bvm, bvec);
 			limit = min(limit, backing_limit);
 		}
-- 
1.9.1

