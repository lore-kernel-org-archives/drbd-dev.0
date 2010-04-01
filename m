Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Dan Carpenter <error27@gmail.com>
Date: Thu,  1 Apr 2010 10:56:40 +0200
Message-Id: <1270112219-15836-1-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <9736574BB1380E.7050404@linbit.com>
References: <9736574BB1380E.7050404@linbit.com>
In-Reply-To: <9736574BB1380E.7050404@linbit.com>
References: <9736574BB1380E.7050404@linbit.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Jens Axboe <jens.axboe@oracle.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: lc_element_by_index() never returns NULL
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 43e57f3..df01899 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -1336,7 +1336,7 @@ int drbd_rs_del_all(struct drbd_conf *mdev)
 		/* ok, ->resync is there. */
 		for (i = 0; i < mdev->resync->nr_elements; i++) {
 			e = lc_element_by_index(mdev->resync, i);
-			bm_ext = e ? lc_entry(e, struct bm_extent, lce) : NULL;
+			bm_ext = lc_entry(e, struct bm_extent, lce);
 			if (bm_ext->lce.lc_number == LC_FREE)
 				continue;
 			if (bm_ext->lce.lc_number == mdev->resync_wenr) {
-- 
1.6.3.3

