Return-Path: <lars.ellenberg@linbit.com>
Received: from racke (bk1.linbit [10.9.9.6])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 05FEB105B393
	for <drbd-dev@lists.linbit.com>; Mon, 29 Mar 2010 14:28:05 +0200 (CEST)
Resent-Message-ID: <20100329122805.GB3486@racke>
Date: Sat, 27 Mar 2010 17:59:50 +0300
From: Dan Carpenter <error27@gmail.com>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>
Message-ID: <20100327145950.GG5069@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-user@lists.linbit.com, Jens Axboe <jens.axboe@oracle.com>
Subject: [Drbd-dev] [patch] drbd: potential null dereference
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

If "e" is NULL then "bm_ext" would be NULL too.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
Found by static analysis and compile tested only.  Sorry.  :/

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 17956ff..b68b778 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -1328,7 +1328,7 @@ int drbd_rs_del_all(struct drbd_conf *mdev)
 		for (i = 0; i < mdev->resync->nr_elements; i++) {
 			e = lc_element_by_index(mdev->resync, i);
 			bm_ext = e ? lc_entry(e, struct bm_extent, lce) : NULL;
-			if (bm_ext->lce.lc_number == LC_FREE)
+			if (!bm_ext || bm_ext->lce.lc_number == LC_FREE)
 				continue;
 			if (bm_ext->lce.lc_number == mdev->resync_wenr) {
 				dev_info(DEV, "dropping %u in drbd_rs_del_all, apparently"
